Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7362A47B538
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhLTVbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbhLTVbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:31:09 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:31:08 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id kj16so6632415qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XbS9uErZ5c4CCSbiHzp6Nqw9oW8CSOfv3JYeCjB7h/s=;
        b=ZV2zXZFTlYuITazlNNWKKFxASGrjAHJze0zJTlYdiCD8QL/zjDYWvNbY89WdPJUoIA
         3xQzH1UtKZ/YIx6tIJu0P1FrudhMy2ldKE/xmX+EyXAmTBKmTxpwDwYlR22hue7Z2Mww
         48be5SJ4bIqXnix7MHQcP7SJ/2Ief5l6Jzlai0SakgOPciszJfpca8I+76Wa8u+rsroT
         1CMUKoIen4vDITSx6ohEk37N2tEbM+CA+GPvSpnOs3TN4JLirGOrDJ/DdEecSoN2KuIK
         TNYK4/xW++y9I5wgSK8tmgpfu8igpAJA2Vrhu6a4KtysUxkGT9g8rCrQ32teNyXw+GrX
         skwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbS9uErZ5c4CCSbiHzp6Nqw9oW8CSOfv3JYeCjB7h/s=;
        b=Mkx7kHAMkdaQhH5/IlC0cGtWjVvCh9UaBDEzzfRzhCuHWTNIoewkVM6xXj/uTeJpZj
         76845n+tImAtUS5U09Dw1NvGzxGOrNMVsnA3VATGzsvZkvPb1XF9S3btUDNRln6NstKg
         MntOigB4cAA/QS/BuIKEtfgEflKQKaM9TsoRm+FXRJ7jEi0njkE7rfgx1J7fD1ciIcei
         GKasHXdj2XzuZZcQexDN/5uLmMDlA6PSs3c16qcgkWXmwrOBXBV7eBhge7yd09s4Gzmx
         dAWrKC0O2F3X6grNC3tIhlIU0Par5k6RL0xIo3GS9ShNFk81xUGkAUqTHGRhg9l/Zizy
         d70g==
X-Gm-Message-State: AOAM532GgONT75UdG5YsQoIb60ntfEq4qRv7fKC+Gl3Lh09yeacK3eoy
        sQ6NHU2RD+dRCvMSVLPnqtk=
X-Google-Smtp-Source: ABdhPJxKZCXLVtjy5SJQkGzGpUEqkJD9cq5OV6++SDXZLl1EbbJvmvvBInFUzc53pV55WkgBljI9Rg==
X-Received: by 2002:a05:6214:20e9:: with SMTP id 9mr14767113qvk.28.1640035868201;
        Mon, 20 Dec 2021 13:31:08 -0800 (PST)
Received: from localhost.localdomain ([181.23.83.92])
        by smtp.gmail.com with ESMTPSA id s20sm16132210qtc.75.2021.12.20.13.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 13:31:07 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gascoar@gmail.com
Subject: [PATCH 1/4] staging: vc04_services: avoid the use of typedef for function pointers
Date:   Mon, 20 Dec 2021 18:29:11 -0300
Message-Id: <ae3e8feaf7aa72a85f2e901a31bb382acf8a1ed3.1639858361.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1639858361.git.gascoar@gmail.com>
References: <cover.1639858361.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace typedefs bcm2835_audio_newpcm_func and bcm2835_audio_newctl_func
with equivalent declarations to better align with the linux kernel
coding style.

As the '_func' in the function names is somehow reduntant, it was
dropped in favour of the shorter names: 'bcm2835_audio_newpcm' and
'bcm2835_audio_newctl'

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../vc04_services/bcm2835-audio/bcm2835.c     | 28 ++++++++-----------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index c250fbef2fa3..412342d5b6c9 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -52,20 +52,14 @@ static int bcm2835_devm_add_vchi_ctx(struct device *dev)
 	return 0;
 }
 
-typedef int (*bcm2835_audio_newpcm_func)(struct bcm2835_chip *chip,
-					 const char *name,
-					 enum snd_bcm2835_route route,
-					 u32 numchannels);
-
-typedef int (*bcm2835_audio_newctl_func)(struct bcm2835_chip *chip);
-
 struct bcm2835_audio_driver {
 	struct device_driver driver;
 	const char *shortname;
 	const char *longname;
 	int minchannels;
-	bcm2835_audio_newpcm_func newpcm;
-	bcm2835_audio_newctl_func newctl;
+	int (*bcm2835_audio_newpcm)(struct bcm2835_chip *chip, const char *name,
+				    enum snd_bcm2835_route route, u32 numchannels);
+	int (*bcm2835_audio_newctl)(struct bcm2835_chip *chip);
 	enum snd_bcm2835_route route;
 };
 
@@ -104,8 +98,8 @@ static struct bcm2835_audio_driver bcm2835_audio_alsa = {
 	.shortname = "bcm2835 ALSA",
 	.longname  = "bcm2835 ALSA",
 	.minchannels = 2,
-	.newpcm = bcm2835_audio_alsa_newpcm,
-	.newctl = snd_bcm2835_new_ctl,
+	.bcm2835_audio_newpcm = bcm2835_audio_alsa_newpcm,
+	.bcm2835_audio_newctl = snd_bcm2835_new_ctl,
 };
 
 static struct bcm2835_audio_driver bcm2835_audio_hdmi = {
@@ -116,8 +110,8 @@ static struct bcm2835_audio_driver bcm2835_audio_hdmi = {
 	.shortname = "bcm2835 HDMI",
 	.longname  = "bcm2835 HDMI",
 	.minchannels = 1,
-	.newpcm = bcm2835_audio_simple_newpcm,
-	.newctl = snd_bcm2835_new_hdmi_ctl,
+	.bcm2835_audio_newpcm = bcm2835_audio_simple_newpcm,
+	.bcm2835_audio_newctl = snd_bcm2835_new_hdmi_ctl,
 	.route = AUDIO_DEST_HDMI
 };
 
@@ -129,8 +123,8 @@ static struct bcm2835_audio_driver bcm2835_audio_headphones = {
 	.shortname = "bcm2835 Headphones",
 	.longname  = "bcm2835 Headphones",
 	.minchannels = 1,
-	.newpcm = bcm2835_audio_simple_newpcm,
-	.newctl = snd_bcm2835_new_headphones_ctl,
+	.bcm2835_audio_newpcm = bcm2835_audio_simple_newpcm,
+	.bcm2835_audio_newctl = snd_bcm2835_new_headphones_ctl,
 	.route = AUDIO_DEST_HEADPHONES
 };
 
@@ -189,7 +183,7 @@ static int snd_add_child_device(struct device *dev,
 	strscpy(card->shortname, audio_driver->shortname, sizeof(card->shortname));
 	strscpy(card->longname, audio_driver->longname, sizeof(card->longname));
 
-	err = audio_driver->newpcm(chip, audio_driver->shortname,
+	err = audio_driver->bcm2835_audio_newpcm(chip, audio_driver->shortname,
 		audio_driver->route,
 		numchans);
 	if (err) {
@@ -197,7 +191,7 @@ static int snd_add_child_device(struct device *dev,
 		goto error;
 	}
 
-	err = audio_driver->newctl(chip);
+	err = audio_driver->bcm2835_audio_newctl(chip);
 	if (err) {
 		dev_err(dev, "Failed to create controls, error %d\n", err);
 		goto error;
-- 
2.34.1

