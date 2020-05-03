<?xml version="1.0" encoding="windows-1252"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns="http://www.w3.org/1999/xhtml" version="1.0">
  <xsl:output encoding="utf-8" method="html" />

  <xsl:variable name="version">0.6.1</xsl:variable>

  <xsl:template match="/">

    <!-- Add a proper DOCTYPE declaration here, to make sure the page is rendered
        properly. Firefox doesn't need this, so we make sure it doesn't get
        output when we're using "Transformiix", the Firefox XSLT processor.
        NOTE: This weird behaviour is only an issue if you have this stylesheet
            directly linked from an XML document, i.e. if you're trying to test
            it without having to tell HL to regenerate the XML file every time.
    -->
    <xsl:if test="system-property('xsl:vendor') != 'Transformiix'">
      <xsl:text disable-output-escaping="yes">
        &lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
          "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;
      </xsl:text>
    </xsl:if>
	  
	<style>
      li:empty {display: none;}
    </style>
    <html>
      <head>

      <!-- XHTML requires that you specify a meta-tag to dictate the content type.
      -->
      <xsl:text disable-output-escaping="yes">
      &lt;meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1"/&gt;
        </xsl:text>

      <!-- Page title - just find the first character and use its name  -->
      <title>Hero Lab to Roll20 Export</title>
      </head>

    <body>
	
	<h2>Hero Lab to Roll20 Export (version <xsl:value-of select="$version" />)</h2>
<!--    <button onclick="checkUpdates('{$version}')">Check for Updates</button> -->
    
	<div class="warning">
	  Obligatory warning: Use this at your own risk. I doubt it will explode your computer or delete the Internet, but an incomplete or ruined Roll20 character-sheet might have to be redone from scratch. So test it on something disposable first.
	</div>
	<div class="howitworks">
 	  <h3>How this works</h3>
      <h4>Advanced Sheet</h4>
      <ul>
	    <li>Click the "Copy Character to Clipboard" button below</li>
	    <li>Go to Roll20 and load your character</li>
	    <li>Go to the "Character Sheet" tab and there to the "Character tab"</li>
	    <li>Paste the contents of the Clipboard into the "Chummer Import" field near the bottom (remember to delete whatever placeholder text is in there first)</li>
	    <li>Click "Import" and "Accept"</li>
	    <li>Enjoy (Hopefully)</li>
	  </ul>
      <h4>5th Edition Sheet (using Charactermancer)</h4>
      <ul>
	    <li>Click the "Copy Character to Clipboard" button below</li>
	    <li>Go to Roll20 and load your character</li>
        <li>Go to the "Character Sheet" tab and there to the cog/gear icon</li>
	    <li>Click "Import" to open CharacterMancer import</li>
        <li>Paste the contents of the CLipboard into the giant text field</li>
	    <li>Click "Import" and review the changes</li>
        <li>Accept the changes if it looks good</li>
	    <li>Enjoy (Hopefully)</li>
      </ul>
	</div>
	<div onclick="toggleDisplay('knownIssues');">
	  <h3>Known Issues (Click to show them)</h3>
	</div>
	<div id="knownIssues" class="knownissues" style="display: none">
	  <h4>To-do List (Not yet implemented)</h4>
	  <ul>
	    <li>Making this output sheet a little prettier :)</li>
	    <li>Release final version</li>
	    <li>See if I can link exotic weapon to the correct skill</li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>Known Bugs</h4>
	  <ul>
	    <li>Alchemical Preperations are not recognized and are identified as Spells, which means they get linked to the Spellcasting skill, instead of Alchemy. The dicepool will be correct, so you can ignore it, if all you care about is that. But if you change the School from Spell to Preperation, you also have to set the Bonus to 0, otherwise it will be wrong!</li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>Not provided by Hero Lab (so can't be done (for now?). Sorry)</h4>
	  <ul>
	    <li>Vehicles and Drones (yes that one sucks the most. But unless Hero Lab releases that info into the XML export, there's nothing I can do.)</li>
	    <li>Overflow Boxes modifier (like Tough as Nails)</li>
	    <li>Wound threshold modifiers (like Low/High Pain Tolerance)</li>
	    <li>Drain Attribute (may be able to find a workaround for this)</li>
	    <li>Knowledge Skill Category (Street/Professional/Interest/Academic) (may be able to get at least the Attribute right)</li>
	    <li>Astral Initiative (gets set to the default 3D6, check manually if you have a bonus)</li>
	    <li>Geneware</li>
	    <li>Linking correct skill to Weapons</li>
	    <li>Rituals aren't exported at all. You have to add those manually</li>
	    <li>No way to differenciate between Spells and Alchemical Preperations. Default will be Spells, you have to change Preperations manually</li>
	    <li>Technomancer Complex Forms</li>
	    <li>Martial Arts</li>
	    <li>Matrix Programs in "Data Storage" are not identified as Programs and will appear in the normal equipment list. Programs loaded into devices (like a cyberdeck) will be correctly identified</li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>Bugs in the Import Sheet (I am NOT the author of the character sheet, I can't fix these. I try to find workarounds, but I can't edit the sheet.)</h4>
	  <ul>
	    <li>After the Import Skills are all set to use Body, even though dicepools etc. are displayed correctly. The roll button will not work till the Attribute has been fixed to the correct one. (This happens with a chummer file too) [seems to be fixed!]</li>
	    <li>Complex Forms: Import wants a dv attribute, gets fv from chummer - crash [seems to be fixed]</li>
	    <li>Max of 6 pieces of armor, rest seems to get ignored.</li>
	    <li>Doesn't recognize equipped armor</li>
	    <li>If there's only a single piece of Equipment, it will get ignored</li>
	    <li>If there's only a single spell selected it's unfortunately illegal and doesn't import (added workaround)</li>
	    <li>Weapon dicepool is calculated wrong if there's a specialization. NaN, because "9 (11)" from Chummer</li>
	    <li>Only the first 6 weapons are imported</li>
	    <li>Exotic Weapons are not assigned their proper Skill, but the Pistols skill instead. Dicepool is completely wrong.</li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	</div>
	<div class="copybutton">
      <button type="button" onclick="checkAndFixContents();document.getElementById('roll20exportfield').focus();document.getElementById('roll20exportfield').select();document.execCommand('copy')">Copy Character to Clipboard</button>
	</div>
      <!-- Output all our character nodes in turn and put it into the textarea-->
	  <textarea id="roll20exportfield" rows="20" cols="100" readonly="readonly" autofocus="autofocus"><xsl:apply-templates select="/document/public/character"/></textarea>
	  
	  <script type="text/javascript">
	    function toggleDisplay(id) {
		  const div = document.getElementById(id);
		  div.style.display = div.style.display === 'none' ? '' : 'none';
		}
        
        function checkAndFixContents() {
            let textarea = document.getElementById("roll20exportfield");
            let text = textarea.value;
            if (!checkValid(text)) { 
                // something is not right, so lets figure out whatever
                //checking for illegal linebreaks (Mac issue)
                if (checkLinebreaks(text)) {
                  fixedtext = removeLinebreaks(text);
                  textarea.value = fixedtext;
                  text = textarea.value;
                }
                // Check if Description has any weird linebreaks
                if (description = checkDescription(text)) {
                  fixedtext = cleanDescription(text);
                  textarea.value = fixedtext;
                  text = textarea.value;
                }
                
                //So far this is the only issue that needs post processing.
                
                if (!checkValid(text)) {
                    alert("An unidentified error has occured. Please contact the author (links below) and copy the contents of the textfield");
                    
                }
            }
            
        }
        
        function checkValid(text) {
            try {
               // lets find out if we can parse the text of if there's an error.
               let jsontest = JSON.parse(text);
               return true;
            } 
            catch(err) {
                return false;
            }
        }
        function checkLinebreaks(text) {
            let check = /(\n|\r)[ ]*"[ ]*(\n|\r|,)/g;
            let match = text.match(check);
            return (match != null);
        }
        
        function removeLinebreaks(text) {
            let check = /(\n|\r)[ ]*"[ ]*,/g;
            let newtext = text.replace(check, '",');
            check = /(\n|\r)[ ]*"[ ]*(\n|\r)/g; // checking for " withough a comma
            newtext = newtext.replace(check, '"\n');
            return newtext;
        }
        
        function checkDescription(text) {
            let check = /"description":[\s\S]*?([^\\]|[\\][\\])",/;
            let description = text.match(check)[0];
            return (description.match(/[\n|\r]/) != null);
        }
        
        function cleanDescription(text) {
            let original = text;
            let check = /"description":[\s\S]*?([^\\]|[\\][\\])",/;
            let description = text.match(check)[0];
            if (description.match(/[\n|\r]/) != null) {
                description = description.replace(/[\n|\r]/g, '\\n');
                text = text.replace(check, description);
                return text;
            }
            return original;
        }
    
	  </script>
	
      <!--xsl:apply-templates select="/document/public/character"/ -->

      <!-- Where did this come from? -->
	  <h3>Found a bug?</h3>
      <p>The sheet was written by (<a href="https://www.reddit.com/user/QuatarSR/">QuatarSR</a>) and has been adapted by (<a href="https://www.reddit.com/user/n3rf_herder/">n3rf_herder</a>).</p>
	  <p>Contact n3rf_herder on Reddit of any issues.</p>
	  <p>Please include the sheet you are using (Advanced or not advanced), the error message you get, a copy of the Hero Lab .por file.</p>
 	  <p>We are also not affiliated with Hero Lab or Roll20 in any way, except that we are users of both</p>

	<div onclick="toggleDisplay('changelog');">
	  <h3>Changelog (Click to show them)</h3>
	</div>
	<div id="changelog" class="changelog" style="display: none">
      <h4>0.6.0</h4>
      <ul>
        <li>Updated to provide more available information on existing items.</li>
        <li>Added fields are used by another Roll20 Sheet (Shadowrun5thEdition).</li>
        <li>Bugfix: descriptions being put on different lines.</li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
      </ul>
	  <h4>0.5.2</h4>
	  <ul>
	    <li>Bugfix: Mystic Armor broke the sheet. Fixed</li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>0.5.1</h4>
	  <ul>
	    <li>Bugfix: A quote in the role description of a contact caused an illegal output</li>
	    <li>Workaround: Auxiliary Armor (anything with a + infront of the value) wasn't correctly added.</li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>0.5.0</h4>
	  <ul>
	    <li>New Feature: Weapons now get assigned the correct skill and dicepool. Unfortunately this does not apply to Exotic Weapons at this time</li>
	    <li>New feature: Skill Specializations seem to work now, so they got reactivated</li>
	    <li>Fixed an issue that seems to only appear when using MacOS (or at least some versions), that totally messed up the whole output.</li>
	    <li>Made sure Alchemical Preperations always have the correct dicepool, even though they're not recognized as Preperations. If you change the School to Preperations, you also have to set the Bonus to 0! (Otherwise just leave them as they are, everything should have the right value)</li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>0.4.1</h4>
	  <ul>
	    <li>Fixed a bug that would cause the import to fail if only a single item was added in the categories armor, weapon, adept power, metamagic, quality, cyber/bioware, equipment. </li>
	    <li>Added a workaround so the above is also true for Spells and the Adept Spell power. It's now not crashing anymore, however it adds an empty "dummy spell" if there's only one. Just delete or ignore that one.</li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>0.4.0</h4>
	  <ul>
	    <li>New feature: Initiative Bonus that does not modify Reaction or Intuition (e.g. from the Increase Reflexes spell or a Leadership test) is now exported</li>
	    <li>New feature: Matrix Programs that are loaded into devices (like cyberdecks) are now correctly exported. Programs in Data Storage show up as normal gear on the Equipment tab.</li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>0.3.1</h4>
	  <ul>
	    <li>Bugfix: Fixed a bug that created a invalid result if the Personal Details contained any double quotes or line breaks.</li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>0.3.0</h4>
	  <ul>
	    <li>New feature: Adept Powers can now be exported</li>
	    <li>Experimental Feature: Guessing the Drain Stat. If Log, Int or Cha have the same values, it might pick the wrong one. If it can't be determined, will default to Logic. Please check this manually.</li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>0.2.0</h4>
	  <ul>
	    <li>New feature: Spells can now be exported</li>
	    <li>New feature: Knowledge skills are getting exported</li>
	    <li>New feature: same for Language skills</li>
	    <li>Experimental Feature: Trying to guess "Academic or Street" for knowledge skills, depending on their rating and total dicepools. Professional Skills will be identified as Academic and Interest Skills as Street. Please go over these and manually check.</li>
	    <li>Skill Specializations included and then disabled again. The import ignores them, and in worst case even crashes.</li>
	    <li>Added my email address in the bug report section :)</li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>0.1.2</h4>
	  <ul>
	    <li>Bugfix: Fixed a bug that created an invalid result if no negative quality was selected (or no quality at all)</li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	  <h4>0.1.1</h4>
	  <ul>
	    <li>Bugfix: Also works now if character is not a mage</li>
	    <li>Bugfix: Quotes in custom names now get properly escaped</li>
	    <li></li>
	    <li></li>
	    <li></li>
	    <li></li>
	  </ul>
	
	</div>
      </body>
    </html>
  </xsl:template>

 
  <xsl:template match="character">
{
  "?xml": {
    "@version": "1.0",
    "@encoding": "utf-8"
  },
  "herolab": {
    "version": {
	  "version": "<xsl:value-of select="/document/public/program/version/@version" />",
	  "build": "<xsl:value-of select="/document/public/program/version/@build" />"
	},
	"export": {
	  "version": "<xsl:value-of select="$version" />"
	}
  },
  "characters": {
    "character": {
      "limitastral": null,
      "limitphysical": null,
      "limitsocial": null,
      "limitmental": null,
      "composure": null,
      "memory": null,
      "judgeintentions": null,
      "liftandcarry": null,
      "name": "<xsl:apply-templates select="@name" />",
      "alias": "<xsl:apply-templates select="@name" />",
      "metatype": "<xsl:apply-templates select="race/@name" />",
      "sex": "<xsl:value-of select="personal/@gender" />",
      "age": "<xsl:value-of select="personal/@age" />",
      "height": "<xsl:value-of select="personal/charheight/@text" />",
      "weight": "<xsl:value-of select="personal/charweight/@text" />",
      "playername": "<xsl:value-of select="@playername" />",
      "description": "<xsl:apply-templates select="personal/description" />",
      "background": null,
      "notes": null,
      "gamenotes": null,
      "karma": "<xsl:value-of select="karma/@left" />",
      "totalkarma": "<xsl:value-of select="karma/@total" />",
      "init": "<xsl:value-of select="attributes/attribute[@name='Initiative']/@text" />", <!-- Not used but for now the best I can do -->
      "initvalue": "<xsl:value-of select="attributes/attribute[@name='Initiative']/@modified" />",
      "initbonus": "<xsl:call-template name="init-bonus" />",
      "initdice": "<xsl:call-template name="initiative-dice" />", <!-- Sorry, can't seem to extract that yet -->
      "armor": "<xsl:value-of select="armorratings/armorrating[@name='Armor']/@rating" />",
      "indirectdefenseresist": "<xsl:value-of select="defenses/defense[@name='Ranged Defense']/@normal" />",
      "astralinitdice": "3",
      "cmthresholdoffset": null, <!-- high pain tolerance -->
      "cmthreshold": null, <!-- eg. low pain tolerance -->
      "cmoverflow": null, <!-- doesn't exist -->
      "physicalcm": "<xsl:value-of select="conditionmonitors/conditionmonitor[@name='Physical Damage Track']/@boxes" />",
      "stuncm": "<xsl:value-of select="conditionmonitors/conditionmonitor[@name='Stun Damage Track']/@boxes" />",
      "totalstreetcred": "<xsl:value-of select="reputations/reputation[@name='Street Cred']/@value" />",
      "calculatedstreetcred": "<xsl:value-of select="reputations/reputation[@name='Street Cred']/@value" />",
      "totalnotoriety":"<xsl:value-of select="reputations/reputation[@name='Notoriety']/@value" />",
      "calculatednotoriety":"<xsl:value-of select="reputations/reputation[@name='Notoriety']/@value" />",
      "totalpublicawareness": "<xsl:value-of select="reputations/reputation[@name='Public Awareness']/@value" />",
      "calculatedpublicawareness": "<xsl:value-of select="reputations/reputation[@name='Public Awareness']/@value" />",
      "movement": "<xsl:apply-templates select='movementtypes' />",
      "nuyen": "<xsl:value-of select="cash/@total" />",
      "adept": <xsl:choose>
        <xsl:when test="heritage/@name = 'Adept'">"True"</xsl:when>
        <xsl:otherwise>"False"</xsl:otherwise>
      </xsl:choose>,
      "magician": <xsl:choose>
        <xsl:when test="contains(heritage/@name, 'Magician')">"True"</xsl:when>
        <xsl:when test="contains(heritage/@name, 'Mystic Adept')">"True"</xsl:when>
        <xsl:otherwise>"False"</xsl:otherwise>
      </xsl:choose>,
      "technomancer": <xsl:choose>
        <xsl:when test="heritage/@name = 'Technomancer'">"True"</xsl:when>
        <xsl:otherwise>"False"</xsl:otherwise>
      </xsl:choose>,
      "tradition": {
        "name": "<xsl:apply-templates select="magic/tradition/@name" />",
        "drain": "<xsl:value-of select="magic/tradition/@drain" />", <!-- Drainpool -->
        "drainattribute": {
          "attr": [
            "WIL",
            "<xsl:call-template name="determine-drain-attribute" />" <!-- Doesn't get provided, trying to guess -->
          ]
        },
        "spiritcombat": "<xsl:value-of select="magic/@combatspirits" />",
        "spiritdetection": "<xsl:value-of select="magic/@detectspirits" />",
        "spirithealth": "<xsl:value-of select="magic/@healthspirits" />",
        "spiritillusion": "<xsl:value-of select="magic/@illusionspirits" />",
        "spiritmanipulation": "<xsl:value-of select="magic/@manipulationspirits" />"
      },
      "attributes": [
        "0",
        {
          "attribute": [
            {
              "name": "BOD",<xsl:apply-templates select="attributes/attribute[@name='Body']" />
            },
            {
              "name": "AGI",<xsl:apply-templates select="attributes/attribute[@name='Agility']" />
            },
            {
              "name": "REA",<xsl:apply-templates select="attributes/attribute[@name='Reaction']" />
            },
            {
              "name": "STR",<xsl:apply-templates select="attributes/attribute[@name='Strength']" />
            },
            {
              "name": "CHA",<xsl:apply-templates select="attributes/attribute[@name='Charisma']" />
            },
            {
              "name": "INT",<xsl:apply-templates select="attributes/attribute[@name='Intuition']" />
            },
            {
              "name": "LOG",<xsl:apply-templates select="attributes/attribute[@name='Logic']" />
            },
            {
              "name": "WIL",<xsl:apply-templates select="attributes/attribute[@name='Willpower']" />
            },
            {
              "name": "INI", <!-- What the hell is this? -->
              "base": "2",
              "total": "2",
              "min": "2",
              "max": "12",
              "aug": "16",
              "bp": "0"
            },
            {
              "name": "EDG",<xsl:apply-templates select="attributes/attribute[@name='Edge']" />       
            },
            {
              "name": "MAG",<xsl:call-template name="magic-attribute" />
            },
            <xsl:if test="heritage/@name = 'Technomancer'">{
              "name": "RES",<xsl:apply-templates select="attributes/attribute[@name='Resonance']" />      
			},</xsl:if>
            {
              "name": "DEP", <!-- Again, Huh? AI attribute, I think -->
              "base": "0",
              "total": "0",
              "min": "0",
              "max": "0",
              "aug": "0",
              "bp": "0"
            },
            {
              "name": "ESS",
              "base": "<xsl:value-of select="attributes/attribute[@name='Essence']/@base" />"
            }
          ]
        }
      ], <!-- /attributes -->
      "powers": <xsl:call-template name="adeptpowers" />,
      "initiategrade": "<xsl:call-template name="initiate-grade" />",
      "metamagics": <xsl:call-template name="metamagic" />,
      "martialarts": null,
      "martialartmaneuvers": null,<!-- Not supported yet by HL -->
      "qualities": <xsl:call-template name="qualities" />,
      "cyberwares": <xsl:call-template name="cyberware" />,
      "armors": <xsl:call-template name="armor" />,
      "weapons": <xsl:call-template name="weapons" />,
      "complexforms": <xsl:call-template name="complexforms" />,
      "gears": <xsl:call-template name="equipment" />,
	  <!-- Programs are missing ? -->
      "vehicles": null, <!-- Not supported yet by HL -->
      "spells": <xsl:call-template name="spells" />,
      "contacts": <xsl:call-template name="contacts" />,
      "skills": {
        "skill": [
           <xsl:apply-templates select="skills" />
        ]
      }
    }
  }
}
  </xsl:template>

  <!-- General Templates -->
  
  <!-- Read @name and escape any double quotes -->
  <xsl:template match="@name">
    <xsl:call-template name="string-replace-quotes">
        <xsl:with-param name="text" select="." />
    </xsl:call-template>
  </xsl:template>

  <!-- excape any double quotes from supplied param "text" -->
  <xsl:template name="string-replace-quotes">
    <xsl:param name="text" />
    <xsl:call-template name="string-replace-all">
      <xsl:with-param name="text" select="$text" />
      <xsl:with-param name="replace" select="'&quot;'" />
      <xsl:with-param name="by" select="'\&quot;'" />
    </xsl:call-template>
  </xsl:template>
  
  
  <!-- String replace -->
  <xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />
    <xsl:choose>
        <xsl:when test="$text = '' or $replace = ''or not($replace)" >
            <!-- Prevent this routine from hanging -->
            <xsl:value-of select="$text" />
        </xsl:when>
        <xsl:when test="contains($text, $replace)">
            <xsl:value-of select="substring-before($text,$replace)" />
            <xsl:value-of select="$by" />
            <xsl:call-template name="string-replace-all">
                <xsl:with-param name="text" select="substring-after($text,$replace)" />
                <xsl:with-param name="replace" select="$replace" />
                <xsl:with-param name="by" select="$by" />
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$text" />
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

  <!-- returns the part of $string between $start-after and $end-before -->
  <xsl:template name="substring-between">
    <xsl:param name="string" />
    <xsl:param name="start-after" /> <!-- not included in result -->
    <xsl:param name="end-before" /> <!-- not included in result -->
	<xsl:variable name="result">
	  <xsl:value-of select="substring-before(substring-after($string, $start-after),$end-before)" />
	</xsl:variable>
	<xsl:value-of select="$result" />
  </xsl:template>

    
  <!-- Qualities -->
  <xsl:template name="qualities">
   <xsl:choose>
	  <xsl:when test="((qualities/positive = '') and (qualities/negative = ''))">
	    <xsl:text>null</xsl:text>
      </xsl:when>
	  <xsl:otherwise>{
        "quality": <xsl:apply-templates select="qualities/positive/quality | qualities/negative/quality" />
      }</xsl:otherwise>
	</xsl:choose>
  </xsl:template>

    <xsl:template match="personal/description">
        <xsl:call-template name="description" ><xsl:with-param name="text" select="." /></xsl:call-template>
    </xsl:template>

  <xsl:template match="/document/public/character/qualities/positive/quality | /document/public/character/qualities/negative/quality">
    <xsl:variable name="type">
	  <xsl:choose>
	    <xsl:when test="name(..) = 'positive'">Positive</xsl:when>
		<xsl:otherwise>Negative</xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
          {
            "name": "<xsl:apply-templates select="@name" />",
            "extra": null, <!-- already included in name -->
            "bp": "<xsl:value-of select="traitcost/@bp" />",
            "qualitytype": "<xsl:value-of select="$type" />",
            "qualitytype_english": "<xsl:value-of select="$type" />",
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>"
          }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
        ]</xsl:if>
  </xsl:template>
  
  
  <!-- Attribute -->
  <xsl:template match="attributes/attribute">
              "base": "<xsl:value-of select="@base" />",
              "total": "<xsl:value-of select="@modified" />",
              "min": "<xsl:value-of select="@minimum" />",
              "max": "<xsl:value-of select="@naturalmaximum" />",
              "aug": "<xsl:value-of select="@augmentedmaximum" />",
              "bp": null <!-- needed? -->
  </xsl:template>
	
  <!-- Test if magic attribute exists, otherwise fill with zero values	-->
  <xsl:template name="magic-attribute">
    <xsl:choose>
	  <xsl:when test="attributes/attribute[@name='Magic']">
        <xsl:apply-templates select="attributes/attribute[@name='Magic']" />
	  </xsl:when>
	  <xsl:otherwise>
              "base": "0",
              "total": "0",
              "min": "0",
              "max": "0",
              "aug": "0",
              "bp": null <!-- needed? -->
      </xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <!-- Armor -->
  <xsl:template name="armor">
    <xsl:choose>
     <xsl:when test="gear/armor = ''">null</xsl:when>
     <xsl:otherwise>{
        "armor": <xsl:apply-templates select="gear/armor/item" />
      }</xsl:otherwise></xsl:choose>
  </xsl:template>
  
  <xsl:template match="gear/armor/item">
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
          {
            "name": "<xsl:apply-templates select="@name" />",
            "name_english": "<xsl:apply-templates select="@name" />",
            <!-- Not removing "+" from armor rating to use with non-advanced sheet -->
            <!--"armor": "<xsl:apply-templates select="armorinfo/@rating" />",-->
            "armor": "<xsl:value-of select="armorinfo/@rating" />",
            "category": "",
            "equipped": <xsl:choose>
                            <xsl:when test="armorinfo/@equipped = 'yes'">"True"</xsl:when>
                            <xsl:otherwise>"False"</xsl:otherwise>
                        </xsl:choose>,
            "armormods": <xsl:call-template name="armormods" />,
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>"
          }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
        ]</xsl:if>
  </xsl:template>

  <xsl:template match="gear/armor/item/armorinfo/@rating">
    <xsl:variable name="rating" select="substring-after(., '+')" />
    <xsl:choose>
      <xsl:when test="not($rating)">
        <xsl:value-of select="." />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$rating" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Armor modifications -->
  <xsl:template name="armormods">
    <xsl:choose>
      <xsl:when test="(not(modifications)) or (modifications = '')">null</xsl:when>
      <xsl:otherwise>{
              "armormod": <xsl:apply-templates select="modifications/item" />
            }</xsl:otherwise></xsl:choose>
  </xsl:template>

  <xsl:template match="gear/armor/item/modifications/item">
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
                {
                  "name": "<xsl:apply-templates select="@name" />",
                  "name_english": "<xsl:apply-templates select="@name" />",
                  "rating": "<xsl:value-of select="@rating" />",
                  "description": "<xsl:call-template name="description" >
                                      <xsl:with-param name="text" select="description" />
                                  </xsl:call-template>"
                }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
              ]</xsl:if>
  </xsl:template>

  <!-- Weapon -->
  <xsl:template name="weapons">
    <xsl:choose>
      <xsl:when test="gear/weapons = ''">null</xsl:when>
      <xsl:otherwise>{
        "weapon": <xsl:apply-templates select="gear/weapons/item" />
      }</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="gear/weapons/item">
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
          {
            "name": "<xsl:apply-templates select="@name" />",
            "name_english": "<xsl:apply-templates select="@name" />",
            "category": "<xsl:value-of select="weaponinfo/@grouptext" />",
            "type": "<xsl:call-template name="weapon_type" />",
            "reach": "<xsl:call-template name="weapon_reach" />",
            "accuracy": "<xsl:call-template name="weapon_accuracy" />", 
            "dicepool": "<xsl:call-template name="weapon_dicepool" />",
            "damage_english": "<xsl:value-of select="weaponinfo/@damagetext" />",
            "damage": "<xsl:value-of select="weaponinfo/@damagetext" />",
            "ap": "<xsl:value-of select="weaponinfo/@ap" />",
            "skill": "<xsl:call-template name="weapon_skill" />",
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>",
            "mode": "<xsl:value-of select="weaponinfo/@modestext" />",
            "ranges": {<xsl:apply-templates select="weaponinfo/ranges" />
            },
            "rc": "<xsl:call-template name="weapon_recoil" />"<!-- Comment, so I can have a linebreak
         --><xsl:call-template name="weaponmods" />
          }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
        ]</xsl:if>
  </xsl:template>
  
  <!-- Weapon modifications -->
  <xsl:template name="weaponmods">
    <xsl:if test="((modifications) and (modifications != ''))">,
            "accessories": {
              "accessory": <xsl:apply-templates select="modifications/item" />
            }</xsl:if>
  
  </xsl:template>

  <xsl:template match="weaponinfo/ranges">
      <xsl:variable name="minimum" select="range[@name='Minimum']/@value" />
      <xsl:variable name="short" select="range[@name='Short']/@value" />
      <xsl:variable name="medium" select="range[@name='Medium']/@value" />
      <xsl:variable name="long" select="range[@name='Long']/@value" />
      <xsl:variable name="extreme" select="range[@name='Extreme']/@value" />
              "short": "<xsl:value-of select="$minimum" />-<xsl:value-of select="$short" />",
              "medium": "<xsl:value-of select="$short + 1" />-<xsl:value-of select="$medium" />",
              "long": "<xsl:value-of select="$medium + 1" />-<xsl:value-of select="$long" />",
              "extreme": "<xsl:value-of select="$long + 1" />-<xsl:value-of select="$extreme" />"
  </xsl:template>
  
  <xsl:template match="gear/weapons/item/modifications/item">
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
                {
                  "name": "<xsl:apply-templates select="@name" />",
                  "description": "<xsl:call-template name="description" >
                                      <xsl:with-param name="text" select="description" />
                                  </xsl:call-template>"
                }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
              ]</xsl:if>
  </xsl:template>
  
  <xsl:template name="weapon_recoil">
    <xsl:choose>
      <xsl:when test="weaponinfo/@recoilcomp"><xsl:value-of select="weaponinfo/@recoilcomp" /></xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
  </xsl:template>

  <xsl:template name="weapon_reach">
    <xsl:choose>
      <xsl:when test="((weaponinfo/@reach) and (weaponinfo/@reach != ''))"><xsl:value-of select="weaponinfo/@reach" /></xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="weapon_type">
    <xsl:choose>
      <xsl:when test="weaponinfo/ranges">Ranged</xsl:when>
      <xsl:otherwise>Melee</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Extract Accurcy from dicepool -->
  <xsl:template name="weapon_accuracy">
    <xsl:call-template name="substring-between">
      <xsl:with-param name="string" select="weaponinfo/@dicepool" />
      <xsl:with-param name="start-after" select="'['" />
      <xsl:with-param name="end-before" select="']'" />
    </xsl:call-template>
  </xsl:template>	

  <!-- Extract Dicepool from dicepool -->
  <xsl:template name="weapon_dicepool">
    <xsl:call-template name="substring-between">
      <xsl:with-param name="string" select="weaponinfo/@dicepool" />
      <xsl:with-param name="start-after" select="''" />
      <xsl:with-param name="end-before" select="'dicepool'" />
    </xsl:call-template>
  </xsl:template>	

  <!-- Determining Weapon Skills -->
  <xsl:template name="weapon_skill">
    <xsl:variable name="currentskill">
	  <xsl:value-of select="weaponinfo/@grouptext" /> 
	</xsl:variable>
	<xsl:choose>

      <!-- Melee Weapons -->
      <!-- Blades-->
	  <xsl:when test="$currentskill='Blades'">Blades</xsl:when>
      
      <!-- Clubs -->
	  <xsl:when test="$currentskill='Clubs'">Clubs</xsl:when>
      
      <!-- Unarmed Combat -->
	  <xsl:when test="$currentskill='Unarmed'">Unarmed Combat</xsl:when>

      <!-- Exotic Melee Weapons -->
	  <xsl:when test="$currentskill='Exotic Melee Weapons'">Exotic Melee Weapon</xsl:when>

      <!-- Ranged Weapons -->
      <!-- Archery -->
	  <xsl:when test="$currentskill='Bows'">Archery</xsl:when>
	  <xsl:when test="$currentskill='Crossbows'">Archery</xsl:when>
	  <xsl:when test="$currentskill='Harpoon Guns'">Archery</xsl:when>
	  <xsl:when test="$currentskill='Slingshots'">Archery</xsl:when>

      <!-- Automatics -->
	  <xsl:when test="$currentskill='Assault Rifles'">Automatics</xsl:when>
	  <xsl:when test="$currentskill='Machine Pistols'">Automatics</xsl:when>
	  <xsl:when test="$currentskill='Submachine Guns'">Automatics</xsl:when>

      <!-- Heavy Weapons -->
      <xsl:when test="$currentskill='Assault Cannons'">Heavy Weapons</xsl:when>
	  <xsl:when test="$currentskill='Grenade Launchers'">Heavy Weapons</xsl:when>
	  <xsl:when test="$currentskill='Heavy Machineguns'">Heavy Weapons</xsl:when>
	  <xsl:when test="$currentskill='Light Machineguns'">Heavy Weapons</xsl:when>
	  <xsl:when test="$currentskill='Medium Machineguns'">Heavy Weapons</xsl:when>
	  <xsl:when test="$currentskill='Missile Launchers'">Heavy Weapons</xsl:when>
	  
      <!-- Pistols -->
      <xsl:when test="$currentskill='Pistols'">Pistols</xsl:when>
	  <xsl:when test="$currentskill='Tasers'">Pistols</xsl:when>
	  
      <!-- Longarms -->
      <xsl:when test="$currentskill='Shotguns'">Longarms</xsl:when>
	  <xsl:when test="$currentskill='Sporting Rifles'">Longarms</xsl:when>
	  <xsl:when test="$currentskill='Sniper Rifles'">Longarms</xsl:when>

      <!-- Throwing Weapons -->
	  <xsl:when test="$currentskill='Grenades'">Throwing Weapons</xsl:when>
	  <xsl:when test="$currentskill='Throwing Weapons'">Throwing Weapons</xsl:when>

      <!-- Exotic Ranged Weapons -->
	  <xsl:when test="$currentskill=''">Exotic Ranged Weapon</xsl:when>
	  <xsl:when test="$currentskill='Exotic Ranged Weapon'">Exotic Ranged Weapon</xsl:when>
	  <xsl:when test="$currentskill='Special Weapons'">Exotic Ranged Weapon</xsl:when>
      
      <xsl:otherwise><xsl:value-of select="$currentskill" /></xsl:otherwise>
	</xsl:choose>
  </xsl:template>	

  
  <!-- Equipment -->
  <xsl:template name="equipment">
  <xsl:choose>
    <xsl:when test="gear/equipment = ''">null</xsl:when>
    <xsl:otherwise>{
        "gear": <xsl:apply-templates select="gear/equipment/item | gear/equipment/item/programs/item | gear/augmentations/cyberware/item/programs/item | identities/identity/license" />
      }</xsl:otherwise></xsl:choose>
  </xsl:template>
   
  <xsl:template match="identities/identity/license">
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
          {
            "name": "<xsl:apply-templates select="@name" />",
            "rating": "<xsl:value-of select="@rating" />",
            "qty": "1",
            "extra": "<xsl:value-of select="@for" />",
            "category": "",
            "description": "",
            "category_english": null <!-- not given, maybe not important -->
            }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
        ]</xsl:if>
  </xsl:template>

  <xsl:template match="gear/equipment/item">
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
          {
            "name": "<xsl:apply-templates select="@name" />",
            "rating": "<xsl:value-of select="@rating" />",
            "qty": "<xsl:value-of select="@quantity" />",
            "category": "", <!--- not given -->
            "category_english": "", <!-- not given, maybe not important -->
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>"
          }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
        ]</xsl:if>
  </xsl:template>
  
  <!-- Matrix Programs -->
  <xsl:template match="gear/equipment/item/programs/item | gear/augmentations/cyberware/item/programs/item">
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
          {
            "name": "<xsl:apply-templates select="@name" />",
            "qty": "<xsl:value-of select="@quantity" />",
            "isprogram": "True",
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>",
            "category_english": "Hacking Programs" <!-- Doesn't matter if Common or Hacking, as long as it's either -->
          }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
        ]</xsl:if>
  </xsl:template>
  
  <!-- Skills -->
  <xsl:template match="skills">
    <xsl:apply-templates select="active/skill | knowledge/skill | language/skill" />
    <!--xsl:apply-templates select="knowledge/skill" />
    <xsl:apply-templates select="language/skill" /-->
  </xsl:template>

  <!-- Active Skills -->  
  <xsl:template match="skills/active/skill">
          {
            "name": "<xsl:call-template name="skill-check-name" />",
            "skillcategory_english": "doesn't seem to matter",
            "rating": "<xsl:value-of select="@base" />",
            "ratingmod": "<xsl:value-of select="@modified - @base" />",
            "total": "<xsl:value-of select="@dicepool" />",
            "knowledge": "False",
            "islanguage": "False",
            "exotic": <xsl:choose>
                         <xsl:when test="contains(@name, 'Exotic')">"True",</xsl:when>
						 <xsl:otherwise>"False",</xsl:otherwise>
					  </xsl:choose>
            "attribute": "<xsl:call-template name="skill-attribute" />",
            "attributemod": "<xsl:value-of select="@dicepool - @base" />",
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>",
            "skillspecializations": <xsl:call-template name="skill-specialization" />
          }<xsl:if test="position() != last()">,</xsl:if>
          <!-- If we're at the last active skill and none of them was Spellcasting, and the character is either a mage or a mystic adept, then... -->
          <xsl:if test="(position() = count(../skill)) and (not(../skill[@name='Spellcasting'])) and ((contains(../../../heritage/@name, 'Magician')) or (contains(../../../heritage/@name, 'Mystic Adept')) )"> 
            <xsl:if test="position() = last()">,</xsl:if> <!-- need to add the comma if I didn't before -->
          {
            "name": "Spellcasting",
            "skillcategory_english": "doesn't seem to matter",
            "rating": "0",
            "total": "0",
            "knowledge": "False",
            "exotic": "False",
            "attribute": "MAG",
            "attributemod": "0",
            "description": "",
            "skillspecializations": null
          }<xsl:if test="position() != last()">,</xsl:if>
          </xsl:if>
  </xsl:template>

  <!-- Check for differences between Hero Lab and Chummer names and change them to Chummer -->
  <xsl:template name="skill-check-name">
    <xsl:choose>
	  <xsl:when test="@name='Free Fall'">Free-Fall</xsl:when>
	  <xsl:otherwise><xsl:apply-templates select="@name" /></xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Find attribute and add it -->
  <xsl:template name="skill-attribute">
    <xsl:variable name="currentskill">
	  <xsl:call-template name='skill-check-name' /> 
	</xsl:variable>
	<xsl:choose>
	  <xsl:when test="$currentskill='Aeronautics Mechanic'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Alchemy'">MAG</xsl:when>
	  <xsl:when test="$currentskill='Animal Handling'">CHA</xsl:when>
	  <xsl:when test="$currentskill='Arcana'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Archery'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Armorer'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Artificing'">MAG</xsl:when>
	  <xsl:when test="$currentskill='Artisan'">INT</xsl:when>
	  <xsl:when test="$currentskill='Assensing'">INT</xsl:when>
	  <xsl:when test="$currentskill='Astral Combat'">WIL</xsl:when>
	  <xsl:when test="$currentskill='Automatics'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Automotive Mechanic'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Banishing'">MAG</xsl:when>
	  <xsl:when test="$currentskill='Binding'">MAG</xsl:when>
	  <xsl:when test="$currentskill='Biotechnology'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Blades'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Chemistry'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Clubs'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Compiling'">RES</xsl:when>
	  <xsl:when test="$currentskill='Computer'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Con'">CHA</xsl:when>
	  <xsl:when test="$currentskill='Counterspelling'">MAG</xsl:when>
	  <xsl:when test="$currentskill='Cybercombat'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Cybertechnology'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Decompiling'">RES</xsl:when>
	  <xsl:when test="$currentskill='Demolitions'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Disenchanting'">MAG</xsl:when>
	  <xsl:when test="$currentskill='Disguise'">INT</xsl:when>
	  <xsl:when test="$currentskill='Diving'">BOD</xsl:when>
	  <xsl:when test="$currentskill='Electronic Warfare'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Escape Artist'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Etiquette'">CHA</xsl:when>
	  <xsl:when test="$currentskill='Exotic Melee Weapon'">AGI</xsl:when> <!-- Name does not get submitted :( -->
	  <xsl:when test="$currentskill='Exotic Ranged Weapon'">AGI</xsl:when>
	  <xsl:when test="$currentskill='First Aid'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Flight'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Forgery'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Free Fall'">BOD</xsl:when>
	  <xsl:when test="$currentskill='Gunnery'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Gymnastics'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Hacking'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Hardware'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Heavy Weapons'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Impersonation'">CHA</xsl:when>
	  <xsl:when test="$currentskill='Industrial Mechanic'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Instruction'">CHA</xsl:when>
	  <xsl:when test="$currentskill='Intimidation'">CHA</xsl:when>
	  <xsl:when test="$currentskill='Leadership'">CHA</xsl:when>
	  <xsl:when test="$currentskill='Locksmith'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Longarms'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Medicine'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Nautical Mechanic'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Navigation'">INT</xsl:when>
	  <xsl:when test="$currentskill='Negotiation'">CHA</xsl:when>
	  <xsl:when test="$currentskill='Palming'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Perception'">INT</xsl:when>
	  <xsl:when test="$currentskill='Performance'">CHA</xsl:when>
	  <xsl:when test="$currentskill='Pilot Aerospace'">REA</xsl:when>
	  <xsl:when test="$currentskill='Pilot Aircraft'">REA</xsl:when>
	  <xsl:when test="$currentskill='Pilot Ground Craft'">REA</xsl:when>
	  <xsl:when test="$currentskill='Pilot Walker'">REA</xsl:when>
	  <xsl:when test="$currentskill='Pilot Watercraft'">REA</xsl:when>
	  <xsl:when test="$currentskill='Pistols'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Registering'">RES</xsl:when>
	  <xsl:when test="$currentskill='Ritual Spellcasting'">MAG</xsl:when>
	  <xsl:when test="$currentskill='Running'">STR</xsl:when>
	  <xsl:when test="$currentskill='Sneaking'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Software'">LOG</xsl:when>
	  <xsl:when test="$currentskill='Spellcasting'">MAG</xsl:when>
	  <xsl:when test="$currentskill='Summoning'">MAG</xsl:when>
	  <xsl:when test="$currentskill='Survival'">WIL</xsl:when>
	  <xsl:when test="$currentskill='Swimming'">STR</xsl:when>
	  <xsl:when test="$currentskill='Throwing Weapons'">AGI</xsl:when>
	  <xsl:when test="$currentskill='Tracking'">INT</xsl:when>
	  <xsl:when test="$currentskill='Unarmed Combat'">AGI</xsl:when>
      <xsl:otherwise>NOT RECOGNIZED! ERROR!</xsl:otherwise>
	</xsl:choose>
  </xsl:template>  
  
  <!-- Knowledge Skill -->
  <xsl:template match="skills/knowledge/skill">
          {
            "name": "<xsl:call-template name="skill-check-name" />",
            "skillcategory_english": "<xsl:call-template name="knowledge-skill-type" />",
            "rating": "<xsl:value-of select="@base" />",
            "ratingmod": "<xsl:value-of select="@modified - @base" />",
            "total": "<xsl:value-of select="@dicepool" />",
            "islanguage": "False",
            "knowledge": "True",
            "exotic": "False",
            "attribute": "<xsl:call-template name="knowledge-skill-attribute" />", <!-- Seems to get ignored anyway -->
            "attributemod": "<xsl:value-of select="@dicepool - @base" />",
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>",
            "skillspecializations": <xsl:call-template name="skill-specialization" />
          }<xsl:if test="position() != last()">,</xsl:if>
  </xsl:template>

  <xsl:template name="knowledge-skill-type">
    <xsl:variable name="attributemod" select="@dicepool - @base" />
	<xsl:variable name="log" select="/document/public/character/attributes/attribute[@name='Logic']/@base" />
	<xsl:variable name="int" select="/document/public/character/attributes/attribute[@name='Intuition']/@base" />
	<xsl:choose>
	  <xsl:when test="$log=$attributemod">Academic</xsl:when>
	  <xsl:otherwise>Street</xsl:otherwise>
	</xsl:choose>
  </xsl:template>

  <xsl:template name="knowledge-skill-attribute">
	<xsl:variable name="type">
	  <xsl:call-template name="knowledge-skill-type" />
	</xsl:variable>
	<xsl:choose>
	  <xsl:when test="$type='Academic'">LOG</xsl:when>
	  <xsl:otherwise>INT</xsl:otherwise>
	</xsl:choose>
  </xsl:template>

    <!-- Language Skill -->
  <xsl:template match="skills/language/skill">
          {
            "name": "<xsl:call-template name="skill-check-name" />",
            "skillcategory_english": "Language",
            "rating": "<xsl:call-template name="language-skill-rating" />",
            "ratingmod": "<xsl:value-of select="@modified - @base" />",
            "total": "<xsl:call-template name="language-skill-total" />",
            "islanguage": "True",
            "knowledge": "True",
            "exotic": "False",
            "attribute": "INT", <!-- Seems to get ignored anyway -->
            "attributemod": "<xsl:value-of select="@dicepool - @base" />",
            "skillspecializations": <xsl:call-template name="skill-specialization" />,
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>"
          }<xsl:if test="position() != last()">,</xsl:if>
  </xsl:template>

  <!-- If Native language set rating to 0 -->
  <xsl:template name="language-skill-rating">
	<xsl:choose>
	  <xsl:when test="@text='N'">0</xsl:when>
	  <xsl:otherwise><xsl:value-of select="@base" /></xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <xsl:template name="language-skill-total">
  	<xsl:choose>
	  <xsl:when test="@text='N'">0</xsl:when>
	  <xsl:otherwise><xsl:value-of select="@dicepool" /></xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <!-- Skill Specializations -->
  <xsl:template name="skill-specialization">
    <xsl:choose>
	  <xsl:when test="not(specialization)">null</xsl:when>
	  <xsl:otherwise>{
              "skillspecialization": <xsl:apply-templates select="specialization" />
            }</xsl:otherwise>
	</xsl:choose>
  </xsl:template>

    <xsl:template match="skill/specialization">
    <xsl:variable name="specNameWithoutQuotes">
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text" select="@bonustext" />
            <xsl:with-param name="replace" select="'&quot;'" />
            <xsl:with-param name="by" select="'\&quot;'" />
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="specNameWithoutPlusTwo">
        <xsl:call-template name="string-replace-all">
            <xsl:with-param name="text" select="$specNameWithoutQuotes" />
            <xsl:with-param name="replace" select="' +2'" />
            <xsl:with-param name="by" select="''" />
        </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="specBonus">
        <xsl:if test="contains($specNameWithoutQuotes, '+2')">+2</xsl:if>
    </xsl:variable>
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
                {
                  "name": "<xsl:value-of select="$specNameWithoutPlusTwo" />",
                  "specbonus": "<xsl:value-of select="$specBonus" />"
                }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
              ]</xsl:if>
  </xsl:template>
    
  <!-- Initiative -->
  <!-- Extract Initiative Dice from text -->
  <xsl:template name="initiative-dice">
    <xsl:call-template name="substring-between">
      <xsl:with-param name="string" select="attributes/attribute[@name='Initiative']/@text" />
      <xsl:with-param name="start-after" select="'+'" />
      <xsl:with-param name="end-before" select="'D'" />
    </xsl:call-template>
  </xsl:template>

  <!-- Init Bonus -->
  <xsl:template name="init-bonus">
    <xsl:variable name="init-numeral">
      <xsl:value-of select="attributes/attribute[@name='Initiative']/@modified" />
    </xsl:variable>
    <xsl:variable name="reaction">
      <xsl:value-of select="attributes/attribute[@name='Reaction']/@modified" />
    </xsl:variable>
    <xsl:variable name="intuition">
      <xsl:value-of select="attributes/attribute[@name='Intuition']/@modified" />
    </xsl:variable>
    <xsl:variable name="bonus">
      <xsl:value-of select="$init-numeral - $reaction - $intuition" />
    </xsl:variable>
    <xsl:value-of select="$bonus" />   
  </xsl:template>

 

  <!-- Cyberware and Bioware-->
  <xsl:template name="cyberware">
    <xsl:choose>
	  <xsl:when test="((gear/augmentations/cyberware = '') and (gear/augmentations/bioware = ''))">null</xsl:when>
	  <xsl:otherwise>{
        "cyberware": <xsl:apply-templates select="gear/augmentations/cyberware/item | gear/augmentations/bioware/item" />
      }</xsl:otherwise></xsl:choose>
  </xsl:template>

  <!-- template for single item -->
  <xsl:template match="gear/augmentations/cyberware/item | gear/augmentations/bioware/item">
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
          {
            "name": "<xsl:call-template name="ware-fix-name" />",
            "ess": "<xsl:value-of select="@essencecost" />",
            "rating": "<xsl:value-of select="@rating" />",
            "grade": "<xsl:call-template name="ware-grade" />",
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>"
          }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
        ]</xsl:if>
  </xsl:template>  
  
  <!-- See if name includes a grade, if so, remove it -->
  <xsl:template name="ware-fix-name">
	  <xsl:variable name="grade1" select="' (Alphaware)'" />
	  <xsl:variable name="grade2" select="' (Betaware)'" />
	  <xsl:variable name="grade3" select="' (Gammaware)'" />
	  <xsl:variable name="grade4" select="' (Deltaware)'" />
	  <xsl:variable name="grade5" select="' (Omegaware)'" />
	  <xsl:variable name="grade6" select="' (Used)'" />
	  <xsl:variable name="name">
	    <xsl:apply-templates select="@name" />
      </xsl:variable>
	  
    <xsl:choose>
	  <xsl:when test="$grade1 = substring($name, string-length($name) - string-length($grade1) +1)"><xsl:value-of select="substring($name,1,string-length($name) - string-length($grade1))" /></xsl:when>
	  <xsl:when test="$grade2 = substring($name, string-length($name) - string-length($grade2) +1)"><xsl:value-of select="substring($name,1,string-length($name) - string-length($grade2))" /></xsl:when>
	  <xsl:when test="$grade3 = substring($name, string-length($name) - string-length($grade3) +1)"><xsl:value-of select="substring($name,1,string-length($name) - string-length($grade3))" /></xsl:when>
	  <xsl:when test="$grade4 = substring($name, string-length($name) - string-length($grade4) +1)"><xsl:value-of select="substring($name,1,string-length($name) - string-length($grade4))" /></xsl:when>
	  <xsl:when test="$grade5 = substring($name, string-length($name) - string-length($grade5) +1)"><xsl:value-of select="substring($name,1,string-length($name) - string-length($grade5))" /></xsl:when>
	  <xsl:when test="$grade6 = substring($name, string-length($name) - string-length($grade6) +1)"><xsl:value-of select="substring($name,1,string-length($name) - string-length($grade6))" /></xsl:when>
	  <xsl:otherwise><xsl:apply-templates select="@name" /></xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
    <!-- Find out the grade of the ware -->
  <xsl:template name="ware-grade">
	  <xsl:variable name="grade1" select="' (Alphaware)'" />
	  <xsl:variable name="grade2" select="' (Betaware)'" />
	  <xsl:variable name="grade3" select="' (Gammaware)'" />
	  <xsl:variable name="grade4" select="' (Deltaware)'" />
	  <xsl:variable name="grade5" select="' (Omegaware)'" />
	  <xsl:variable name="grade6" select="' (Used)'" />
    <xsl:choose>
	  <xsl:when test="$grade1 = substring(@name, string-length(@name) - string-length($grade1) +1)">Alphaware</xsl:when>
	  <xsl:when test="$grade2 = substring(@name, string-length(@name) - string-length($grade2) +1)">Betaware</xsl:when>
	  <xsl:when test="$grade3 = substring(@name, string-length(@name) - string-length($grade3) +1)">Gammaware</xsl:when>
	  <xsl:when test="$grade4 = substring(@name, string-length(@name) - string-length($grade4) +1)">Deltaware</xsl:when>
	  <xsl:when test="$grade5 = substring(@name, string-length(@name) - string-length($grade5) +1)">Omegaware</xsl:when>
	  <xsl:when test="$grade6 = substring(@name, string-length(@name) - string-length($grade6) +1)">Used</xsl:when>
	  <xsl:otherwise>Standard</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <!-- Determine Initiate Grade -->
  <xsl:template name="initiate-grade">
    <xsl:choose>
	  <xsl:when test="not(attributes/attribute[@name='Initiate Grade'])">0</xsl:when>
	  <xsl:otherwise><xsl:value-of select="attributes/attribute[@name='Initiate Grade']/@base" /></xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  
  <!-- Metamagic -->
  <xsl:template name="metamagic">
    <xsl:choose>
	  <xsl:when test="((not(magic/metamagics)) or (magic/metamagics = ''))">null</xsl:when>
	  <xsl:otherwise>{
        "metamagic": <xsl:apply-templates select="magic/metamagics/metamagic" />
      }</xsl:otherwise></xsl:choose>
  </xsl:template>

  <xsl:template match="magic/metamagics/metamagic">
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
          {
            "name": "<xsl:apply-templates select="@name" />"
          }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
        ]</xsl:if>
  </xsl:template>
  
  <!-- Spells -->
  <xsl:template name="spells">
    <xsl:choose>
	  <xsl:when test="((not(magic/spells)) or (magic/spells = ''))">null</xsl:when>
	  <xsl:otherwise>{
        "spell": <xsl:apply-templates select="magic/spells/spell" />
      }</xsl:otherwise></xsl:choose>
  </xsl:template>

<!-- Disabled for now! It's working as soon as the sheet get fixed -->  
<!-- Change name to match and the - to / ! -->  
  <xsl:template name="magic-spells-spell">
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
          {
            "name": "<xsl:apply-templates select="@name" />",
            "descriptors": "<xsl:value-of select="@subcat" />",
            "category": "<xsl:value-of select="@category" />",
            "type": "<xsl:call-template name="spell-type" />", 
            "range": "<xsl:call-template name="spell-range" />", 
            "duration": "<xsl:call-template name="spell-duration" />",
            "dv": "<xsl:value-of select="@draintext" />",
            "alchemy": "False", <!-- No way to figure this out,defaulting to Spell -->
            "dicepool": "<xsl:value-of select="@casting" />",
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>"
          }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
        ]</xsl:if>
  </xsl:template>

  <!-- Workaround version. Use the one above once sheet is fixed -->
  <xsl:template match="magic/spells/spell">
    <xsl:if test="(position() = 1)">[</xsl:if>
          {
            "name": "<xsl:apply-templates select="@name" />",
            "descriptors": "<xsl:value-of select="@subcat" />",
            "category": "<xsl:value-of select="@category" />",
            "type": "<xsl:call-template name="spell-type" />", 
            "range": "<xsl:call-template name="spell-range" />", 
            "duration": "<xsl:call-template name="spell-duration" />",
            "dv": "<xsl:value-of select="@draintext" />",
            "alchemy": <xsl:call-template name="determine-is-alchemy" />,
            "dicepool": "<xsl:value-of select="@casting" />",
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>"
          }<xsl:if test="position() != last()">,</xsl:if>
          <xsl:if test="last() = 1"> <!-- if there's only one spell, add a second dummy one -->
          ,{
            "name": "",
            "descriptors": "",
            "category": "",
            "type": "", 
            "range": "", 
            "duration": "",
            "dv": "0",
            "alchemy": "False", <!-- No way to figure this out,defaulting to Spell -->
            "dicepool": "0"
          }</xsl:if>
    <xsl:if test="(position() = last())">
        ]</xsl:if>
  </xsl:template>

            
            
  <!-- Spells Sub-Templates -->
  <xsl:template name="spell-type">
    <xsl:value-of select="substring(@type, 1, 1)" />
  </xsl:template>

  <xsl:template name="spell-range">
    <xsl:choose>
	  <xsl:when test="@range='Touch'">T</xsl:when>
	  <xsl:when test="@range='Line-of-Sight'">LOS</xsl:when>
	  <xsl:otherwise><xsl:value-of select="@range" /></xsl:otherwise>
	</xsl:choose>
    <xsl:if test="contains(@subcat, 'Area')"> (A)</xsl:if>
  </xsl:template>

  <xsl:template name="spell-duration">
    <xsl:value-of select="substring(@duration, 1, 1)" />
  </xsl:template>

  <xsl:template name="determine-is-alchemy">
    <xsl:variable name="dicepool" select="@casting" />
    <xsl:variable name="spellcasting" select="/document/public/character/skills/active/skill[@name='Spellcasting']/@dicepool" />
    <xsl:variable name="alchemy" select="/document/public/character/skills/active/skill[@name='Alchemy']/@dicepool" />
    <xsl:choose>
      <xsl:when test="$spellcasting=$dicepool">"False"</xsl:when>
      <xsl:when test="$alchemy=$dicepool">"True"</xsl:when>
      <xsl:otherwise>"False"</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Complex Forms -->  
  <!-- Unfortunately bugged. Setting to null -->  
  <xsl:template name="complexforms">
    <xsl:text>null</xsl:text>
    <!--xsl:choose>
	  <xsl:when test="((not(magic/spells)) or (magic/spells = ''))">null</xsl:when>
	  <xsl:otherwise>{
        "spell": [<xsl:apply-templates select="magic/spells/spell" />
        ]
      }</xsl:otherwise></xsl:choose-->
  </xsl:template>

  <!-- Adept Powers -->  
  <xsl:template name="adeptpowers">
    <xsl:choose>
	  <xsl:when test="((not(magic/adeptpowers)) or (magic/adeptpowers = ''))">null</xsl:when>
	  <xsl:otherwise>{
        "power": <xsl:apply-templates select="magic/adeptpowers/adeptpower" />
      }</xsl:otherwise></xsl:choose>
  </xsl:template>

  <xsl:template match="magic/adeptpowers/adeptpower">
    <xsl:if test="(position() = 1) and (last() > 1)">[</xsl:if>
          {
            "name": "<xsl:apply-templates select="@name" />",
            "fullname": "<xsl:apply-templates select="@text" />",
            "rating": "<xsl:value-of select="@rating" />",
            "totalpoints": "<xsl:value-of select="traitcost/@powerpoints" />",
            "description": "<xsl:call-template name="description" >
                                <xsl:with-param name="text" select="description" />
                            </xsl:call-template>"
          }<xsl:if test="position() != last()">,</xsl:if>
    <xsl:if test="(position() = last()) and (last() > 1)">
        ]</xsl:if>
  </xsl:template>
  
  <!-- Drain Attribute -->
  <!-- Doesn't get provided, trying to guess -->
  <xsl:template name="determine-drain-attribute">
	<xsl:variable name="will" select="/document/public/character/attributes/attribute[@name='Logic']/@base" /> <!-- Willpower is always used -->
    <xsl:variable name="attributemod" select="magic/tradition/@drain - $will" /> <!-- value of the other one -->
	<xsl:variable name="log" select="/document/public/character/attributes/attribute[@name='Logic']/@base" />
	<xsl:variable name="int" select="/document/public/character/attributes/attribute[@name='Intuition']/@base" />
	<xsl:variable name="cha" select="/document/public/character/attributes/attribute[@name='Charisma']/@base" />
	<xsl:choose>
	  <xsl:when test="$log=$attributemod">LOG</xsl:when>
	  <xsl:when test="$cha=$attributemod">CHA</xsl:when>
	  <xsl:when test="$int=$attributemod">INT</xsl:when>
	  <xsl:otherwise>LOG</xsl:otherwise> <!-- defaulting to LOG if nothing matches -->
	</xsl:choose>
  </xsl:template>

  <!-- Contacts -->  
  <xsl:template name="contacts">
    <xsl:choose>
	  <xsl:when test="((not(contacts)) or (contacts = ''))">null</xsl:when>
	  <xsl:otherwise>{
        "contact": [<xsl:apply-templates select="contacts/contact" />
        ]
      }</xsl:otherwise></xsl:choose>
  </xsl:template>

  <xsl:template match="contacts/contact">
        {
          "name": "<xsl:apply-templates select="@name" />",
          "rating": "<xsl:value-of select="@rating" />",
          "totalpoints": "<xsl:value-of select="traitcost/@powerpoints" />",
          "role": "<xsl:call-template name="string-replace-quotes">
                     <xsl:with-param name="text" select="@type" />
                   </xsl:call-template>", 
          "location": "Lalaland",
          "connection": "<xsl:value-of select="@connection" />",
          "loyalty": "<xsl:value-of select="@loyalty" />",
          "type": "Contact",
          "mademan": "False", <!-- No Info on this -->
          "blackmail": "False", <!-- No Info on this -->
          "family": "False" <!-- No Info on this -->
          }<xsl:if test="position() != last()">,</xsl:if>
  </xsl:template>
  
  <!-- Description -->
  <!-- Escape linebreaks and Quotes -->
  <!-- Actually only quotes for now, linebreaks done with Javascript -->
  <xsl:template name="description">
    <xsl:param name="text" />
    <xsl:variable name="newtext">
      <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="." />
          <xsl:with-param name="replace" select="'&quot;'" />
          <xsl:with-param name="by" select="'\&quot;'" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="newtext2">
      <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="$newtext" />
          <xsl:with-param name="replace" select="'&#10;'" /> <!-- /n -->
          <xsl:with-param name="by" select="' '" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="newtext3">
      <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="$newtext2" />
          <xsl:with-param name="replace" select="'&#13;'" /> <!-- /r -->
          <xsl:with-param name="by" select="''" />
      </xsl:call-template>
    </xsl:variable>
	<xsl:value-of select="$newtext3" /> <!-- change to newtext3 if ever active again -->
  </xsl:template>

  
</xsl:stylesheet>
