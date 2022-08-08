Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB4C58C1FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 05:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiHHDMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 23:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiHHDMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 23:12:05 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67CFDE83;
        Sun,  7 Aug 2022 20:11:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F33575C011B;
        Sun,  7 Aug 2022 23:11:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 07 Aug 2022 23:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659928303; x=1660014703; bh=aA
        J0TY3UkjN192lczAaBiGzDBA8drBicPHjn4msdTfo=; b=cCWjUO7u1GPZ7nf0Or
        4fIYuDd1aGX8KGXVO3VRzN3kDlCauMXzF0qXpHkqRT7rAJHVVMFFpMkgT2mwLR/c
        81K88AWjTv1/PkvMQJLoycF6k4ZcGtzQ6iMrV7dsqOxTQuemiolPjgu4Aq6th4ta
        YThQYVIImkLEihky76pQiY9GJWeMbmkymxTSwf3hvPVtaZJJd0w6y5iyenUeXzpZ
        gPQWVK8BkNOMEej4koRMesAVaL6GoTPlwEW30NPs4A+xDoBls6QZS3q8E14u0xDx
        /eB6EIGnaiJWCF4evnVOHjfyw3ONPqSkH4O1pg8+JgRNWaZshCvpXkm7McPSYDan
        Y+rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659928303; x=1660014703; bh=aAJ0TY3UkjN19
        2lczAaBiGzDBA8drBicPHjn4msdTfo=; b=BdiL1OAkH1JLYRSIKJcg5JM7o6gZU
        oC0RiNmnQyCxyM0dj4ETGOyFx8wH52+hFXwvlv5pbBYy1KKSL675bv3s6DdJEKjE
        aQ3+if7AsgIzrB+QfqCI+is3Cj0Z0QI7z5CNkWzwqUSCn9WcdwzLanq45OMA5wwl
        bHo41nyZypJMoM/ZUXOOnUdCpzfgxsWqUN82618dbHrk3yU1lpMAc8y0pcbOueKh
        WGPbH/UhJ9jlLpPPxNPbaMuz+KnipfNzIzdHOpi3odYAjAj5P6opQGGAMU1E2dDw
        z5oeZguv+ztlP25fGu8oXPKML6WgZ/4h9JIlWkit1oygvgZObaJM+rmLA==
X-ME-Sender: <xms:737wYksCA1_D1uHvRZjcJBtoqjxMm62-p-CRlDAKbBtpMZuF0tORPw>
    <xme:737wYhd4cZfyukKXuUuhEthdrmVIgtNW2tLFYHtE3fVD8qBt5g51wqzJa2nLVO4II
    Zow-TnApgc5sZAZLqA>
X-ME-Received: <xmr:737wYvwjyQvOwnBkN5QgczRtcwsIl7mie4AO6Tul6cFeX4vFgZQ2hJ5eOmv4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:737wYnMmLLTS99WKUEbe_k-Q0_yBmnBN9K48DAgUYr1Rb6Ik0IaFUg>
    <xmx:737wYk91n8n9n5fCT_gPjub2KqzFXIaab3fqqNv0f-HBmAZ0Cuc-lA>
    <xmx:737wYvWIBESM6QxVs4_nsJpaDaZWNWieWa41YAjMHtadwoIhIW1-Jg>
    <xmx:737wYmI9oMnMKWZkFckZA3SN52gZ7JVnroi8TeTy1VLKj2oSPvF3NA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 23:11:41 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/2] asus-wmi: Adjust tablet/lidflip handling to use enum
Date:   Mon,  8 Aug 2022 15:11:31 +1200
Message-Id: <20220808031132.10075-2-luke@ljones.dev>
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

Due to multiple types of tablet/lidflip, the existing code for
handlign these events is refactored to use an enum for each type.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-nb-wmi.c | 13 +++-----
 drivers/platform/x86/asus-wmi.c    | 53 +++++++++++++++++++++---------
 drivers/platform/x86/asus-wmi.h    |  9 +++--
 3 files changed, 49 insertions(+), 26 deletions(-)

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
index 0e7fbed8a50d..a32e99205697 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -504,7 +504,10 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
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
@@ -512,12 +515,11 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
 		} else if (result != -ENODEV) {
 			pr_err("Error checking for keyboard-dock: %d\n", result);
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
@@ -526,6 +528,7 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
 		} else {
 			pr_err("Error checking for lid-flip: %d\n", result);
 		}
+		break;
 	}
 
 	err = input_register_device(asus->inputdev);
@@ -3083,20 +3086,26 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
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
@@ -3731,8 +3740,14 @@ static int asus_hotk_resume(struct device *device)
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
@@ -3773,8 +3788,14 @@ static int asus_hotk_restore(struct device *device)
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

