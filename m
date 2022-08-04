Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B0758A339
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbiHDWW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239894AbiHDWWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:22:33 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9E77393A;
        Thu,  4 Aug 2022 15:21:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 869E05C00C8;
        Thu,  4 Aug 2022 18:21:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Aug 2022 18:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659651668; x=1659738068; bh=Etrm0mn/b1
        ZZou1SHYIbTvDZzWsyWDuPqWoDH7acWd4=; b=dsC8eOhJa2uJFEis+k9AG9hAW5
        pjgjH+OPWvmWuCNW2J5t8jCHAVX3qqXcgn997PSle7Uxqjc5L3N97QBQ+tVfPtYo
        bS5l0gI8ct0P41/pZUIJ3XiCweT6wGByWb7mXKsfxQi/wO9RFMYFZmNYiMMy7llC
        YRkpR9/gKxMz8IP9vyes5Pcw0NazpvRg/FNo9rFMs28agdy2cJDZCcLBRtXHySQU
        U1N5ua/014oYo2ZrZ589+ECISKw7z2DjT8AJPL62RTk1p+bJ8WFzg3VK8rIusZJj
        +OBWFM1cIhowa+eHZc8bMUI8eQXzwDd3J/fXF4OsRbH2uKnKU+KEkqLfeQew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659651668; x=1659738068; bh=Etrm0mn/b1ZZou1SHYIbTvDZzWsy
        WDuPqWoDH7acWd4=; b=gjcHKiqUchqFoNiLEQoN+k97LqbAt3S6cTOXo3TQOB3c
        9TuCgs1Vr7SR16/LvsRjb4634cBGewTnkjoHW6U1Km6fE8sHEXSHjCg8u1fSGCD4
        N8pChPdae8Wxogx4mqcTyL4HvoSw1PCxPlVc3z/sUW6EQ5WXMhMWVr3WCLqGnu7m
        S93IkZz1DBslci5/vXlKc6sXqX3rfz/u1maUWb9cdq/pMU+L6//bUo/XFMpRCfvD
        nPIrnpXCGkocMuOSfogE15ZTXW81fmsjWaRfbGcOZvLdnJch10ggHlx7qJYeDb+p
        bNNrpvmGdwmLDGtaMAWwOi4LdV6PvJnwRpziCYcALA==
X-ME-Sender: <xms:VEbsYg3PKWtQv1lPwrYzws5h5roaDYyjt5Rhxn7rbq71MdiXyk-JEQ>
    <xme:VEbsYrHyxJ4R42hOAzyhU-8VFYSqf9Jq0hLx78JahX-5-ViAf_UIkJ6hFdnySShUU
    F8ujHCqp2zGUyWupH8>
X-ME-Received: <xmr:VEbsYo6zcryThYahBINQMrgmZxciRqgHbaVQtd8AHlv9_E4ZommBY2zJUEKM5rv_S2vS0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeftddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesmhdtreerredtvdenucfhrhhomhepnfhukhgv
    ucflohhnvghsuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnh
    epveeutefgveehfefgvdetiefgtefgheekgfduvdeitdeigfdvtdethfejveevvdehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvse
    hljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:VEbsYp1z8zmxxyKijZcDU3UGMlpQCPHMynEFnMIjFqAdJ-6IyJsE6w>
    <xmx:VEbsYjEMh132Ea7cvpsuNnHxa9tENImV0-om45dnQSCM7RLBrVhoNw>
    <xmx:VEbsYi_ThmODClf0hqI-5xJUe45tO6iAO-oTYphu2muqcyjNOICSfQ>
    <xmx:VEbsYpN1OAGJtqptGkgrYXZsgsuZ4LFinhFlOfk9b3YoMgk74N-S1A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Aug 2022 18:21:03 -0400 (EDT)
Date:   Fri, 05 Aug 2022 10:20:49 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH 1/1] asus-wmi: Add support for ROG X13 tablet mode
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <PE34GR.UO4Z6YSS29Z83@ljones.dev>
In-Reply-To: <d9d79f9b-f3ab-c07e-9e18-5760ff828487@redhat.com>
References: <20220803063734.765614-1-luke@ljones.dev>
        <d9d79f9b-f3ab-c07e-9e18-5760ff828487@redhat.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-o7kHpQq5PZokAU2hgIfg"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-o7kHpQq5PZokAU2hgIfg
Content-Type: text/plain; charset=us-ascii; format=flowed

Excellent review as always, thank you.

Per your advice I've rewritten the patches and will have some people 
test them.

I've attached the patches and also pasted.

Trying to reply via git is a bit frustrating so below is a paste of the 
first half of the new patch, followed by second:

 From e66a77b93c9d60687b96bb72aa876e261dea8535 Mon Sep 17 00:00:00 2001
 From: "Luke D. Jones" <luke@ljones.dev>
Date: Fri, 5 Aug 2022 09:39:18 +1200
Subject: [PATCH 1/2] asus-wmi: Adjust tablet/lidflip handling to use 
enum

Due to multiple types of tablet/lidflip, the existing code for
handlign these events is refactored to use an enum for each type.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-nb-wmi.c | 13 +++-----
 drivers/platform/x86/asus-wmi.c | 53 +++++++++++++++++++++---------
 drivers/platform/x86/asus-wmi.h | 9 +++--
 3 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c 
b/drivers/platform/x86/asus-nb-wmi.c
index a81dc4b191b7..3a93e056c4e1 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -115,12 +115,12 @@ static struct quirk_entry quirk_asus_forceals = {
 };

 static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
- .use_kbd_dock_devid = true,
+ .tablet_switch_mode = asus_wmi_kbd_dock_devid,
 };

 static struct quirk_entry quirk_asus_use_lid_flip_devid = {
  .wmi_backlight_set_devstate = true,
- .use_lid_flip_devid = true,
+ .tablet_switch_mode = asus_wmi_lid_flip_devid,
 };

 static int dmi_matched(const struct dmi_system_id *dmi)
@@ -492,16 +492,13 @@ static void asus_nb_wmi_quirks(struct 
asus_wmi_driver *driver)

  switch (tablet_mode_sw) {
  case 0:
- quirks->use_kbd_dock_devid = false;
- quirks->use_lid_flip_devid = false;
+ quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
   break;
  case 1:
- quirks->use_kbd_dock_devid = true;
- quirks->use_lid_flip_devid = false;
+ quirks->tablet_switch_mode = asus_wmi_kbd_dock_devid;
   break;
  case 2:
- quirks->use_kbd_dock_devid = false;
- quirks->use_lid_flip_devid = true;
+ quirks->tablet_switch_mode = asus_wmi_lid_flip_devid;
   break;
  }

diff --git a/drivers/platform/x86/asus-wmi.c 
b/drivers/platform/x86/asus-wmi.c
index 0e7fbed8a50d..a32e99205697 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -504,7 +504,10 @@ static int asus_wmi_input_init(struct asus_wmi 
*asus)
  if (err)
   goto err_free_dev;

- if (asus->driver->quirks->use_kbd_dock_devid) {
+ switch (asus->driver->quirks->tablet_switch_mode) {
+ case asus_wmi_no_tablet_switch:
+ break;
+ case asus_wmi_kbd_dock_devid:
   result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
   if (result >= 0) {
    input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
@@ -512,12 +515,11 @@ static int asus_wmi_input_init(struct asus_wmi 
*asus)
   } else if (result != -ENODEV) {
    pr_err("Error checking for keyboard-dock: %d\n", result);
   }
- }
-
- if (asus->driver->quirks->use_lid_flip_devid) {
+ break;
+ case asus_wmi_lid_flip_devid:
   result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
   if (result < 0)
- asus->driver->quirks->use_lid_flip_devid = 0;
+ asus->driver->quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
   if (result >= 0) {
    input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
    input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
@@ -526,6 +528,7 @@ static int asus_wmi_input_init(struct asus_wmi 
*asus)
   } else {
    pr_err("Error checking for lid-flip: %d\n", result);
   }
+ break;
  }

  err = input_register_device(asus->inputdev);
@@ -3083,20 +3086,26 @@ static void asus_wmi_handle_event_code(int 
code, struct asus_wmi *asus)
   return;
  }

- if (asus->driver->quirks->use_kbd_dock_devid && code == 
NOTIFY_KBD_DOCK_CHANGE) {
- result = asus_wmi_get_devstate_simple(asus,
- ASUS_WMI_DEVID_KBD_DOCK);
+ switch (asus->driver->quirks->tablet_switch_mode) {
+ case asus_wmi_no_tablet_switch:
+ break;
+ case asus_wmi_kbd_dock_devid:
+ if (code == NOTIFY_KBD_DOCK_CHANGE) {
+ result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
   if (result >= 0) {
    input_report_switch(asus->inputdev, SW_TABLET_MODE,
- !result);
+ !result);
    input_sync(asus->inputdev);
   }
   return;
- }
-
- if (asus->driver->quirks->use_lid_flip_devid && code == 
NOTIFY_LID_FLIP) {
- lid_flip_tablet_mode_get_state(asus);
- return;
+ }
+ break;
+ case asus_wmi_lid_flip_devid:
+ if (code == NOTIFY_LID_FLIP) {
+ lid_flip_tablet_mode_get_state(asus);
+ return;
+ }
+ break;
  }

  if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
@@ -3731,8 +3740,14 @@ static int asus_hotk_resume(struct device 
*device)
  if (asus_wmi_has_fnlock_key(asus))
   asus_wmi_fnlock_update(asus);

- if (asus->driver->quirks->use_lid_flip_devid)
+ switch (asus->driver->quirks->tablet_switch_mode) {
+ case asus_wmi_no_tablet_switch:
+ case asus_wmi_kbd_dock_devid:
+ break;
+ case asus_wmi_lid_flip_devid:
   lid_flip_tablet_mode_get_state(asus);
+ break;
+ }

  return 0;
 }
@@ -3773,8 +3788,14 @@ static int asus_hotk_restore(struct device 
*device)
  if (asus_wmi_has_fnlock_key(asus))
   asus_wmi_fnlock_update(asus);

- if (asus->driver->quirks->use_lid_flip_devid)
+ switch (asus->driver->quirks->tablet_switch_mode) {
+ case asus_wmi_no_tablet_switch:
+ case asus_wmi_kbd_dock_devid:
+ break;
+ case asus_wmi_lid_flip_devid:
   lid_flip_tablet_mode_get_state(asus);
+ break;
+ }

  return 0;
 }
diff --git a/drivers/platform/x86/asus-wmi.h 
b/drivers/platform/x86/asus-wmi.h
index b302415bf1d9..413920bad0c6 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -25,6 +25,12 @@ struct module;
 struct key_entry;
 struct asus_wmi;

+enum asus_wmi_tablet_switch_mode {
+ asus_wmi_no_tablet_switch,
+ asus_wmi_kbd_dock_devid,
+ asus_wmi_lid_flip_devid,
+};
+
 struct quirk_entry {
  bool hotplug_wireless;
  bool scalar_panel_brightness;
@@ -33,8 +39,7 @@ struct quirk_entry {
  bool wmi_backlight_native;
  bool wmi_backlight_set_devstate;
  bool wmi_force_als_set;
- bool use_kbd_dock_devid;
- bool use_lid_flip_devid;
+ enum asus_wmi_tablet_switch_mode tablet_switch_mode;
  int wapf;
  /*
   * For machines with AMD graphic chips, it will send out WMI event
-- 
2.37.1



 From b5c6f4dc0be17d3f57b2f6f90e9d01027c03a5e1 Mon Sep 17 00:00:00 2001
 From: "Luke D. Jones" <luke@ljones.dev>
Date: Fri, 5 Aug 2022 10:15:14 +1200
Subject: [PATCH 2/2] asus-wmi: Add support for ROG X13 tablet mode

Add quirk for ASUS ROG X13 Flow 2-in-1 to enable tablet mode with
lid flip (all screen rotations).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-nb-wmi.c | 17 +++++++++-
 drivers/platform/x86/asus-wmi.c | 36 ++++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h | 1 +
 include/linux/platform_data/x86/asus-wmi.h | 1 +
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c 
b/drivers/platform/x86/asus-nb-wmi.c
index 3a93e056c4e1..4aeaac92296f 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -123,6 +123,11 @@ static struct quirk_entry 
quirk_asus_use_lid_flip_devid = {
  .tablet_switch_mode = asus_wmi_lid_flip_devid,
 };

+static struct quirk_entry quirk_asus_tablet_mode = {
+ .wmi_backlight_set_devstate = true,
+ .tablet_switch_mode = asus_wmi_lid_flip_rog_devid,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
  pr_info("Identified laptop model '%s'\n", dmi->ident);
@@ -471,6 +476,15 @@ static const struct dmi_system_id asus_quirks[] = {
   },
   .driver_data = &quirk_asus_use_lid_flip_devid,
  },
+ {
+ .callback = dmi_matched,
+ .ident = "ASUS ROG FLOW X13",
+ .matches = {
+ DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+ DMI_MATCH(DMI_PRODUCT_NAME, "GV301Q"),
+ },
+ .driver_data = &quirk_asus_tablet_mode,
+ },
  {},
 };

@@ -574,7 +588,8 @@ static const struct key_entry asus_nb_wmi_keymap[] 
= {
  { KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
  { KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
  { KE_IGNORE, 0xC6, }, /* Ambient Light Sensor notification */
- { KE_KEY, 0xFA, { KEY_PROG2 } }, /* Lid flip action */
+ { KE_KEY, 0xFA, { KEY_PROG2 } }, /* Lid flip action */
+ { KE_KEY, 0xBD, { KEY_PROG2 } }, /* Lid flip action on ROG xflow 
laptops */
  { KE_END, 0},
 };

diff --git a/drivers/platform/x86/asus-wmi.c 
b/drivers/platform/x86/asus-wmi.c
index a32e99205697..51610bd6b1c4 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -68,6 +68,7 @@ module_param(fnlock_default, bool, 0444);
 #define NOTIFY_KBD_FBM 0x99
 #define NOTIFY_KBD_TTP 0xae
 #define NOTIFY_LID_FLIP 0xfa
+#define NOTIFY_LID_FLIP_ROG 0xbd

 #define ASUS_WMI_FNLOCK_BIOS_DISABLED BIT(0)

@@ -529,6 +530,19 @@ static int asus_wmi_input_init(struct asus_wmi 
*asus)
    pr_err("Error checking for lid-flip: %d\n", result);
   }
   break;
+ case asus_wmi_lid_flip_rog_devid:
+ result = asus_wmi_get_devstate_simple(asus, 
ASUS_WMI_DEVID_LID_FLIP_ROG);
+ if (result < 0)
+ asus->driver->quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
+ if (result >= 0) {
+ input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
+ input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
+ } else if (result == -ENODEV) {
+ pr_err("This device has lid-flip-rog quirk but got ENODEV checking 
it. This is a bug.");
+ } else {
+ pr_err("Error checking for lid-flip: %d\n", result);
+ }
+ break;
  }

  err = input_register_device(asus->inputdev);
@@ -562,6 +576,16 @@ static void lid_flip_tablet_mode_get_state(struct 
asus_wmi *asus)
  }
 }

+static void lid_flip_rog_tablet_mode_get_state(struct asus_wmi *asus)
+{
+ int result = asus_wmi_get_devstate_simple(asus, 
ASUS_WMI_DEVID_LID_FLIP_ROG);
+
+ if (result >= 0) {
+ input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
+ input_sync(asus->inputdev);
+ }
+}
+
 /* dGPU 
********************************************************************/
 static int dgpu_disable_check_present(struct asus_wmi *asus)
 {
@@ -3106,6 +3130,12 @@ static void asus_wmi_handle_event_code(int code, 
struct asus_wmi *asus)
    return;
   }
   break;
+ case asus_wmi_lid_flip_rog_devid:
+ if (code == NOTIFY_LID_FLIP_ROG) {
+ lid_flip_rog_tablet_mode_get_state(asus);
+ return;
+ }
+ break;
  }

  if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
@@ -3747,6 +3777,9 @@ static int asus_hotk_resume(struct device *device)
  case asus_wmi_lid_flip_devid:
   lid_flip_tablet_mode_get_state(asus);
   break;
+ case asus_wmi_lid_flip_rog_devid:
+ lid_flip_rog_tablet_mode_get_state(asus);
+ break;
  }

  return 0;
@@ -3795,6 +3828,9 @@ static int asus_hotk_restore(struct device 
*device)
  case asus_wmi_lid_flip_devid:
   lid_flip_tablet_mode_get_state(asus);
   break;
+ case asus_wmi_lid_flip_rog_devid:
+ lid_flip_rog_tablet_mode_get_state(asus);
+ break;
  }

  return 0;
diff --git a/drivers/platform/x86/asus-wmi.h 
b/drivers/platform/x86/asus-wmi.h
index 413920bad0c6..0187f13d2414 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -29,6 +29,7 @@ enum asus_wmi_tablet_switch_mode {
  asus_wmi_no_tablet_switch,
  asus_wmi_kbd_dock_devid,
  asus_wmi_lid_flip_devid,
+ asus_wmi_lid_flip_rog_devid,
 };

 struct quirk_entry {
diff --git a/include/linux/platform_data/x86/asus-wmi.h 
b/include/linux/platform_data/x86/asus-wmi.h
index a571b47ff362..d54458431600 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -64,6 +64,7 @@
 #define ASUS_WMI_DEVID_PANEL_OD 0x00050019
 #define ASUS_WMI_DEVID_CAMERA 0x00060013
 #define ASUS_WMI_DEVID_LID_FLIP 0x00060062
+#define ASUS_WMI_DEVID_LID_FLIP_ROG 0x00060077

 /* Storage */
 #define ASUS_WMI_DEVID_CARDREADER 0x00080013
-- 
2.37.1



On Thu, Aug 4 2022 at 15:51:22 +0200, Hans de Goede 
<hdegoede@redhat.com> wrote:
> Hi,
> 
> On 8/3/22 08:37, Luke D. Jones wrote:
>>  Add quirk for ASUS ROG X13 Flow 2-in-1 to enable tablet mode with
>>  lid flip (all screen rotations).
>> 
>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>  ---
>>   drivers/platform/x86/asus-nb-wmi.c         | 16 ++++++++++++++++
>>   drivers/platform/x86/asus-wmi.c            | 16 +++++++++++++++-
>>   drivers/platform/x86/asus-wmi.h            |  1 +
>>   include/linux/platform_data/x86/asus-wmi.h |  1 +
>>   4 files changed, 33 insertions(+), 1 deletion(-)
>> 
>>  diff --git a/drivers/platform/x86/asus-nb-wmi.c 
>> b/drivers/platform/x86/asus-nb-wmi.c
>>  index 478dd300b9c9..1ce8924d0474 100644
>>  --- a/drivers/platform/x86/asus-nb-wmi.c
>>  +++ b/drivers/platform/x86/asus-nb-wmi.c
>>  @@ -123,6 +123,12 @@ static struct quirk_entry 
>> quirk_asus_use_lid_flip_devid = {
>>   	.use_lid_flip_devid = true,
>>   };
>> 
>>  +static struct quirk_entry quirk_asus_gv301 = {
>>  +	.wmi_backlight_set_devstate = true,
>>  +	.use_lid_flip_devid = true,
>>  +	.enodev_as_tablet_mode = true,
>>  +};
>>  +
>>   static int dmi_matched(const struct dmi_system_id *dmi)
>>   {
>>   	pr_info("Identified laptop model '%s'\n", dmi->ident);
>>  @@ -471,6 +477,15 @@ static const struct dmi_system_id 
>> asus_quirks[] = {
>>   		},
>>   		.driver_data = &quirk_asus_use_lid_flip_devid,
>>   	},
>>  +	{
>>  +		.callback = dmi_matched,
>>  +		.ident = "ASUS ROG FLOW X13",
>>  +		.matches = {
>>  +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>  +			DMI_MATCH(DMI_PRODUCT_NAME, "GV301Q"),
>>  +		},
>>  +		.driver_data = &quirk_asus_gv301,
>>  +	},
>>   	{},
>>   };
>> 
>>  @@ -581,6 +596,7 @@ static const struct key_entry 
>> asus_nb_wmi_keymap[] = {
>>   	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
>>   	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
>>   	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
>>  +	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on 
>> rog flow laptops */
> 
> asus_wmi_handle_event_code() will never get to the part where it 
> parses
> the keymap since it has:
> 
> 	if (asus->driver->quirks->use_lid_flip_devid &&
> 			(code == NOTIFY_LID_FLIP || code == NOTIFY_LID_FLIP_GV301)) {
>  		lid_flip_tablet_mode_get_state(asus);
>   		return;
>   	}
> 
> after this patch. The old 0xFA mapping is there from before we had 
> LID switch
> reporting on devices using ASUS_WMI_DEVID_LID_FLIP. I don't believe 
> adding
> an extra entry for this is necessary; nor is it a good idea since then
> userspace might become to rely on these events which we don't want.
> 
> 
> 
>>   	{ KE_END, 0},
>>   };
>> 
>>  diff --git a/drivers/platform/x86/asus-wmi.c 
>> b/drivers/platform/x86/asus-wmi.c
>>  index 62ce198a3463..0458e9107ca7 100644
>>  --- a/drivers/platform/x86/asus-wmi.c
>>  +++ b/drivers/platform/x86/asus-wmi.c
>>  @@ -68,6 +68,7 @@ module_param(fnlock_default, bool, 0444);
>>   #define NOTIFY_KBD_FBM			0x99
>>   #define NOTIFY_KBD_TTP			0xae
>>   #define NOTIFY_LID_FLIP			0xfa
>>  +#define NOTIFY_LID_FLIP_GV301	0xbd
>> 
>>   #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
>> 
>>  @@ -516,6 +517,12 @@ static int asus_wmi_input_init(struct asus_wmi 
>> *asus)
>> 
>>   	if (asus->driver->quirks->use_lid_flip_devid) {
>>   		result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_LID_FLIP);
>>  +		if (result < 0)
>>  +			result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_GV301_LID_FLIP);
>>  +
>>  +		if (result == -ENODEV && 
>> asus->driver->quirks->enodev_as_tablet_mode)
>>  +			result = 1;
>>  +
> 
> Looking at the handling of this here.
> 
>>   		if (result < 0)
>>   			asus->driver->quirks->use_lid_flip_devid = 0;
>>   		if (result >= 0) {
>>  @@ -553,6 +560,12 @@ static void 
>> lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
>>   {
>>   	int result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_LID_FLIP);
>> 
>>  +	if (result < 0)
>>  +		result = asus_wmi_get_devstate_simple(asus, 
>> ASUS_WMI_DEVID_GV301_LID_FLIP);
>>  +
>>  +	if (result == -ENODEV && 
>> asus->driver->quirks->enodev_as_tablet_mode)
>>  +		result = 1;
>>  +
> 
> And here.
> 
>>   	if (result >= 0) {
>>   		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
>>   		input_sync(asus->inputdev);
>>  @@ -3094,7 +3107,8 @@ static void asus_wmi_handle_event_code(int 
>> code, struct asus_wmi *asus)
>>   		return;
>>   	}
>> 
>>  -	if (asus->driver->quirks->use_lid_flip_devid && code == 
>> NOTIFY_LID_FLIP) {
>>  +	if (asus->driver->quirks->use_lid_flip_devid &&
>>  +			(code == NOTIFY_LID_FLIP || code == NOTIFY_LID_FLIP_GV301)) {
>>   		lid_flip_tablet_mode_get_state(asus);
>>   		return;
>>   	}
> 
> and here. This really just is an entirely different code flow from the
> devices using ASUS_WMI_DEVID_LID_FLIP.
> 
> I think it would be better to instead of the enodev_as_tablet_mode 
> quirk, to
> do a preparation patch 1/2 adding a:
> 
> enum asus_wmi_tablet_switch_mode {
> 	asus_wmi_no_tablet_switch,
> 	asus_wmi_kbd_dock_devid,
> 	asus_Wmi_lid_flip_devid,
> 	asus_wmi_gv301_lid_flip_devid, /* to be added in patch 2/2 */
> };
> 
> and then in the quirks struct replace:
> 
>   	bool use_kbd_dock_devid;
>   	bool use_lid_flip_devid;
> 
> with:
> 
> 	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
> 
> Adjust the quirks to set this to the right value and then where
> the current code has the following pattern:
> 
>         if (asus->driver->quirks->use_kbd_dock_devid) {
> 		<kbd_dock_devid handling>;
> 	}
> 
>         if (asus->driver->quirks->use_lid_flip_devid) {
> 		<lid_flip_devid handling>;
> 	}
> 
> replace this with:
> 
>         switch (asus->driver->quirks->tablet_switch_mode) {
> 	case asus_wmi_no_tablet_switch:
> 		break;
> 	case asus_wmi_kbd_dock_devid:
> 		<kbd_dock_devid handling>;
> 		break;
> 	case asus_Wmi_lid_flip_devid:
> 		<lid_flip_devid handling>;
> 		break;
> 	}
> 
> And then in patch 2/2 add asus_wmi_gv301_lid_flip_devid to the enum
> and extend the switch-cases with the necessary handling for the new
> tablet-mode-switch type.
> 
> Regards,
> 
> Hans
> 
> 
> 
>>  diff --git a/drivers/platform/x86/asus-wmi.h 
>> b/drivers/platform/x86/asus-wmi.h
>>  index b302415bf1d9..ac9023aae838 100644
>>  --- a/drivers/platform/x86/asus-wmi.h
>>  +++ b/drivers/platform/x86/asus-wmi.h
>>  @@ -35,6 +35,7 @@ struct quirk_entry {
>>   	bool wmi_force_als_set;
>>   	bool use_kbd_dock_devid;
>>   	bool use_lid_flip_devid;
>>  +	bool enodev_as_tablet_mode;
>>   	int wapf;
>>   	/*
>>   	 * For machines with AMD graphic chips, it will send out WMI event
>>  diff --git a/include/linux/platform_data/x86/asus-wmi.h 
>> b/include/linux/platform_data/x86/asus-wmi.h
>>  index a571b47ff362..79bd06628a8b 100644
>>  --- a/include/linux/platform_data/x86/asus-wmi.h
>>  +++ b/include/linux/platform_data/x86/asus-wmi.h
>>  @@ -64,6 +64,7 @@
>>   #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
>>   #define ASUS_WMI_DEVID_CAMERA		0x00060013
>>   #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
>>  +#define ASUS_WMI_DEVID_GV301_LID_FLIP	0x00060077
>> 
>>   /* Storage */
>>   #define ASUS_WMI_DEVID_CARDREADER	0x00080013
> 


--=-o7kHpQq5PZokAU2hgIfg
Content-Type: multipart/mixed; boundary="=-4oAOPWB0BQ0lEMDfsy1U"

--=-4oAOPWB0BQ0lEMDfsy1U
Content-Type: text/x-patch
Content-Disposition: attachment;
	filename=0002-asus-wmi-Add-support-for-ROG-X13-tablet-mode.patch
Content-Transfer-Encoding: base64

RnJvbSBiNWM2ZjRkYzBiZTE3ZDNmNTdiMmY2ZjkwZTlkMDEwMjdjMDNhNWUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiTHVrZSBELiBKb25lcyIgPGx1a2VAbGpvbmVzLmRldj4KRGF0
ZTogRnJpLCA1IEF1ZyAyMDIyIDEwOjE1OjE0ICsxMjAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIGFz
dXMtd21pOiBBZGQgc3VwcG9ydCBmb3IgUk9HIFgxMyB0YWJsZXQgbW9kZQoKQWRkIHF1aXJrIGZv
ciBBU1VTIFJPRyBYMTMgRmxvdyAyLWluLTEgdG8gZW5hYmxlIHRhYmxldCBtb2RlIHdpdGgKbGlk
IGZsaXAgKGFsbCBzY3JlZW4gcm90YXRpb25zKS4KClNpZ25lZC1vZmYtYnk6IEx1a2UgRC4gSm9u
ZXMgPGx1a2VAbGpvbmVzLmRldj4KLS0tCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLW5iLXdt
aS5jICAgICAgICAgfCAxNyArKysrKysrKystCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdt
aS5jICAgICAgICAgICAgfCAzNiArKysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL3BsYXRm
b3JtL3g4Ni9hc3VzLXdtaS5oICAgICAgICAgICAgfCAgMSArCiBpbmNsdWRlL2xpbnV4L3BsYXRm
b3JtX2RhdGEveDg2L2FzdXMtd21pLmggfCAgMSArCiA0IGZpbGVzIGNoYW5nZWQsIDU0IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4
Ni9hc3VzLW5iLXdtaS5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1cy1uYi13bWkuYwppbmRl
eCAzYTkzZTA1NmM0ZTEuLjRhZWFhYzkyMjk2ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wbGF0Zm9y
bS94ODYvYXN1cy1uYi13bWkuYworKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLW5iLXdt
aS5jCkBAIC0xMjMsNiArMTIzLDExIEBAIHN0YXRpYyBzdHJ1Y3QgcXVpcmtfZW50cnkgcXVpcmtf
YXN1c191c2VfbGlkX2ZsaXBfZGV2aWQgPSB7CiAJLnRhYmxldF9zd2l0Y2hfbW9kZSA9IGFzdXNf
d21pX2xpZF9mbGlwX2RldmlkLAogfTsKIAorc3RhdGljIHN0cnVjdCBxdWlya19lbnRyeSBxdWly
a19hc3VzX3RhYmxldF9tb2RlID0geworCS53bWlfYmFja2xpZ2h0X3NldF9kZXZzdGF0ZSA9IHRy
dWUsCisJLnRhYmxldF9zd2l0Y2hfbW9kZSA9IGFzdXNfd21pX2xpZF9mbGlwX3JvZ19kZXZpZCwK
K307CisKIHN0YXRpYyBpbnQgZG1pX21hdGNoZWQoY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQg
KmRtaSkKIHsKIAlwcl9pbmZvKCJJZGVudGlmaWVkIGxhcHRvcCBtb2RlbCAnJXMnXG4iLCBkbWkt
PmlkZW50KTsKQEAgLTQ3MSw2ICs0NzYsMTUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkbWlfc3lz
dGVtX2lkIGFzdXNfcXVpcmtzW10gPSB7CiAJCX0sCiAJCS5kcml2ZXJfZGF0YSA9ICZxdWlya19h
c3VzX3VzZV9saWRfZmxpcF9kZXZpZCwKIAl9LAorCXsKKwkJLmNhbGxiYWNrID0gZG1pX21hdGNo
ZWQsCisJCS5pZGVudCA9ICJBU1VTIFJPRyBGTE9XIFgxMyIsCisJCS5tYXRjaGVzID0geworCQkJ
RE1JX01BVENIKERNSV9TWVNfVkVORE9SLCAiQVNVU1RlSyBDT01QVVRFUiBJTkMuIiksCisJCQlE
TUlfTUFUQ0goRE1JX1BST0RVQ1RfTkFNRSwgIkdWMzAxUSIpLAorCQl9LAorCQkuZHJpdmVyX2Rh
dGEgPSAmcXVpcmtfYXN1c190YWJsZXRfbW9kZSwKKwl9LAogCXt9LAogfTsKIApAQCAtNTc0LDcg
KzU4OCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qga2V5X2VudHJ5IGFzdXNfbmJfd21pX2tleW1h
cFtdID0gewogCXsgS0VfS0VZLCAweEM0LCB7IEtFWV9LQkRJTExVTVVQIH0gfSwKIAl7IEtFX0tF
WSwgMHhDNSwgeyBLRVlfS0JESUxMVU1ET1dOIH0gfSwKIAl7IEtFX0lHTk9SRSwgMHhDNiwgfSwg
IC8qIEFtYmllbnQgTGlnaHQgU2Vuc29yIG5vdGlmaWNhdGlvbiAqLwotCXsgS0VfS0VZLCAweEZB
LCB7IEtFWV9QUk9HMiB9IH0sICAgICAgICAgICAvKiBMaWQgZmxpcCBhY3Rpb24gKi8KKwl7IEtF
X0tFWSwgMHhGQSwgeyBLRVlfUFJPRzIgfSB9LCAvKiBMaWQgZmxpcCBhY3Rpb24gKi8KKwl7IEtF
X0tFWSwgMHhCRCwgeyBLRVlfUFJPRzIgfSB9LCAvKiBMaWQgZmxpcCBhY3Rpb24gb24gUk9HIHhm
bG93IGxhcHRvcHMgKi8KIAl7IEtFX0VORCwgMH0sCiB9OwogCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5jIGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1cy13bWku
YwppbmRleCBhMzJlOTkyMDU2OTcuLjUxNjEwYmQ2YjFjNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9w
bGF0Zm9ybS94ODYvYXN1cy13bWkuYworKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdt
aS5jCkBAIC02OCw2ICs2OCw3IEBAIG1vZHVsZV9wYXJhbShmbmxvY2tfZGVmYXVsdCwgYm9vbCwg
MDQ0NCk7CiAjZGVmaW5lIE5PVElGWV9LQkRfRkJNCQkJMHg5OQogI2RlZmluZSBOT1RJRllfS0JE
X1RUUAkJCTB4YWUKICNkZWZpbmUgTk9USUZZX0xJRF9GTElQCQkJMHhmYQorI2RlZmluZSBOT1RJ
RllfTElEX0ZMSVBfUk9HCQkweGJkCiAKICNkZWZpbmUgQVNVU19XTUlfRk5MT0NLX0JJT1NfRElT
QUJMRUQJQklUKDApCiAKQEAgLTUyOSw2ICs1MzAsMTkgQEAgc3RhdGljIGludCBhc3VzX3dtaV9p
bnB1dF9pbml0KHN0cnVjdCBhc3VzX3dtaSAqYXN1cykKIAkJCXByX2VycigiRXJyb3IgY2hlY2tp
bmcgZm9yIGxpZC1mbGlwOiAlZFxuIiwgcmVzdWx0KTsKIAkJfQogCQlicmVhazsKKwljYXNlIGFz
dXNfd21pX2xpZF9mbGlwX3JvZ19kZXZpZDoKKwkJcmVzdWx0ID0gYXN1c193bWlfZ2V0X2RldnN0
YXRlX3NpbXBsZShhc3VzLCBBU1VTX1dNSV9ERVZJRF9MSURfRkxJUF9ST0cpOworCQlpZiAocmVz
dWx0IDwgMCkKKwkJCWFzdXMtPmRyaXZlci0+cXVpcmtzLT50YWJsZXRfc3dpdGNoX21vZGUgPSBh
c3VzX3dtaV9ub190YWJsZXRfc3dpdGNoOworCQlpZiAocmVzdWx0ID49IDApIHsKKwkJCWlucHV0
X3NldF9jYXBhYmlsaXR5KGFzdXMtPmlucHV0ZGV2LCBFVl9TVywgU1dfVEFCTEVUX01PREUpOwor
CQkJaW5wdXRfcmVwb3J0X3N3aXRjaChhc3VzLT5pbnB1dGRldiwgU1dfVEFCTEVUX01PREUsIHJl
c3VsdCk7CisJCX0gZWxzZSBpZiAocmVzdWx0ID09IC1FTk9ERVYpIHsKKwkJCXByX2VycigiVGhp
cyBkZXZpY2UgaGFzIGxpZC1mbGlwLXJvZyBxdWlyayBidXQgZ290IEVOT0RFViBjaGVja2luZyBp
dC4gVGhpcyBpcyBhIGJ1Zy4iKTsKKwkJfSBlbHNlIHsKKwkJCXByX2VycigiRXJyb3IgY2hlY2tp
bmcgZm9yIGxpZC1mbGlwOiAlZFxuIiwgcmVzdWx0KTsKKwkJfQorCQlicmVhazsKIAl9CiAKIAll
cnIgPSBpbnB1dF9yZWdpc3Rlcl9kZXZpY2UoYXN1cy0+aW5wdXRkZXYpOwpAQCAtNTYyLDYgKzU3
NiwxNiBAQCBzdGF0aWMgdm9pZCBsaWRfZmxpcF90YWJsZXRfbW9kZV9nZXRfc3RhdGUoc3RydWN0
IGFzdXNfd21pICphc3VzKQogCX0KIH0KIAorc3RhdGljIHZvaWQgbGlkX2ZsaXBfcm9nX3RhYmxl
dF9tb2RlX2dldF9zdGF0ZShzdHJ1Y3QgYXN1c193bWkgKmFzdXMpCit7CisJaW50IHJlc3VsdCA9
IGFzdXNfd21pX2dldF9kZXZzdGF0ZV9zaW1wbGUoYXN1cywgQVNVU19XTUlfREVWSURfTElEX0ZM
SVBfUk9HKTsKKworCWlmIChyZXN1bHQgPj0gMCkgeworCQlpbnB1dF9yZXBvcnRfc3dpdGNoKGFz
dXMtPmlucHV0ZGV2LCBTV19UQUJMRVRfTU9ERSwgcmVzdWx0KTsKKwkJaW5wdXRfc3luYyhhc3Vz
LT5pbnB1dGRldik7CisJfQorfQorCiAvKiBkR1BVICoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwogc3RhdGljIGludCBk
Z3B1X2Rpc2FibGVfY2hlY2tfcHJlc2VudChzdHJ1Y3QgYXN1c193bWkgKmFzdXMpCiB7CkBAIC0z
MTA2LDYgKzMxMzAsMTIgQEAgc3RhdGljIHZvaWQgYXN1c193bWlfaGFuZGxlX2V2ZW50X2NvZGUo
aW50IGNvZGUsIHN0cnVjdCBhc3VzX3dtaSAqYXN1cykKIAkJCXJldHVybjsKIAkJfQogCQlicmVh
azsKKwljYXNlIGFzdXNfd21pX2xpZF9mbGlwX3JvZ19kZXZpZDoKKwkJaWYgKGNvZGUgPT0gTk9U
SUZZX0xJRF9GTElQX1JPRykgeworCQkJbGlkX2ZsaXBfcm9nX3RhYmxldF9tb2RlX2dldF9zdGF0
ZShhc3VzKTsKKwkJCXJldHVybjsKKwkJfQorCQlicmVhazsKIAl9CiAKIAlpZiAoYXN1cy0+ZmFu
X2Jvb3N0X21vZGVfYXZhaWxhYmxlICYmIGNvZGUgPT0gTk9USUZZX0tCRF9GQk0pIHsKQEAgLTM3
NDcsNiArMzc3Nyw5IEBAIHN0YXRpYyBpbnQgYXN1c19ob3RrX3Jlc3VtZShzdHJ1Y3QgZGV2aWNl
ICpkZXZpY2UpCiAJY2FzZSBhc3VzX3dtaV9saWRfZmxpcF9kZXZpZDoKIAkJbGlkX2ZsaXBfdGFi
bGV0X21vZGVfZ2V0X3N0YXRlKGFzdXMpOwogCQlicmVhazsKKwljYXNlIGFzdXNfd21pX2xpZF9m
bGlwX3JvZ19kZXZpZDoKKwkJbGlkX2ZsaXBfcm9nX3RhYmxldF9tb2RlX2dldF9zdGF0ZShhc3Vz
KTsKKwkJYnJlYWs7CiAJfQogCiAJcmV0dXJuIDA7CkBAIC0zNzk1LDYgKzM4MjgsOSBAQCBzdGF0
aWMgaW50IGFzdXNfaG90a19yZXN0b3JlKHN0cnVjdCBkZXZpY2UgKmRldmljZSkKIAljYXNlIGFz
dXNfd21pX2xpZF9mbGlwX2RldmlkOgogCQlsaWRfZmxpcF90YWJsZXRfbW9kZV9nZXRfc3RhdGUo
YXN1cyk7CiAJCWJyZWFrOworCWNhc2UgYXN1c193bWlfbGlkX2ZsaXBfcm9nX2RldmlkOgorCQls
aWRfZmxpcF9yb2dfdGFibGV0X21vZGVfZ2V0X3N0YXRlKGFzdXMpOworCQlicmVhazsKIAl9CiAK
IAlyZXR1cm4gMDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmgg
Yi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5oCmluZGV4IDQxMzkyMGJhZDBjNi4uMDE4
N2YxM2QyNDE0IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5oCisr
KyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmgKQEAgLTI5LDYgKzI5LDcgQEAgZW51
bSBhc3VzX3dtaV90YWJsZXRfc3dpdGNoX21vZGUgewogCWFzdXNfd21pX25vX3RhYmxldF9zd2l0
Y2gsCiAJYXN1c193bWlfa2JkX2RvY2tfZGV2aWQsCiAJYXN1c193bWlfbGlkX2ZsaXBfZGV2aWQs
CisJYXN1c193bWlfbGlkX2ZsaXBfcm9nX2RldmlkLAogfTsKIAogc3RydWN0IHF1aXJrX2VudHJ5
IHsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS94ODYvYXN1cy13bWku
aCBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS94ODYvYXN1cy13bWkuaAppbmRleCBhNTcx
YjQ3ZmYzNjIuLmQ1NDQ1ODQzMTYwMCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9wbGF0Zm9y
bV9kYXRhL3g4Ni9hc3VzLXdtaS5oCisrKyBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS94
ODYvYXN1cy13bWkuaApAQCAtNjQsNiArNjQsNyBAQAogI2RlZmluZSBBU1VTX1dNSV9ERVZJRF9Q
QU5FTF9PRAkJMHgwMDA1MDAxOQogI2RlZmluZSBBU1VTX1dNSV9ERVZJRF9DQU1FUkEJCTB4MDAw
NjAwMTMKICNkZWZpbmUgQVNVU19XTUlfREVWSURfTElEX0ZMSVAJCTB4MDAwNjAwNjIKKyNkZWZp
bmUgQVNVU19XTUlfREVWSURfTElEX0ZMSVBfUk9HCTB4MDAwNjAwNzcKIAogLyogU3RvcmFnZSAq
LwogI2RlZmluZSBBU1VTX1dNSV9ERVZJRF9DQVJEUkVBREVSCTB4MDAwODAwMTMKLS0gCjIuMzcu
MQoK

--=-4oAOPWB0BQ0lEMDfsy1U
Content-Type: text/x-patch
Content-Disposition: attachment;
	filename=0001-asus-wmi-Adjust-tablet-lidflip-handling-to-use-enum.patch
Content-Transfer-Encoding: base64

RnJvbSBlNjZhNzdiOTNjOWQ2MDY4N2I5NmJiNzJhYTg3NmUyNjFkZWE4NTM1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiTHVrZSBELiBKb25lcyIgPGx1a2VAbGpvbmVzLmRldj4KRGF0
ZTogRnJpLCA1IEF1ZyAyMDIyIDA5OjM5OjE4ICsxMjAwClN1YmplY3Q6IFtQQVRDSCAxLzJdIGFz
dXMtd21pOiBBZGp1c3QgdGFibGV0L2xpZGZsaXAgaGFuZGxpbmcgdG8gdXNlIGVudW0KCkR1ZSB0
byBtdWx0aXBsZSB0eXBlcyBvZiB0YWJsZXQvbGlkZmxpcCwgdGhlIGV4aXN0aW5nIGNvZGUgZm9y
CmhhbmRsaWduIHRoZXNlIGV2ZW50cyBpcyByZWZhY3RvcmVkIHRvIHVzZSBhbiBlbnVtIGZvciBl
YWNoIHR5cGUuCgpTaWduZWQtb2ZmLWJ5OiBMdWtlIEQuIEpvbmVzIDxsdWtlQGxqb25lcy5kZXY+
Ci0tLQogZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1cy1uYi13bWkuYyB8IDEzICsrKy0tLS0tCiBk
cml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5jICAgIHwgNTMgKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tCiBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5oICAgIHwgIDkgKysr
LS0KIDMgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1cy1uYi13bWkuYyBiL2RyaXZlcnMv
cGxhdGZvcm0veDg2L2FzdXMtbmItd21pLmMKaW5kZXggYTgxZGM0YjE5MWI3Li4zYTkzZTA1NmM0
ZTEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtbmItd21pLmMKKysrIGIv
ZHJpdmVycy9wbGF0Zm9ybS94ODYvYXN1cy1uYi13bWkuYwpAQCAtMTE1LDEyICsxMTUsMTIgQEAg
c3RhdGljIHN0cnVjdCBxdWlya19lbnRyeSBxdWlya19hc3VzX2ZvcmNlYWxzID0gewogfTsKIAog
c3RhdGljIHN0cnVjdCBxdWlya19lbnRyeSBxdWlya19hc3VzX3VzZV9rYmRfZG9ja19kZXZpZCA9
IHsKLQkudXNlX2tiZF9kb2NrX2RldmlkID0gdHJ1ZSwKKwkudGFibGV0X3N3aXRjaF9tb2RlID0g
YXN1c193bWlfa2JkX2RvY2tfZGV2aWQsCiB9OwogCiBzdGF0aWMgc3RydWN0IHF1aXJrX2VudHJ5
IHF1aXJrX2FzdXNfdXNlX2xpZF9mbGlwX2RldmlkID0gewogCS53bWlfYmFja2xpZ2h0X3NldF9k
ZXZzdGF0ZSA9IHRydWUsCi0JLnVzZV9saWRfZmxpcF9kZXZpZCA9IHRydWUsCisJLnRhYmxldF9z
d2l0Y2hfbW9kZSA9IGFzdXNfd21pX2xpZF9mbGlwX2RldmlkLAogfTsKIAogc3RhdGljIGludCBk
bWlfbWF0Y2hlZChjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCAqZG1pKQpAQCAtNDkyLDE2ICs0
OTIsMTMgQEAgc3RhdGljIHZvaWQgYXN1c19uYl93bWlfcXVpcmtzKHN0cnVjdCBhc3VzX3dtaV9k
cml2ZXIgKmRyaXZlcikKIAogCXN3aXRjaCAodGFibGV0X21vZGVfc3cpIHsKIAljYXNlIDA6Ci0J
CXF1aXJrcy0+dXNlX2tiZF9kb2NrX2RldmlkID0gZmFsc2U7Ci0JCXF1aXJrcy0+dXNlX2xpZF9m
bGlwX2RldmlkID0gZmFsc2U7CisJCXF1aXJrcy0+dGFibGV0X3N3aXRjaF9tb2RlID0gYXN1c193
bWlfbm9fdGFibGV0X3N3aXRjaDsKIAkJYnJlYWs7CiAJY2FzZSAxOgotCQlxdWlya3MtPnVzZV9r
YmRfZG9ja19kZXZpZCA9IHRydWU7Ci0JCXF1aXJrcy0+dXNlX2xpZF9mbGlwX2RldmlkID0gZmFs
c2U7CisJCXF1aXJrcy0+dGFibGV0X3N3aXRjaF9tb2RlID0gYXN1c193bWlfa2JkX2RvY2tfZGV2
aWQ7CiAJCWJyZWFrOwogCWNhc2UgMjoKLQkJcXVpcmtzLT51c2Vfa2JkX2RvY2tfZGV2aWQgPSBm
YWxzZTsKLQkJcXVpcmtzLT51c2VfbGlkX2ZsaXBfZGV2aWQgPSB0cnVlOworCQlxdWlya3MtPnRh
YmxldF9zd2l0Y2hfbW9kZSA9IGFzdXNfd21pX2xpZF9mbGlwX2RldmlkOwogCQlicmVhazsKIAl9
CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmMgYi9kcml2ZXJz
L3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5jCmluZGV4IDBlN2ZiZWQ4YTUwZC4uYTMyZTk5MjA1Njk3
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5jCisrKyBiL2RyaXZl
cnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmMKQEAgLTUwNCw3ICs1MDQsMTAgQEAgc3RhdGljIGlu
dCBhc3VzX3dtaV9pbnB1dF9pbml0KHN0cnVjdCBhc3VzX3dtaSAqYXN1cykKIAlpZiAoZXJyKQog
CQlnb3RvIGVycl9mcmVlX2RldjsKIAotCWlmIChhc3VzLT5kcml2ZXItPnF1aXJrcy0+dXNlX2ti
ZF9kb2NrX2RldmlkKSB7CisJc3dpdGNoIChhc3VzLT5kcml2ZXItPnF1aXJrcy0+dGFibGV0X3N3
aXRjaF9tb2RlKSB7CisJY2FzZSBhc3VzX3dtaV9ub190YWJsZXRfc3dpdGNoOgorCQlicmVhazsK
KwljYXNlIGFzdXNfd21pX2tiZF9kb2NrX2RldmlkOgogCQlyZXN1bHQgPSBhc3VzX3dtaV9nZXRf
ZGV2c3RhdGVfc2ltcGxlKGFzdXMsIEFTVVNfV01JX0RFVklEX0tCRF9ET0NLKTsKIAkJaWYgKHJl
c3VsdCA+PSAwKSB7CiAJCQlpbnB1dF9zZXRfY2FwYWJpbGl0eShhc3VzLT5pbnB1dGRldiwgRVZf
U1csIFNXX1RBQkxFVF9NT0RFKTsKQEAgLTUxMiwxMiArNTE1LDExIEBAIHN0YXRpYyBpbnQgYXN1
c193bWlfaW5wdXRfaW5pdChzdHJ1Y3QgYXN1c193bWkgKmFzdXMpCiAJCX0gZWxzZSBpZiAocmVz
dWx0ICE9IC1FTk9ERVYpIHsKIAkJCXByX2VycigiRXJyb3IgY2hlY2tpbmcgZm9yIGtleWJvYXJk
LWRvY2s6ICVkXG4iLCByZXN1bHQpOwogCQl9Ci0JfQotCi0JaWYgKGFzdXMtPmRyaXZlci0+cXVp
cmtzLT51c2VfbGlkX2ZsaXBfZGV2aWQpIHsKKwkJYnJlYWs7CisJY2FzZSBhc3VzX3dtaV9saWRf
ZmxpcF9kZXZpZDoKIAkJcmVzdWx0ID0gYXN1c193bWlfZ2V0X2RldnN0YXRlX3NpbXBsZShhc3Vz
LCBBU1VTX1dNSV9ERVZJRF9MSURfRkxJUCk7CiAJCWlmIChyZXN1bHQgPCAwKQotCQkJYXN1cy0+
ZHJpdmVyLT5xdWlya3MtPnVzZV9saWRfZmxpcF9kZXZpZCA9IDA7CisJCQlhc3VzLT5kcml2ZXIt
PnF1aXJrcy0+dGFibGV0X3N3aXRjaF9tb2RlID0gYXN1c193bWlfbm9fdGFibGV0X3N3aXRjaDsK
IAkJaWYgKHJlc3VsdCA+PSAwKSB7CiAJCQlpbnB1dF9zZXRfY2FwYWJpbGl0eShhc3VzLT5pbnB1
dGRldiwgRVZfU1csIFNXX1RBQkxFVF9NT0RFKTsKIAkJCWlucHV0X3JlcG9ydF9zd2l0Y2goYXN1
cy0+aW5wdXRkZXYsIFNXX1RBQkxFVF9NT0RFLCByZXN1bHQpOwpAQCAtNTI2LDYgKzUyOCw3IEBA
IHN0YXRpYyBpbnQgYXN1c193bWlfaW5wdXRfaW5pdChzdHJ1Y3QgYXN1c193bWkgKmFzdXMpCiAJ
CX0gZWxzZSB7CiAJCQlwcl9lcnIoIkVycm9yIGNoZWNraW5nIGZvciBsaWQtZmxpcDogJWRcbiIs
IHJlc3VsdCk7CiAJCX0KKwkJYnJlYWs7CiAJfQogCiAJZXJyID0gaW5wdXRfcmVnaXN0ZXJfZGV2
aWNlKGFzdXMtPmlucHV0ZGV2KTsKQEAgLTMwODMsMjAgKzMwODYsMjYgQEAgc3RhdGljIHZvaWQg
YXN1c193bWlfaGFuZGxlX2V2ZW50X2NvZGUoaW50IGNvZGUsIHN0cnVjdCBhc3VzX3dtaSAqYXN1
cykKIAkJcmV0dXJuOwogCX0KIAotCWlmIChhc3VzLT5kcml2ZXItPnF1aXJrcy0+dXNlX2tiZF9k
b2NrX2RldmlkICYmIGNvZGUgPT0gTk9USUZZX0tCRF9ET0NLX0NIQU5HRSkgewotCQlyZXN1bHQg
PSBhc3VzX3dtaV9nZXRfZGV2c3RhdGVfc2ltcGxlKGFzdXMsCi0JCQkJCQkgICAgICBBU1VTX1dN
SV9ERVZJRF9LQkRfRE9DSyk7CisJc3dpdGNoIChhc3VzLT5kcml2ZXItPnF1aXJrcy0+dGFibGV0
X3N3aXRjaF9tb2RlKSB7CisJY2FzZSBhc3VzX3dtaV9ub190YWJsZXRfc3dpdGNoOgorCQlicmVh
azsKKwljYXNlIGFzdXNfd21pX2tiZF9kb2NrX2RldmlkOgorCQlpZiAoY29kZSA9PSBOT1RJRllf
S0JEX0RPQ0tfQ0hBTkdFKSB7CisJCQlyZXN1bHQgPSBhc3VzX3dtaV9nZXRfZGV2c3RhdGVfc2lt
cGxlKGFzdXMsIEFTVVNfV01JX0RFVklEX0tCRF9ET0NLKTsKIAkJaWYgKHJlc3VsdCA+PSAwKSB7
CiAJCQlpbnB1dF9yZXBvcnRfc3dpdGNoKGFzdXMtPmlucHV0ZGV2LCBTV19UQUJMRVRfTU9ERSwK
LQkJCQkJICAgICFyZXN1bHQpOworCQkJCQkJIXJlc3VsdCk7CiAJCQlpbnB1dF9zeW5jKGFzdXMt
PmlucHV0ZGV2KTsKIAkJfQogCQlyZXR1cm47Ci0JfQotCi0JaWYgKGFzdXMtPmRyaXZlci0+cXVp
cmtzLT51c2VfbGlkX2ZsaXBfZGV2aWQgJiYgY29kZSA9PSBOT1RJRllfTElEX0ZMSVApIHsKLQkJ
bGlkX2ZsaXBfdGFibGV0X21vZGVfZ2V0X3N0YXRlKGFzdXMpOwotCQlyZXR1cm47CisJCX0KKwkJ
YnJlYWs7CisJY2FzZSBhc3VzX3dtaV9saWRfZmxpcF9kZXZpZDoKKwkJaWYgKGNvZGUgPT0gTk9U
SUZZX0xJRF9GTElQKSB7CisJCQlsaWRfZmxpcF90YWJsZXRfbW9kZV9nZXRfc3RhdGUoYXN1cyk7
CisJCQlyZXR1cm47CisJCX0KKwkJYnJlYWs7CiAJfQogCiAJaWYgKGFzdXMtPmZhbl9ib29zdF9t
b2RlX2F2YWlsYWJsZSAmJiBjb2RlID09IE5PVElGWV9LQkRfRkJNKSB7CkBAIC0zNzMxLDggKzM3
NDAsMTQgQEAgc3RhdGljIGludCBhc3VzX2hvdGtfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldmlj
ZSkKIAlpZiAoYXN1c193bWlfaGFzX2ZubG9ja19rZXkoYXN1cykpCiAJCWFzdXNfd21pX2ZubG9j
a191cGRhdGUoYXN1cyk7CiAKLQlpZiAoYXN1cy0+ZHJpdmVyLT5xdWlya3MtPnVzZV9saWRfZmxp
cF9kZXZpZCkKKwlzd2l0Y2ggKGFzdXMtPmRyaXZlci0+cXVpcmtzLT50YWJsZXRfc3dpdGNoX21v
ZGUpIHsKKwljYXNlIGFzdXNfd21pX25vX3RhYmxldF9zd2l0Y2g6CisJY2FzZSBhc3VzX3dtaV9r
YmRfZG9ja19kZXZpZDoKKwkJYnJlYWs7CisJY2FzZSBhc3VzX3dtaV9saWRfZmxpcF9kZXZpZDoK
IAkJbGlkX2ZsaXBfdGFibGV0X21vZGVfZ2V0X3N0YXRlKGFzdXMpOworCQlicmVhazsKKwl9CiAK
IAlyZXR1cm4gMDsKIH0KQEAgLTM3NzMsOCArMzc4OCwxNCBAQCBzdGF0aWMgaW50IGFzdXNfaG90
a19yZXN0b3JlKHN0cnVjdCBkZXZpY2UgKmRldmljZSkKIAlpZiAoYXN1c193bWlfaGFzX2ZubG9j
a19rZXkoYXN1cykpCiAJCWFzdXNfd21pX2ZubG9ja191cGRhdGUoYXN1cyk7CiAKLQlpZiAoYXN1
cy0+ZHJpdmVyLT5xdWlya3MtPnVzZV9saWRfZmxpcF9kZXZpZCkKKwlzd2l0Y2ggKGFzdXMtPmRy
aXZlci0+cXVpcmtzLT50YWJsZXRfc3dpdGNoX21vZGUpIHsKKwljYXNlIGFzdXNfd21pX25vX3Rh
YmxldF9zd2l0Y2g6CisJY2FzZSBhc3VzX3dtaV9rYmRfZG9ja19kZXZpZDoKKwkJYnJlYWs7CisJ
Y2FzZSBhc3VzX3dtaV9saWRfZmxpcF9kZXZpZDoKIAkJbGlkX2ZsaXBfdGFibGV0X21vZGVfZ2V0
X3N0YXRlKGFzdXMpOworCQlicmVhazsKKwl9CiAKIAlyZXR1cm4gMDsKIH0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGxhdGZvcm0veDg2L2FzdXMtd21pLmggYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9h
c3VzLXdtaS5oCmluZGV4IGIzMDI0MTViZjFkOS4uNDEzOTIwYmFkMGM2IDEwMDY0NAotLS0gYS9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9hc3VzLXdtaS5oCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2
L2FzdXMtd21pLmgKQEAgLTI1LDYgKzI1LDEyIEBAIHN0cnVjdCBtb2R1bGU7CiBzdHJ1Y3Qga2V5
X2VudHJ5Owogc3RydWN0IGFzdXNfd21pOwogCitlbnVtIGFzdXNfd21pX3RhYmxldF9zd2l0Y2hf
bW9kZSB7CisJYXN1c193bWlfbm9fdGFibGV0X3N3aXRjaCwKKwlhc3VzX3dtaV9rYmRfZG9ja19k
ZXZpZCwKKwlhc3VzX3dtaV9saWRfZmxpcF9kZXZpZCwKK307CisKIHN0cnVjdCBxdWlya19lbnRy
eSB7CiAJYm9vbCBob3RwbHVnX3dpcmVsZXNzOwogCWJvb2wgc2NhbGFyX3BhbmVsX2JyaWdodG5l
c3M7CkBAIC0zMyw4ICszOSw3IEBAIHN0cnVjdCBxdWlya19lbnRyeSB7CiAJYm9vbCB3bWlfYmFj
a2xpZ2h0X25hdGl2ZTsKIAlib29sIHdtaV9iYWNrbGlnaHRfc2V0X2RldnN0YXRlOwogCWJvb2wg
d21pX2ZvcmNlX2Fsc19zZXQ7Ci0JYm9vbCB1c2Vfa2JkX2RvY2tfZGV2aWQ7Ci0JYm9vbCB1c2Vf
bGlkX2ZsaXBfZGV2aWQ7CisJZW51bSBhc3VzX3dtaV90YWJsZXRfc3dpdGNoX21vZGUgdGFibGV0
X3N3aXRjaF9tb2RlOwogCWludCB3YXBmOwogCS8qCiAJICogRm9yIG1hY2hpbmVzIHdpdGggQU1E
IGdyYXBoaWMgY2hpcHMsIGl0IHdpbGwgc2VuZCBvdXQgV01JIGV2ZW50Ci0tIAoyLjM3LjEKCg==

--=-4oAOPWB0BQ0lEMDfsy1U--

--=-o7kHpQq5PZokAU2hgIfg--

