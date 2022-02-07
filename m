Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5D4AC107
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391297AbiBGOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbiBGOGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:06:21 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B984C0401C3;
        Mon,  7 Feb 2022 06:06:20 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id k18so24984471wrg.11;
        Mon, 07 Feb 2022 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tBKWnS+g7You4oahdBZV1moenSdw6O464+uIoP4Ehfw=;
        b=dXHUkHHHLQVcF081BhnShtt/ILiXpVb0T3NzyCo3i0nakhqxWs2EPz9K/tIrOG4t/q
         ZmJBv6zMZ9oe2EmWqrcUsw0RWxqGsxtBSS4T4i2UE1VGygzOS0q5+qq1slHJLFk61oua
         32mR5gFhRVh0FEPZ8PCqrbEPsdeUVImaqnqPUkg2cYvsF55RNOzS7L/8Bl9l/pljVxiV
         Tc8pb7VPlg5FpOF2bd6lqh7OJ7EpRKlboqsn/+n+WB8gl5tuYmx6b8XTa6k97x7IPPxt
         q7Mvq5E2Hi7r8q6eIWDyZ0jZ+gnBR4HFiHWwyOlmMbRQeGVbu6rIxc85DNgUrhocF6eh
         OF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tBKWnS+g7You4oahdBZV1moenSdw6O464+uIoP4Ehfw=;
        b=Oa/vru13XJJl4LvgtF3HepbIBVdR4bkWMYXBGmJKDEtgEOg+fCVhJ5y606pI0+j3On
         z/bpDHUSqPjV45QanUjDPUbe0jO9+8iTMBufbfyBuHrlP9u7dYLJq0d2Zs9G2rbA0Abs
         SkNk2F7KlvjzxoeeAPdbnK3cDNYFaLex7KlBfNzZpeI85+UbXtvMsXt75LVZQHDRSNiy
         GPumB6A2pOrV/shzsFCOFykR+hIGIrb7Fhby21HyYDumG4RTen21sX0KAUQe+PrtW8mz
         pCYsWDpwZ8yaSapCQx0vliUW9Q7kWpgya+WMrs2EBKoyctwlR3jlNAfI1Djtpp6TxZLA
         Fufw==
X-Gm-Message-State: AOAM532iJqyj9LXFZTcE/MgVSXvk0uu3jd+wf3JxI+3EsHzBGYXZ5fSR
        UU+n4dXBn5j/LdfAjulZvZsdmh7TCEGCJQ==
X-Google-Smtp-Source: ABdhPJyKet9Uuh60UU/p6hDZJIyCF7NM/ixYXuVRcY9k1xOZeokpEzA36xzaIhpdpjAHmboNRpfbrw==
X-Received: by 2002:a05:6000:1866:: with SMTP id d6mr10140333wri.309.1644242778904;
        Mon, 07 Feb 2022 06:06:18 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n10sm4140786wrt.93.2022.02.07.06.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 06:06:18 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: remove redundant assignment to variable c
Date:   Mon,  7 Feb 2022 14:06:17 +0000
Message-Id: <20220207140617.341172-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable c is being initialized in an outer for-loop and also
re-initialized inside an inner for-loop. The first initialization
is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/usb/mixer_s1810c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/mixer_s1810c.c b/sound/usb/mixer_s1810c.c
index 0255089c9efb..fac4bbc6b275 100644
--- a/sound/usb/mixer_s1810c.c
+++ b/sound/usb/mixer_s1810c.c
@@ -221,7 +221,7 @@ static int snd_s1810c_init_mixer_maps(struct snd_usb_audio *chip)
 	e = 0xbc;
 	for (n = 0; n < 2; n++) {
 		off = n * 18;
-		for (b = off, c = 0; b < 18 + off; b++) {
+		for (b = off; b < 18 + off; b++) {
 			/* This channel to all outputs ? */
 			for (c = 0; c <= 8; c++) {
 				snd_s1810c_send_ctl_packet(dev, a, b, c, 0, e);
-- 
2.34.1

