Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE09B58C1FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiHHDMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiHHDMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:12:06 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11038DE8E;
        Sun,  7 Aug 2022 20:11:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 730325C00EC;
        Sun,  7 Aug 2022 23:11:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 07 Aug 2022 23:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659928306; x=1660014706; bh=rb
        q+GR1KjHrdFBIltGS8U+6Pe1Bj1GnwkA90Taje7+0=; b=lQunEgi4l1RjirM1a/
        1/aYxZbjILHeJTAiHipaxLis7nbwTNJtbID5eGnD++XOJXlCg//cfBFOIzfXrpGH
        Pq5LDbpwVZxYkmrmzwGdeg0TXhld6kUp5yitShaNPjwgr39P81y/xfvBihaY8PzE
        mz3SoIt1ZoN9mawephY7bqhnIpDvS5Dy0sN6bZih4hdMrEdaiFtKw+ZLGEVVEei0
        ULlrsPpr5Fw1Xmo4V/cH3jDsfzkFCZz3BM+6THOZsCp/p88wny8Jr6mRTei+ffhS
        6IxBPE7KeId3RzINUDdTR2bTCl0J3SWnapf1k7VhAaLDwGY8cVAlQlPUzIDJp915
        Uy7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659928306; x=1660014706; bh=rbq+GR1KjHrdF
        BIltGS8U+6Pe1Bj1GnwkA90Taje7+0=; b=yUjU73D2hlCsuP0yhmlC4FOu7RJwV
        eo9/JdUq/BrpwgxKyRCDj7B0bfqQhn0Ut5Nfu8FL/d5bby7G7PmaCqyNY4NIDUz3
        OLI3Vm7t//TDJa1lNW6mWaW4fm7Wf31nPSMfMGY3vTeMWoU655/4uL6yymwD4hQd
        Iy+Bzjx3yGMw822DpxTyXL7V4s76uTMpRyAHaLomzfzw3wOhcY2KyKO0IZzbbRku
        8dazX6gLy9iZ/kQiZ7og2Wx1phm4VeE6OLOwyBUOZsvdmku/wrWxAo2jskQZRf3d
        BY5jIFMjBsRLD3KPe6jC9Uc2I1dEndQrmadv+PmvHJOJQnsktWINNquWw==
X-ME-Sender: <xms:8n7wYuu-RvbtU7Sbvh9ZX_cnRTOiheRfOtMnuKnfLtWZYOytyDJ3PA>
    <xme:8n7wYjeIQH6l-A1_zFWzZz7A5ppktgxjTlUevDv6N82OSRCOqJPFJeUuCVx8RHHHJ
    Zt8Nv5Siy1sOez7OQI>
X-ME-Received: <xmr:8n7wYpzB7_d5sW_Tk72nzh82pIvD0NhbXGoHm55zEhJ0xzlGN05vC18KDOuC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:8n7wYpMDuwGJreot3gOe8cUXVibvSiK6-5a3M5YSBEgwKs8S5t5vQA>
    <xmx:8n7wYu9bnsPVQMuwg-PIOXScOuSVmLfbchP60mCxMUFYNGD-yIXKkQ>
    <xmx:8n7wYhV7QBRqabacPXesxa-H7VU8zZ1QOzx_UREGPXoX0eHMsnXlMQ>
    <xmx:8n7wYgJY2QncdfkNUvHIOUvqhCnxYBXQXV96GtxpwG4444Ccd6c1Fg>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 23:11:44 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 2/2] asus-wmi: Add support for ROG X13 tablet mode
Date:   Mon,  8 Aug 2022 15:11:32 +1200
Message-Id: <20220808031132.10075-3-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808031132.10075-1-luke@ljones.dev>
References: <20220808031132.10075-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirk for ASUS ROG X13 Flow 2-in-1 to enable tablet mode with
lid flip (all screen rotations).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-nb-wmi.c         | 17 +++++++++-
 drivers/platform/x86/asus-wmi.c            | 36 ++++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |  1 +
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 3a93e056c4e1..4aeaac92296f 100644
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
 
@@ -574,7 +588,8 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
-	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
+	{ KE_KEY, 0xFA, { KEY_PROG2 } }, /* Lid flip action */
+	{ KE_KEY, 0xBD, { KEY_PROG2 } }, /* Lid flip action on ROG xflow laptops */
 	{ KE_END, 0},
 };
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a32e99205697..51610bd6b1c4 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -68,6 +68,7 @@ module_param(fnlock_default, bool, 0444);
 #define NOTIFY_KBD_FBM			0x99
 #define NOTIFY_KBD_TTP			0xae
 #define NOTIFY_LID_FLIP			0xfa
+#define NOTIFY_LID_FLIP_ROG		0xbd
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
 
@@ -529,6 +530,19 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
 			pr_err("Error checking for lid-flip: %d\n", result);
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
+			pr_err("This device has lid-flip-rog quirk but got ENODEV checking it. This is a bug.");
+		} else {
+			pr_err("Error checking for lid-flip: %d\n", result);
+		}
+		break;
 	}
 
 	err = input_register_device(asus->inputdev);
@@ -562,6 +576,16 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
 	}
 }
 
+static void lid_flip_rog_tablet_mode_get_state(struct asus_wmi *asus)
+{
+	int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP_ROG);
+
+	if (result >= 0) {
+		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
+		input_sync(asus->inputdev);
+	}
+}
+
 /* dGPU ********************************************************************/
 static int dgpu_disable_check_present(struct asus_wmi *asus)
 {
@@ -3106,6 +3130,12 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
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
@@ -3747,6 +3777,9 @@ static int asus_hotk_resume(struct device *device)
 	case asus_wmi_lid_flip_devid:
 		lid_flip_tablet_mode_get_state(asus);
 		break;
+	case asus_wmi_lid_flip_rog_devid:
+		lid_flip_rog_tablet_mode_get_state(asus);
+		break;
 	}
 
 	return 0;
@@ -3795,6 +3828,9 @@ static int asus_hotk_restore(struct device *device)
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
index a571b47ff362..d54458431600 100644
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

