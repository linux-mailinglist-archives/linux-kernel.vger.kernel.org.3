Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A964F5178
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846452AbiDFCEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443051AbiDEPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:38:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA4E144B5C;
        Tue,  5 Apr 2022 06:54:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so19385760wrc.13;
        Tue, 05 Apr 2022 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DtW73tEE2+XFkT3bPsX/7iGbHd2vWpPYT/i50JAUgmI=;
        b=KRuBEqeehUWFQiE6Qb6pz2CZtRUAXww/24GIyCnvwpdbtfIKvDXbMg/G7g3DnY42x6
         /iZbgKc5kKf24N8Ac4Mpu156t4HMYzU7Nm+RM3S3BnmbpSHNkHbZn/OOn478oWoEpF8E
         De5/l0DXrm9uA/jpBI0/y5L4nLSqe4IWXKqb4B9WfjbhMRIsV28Dz8F/Eb2URXYcNzQM
         AtiZNEnvnfUmIdfza2vc32Mep19NqVFUKjYP78+D97mljq2ztcdx3TyvTolE+C9Klo0g
         A++9eTEGSW/RNdTwnTzk/7OBaYYwNf3nClqpPAgFLubykoDzWaSzpo9QnkjU9VSqUVjI
         FKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DtW73tEE2+XFkT3bPsX/7iGbHd2vWpPYT/i50JAUgmI=;
        b=wg2+xuN2p/2bH9p0ysDY0PM6PYQ8n/7R/ZS4VFjHDTpKvINogCpTWx/9WCBTAuVo7j
         PinirXoGTmofj2Ln5Gan1Gip4C4OocGgxWo9ob4Hebzu3IWGVWAYomgkiDu5ndSHpCJG
         QFAJ0oW6NBPzGaWiTVhc5iXnMjD1+YO6NIaNpTn1gq3pgWIPuDudm9J/EU/9+FtU1sIu
         xrpdDGHoP0pQg07hQI4Eqbw7zJ1eVlpNL2JkUzBA7Ge3jdsFYByX2WdTDB5XkDS3o5Mm
         XQiZWc98z48LaZGT5nYfjLgplX4JvuwyDyHWNPGAvQqdBhwsCSAooD3JxOe2UnROC4Q/
         mkDg==
X-Gm-Message-State: AOAM530w4awfk3c2ymPRlPpwMmmXnYDUIurCvkyZUeqlNaQuxi3UlFmy
        0sqjcuoEVA10yEhRf1DKOkA=
X-Google-Smtp-Source: ABdhPJx7uWLB6seAta51fiSK0+njz9yI+4yOg/CEwF3nvoU2EuPI0t4kkYbH392xPZ7JN2jShsBA+w==
X-Received: by 2002:a05:6000:156d:b0:204:c24:895f with SMTP id 13-20020a056000156d00b002040c24895fmr3015212wrz.339.1649166854425;
        Tue, 05 Apr 2022 06:54:14 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k12-20020a5d628c000000b00203e2fbb2absm12132822wru.113.2022.04.05.06.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:54:13 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: echoaudio: remove redundant assignment to variable i
Date:   Tue,  5 Apr 2022 14:54:12 +0100
Message-Id: <20220405135412.199251-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The variable i is being assigned a value that is never read, it
is being re-assigned in the following for-loop. The assignment is
redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/pci/echoaudio/midi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/echoaudio/midi.c b/sound/pci/echoaudio/midi.c
index 7be5c3327b16..47b2c023ee3d 100644
--- a/sound/pci/echoaudio/midi.c
+++ b/sound/pci/echoaudio/midi.c
@@ -124,7 +124,6 @@ static int midi_service_irq(struct echoaudio *chip)
 		return 0;
 
 	/* Get the MIDI data from the comm page */
-	i = 1;
 	received = 0;
 	for (i = 1; i <= count; i++) {
 		/* Get the MIDI byte */
-- 
2.35.1

