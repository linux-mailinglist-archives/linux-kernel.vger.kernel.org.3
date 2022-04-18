Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C6505A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344751AbiDROnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345018AbiDROme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:42:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D254CB867
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:28:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t11so26799837eju.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nkYV7T1aixHjHVn90tgTWbE9t0QEJM6StqL3GUrlAlk=;
        b=LJ5T0cy9J4PoTu2Gd8yp/uT1fnd+pbUuNHOuNNn89UJS8blNpb3NIOyZFbECSoeQcL
         DcZzQARnZ/5ZPC0G2rwBGsqQfKnsgvJgIpgBoTEYQe8ioKPrrvjKkPVIuA69qqb4g8DY
         NWg1yC27X17kcs5BKDp57PF9wPy06dijZTrxb4V8xl0/5Evb4zQyPB3o8WFYc99ZXhJv
         Cb9za5/p+OORSs/5+nxe6YFmjXWDigF9v+v7TG5iAkOYanf+jsB7T48gUxEKlXLn2abz
         7TG977jkIN85MD0Wzni8o/Dh8UxPcD/ECX13UaffuXbLncB0JHhYlFSgQ6BkfcD0d0IB
         Ez1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nkYV7T1aixHjHVn90tgTWbE9t0QEJM6StqL3GUrlAlk=;
        b=XoK1I1SR1wRmDs46MBpD1mhE7tkHJP1npe74EcVKbolAL5EwmRkEYHjACSdGNsfA8h
         6pGMg36rEQubFyVeFgwJw6Dj9fBsWyGqfiTs9AKvRcbbPykLMgpB/H82SES+Mm7EeUvr
         cOS+yVmRwKGHnxiCE/34xZiKQ7kkBvcpylM0GkE0oRrby3ydTrEuwcjP/S5iztnkOeJw
         2Hc5YJgv+xKGyMIkZCw0xAFCc4M8pQ6ELTMmEekok2+58cb2aQuK4aB7E/xHRHo3bZdL
         DivoFXhIYN1TGO/T1s9dzwzC9dfIL4LKm2XL5M5CR5Q4zMPlgNrqcRHfEaBln8ZW6+tW
         bH4w==
X-Gm-Message-State: AOAM532xeTPqRhbeZjOBuTIFCpPjA8z8Mj90h+OkrSLnMkWziehZ94Dw
        QXwbAvpD2Yfo7yM/q4KgFy5ymKeeCaUW7A==
X-Google-Smtp-Source: ABdhPJwWqLeK8fB27393z2QZpt7Z0xPsk0D8WVyrVl7h6EkfMopl9RFZbXWs6a/WiIcQSwI3zXri9g==
X-Received: by 2002:a17:906:58d2:b0:6da:b635:fbf3 with SMTP id e18-20020a17090658d200b006dab635fbf3mr8830951ejs.40.1650288480437;
        Mon, 18 Apr 2022 06:28:00 -0700 (PDT)
Received: from ryzen ([2001:b07:2e3:dacc:d3f3:c3c5:d3a2:5ee7])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906521000b006d58773e992sm4619829ejm.188.2022.04.18.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 06:28:00 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:27:57 +0200
From:   Maurizio Avogadro <mavoga@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Andrea Fagiani <andfagiani@gmail.com>,
        Timo Gurr <timo.gurr@gmail.com>, linux-kernel@vger.kernel.org,
        Maurizio Avogadro <mavoga@gmail.com>
Subject: [PATCH] ALSA: usb-audio: add mapping for MSI MAG X570S Torpedo MAX.
Message-ID: <Yl1nXcsAKWrFOMbY@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB audio device 0db0:419c based on the Realtek ALC4080  chipset
exposes all playback volume controls as "PCM". This makes
distinguishing the individual functions hard: the mapping already
adopted for  device 0db0:419c fixes the issue, apply it.

Signed-off-by: Maurizio Avogadro <mavoga@gmail.com>
---
 sound/usb/mixer_maps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 64f5544d0a0a..7ef7a8abcc2b 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -599,6 +599,10 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x0db0, 0x419c),
 		.map = msi_mpg_x570s_carbon_max_wifi_alc4080_map,
 	},
+	{	/* MSI MAG X570S Torpedo Max */
+		.id = USB_ID(0x0db0, 0xa073),
+		.map = msi_mpg_x570s_carbon_max_wifi_alc4080_map,
+	},
 	{	/* MSI TRX40 */
 		.id = USB_ID(0x0db0, 0x543d),
 		.map = trx40_mobo_map,
-- 
2.35.1

