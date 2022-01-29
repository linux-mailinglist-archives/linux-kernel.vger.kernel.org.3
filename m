Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1F64A2B48
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 03:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352207AbiA2CiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 21:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbiA2CiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 21:38:01 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B0AC061714;
        Fri, 28 Jan 2022 18:38:01 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e9so6884418pgb.3;
        Fri, 28 Jan 2022 18:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pioxi9XTP9GgEJF7NTcDbxGQkHi4pVDGFMqOd1k4jbE=;
        b=fqIQEDEmnNNvfGcJNLOgbUPqxAGjiOG/dz4NnUSviMeFlU8lrwNI1Zket+SarsI0dg
         qvFIEFVyEsL8dyISV2wgrfbDeFOikd4zLZQxc9RrhsRp2/KJszNwv8rOj3eXIwHbIhj/
         9xc9SV/BJClk/Ab5xMMa/361rp5/9CK4FFit7euIbuKHburCPiQNiRr5dZJKiC7V0zr7
         5Gw+ixs020omEckyLCfgtY87kH832cj/qeF3gcpGl8Mi+DzFNrHD6wzvIaHvk+oeJvfY
         xCmd1etOR2Dsyr2vAzhq8fDTiVvV9wVlajbz6heJQecDfonE+JqcMX6ogENeuJ+tlkDM
         IZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pioxi9XTP9GgEJF7NTcDbxGQkHi4pVDGFMqOd1k4jbE=;
        b=SgirWxwAy4wYVOZmEfTUliHfakUKlIMGWCV+URlj9h9p9y/AQq3lh7iFVYa33MQSLl
         INqmd2p1CNEvSTqbn6sJ/+1LQjKsaTwGpZsiD0AnymPpp2GY9YNEcUQVDs7Xsc8UZA7D
         opzGcCLGXKHctaleF9klZN6TuxC8xE8mZHpNNEBwSILU7XZf3wCrOtWOFYozZeVbYjJT
         0Fwg8XS/IKm/bcTj3BKM7d8cMQJGvHA+vA8E05H98awvlg8nQzRstpXkMk7QB5r+EKmM
         vvlFDW2CdrAnQD0njZPQ9v9dCvWWoTBgM2oL6K9zpN2lS6EB7vCsBbDyhJE/n/r9cBqv
         93Pw==
X-Gm-Message-State: AOAM531P0HxguhTSnn98uzzsQO3YcC8ACZY/QC6f278pehkQnB8lVnyJ
        5oNGMUqJ/1yG+CUfUx/HDHY=
X-Google-Smtp-Source: ABdhPJyCUW1sZtFs0iVJMLp6277XtmgPSqbbDsK8AZ0+P1gHy5T+p2tdjXyjgTYqwpxf0NZDkI2lag==
X-Received: by 2002:a05:6a00:16d4:: with SMTP id l20mr10795398pfc.5.1643423880800;
        Fri, 28 Jan 2022 18:38:00 -0800 (PST)
Received: from lxb-server.lan ([2605:52c0:2:32c::])
        by smtp.gmail.com with ESMTPSA id ms14sm3787991pjb.15.2022.01.28.18.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 18:38:00 -0800 (PST)
From:   Yunhao Tian <t123yh.xyz@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunhao Tian <t123yh.xyz@gmail.com>
Subject: [PATCH] usb: gadget: audio: fix indent
Date:   Sat, 29 Jan 2022 10:37:53 +0800
Message-Id: <20220129023753.1494755-1-t123yh.xyz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes indents of f_uac2.c and u_audio.c introduced by
previous commits.

Signed-off-by: Yunhao Tian <t123yh.xyz@gmail.com>
---
 drivers/usb/gadget/function/f_uac2.c  | 16 +++++++-------
 drivers/usb/gadget/function/u_audio.c | 30 +++++++++++++--------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 242824da55df..abe57f6de73a 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -785,15 +785,15 @@ static void setup_headers(struct f_uac2_opts *opts,
 		headers[i++] = USBDHDR(&out_clk_src_desc);
 		headers[i++] = USBDHDR(&usb_out_it_desc);
 
-    if (FUOUT_EN(opts))
-      headers[i++] = USBDHDR(out_feature_unit_desc);
-  }
+		if (FUOUT_EN(opts))
+			headers[i++] = USBDHDR(out_feature_unit_desc);
+	}
 
 	if (EPIN_EN(opts)) {
 		headers[i++] = USBDHDR(&io_in_it_desc);
 
-    if (FUIN_EN(opts))
-      headers[i++] = USBDHDR(in_feature_unit_desc);
+		if (FUIN_EN(opts))
+			headers[i++] = USBDHDR(in_feature_unit_desc);
 
 		headers[i++] = USBDHDR(&usb_in_ot_desc);
 	}
@@ -801,8 +801,8 @@ static void setup_headers(struct f_uac2_opts *opts,
 	if (EPOUT_EN(opts))
 		headers[i++] = USBDHDR(&io_out_ot_desc);
 
-  if (FUOUT_EN(opts) || FUIN_EN(opts))
-      headers[i++] = USBDHDR(ep_int_desc);
+	if (FUOUT_EN(opts) || FUIN_EN(opts))
+		headers[i++] = USBDHDR(ep_int_desc);
 
   if (EPOUT_EN(opts)) {
 		headers[i++] = USBDHDR(&std_as_out_if0_desc);
@@ -1258,7 +1258,7 @@ afunc_bind(struct usb_configuration *cfg, struct usb_function *fn)
 	agdev->params.fb_max = uac2_opts->fb_max;
 
 	if (FUOUT_EN(uac2_opts) || FUIN_EN(uac2_opts))
-    agdev->notify = afunc_notify;
+		agdev->notify = afunc_notify;
 
 	ret = g_audio_setup(agdev, "UAC2 PCM", "UAC2_Gadget");
 	if (ret)
diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 2bb569895a90..889dec11bb19 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -1115,21 +1115,21 @@ static int u_audio_rate_get(struct snd_kcontrol *kcontrol,
 }
 
 static struct snd_kcontrol_new u_audio_controls[]  = {
-  [UAC_FBACK_CTRL] {
-    .iface =        SNDRV_CTL_ELEM_IFACE_PCM,
-    .name =         "Capture Pitch 1000000",
-    .info =         u_audio_pitch_info,
-    .get =          u_audio_pitch_get,
-    .put =          u_audio_pitch_put,
-  },
+	[UAC_FBACK_CTRL] {
+		.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+		.name =		"Capture Pitch 1000000",
+		.info =		u_audio_pitch_info,
+		.get =		u_audio_pitch_get,
+		.put =		u_audio_pitch_put,
+	},
 	[UAC_P_PITCH_CTRL] {
-		.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
-		.name =         "Playback Pitch 1000000",
-		.info =         u_audio_pitch_info,
-		.get =          u_audio_pitch_get,
-		.put =          u_audio_pitch_put,
+		.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+		.name =		"Playback Pitch 1000000",
+		.info =		u_audio_pitch_info,
+		.get =		u_audio_pitch_get,
+		.put =		u_audio_pitch_put,
 	},
-  [UAC_MUTE_CTRL] {
+	[UAC_MUTE_CTRL] {
 		.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name =		"", /* will be filled later */
 		.info =		u_audio_mute_info,
@@ -1179,8 +1179,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 	if (c_chmask) {
 		struct uac_rtd_params *prm = &uac->c_prm;
 
-    spin_lock_init(&prm->lock);
-    uac->c_prm.uac = uac;
+		spin_lock_init(&prm->lock);
+		uac->c_prm.uac = uac;
 		prm->max_psize = g_audio->out_ep_maxpsize;
 		prm->srate = params->c_srates[0];
 
-- 
2.25.1

