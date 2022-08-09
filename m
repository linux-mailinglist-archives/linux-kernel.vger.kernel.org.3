Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E62658D262
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiHIDbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiHIDa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:30:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E9E65CF;
        Mon,  8 Aug 2022 20:30:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 21DF25C0093;
        Mon,  8 Aug 2022 23:30:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Aug 2022 23:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660015858; x=1660102258; bh=fT
        GZlcEwfM3To5pttPBm3GslCYQEv76om5k1o/mHy4Y=; b=N3qTis+rGh69CZRQRy
        kMUcVTn8v93dL/0Net0/N9GvwNDyy3f6bTPlEXreLIJbxgsL96RCOl9yPXXu/lKJ
        /peNOlunmoPGIGqB1WDYpfupb81bHZaKDOwdwaihQjI/T5gZC0zl9XkQ8I/UfoVA
        q+2je/pzCyF7MPeT6dk6Mc/SYC8iRvb1EuSdLEPLt0o1/Nf9qIfufDhuAJKMaCvq
        YuvyT+lVycyME1yiV+E7VugKPsPQSiCny/uLuz/WRmUQwYbqRRtepoD1uNOvahPg
        /jI3GbqRXDAW+AyT7uGB3KMU/EIKehyjvzdyr9JSvoDY2uUWVHnLsCUDZ66qto+2
        +a+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660015858; x=1660102258; bh=fTGZlcEwfM3To
        5pttPBm3GslCYQEv76om5k1o/mHy4Y=; b=EpzI+xPYDwcXP9p50eDFUi+MBPwTa
        aj3VYnnikgf12KElENTQoY7sFSaUVSgcL6TOvZhTLpCxQ3n82IzFe0khgotF3J/k
        DZIusJsVg6Ozg0le2ZJuIgApnRfbB8GTpXwpz6bDuWxOCTvZgcHI0Kp3Z0auESy6
        +RHSVZ2cFMnSgF136fZz/w7DjwPX7lvo2BJt7dti+ubdKvg57m95Atnzz/D1oOQL
        T+lzwLimNj1FtO0hPl6Bx0KwfPQH9pu/p3olFWdpd59SmiKZdMhn7lJ8MUe4liZj
        vVmX6guGlkaCzYuj2ghXpH+r/IsgrSBEnDRR8dsiHvVUdveBuWLs1ggAA==
X-ME-Sender: <xms:8dTxYs7R_rcfDn1t-vnCPO_6scXK5y5r7_vNo6hFqvecPwGgfGX8vw>
    <xme:8dTxYt6E3J1gpKkehRzR8SSHvhv9SXf0DBUi0VJ6AGfHDSRXriVCYoguD9CaMcYi0
    O8a0Sp5J7CKeoNBiZk>
X-ME-Received: <xmr:8dTxYrdeTE6J09OtCr0BrAIUFIabF-QLehevLOw9vOp3vxCUsA0hyOBKfrEb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:8tTxYhIqNDv6MkqgkyttCzVXj8fgj_meIT_mgcMc72X8PvcWwM0eOA>
    <xmx:8tTxYgLa3bNSqps2Fmeg4dnw0dypmlZ9Ybw08Iun0xE4TQau3Q1dew>
    <xmx:8tTxYiw7Eh7_dv_JXE7_BoMXVi9zemIB4iv5dX8FHR6CQIKedTeV3Q>
    <xmx:8tTxYnVlFXc89gn-uR96WcS6nFEuyZFmNjMZ-n6rK0Yu_E_iZTqTYQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 23:30:55 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 1/2] asus-wmi: Adjust tablet/lidflip handling to use enum
Date:   Tue,  9 Aug 2022 15:30:47 +1200
Message-Id: <20220809033048.1634583-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809033048.1634583-1-luke@ljones.dev>
References: <20220809033048.1634583-1-luke@ljones.dev>
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

Due to multiple types of tablet/lidflip, the existing code for
handling these events is refactored to use an enum for each type.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-nb-wmi.c | 13 +++---
 drivers/platform/x86/asus-wmi.c    | 67 ++++++++++++++++++++----------
 drivers/platform/x86/asus-wmi.h    |  9 +++-
 3 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index a81dc4b191b7..3a93e056c4e1 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -115,12 +115,12 @@ static struct quirk_entry quirk_asus_forceals = {
 };
 
 static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
-	.use_kbd_dock_devid = true,
+	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
 };
 
 static struct quirk_entry quirk_asus_use_lid_flip_devid = {
 	.wmi_backlight_set_devstate = true,
-	.use_lid_flip_devid = true,
+	.tablet_switch_mode = asus_wmi_lid_flip_devid,
 };
 
 static int dmi_matched(const struct dmi_system_id *dmi)
@@ -492,16 +492,13 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 
 	switch (tablet_mode_sw) {
 	case 0:
-		quirks->use_kbd_dock_devid = false;
-		quirks->use_lid_flip_devid = false;
+		quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
 		break;
 	case 1:
-		quirks->use_kbd_dock_devid = true;
-		quirks->use_lid_flip_devid = false;
+		quirks->tablet_switch_mode = asus_wmi_kbd_dock_devid;
 		break;
 	case 2:
-		quirks->use_kbd_dock_devid = false;
-		quirks->use_lid_flip_devid = true;
+		quirks->tablet_switch_mode = asus_wmi_lid_flip_devid;
 		break;
 	}
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index c5fa21370481..029c26a218e1 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -507,8 +507,11 @@ static bool asus_wmi_dev_is_present(struct asus_wmi *asus, u32 dev_id)
 
 static int asus_wmi_input_init(struct asus_wmi *asus)
 {
+	struct device *dev;
 	int err, result;
 
+	dev = &asus->platform_device->dev;
+
 	asus->inputdev = input_allocate_device();
 	if (!asus->inputdev)
 		return -ENOMEM;
@@ -516,35 +519,38 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
 	asus->inputdev->name = asus->driver->input_name;
 	asus->inputdev->phys = asus->driver->input_phys;
 	asus->inputdev->id.bustype = BUS_HOST;
-	asus->inputdev->dev.parent = &asus->platform_device->dev;
+	asus->inputdev->dev.parent = dev;
 	set_bit(EV_REP, asus->inputdev->evbit);
 
 	err = sparse_keymap_setup(asus->inputdev, asus->driver->keymap, NULL);
 	if (err)
 		goto err_free_dev;
 
-	if (asus->driver->quirks->use_kbd_dock_devid) {
+	switch (asus->driver->quirks->tablet_switch_mode) {
+	case asus_wmi_no_tablet_switch:
+		break;
+	case asus_wmi_kbd_dock_devid:
 		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
 		if (result >= 0) {
 			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
 			input_report_switch(asus->inputdev, SW_TABLET_MODE, !result);
 		} else if (result != -ENODEV) {
-			pr_err("Error checking for keyboard-dock: %d\n", result);
+			dev_err(dev, "Error checking for keyboard-dock: %d\n", result);
 		}
-	}
-
-	if (asus->driver->quirks->use_lid_flip_devid) {
+		break;
+	case asus_wmi_lid_flip_devid:
 		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
 		if (result < 0)
-			asus->driver->quirks->use_lid_flip_devid = 0;
+			asus->driver->quirks->tablet_switch_mode = asus_wmi_no_tablet_switch;
 		if (result >= 0) {
 			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
 			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
 		} else if (result == -ENODEV) {
-			pr_err("This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
+			dev_err(dev, "This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
 		} else {
-			pr_err("Error checking for lid-flip: %d\n", result);
+			dev_err(dev, "Error checking for lid-flip: %d\n", result);
 		}
+		break;
 	}
 
 	err = input_register_device(asus->inputdev);
@@ -570,8 +576,9 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 
 static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
 {
-	int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
+	int result;
 
+	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
 	if (result >= 0) {
 		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
 		input_sync(asus->inputdev);
@@ -3404,20 +3411,26 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
-	if (asus->driver->quirks->use_kbd_dock_devid && code == NOTIFY_KBD_DOCK_CHANGE) {
-		result = asus_wmi_get_devstate_simple(asus,
-						      ASUS_WMI_DEVID_KBD_DOCK);
+	switch (asus->driver->quirks->tablet_switch_mode) {
+	case asus_wmi_no_tablet_switch:
+		break;
+	case asus_wmi_kbd_dock_devid:
+		if (code == NOTIFY_KBD_DOCK_CHANGE) {
+			result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
 		if (result >= 0) {
 			input_report_switch(asus->inputdev, SW_TABLET_MODE,
-					    !result);
+						!result);
 			input_sync(asus->inputdev);
 		}
 		return;
-	}
-
-	if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
-		lid_flip_tablet_mode_get_state(asus);
-		return;
+		}
+		break;
+	case asus_wmi_lid_flip_devid:
+		if (code == NOTIFY_LID_FLIP) {
+			lid_flip_tablet_mode_get_state(asus);
+			return;
+		}
+		break;
 	}
 
 	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
@@ -4085,8 +4098,14 @@ static int asus_hotk_resume(struct device *device)
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
 
-	if (asus->driver->quirks->use_lid_flip_devid)
+	switch (asus->driver->quirks->tablet_switch_mode) {
+	case asus_wmi_no_tablet_switch:
+	case asus_wmi_kbd_dock_devid:
+		break;
+	case asus_wmi_lid_flip_devid:
 		lid_flip_tablet_mode_get_state(asus);
+		break;
+	}
 
 	return 0;
 }
@@ -4127,8 +4146,14 @@ static int asus_hotk_restore(struct device *device)
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
 
-	if (asus->driver->quirks->use_lid_flip_devid)
+	switch (asus->driver->quirks->tablet_switch_mode) {
+	case asus_wmi_no_tablet_switch:
+	case asus_wmi_kbd_dock_devid:
+		break;
+	case asus_wmi_lid_flip_devid:
 		lid_flip_tablet_mode_get_state(asus);
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index b302415bf1d9..413920bad0c6 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -25,6 +25,12 @@ struct module;
 struct key_entry;
 struct asus_wmi;
 
+enum asus_wmi_tablet_switch_mode {
+	asus_wmi_no_tablet_switch,
+	asus_wmi_kbd_dock_devid,
+	asus_wmi_lid_flip_devid,
+};
+
 struct quirk_entry {
 	bool hotplug_wireless;
 	bool scalar_panel_brightness;
@@ -33,8 +39,7 @@ struct quirk_entry {
 	bool wmi_backlight_native;
 	bool wmi_backlight_set_devstate;
 	bool wmi_force_als_set;
-	bool use_kbd_dock_devid;
-	bool use_lid_flip_devid;
+	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
 	int wapf;
 	/*
 	 * For machines with AMD graphic chips, it will send out WMI event
-- 
2.37.1

