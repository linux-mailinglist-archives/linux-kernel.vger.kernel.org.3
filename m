Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E8E473234
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbhLMQrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:47:12 -0500
Received: from pmta31.teksavvy.com ([76.10.157.38]:30202 "EHLO
        pmta31.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhLMQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:47:12 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 11:47:11 EST
IronPort-SDR: oFYPOYxaCIsiMyR1OxpvP8fRkZVPRS7459J7/Tv2bxiz01PuxDlVuXHW+GdHXTZ11O2OTFxfVG
 MFvbhNIY8CYg==
IronPort-Data: =?us-ascii?q?A9a23=3A5KrxR6B8RWWATxVW/8Tiw5YqxClBgxIJ4kV8j?=
 =?us-ascii?q?S/XYbTApG5z1GABnDMZXjzVafaKYWD0ftsga4zl9UkH75/cytBiTANkpHpgZ?=
 =?us-ascii?q?kwRpJueD7x1DKtQ0wB+jyH7ocsOA/w2MrEsF+hpCC+MzvuRGuK59yAlj/jTH?=
 =?us-ascii?q?uGU5NPsY0ideyc1EE/Ntjo+w4bVsqYw6TSIK1vlVeHa+qUzC3f/s9JACV/43?=
 =?us-ascii?q?orYwP9ZUFQejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5godW7gsepYxV8?=
 =?us-ascii?q?F81/z91Yj+kupzhe0ERcJTVOgvIgX1QVbW5jxFJrzB01bw0XBYeQR0LzW/Qx?=
 =?us-ascii?q?ZYrkYgL7MDhIesqFvSkdOA1WQJTFD1iFbFL+6TOP2au98eUyiUqdlO1nKgwX?=
 =?us-ascii?q?R1rYt1wFuFfRDsmGeYjACwMcRmCr/mr27/9RuQErtwuNsT7FJsSoHxwizrLZ?=
 =?us-ascii?q?d46QI/KQo3R+MRVmjw3g6hmFvHEbccFQT5walLGbgEnElUaEp87jaGzlGTXe?=
 =?us-ascii?q?DRer1SUrqMzpWPUyWRZ0KXsdsXcfNOiTsxTmUCZrWvCuW/+B3kyK8eS4SaY4?=
 =?us-ascii?q?n+ggeTImDvmRI8ID/uz8fsCqF6ax2gaDhI+T1aypeW0iQi1XNc3A0cd/wIoo?=
 =?us-ascii?q?K935kGsSJ/xUnWQu3eBvzYYXN1WHqs06Wmlx67V6gqUGGkYSRZObdUnsIk9Q?=
 =?us-ascii?q?jlC/laNhNqsCTFxvbm9QHaG//KMtzSwNCMJa2gYakcsSQoD/smmrIY4pgzAQ?=
 =?us-ascii?q?8wlE6OviNDxXzbqzFiiqCk4mqVWjsMR0ai/1U7IjijqpZXTSAMxoALNUQqN5?=
 =?us-ascii?q?BhyY5K5T5Cl6kPS8+hRao2eSzG8UNIs8ySFxLpSSMvUzmnXGbhIRe34of2MO?=
 =?us-ascii?q?jnRx0JiHIIo6Sq8vXWkeOhtDPhFDB8BGq45lfXBOic/YT9s2aI=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AdPuVSq1+YobHrBNip5GsUAqjBKskLtp133?=
 =?us-ascii?q?Aq2lEZdPWaSKGlfqeV7ZcmPHDP5wr5NEtKpTniAsm9qA3nm6KdiLN5VYtKNz?=
 =?us-ascii?q?OLhILHFutfBPPZogHdJw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FUBACJdrdh/5XX1BhaHgEBCxIMSYF?=
 =?us-ascii?q?FC4N7bI1LiEsBngoLAQEBAQEBAQEBCUEEAQGFAAQCgyYmNwYOAQIEAQEBEgE?=
 =?us-ascii?q?BAQUBAQEBAQYEAgKBGIV1hwQBIyMpJm8TgnGDGLJSgQGIFoFjgTqJLIVJgUl?=
 =?us-ascii?q?EgRWDaIpCBJJ3gQ+CLjqVKwGKMoIQnWeDSp8OTadPAZYspkmBd4F/MxoIGxW?=
 =?us-ascii?q?DJFEZD50OJjA4AgYLAQEDCZBwAQE?=
X-IPAS-Result: =?us-ascii?q?A2FUBACJdrdh/5XX1BhaHgEBCxIMSYFFC4N7bI1LiEsBn?=
 =?us-ascii?q?goLAQEBAQEBAQEBCUEEAQGFAAQCgyYmNwYOAQIEAQEBEgEBAQUBAQEBAQYEA?=
 =?us-ascii?q?gKBGIV1hwQBIyMpJm8TgnGDGLJSgQGIFoFjgTqJLIVJgUlEgRWDaIpCBJJ3g?=
 =?us-ascii?q?Q+CLjqVKwGKMoIQnWeDSp8OTadPAZYspkmBd4F/MxoIGxWDJFEZD50OJjA4A?=
 =?us-ascii?q?gYLAQEDCZBwAQE?=
X-IronPort-AV: E=Sophos;i="5.88,203,1635220800"; 
   d="scan'208";a="175694578"
Received: from 24-212-215-149.cable.teksavvy.com (HELO BradsZBook.confuseacat.org) ([24.212.215.149])
  by smtp13.teksavvy.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2021 11:40:04 -0500
From:   Bradley Scott <bscott@teksavvy.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Kailang Yang <kailang@realtek.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Sami Loone <sami@loone.fi>, Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bradley Scott <bscott@teksavvy.com>
Subject: [PATCH] ALSA: hda/realtek: Add new alc285-hp-amp-init model
Date:   Mon, 13 Dec 2021 11:22:47 -0500
Message-Id: <20211213162246.506838-1-bscott@teksavvy.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new "alc285-hp-amp-init" model that can be used to apply the ALC285
HP speaker amplifier initialization fixup to devices that are not already
known by passing "hda_model=alc285-hp-amp-init" to the
snd-sof-intel-hda-common module or "model=alc285-hp-amp-init" to the
snd-hda-intel module, depending on which is being used.

Signed-off-by: Bradley Scott <bscott@teksavvy.com>
---
 Documentation/sound/hd-audio/models.rst | 2 ++
 sound/pci/hda/patch_realtek.c           | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/sound/hd-audio/models.rst b/Documentation/sound/hd-audio/models.rst
index 0ea967d34583..d25335993e55 100644
--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -326,6 +326,8 @@ usi-headset
     Headset support on USI machines
 dual-codecs
     Lenovo laptops with dual codecs
+alc285-hp-amp-init
+    HP laptops which require speaker amplifier initialization (ALC285)
 
 ALC680
 ======
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d162662fe684..fc41f3e8ddc3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9124,6 +9124,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP, .name = "alc287-ideapad-bass-spk-amp"},
 	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
+	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.25.1

