Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC37C591993
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiHMJ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbiHMJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 05:28:14 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8194F2A94F;
        Sat, 13 Aug 2022 02:28:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9EAF2320091A;
        Sat, 13 Aug 2022 05:28:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 13 Aug 2022 05:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660382892; x=1660469292; bh=MM
        klmZLyGf0toWbpCjfyEMIgLo7VHWmmRbes1zdNTXE=; b=HtuQqDPgDf+fItBU5M
        0H9IT3GguBRUDaN8u0hhXHwiabr6hGvhN4BhExO7Wy9v2zADoFd+iay5rx4NwLAg
        BNjysYj1LDwrOnoaXpIUI7gTzLvMw3UD5vVux6qbemEEOjM5mOKomZNStJvAavZx
        yqYU+jKGV9njaDYuo5NNpVv1Ak6uWSjjfasffLCRnWuH7TyOyhkPxV8F46ML8w3J
        49K3g8895nWEy2k1X4FsszbWbTZ0BKgbrsegwNs2safzmAoTc8l1c+zvR5GtdwPD
        CW8Tr/thDgaWB9AKDFtkv5UYx6spiWN33lkzQc3cfB7HGH2HiOvOfDdE1DGOBZpd
        iDKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660382892; x=1660469292; bh=MMklmZLyGf0to
        WbpCjfyEMIgLo7VHWmmRbes1zdNTXE=; b=RuTWNlEttqsCN0VWAHPGmI1O2iAAm
        XRSdveR0CjEAmXb3HT3PK7Qw9yWOvO8TZjPQBy+VN9HUGK6Z16GsRNFwQmWJdazA
        gOd0g8wvauByaly3mCqwFgePa6ZEhC7Mo7YmTzVxDBiKgIFYA0lfrhNKCGfFirwT
        pS9odkSXcZ0lSuyRhSsREbVZpT88Xpe1VDMfalABDN/yxYu0yVdJRS2x5Cg+h9g4
        ExJNFZ68MOWf3dHacJufZ6yFkUn2YBZhZh4H9espsjI+FLiAaNdTbZpFRcOXFxyQ
        TrrIeqlPyEMJIs2J8kc9MWqs1DTZVcgyIYPoG2Em34agpZZHUFGWhBtGQ==
X-ME-Sender: <xms:rG73YnumrDgoEf-_3TlN6GCfaCBlPRlj-hOYcaY0c6cLttGu1HBc6Q>
    <xme:rG73YoeAb6ogS4OotSw30DWZT8RAdbSylSIgqGsKavjYe5EhZ_cYYlIWtWblDV-6c
    dnTylaUdN6OK-51n34>
X-ME-Received: <xmr:rG73Yqxbx0SHvb3OKEhigOLVpRB70xzVqWPLrTl05-ATbEKrV_jSQBWLdgsX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:rG73YmP8sVTo7fl9sjZuKfZPUzrsKWNo1w50hNAF0FaPdOTr9t6_NA>
    <xmx:rG73Yn8sEbr2DeLx0cUyfDBvxSXKSJWaO5aZ1Ods7ewoDGammvcb4w>
    <xmx:rG73YmWoRE_50iTSpdOlE0dBGS8GsGbRUu77kYpslfj5ZG7GDJK01w>
    <xmx:rG73YpKq_7IfHEoOT4e6CC7OeZycT_MTWr2LMjpmUmNMoJwgRjr6DQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Aug 2022 05:28:08 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/2] asus-wmi: Add support for ROG X13 tablet mode
Date:   Sat, 13 Aug 2022 21:27:53 +1200
Message-Id: <20220813092753.6635-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220813092753.6635-1-luke@ljones.dev>
References: <20220813092753.6635-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirk for ASUS ROG X13 Flow 2-in-1 to enable tablet mode with
lid flip (all screen rotations).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-nb-wmi.c         | 15 +++++++++
 drivers/platform/x86/asus-wmi.c            | 37 ++++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |  1 +
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 4 files changed, 54 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 3a93e056c4e1..d4cc6afc1861 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -123,6 +123,11 @@ static struct quirk_entry quirk_asus_use_lid_flip_devid = {
 	.tablet_switch_mode = asus_wmi_lid_flip_devid,
 };
 
+static struct quirk_entry quirk_asus_tablet_mode = {
+	.wmi_backlight_set_devstate = true,
+	.tablet_switch_mode = asus_wmi_lid_flip_rog_devid,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
 	pr_info("Identified laptop model '%s'\n", dmi->ident);
@@ -471,6 +476,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_use_lid_flip_devid,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG FLOW X13",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GV301Q"),
+		},
+		.driver_data = &quirk_asus_tablet_mode,
+	},
 	{},
 };
 
@@ -575,6 +589,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
+	{ KE_KEY, 0xBD, { KEY_PROG2 } }, /* Lid flip action on ROG xflow laptops */
 	{ KE_END, 0},
 };
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index b4690ac39147..c62977cd07bf 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -68,6 +68,7 @@ module_param(fnlock_default, bool, 0444);
 #define NOTIFY_KBD_FBM			0x99
 #define NOTIFY_KBD_TTP			0xae
 #define NOTIFY_LID_FLIP			0xfa
+#define NOTIFY_LID_FLIP_ROG		0xbd
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
 
@@ -529,6 +530,19 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
 			dev_err(dev, "Error checking for lid-flip: %d\n", result);
 		}
 		break;
+	case asus_wmi_lid_flip_rog_devid:
+		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP_ROG);
+		if (result < 0)
+			asus->driver->quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
+		if (result >= 0) {
+			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
+			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
+		} else if (result == -ENODEV) {
+			dev_err(dev, "This device has lid-flip-rog quirk but got ENODEV checking it. This is a bug.");
+		} else {
+			dev_err(dev, "Error checking for lid-flip: %d\n", result);
+		}
+		break;
 	}
 
 	err = input_register_device(asus->inputdev);
@@ -563,6 +577,17 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
 	}
 }
 
+static void lid_flip_rog_tablet_mode_get_state(struct asus_wmi *asus)
+{
+	int result;
+
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP_ROG);
+	if (result >= 0) {
+		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
+		input_sync(asus->inputdev);
+	}
+}
+
 /* dGPU ********************************************************************/
 static int dgpu_disable_check_present(struct asus_wmi *asus)
 {
@@ -3071,6 +3096,12 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 			return;
 		}
 		break;
+	case asus_wmi_lid_flip_rog_devid:
+		if (code == NOTIFY_LID_FLIP_ROG) {
+			lid_flip_rog_tablet_mode_get_state(asus);
+			return;
+		}
+		break;
 	}
 
 	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
@@ -3720,6 +3751,9 @@ static int asus_hotk_resume(struct device *device)
 	case asus_wmi_lid_flip_devid:
 		lid_flip_tablet_mode_get_state(asus);
 		break;
+	case asus_wmi_lid_flip_rog_devid:
+		lid_flip_rog_tablet_mode_get_state(asus);
+		break;
 	}
 
 	return 0;
@@ -3768,6 +3802,9 @@ static int asus_hotk_restore(struct device *device)
 	case asus_wmi_lid_flip_devid:
 		lid_flip_tablet_mode_get_state(asus);
 		break;
+	case asus_wmi_lid_flip_rog_devid:
+		lid_flip_rog_tablet_mode_get_state(asus);
+		break;
 	}
 
 	return 0;
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 413920bad0c6..0187f13d2414 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -29,6 +29,7 @@ enum asus_wmi_tablet_switch_mode {
 	asus_wmi_no_tablet_switch,
 	asus_wmi_kbd_dock_devid,
 	asus_wmi_lid_flip_devid,
+	asus_wmi_lid_flip_rog_devid,
 };
 
 struct quirk_entry {
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index c023332842a2..9132b43c2666 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -64,6 +64,7 @@
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
 #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
+#define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
 
 /* Storage */
 #define ASUS_WMI_DEVID_CARDREADER	0x00080013
-- 
2.37.1

