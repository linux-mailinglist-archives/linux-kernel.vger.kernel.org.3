Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8002558D264
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiHIDbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHIDbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:31:02 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E53064DA;
        Mon,  8 Aug 2022 20:31:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 922A25C0093;
        Mon,  8 Aug 2022 23:31:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Aug 2022 23:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660015860; x=1660102260; bh=nv
        kTijB0VB7W98jLK9gRvJD/2uHgCUQLG98hIofqflg=; b=MTJ037C6UY3HECfJI5
        yiwYv5l1VHg4zzoCDObJdNOmANYgylb5X02OcH4+bCVVUFnezHE9MEYJdHRP6RXA
        3ALwJdNR6NP3u9E5Rua293DOM0TlUjHW07RrceeZRrwYrtoFLqmY+24jrPQWIJ/m
        I+whostDsj3QmDTVVrDvC3b51AsnTtGVMtuHFJ/EGtlPSVyq4egAu77FM+aZAz0m
        rBg/Ph+GcgB9AbTSewAG8poMriOJcr99LYTf0RV/tQbRRPX8aCZYCLyrUn40THOP
        od3H0CIVsmcQ9uulpqTLT8sHBWiWibLeex5vtzttDuZnKs5ApfXP9y+KcZccwAmY
        qagg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660015860; x=1660102260; bh=nvkTijB0VB7W9
        8jLK9gRvJD/2uHgCUQLG98hIofqflg=; b=uGff1uiN7xwZGQqgH8CQtnwjtBXv6
        n2TzbpC0FhxFd7ruu78UmLPclszsLnC0BA+msJp26OhpeDXyAjFKYfAFsW4mihqe
        PRIVNgB48EOKgnDoFnLt+p/ZhVZdEUiBKbmAgMF5her16o3YWXluOwS5M9o1UAb4
        XVXGQI33DGa/xT6OKrcpx6IDWqqpoIwXccJFnsDuKrbz0fCnSjkfxUgeNDTZH3NU
        7/7Spa6cYPBx32e37N2wFNjCjc6tnEdxTxPGhNTz3S4IqafOwsjeae/BL3INCsOT
        QSQpUjTkzulVtxZUn6S5iSF932tIuzuFptNvSvfDquLiZ+j5aIkmhw0kA==
X-ME-Sender: <xms:9NTxYu9OST2D1lPcKvSUIWoyq-nJJ0WGCG_YrUy73APweBu9YDz5Tg>
    <xme:9NTxYutxa0PSwNbp4EiAct7y6YvGccDyGqcNSm8vETJKi_aewR6bLvZKwosMNOF9e
    JmEcnjUjWYtMh7m9-E>
X-ME-Received: <xmr:9NTxYkD7HAM10yz4n2rAnCEu_IrkJrnyvvvb-JTyOOB2R4vETo0F_P8DU0Ot>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:9NTxYmfm9cCFz3sDB2_TIF2lOHyITIQe-Rb9But4UE4SiyqFrh0aNw>
    <xmx:9NTxYjNo6wp3VkQ04B3yESG356fJAXgeK4ngHBSrKjed5cJ4Me7CDw>
    <xmx:9NTxYgnMw-8CMGMj7IMRJv33CBxrK06SXK1OqzXI8HxAPwLG3ZmbrQ>
    <xmx:9NTxYsYoOhd10KmtCo3LAD_yuIGR1QwoDeacfNeWh9UYbmT_JtADLQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 23:30:58 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     andy.shevchenko@gmail.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v3 2/2] asus-wmi: Add support for ROG X13 tablet mode
Date:   Tue,  9 Aug 2022 15:30:48 +1200
Message-Id: <20220809033048.1634583-3-luke@ljones.dev>
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
index 029c26a218e1..8b8ab48a644e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -69,6 +69,7 @@ module_param(fnlock_default, bool, 0444);
 #define NOTIFY_KBD_FBM			0x99
 #define NOTIFY_KBD_TTP			0xae
 #define NOTIFY_LID_FLIP			0xfa
+#define NOTIFY_LID_FLIP_ROG		0xbd
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
 
@@ -551,6 +552,19 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
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
@@ -585,6 +599,17 @@ static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
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
@@ -3431,6 +3456,12 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
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
@@ -4105,6 +4136,9 @@ static int asus_hotk_resume(struct device *device)
 	case asus_wmi_lid_flip_devid:
 		lid_flip_tablet_mode_get_state(asus);
 		break;
+	case asus_wmi_lid_flip_rog_devid:
+		lid_flip_rog_tablet_mode_get_state(asus);
+		break;
 	}
 
 	return 0;
@@ -4153,6 +4187,9 @@ static int asus_hotk_restore(struct device *device)
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
index 3faeb98f6ea9..69c5308ed4c5 100644
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

