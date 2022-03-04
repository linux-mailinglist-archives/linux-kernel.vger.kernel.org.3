Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B6F4CDFBE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiCDVY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCDVY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:24:26 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837235E143
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:23:37 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hw13so19882018ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 13:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oig8fhLNyVNunrNPMCm55EjpGrpFgGoOxxBNe6hX29Q=;
        b=fMaD3ywH8iy0Z2twtGF0BWxNTmtA6vvgiUdlUCWiZFnv0u1vqqQHU7G/S8GF8aTtdO
         r4rjCbFzNXHYjkw+nYPoY126hOKWZXwU/QIdQBB1IpPnRxrrmxgmzSec9n9HDr3X9V/u
         3Kp0VrWTis8L6MGfAc+BnD60vksV8m+m05LwkISoW0wIOwEX3Xjz2cc3d0B7ez4e/q99
         rDG0EFdraH20cLIj0cittLQ4fjiLPfgN0Ebelf4qhQf/phvShysDxILdNs0BFDBt5NlU
         qEEo/PZVeYzWroMJVnPm5aDeCcTm85g2AdNNEAxOV3QLpGEoGc9wbvPVcOY3KDWYLX8w
         zGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oig8fhLNyVNunrNPMCm55EjpGrpFgGoOxxBNe6hX29Q=;
        b=rISpz2mfDn27+LGtpJKc5iduaHdzNRN5V5XOijAveza9x7ahel3IJTEDMR1ATZ3ANW
         7euN+MkaiqPMEpTzBHjMOjX0s/9BjqJ9xqLB1ucqCI7eeA9izgC7kRkOcVZ13XWJLPIK
         Yw93PuQvv8TjDqli29SW4eouO+4dxguUi/nMD+pb1298FBGn01EaVIv8+kjtsHozP6As
         k4et4tAhShvThXD/1cyN5Hr47FoitMo+Kd+kvmN2Bj58DbqUW/OT2/G4znNOjevm63tt
         9SKBoSDYgbdvmxetCUHF5ih6s2lmOeNHqV7XR2o9YMhB+rAmR4GRAohi13ci3wu8O88S
         FWIg==
X-Gm-Message-State: AOAM531nD6JSF9k8CeKee6gSoksWGhhrbCO/DE308kQYhcOK7Nu3AMV1
        TR7fxrdgyY2KVuch5FrUhBE=
X-Google-Smtp-Source: ABdhPJx1mj58ZJXedZ+imCgau9OHpp1s8A2U+fVVz7OtXF2X982LGH/8Dj+YK6jyDK2a15GCao6q/g==
X-Received: by 2002:a17:906:1ec3:b0:6cf:d118:59e2 with SMTP id m3-20020a1709061ec300b006cfd11859e2mr529524ejj.767.1646429015877;
        Fri, 04 Mar 2022 13:23:35 -0800 (PST)
Received: from reza-pc.. (73-241-201-31.ftth.glasoperator.nl. [31.201.241.73])
        by smtp.googlemail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm2147396ejt.108.2022.03.04.13.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 13:23:35 -0800 (PST)
From:   Reza Jahanbakhshi <reza.jahanbakhshi@gmail.com>
Cc:     reza.jahanbakhshi@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Johannes Schickel <lordhoto@gmail.com>,
        Timo Gurr <timo.gurr@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: add mapping for new Corsair Virtuoso SE
Date:   Fri,  4 Mar 2022 22:23:02 +0100
Message-Id: <20220304212303.195949-1-reza.jahanbakhshi@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New device id for Corsair Virtuoso SE RGB Wireless that currently is not
in the mixer_map. This entry in the mixer_map is necessary in order to
label its mixer appropriately and allow userspace to pick the correct
volume controls. For instance, my own Corsair Virtuoso SE RGB Wireless
headset has this new ID and consequently, the sidetone and volume are not
 working correctly without this change.
> sudo lsusb -v | grep -i corsair
Bus 007 Device 011: ID 1b1c:0a40 Corsair CORSAIR VIRTUOSO SE Wireless Gam
  idVendor           0x1b1c Corsair
  iManufacturer           1 Corsair
  iProduct                2 CORSAIR VIRTUOSO SE Wireless Gaming Headset

Signed-off-by: Reza Jahanbakhshi <reza.jahanbakhshi@gmail.com>
---
 sound/usb/mixer_maps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 96991ddf5055..64f5544d0a0a 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -542,6 +542,16 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x05a7, 0x40fa),
 		.map = bose_soundlink_map,
 	},
+	{
+		/* Corsair Virtuoso SE Latest (wired mode) */
+		.id = USB_ID(0x1b1c, 0x0a3f),
+		.map = corsair_virtuoso_map,
+	},
+	{
+		/* Corsair Virtuoso SE Latest (wireless mode) */
+		.id = USB_ID(0x1b1c, 0x0a40),
+		.map = corsair_virtuoso_map,
+	},
 	{
 		/* Corsair Virtuoso SE (wired mode) */
 		.id = USB_ID(0x1b1c, 0x0a3d),
-- 
2.35.1

