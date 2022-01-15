Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FF448F73B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 15:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiAOODz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 09:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiAOODy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 09:03:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5474FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 06:03:54 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id w26so11328917wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 06:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgqdAQ+WwQ2orxsAM2n1S2UekO1K+V1jDnafdr+cUBA=;
        b=eNlULm9KFr7sVfv7XXX8WvBvJ3EfnXgUDJB50ROFdt/F+8ya6/aT3s+UQrnnIPVR9a
         46btCi0k7UxcG9C16YryKFwdNsh3kpvNfwx5BcbuRatdkkZgwrp/ojsyvrylHuxYufIq
         EhA4Wf2KVbxkJ1VPLZ6iWslGLpPkqdDXHC2cDUIO1sj8b7DP4Qo6bDkA6cFzpfx0fdQ8
         Tb3cwWyN/t//79o4oszMDCL6TPrc+kmBrjlQs0RkEXQj3N0r5ZZq//cipYXG+jAsJuUB
         4OANPlKVCQZ0wjnvXtBXaDb7t6wEW/Qy1dH1cmn/BUFoIOZF+hdrczNY5din6QbN8SWD
         iShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BgqdAQ+WwQ2orxsAM2n1S2UekO1K+V1jDnafdr+cUBA=;
        b=Co6jMUAUamXBOFkJmMwMKTZZjE/GKUaYCQRlYmk2ULq//dHlaG6SYD+eyy6Jox57sC
         fe71wZc5z3Fm9498WcyH5S6tRhDyGJQv1Mfq6VRBC3wZYihTqTFOtbXW0GDsz7XnRlDQ
         muAjddfh5CYvQrXqBxbZ0aFFJSijJLpSq1w/UrPV9t/USXm1Ctw4gY0PYs8PV5il03G2
         96v4ZB+9uTPrjl8PEw40DWhZwOpiXxdz+PufZBh0Qsrn7dBMQJmnMf3DZ0TLQe+vzvv8
         2pJpIonFGAIy4Y9tBBru1sAinTqUsoFJtAjjVz1Is2fJV3MTkpBR8pZzIsJBhDvHqkup
         6lHQ==
X-Gm-Message-State: AOAM533QKcOK9MrqimeUuKc9mMYb98vS2CSGwQZ+9yCf5KKa75ALnkmM
        SGdL3HzW1qlhmDWlB4KhrAU=
X-Google-Smtp-Source: ABdhPJxpkSz+rTg4zCg4BU+pdDS31h57yxHNbH9tGWP4j2dQMy8tIubmv1xnIBgPdZ60V/gmyOln5w==
X-Received: by 2002:a05:6000:18ab:: with SMTP id b11mr12329440wri.385.1642255432721;
        Sat, 15 Jan 2022 06:03:52 -0800 (PST)
Received: from kyrandia.fritz.box ([2001:a61:5e8:7801:dabb:c1ff:fe6f:aedd])
        by smtp.googlemail.com with ESMTPSA id p2sm11148434wmg.44.2022.01.15.06.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 06:03:51 -0800 (PST)
From:   Johannes Schickel <lordhoto@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Johannes Schickel <lordhoto@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andrea Fagiani <andfagiani@gmail.com>,
        Timo Gurr <timo.gurr@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: add mapping for MSI MPG X570S Carbon Max Wifi.
Date:   Sat, 15 Jan 2022 15:02:57 +0100
Message-Id: <20220115140257.8751-1-lordhoto@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB audio device 0db0:419c based on the Realtek ALC4080 chip exposes
all playback volume controls as "PCM". This is makes distinguishing the
individual functions hard.

The added mapping distinguishes all playback volume controls as their
respective function:
 - Speaker              - for back panel output
 - Frontpanel Headphone - for front panel output
 - IEC958               - for digital output on the back panel

This clarifies the individual volume control functions for users.

Signed-off-by: Johannes Schickel <lordhoto@gmail.com>
---
 sound/usb/mixer_maps.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 5d391f62351b..96991ddf5055 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -431,6 +431,14 @@ static const struct usbmix_name_map aorus_master_alc1220vb_map[] = {
 	{}
 };
 
+/* MSI MPG X570S Carbon Max Wifi with ALC4080  */
+static const struct usbmix_name_map msi_mpg_x570s_carbon_max_wifi_alc4080_map[] = {
+	{ 29, "Speaker Playback" },
+	{ 30, "Front Headphone Playback" },
+	{ 32, "IEC958 Playback" },
+	{}
+};
+
 /*
  * Control map entries
  */
@@ -577,6 +585,10 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.map = trx40_mobo_map,
 		.connector_map = trx40_mobo_connector_map,
 	},
+	{	/* MSI MPG X570S Carbon Max Wifi */
+		.id = USB_ID(0x0db0, 0x419c),
+		.map = msi_mpg_x570s_carbon_max_wifi_alc4080_map,
+	},
 	{	/* MSI TRX40 */
 		.id = USB_ID(0x0db0, 0x543d),
 		.map = trx40_mobo_map,
-- 
2.34.1

