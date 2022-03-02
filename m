Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7C4CAB24
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbiCBRIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243643AbiCBRIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:08:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1506E5F65;
        Wed,  2 Mar 2022 09:07:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m6so3799224wrr.10;
        Wed, 02 Mar 2022 09:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+FBEODWlEwE4ZBpRu4pszv+L75J4ftu6Yw0by+ZcvnE=;
        b=hOrlpj9wIqQtiZ2iI5gabtXozHts++6EWfoyBCd9XE7smYEqH0D0OVdiWv1pcyWOmv
         drF40iR0EnF9vCeXmIYqfPop33M7aHpNtmCzSt5le3/11zOqSeexGyBz8MgQ4WEPa5oI
         IAkV+2cfB3IjRsBMxueIpgamXDtArN4GOSuNjFxfLz7eFSSMx7HDIJrnb/ZruGVPRQqm
         JuXSGImYl/NJQlq9JmPQ6uAcc6mnjQS0l7Y1oTTVRL9RQWBTmnnBopCO4aH4quRq43/G
         dc2kmxA0iGAwtQmMN6z3smEFOwKvl/1qLFFuPzojfYWvmcG8HPgoK2q2CCBdNQ2VmTBc
         0fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+FBEODWlEwE4ZBpRu4pszv+L75J4ftu6Yw0by+ZcvnE=;
        b=6fuFDZzxWOGkFrJKQQXZuQTGyQ0ou3lpE3/TRfwMqATjtkIn4EUi1gB0XrdHf+lzIq
         YZy5UCv0CbKZz1z8UHs19ope2G97ZMuWgILV7zB+fJQUxgmuGiw/wtCcrYqASvYBbJtJ
         hKgpxM4JQWGYfUvatPb/J6K1DQC6Juc3cBOKtRq5p4x+cxswEAy6KV3OX+jCPPnoGiFc
         UPkJZ3sTlo36y5LJ9RhoR41pkgJ7DofZvwl16u5c1PpvJNHIDxGl1HBkous45aDyyasr
         O2YXV+245zvIwybjkW1iioiha7arNmPkmeoZ2oTkv22spLzfylBqx7zhWNYBUeH4pYy3
         Y47w==
X-Gm-Message-State: AOAM5313enK2e8TWaglWC9Be+NtWfpP6TkmiF+X6VK4klpON7GsBSCBp
        v39CHqwzHFkzbrt43vGLAijYTENvADe/qg==
X-Google-Smtp-Source: ABdhPJyDPnbwGRm/gHFADgHnG9mY1P7DvsXiSdJn8zqflakPBj5aWX46fD1EGCCM5wnDqY8YQSkV6A==
X-Received: by 2002:adf:f201:0:b0:1ed:c254:c1a2 with SMTP id p1-20020adff201000000b001edc254c1a2mr23485713wro.106.1646240849938;
        Wed, 02 Mar 2022 09:07:29 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0037d62a899b1sm6651200wmq.6.2022.03.02.09.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:07:29 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] ALSA: echoaudio: remove redundant assignment to variable bytes
Date:   Wed,  2 Mar 2022 17:07:28 +0000
Message-Id: <20220302170728.1094633-1-colin.i.king@gmail.com>
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

The variable bytes is being assigned a value that is never read, it
is being re-assigned inside a following if block. The assignment is
redundant and can be removed.

Cleans up clang scan build warning:
sound/pci/echoaudio/midi.c:211:9: warning: Although the value stored
to 'bytes' is used in the enclosing expression, the value is never
actually read from 'bytes' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/pci/echoaudio/midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/echoaudio/midi.c b/sound/pci/echoaudio/midi.c
index cb72d27e809e..7be5c3327b16 100644
--- a/sound/pci/echoaudio/midi.c
+++ b/sound/pci/echoaudio/midi.c
@@ -208,7 +208,7 @@ static void snd_echo_midi_output_write(struct timer_list *t)
 
 	/* No interrupts are involved: we have to check at regular intervals
 	if the card's output buffer has room for new data. */
-	sent = bytes = 0;
+	sent = 0;
 	spin_lock_irqsave(&chip->lock, flags);
 	chip->midi_full = 0;
 	if (!snd_rawmidi_transmit_empty(chip->midi_out)) {
-- 
2.34.1

