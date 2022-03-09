Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC514D2AF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiCIIxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiCIIxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:53:20 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C986D165C31
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:52:21 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id r13so3365269ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 00:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQyR0zO7n2luNlcmsiExWGwlTndourCo+FKtAyqqPd0=;
        b=hyG7opaHxxU1yhVyszjVCofi1Pfzm4tV6Vy9kROTuJwYDUm3zqTs5wltvPCDplmdTa
         SP0qAI/j2lNy6vM388ieaS4aZLWeCC3e5CQL1ldzcycj3dfdlszR/VF2JfSmCQwADTeH
         v6ahJ8UI9XJohtKYz0yRgZvyRauDjKiBUk0KkvjOVWUcd5jkUPBaf5q7ByaHq3Fc6Aus
         za9HZdXkb55rSHs0VQV1DX9841vchNa22xyrxsVLAaatEDMm9awbTSMhEhzghDV5T0Fe
         OGAbk0/jtXb0ivWLOHZW2A4aGez3yxsS+E50QCC/zXcE79VmARqnC2fDLJtmFLa9gcA1
         ckLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQyR0zO7n2luNlcmsiExWGwlTndourCo+FKtAyqqPd0=;
        b=cc0DhmuynwTl8Gz5fLWHCU+y/RGJwYqWjvBnSHfJvTA5KKMlPg6R2HG30xaUtAAB7P
         AYZ0jwjfdi94L+6b8oxOzlDpesoIRTvNon8CZF4dF2bGMa7b0gg84l1rh9brjRLCVuSO
         iFaFCZNKNistnshOueexcqLcSeFyoUu8hs0AnQUsUyco4byt6CFnEyCdco2HFuUzTnyV
         mGK0u/g+dTVaG+XiHw9+khm33QF8Z+PLEhYG/SOT4T1zbAeg74C81ntbSGuRwRuqd5XS
         aIU3JgHUsppvEUIRUi/1iWassV+F3HgrixZXGtKf1DUBSiIf5vW1ER9SQMHwU0lcjApR
         phtA==
X-Gm-Message-State: AOAM530vLpcBqBIVpcIW7ilsZsC+HcQGDU5utQ3KpdqZikIEtuzl65xd
        ee1mdhWhvXa8k8qTu9at8eJJVUzILjyfCKoK
X-Google-Smtp-Source: ABdhPJz8SK8K0sX37U3BiTmR1RgC+OqM/zJvE3fjlnCz4BXY77i6JErjBW+EbSAhD0BdDtyflj4PRQ==
X-Received: by 2002:a17:906:c0c8:b0:6d0:562c:2894 with SMTP id bn8-20020a170906c0c800b006d0562c2894mr16905477ejb.625.1646815940117;
        Wed, 09 Mar 2022 00:52:20 -0800 (PST)
Received: from localhost.localdomain ([102.126.147.138])
        by smtp.gmail.com with ESMTPSA id jl2-20020a17090775c200b006dabe8887b8sm458706ejc.21.2022.03.09.00.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 00:52:19 -0800 (PST)
From:   hatimmohammed369@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, abbotti@mev.co.uk, hsweeten@visionengravers.com,
        Hatim Muhammed <hatimmohammed369@gmail.com>
Subject: [PATCH 6/6] [Staging]: Removed an unnecessary #if
Date:   Wed,  9 Mar 2022 10:52:15 +0200
Message-Id: <20220309085215.7881-1-hatimmohammed369@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hatim Muhammed <hatimmohammed369@gmail.com>

This removed #if had 1 as its condition, hence it's body will always
execute and its #else block will never

Signed-off-by: Hatim Muhammed <hatimmohammed369@gmail.com>
---
 drivers/comedi/drivers/s526.c | 49 -----------------------------------
 1 file changed, 49 deletions(-)

diff --git a/drivers/comedi/drivers/s526.c b/drivers/comedi/drivers/s526.c
index 9245c679a3c4..df9d240518ef 100644
--- a/drivers/comedi/drivers/s526.c
+++ b/drivers/comedi/drivers/s526.c
@@ -229,7 +229,6 @@ static int s526_gpct_insn_config(struct comedi_device *dev,
 		 */
 		devpriv->gpct_config[chan] = data[0];
 
-#if 1
 		/*  Set Counter Mode Register */
 		val = data[1] & 0xffff;
 		outw(val, dev->iobase + S526_GPCT_MODE_REG(chan));
@@ -246,54 +245,6 @@ static int s526_gpct_insn_config(struct comedi_device *dev,
 			 *      dev->iobase + S526_GPCT_CTRL_REG(chan));
 			 */
 		}
-#else
-		val = S526_GPCT_MODE_CTDIR_CTRL_QUAD;
-
-		/*  data[1] contains GPCT_X1, GPCT_X2 or GPCT_X4 */
-		if (data[1] == GPCT_X2)
-			val |= S526_GPCT_MODE_CLK_SRC_QUADX2;
-		else if (data[1] == GPCT_X4)
-			val |= S526_GPCT_MODE_CLK_SRC_QUADX4;
-		else
-			val |= S526_GPCT_MODE_CLK_SRC_QUADX1;
-
-		/*  When to take into account the indexpulse: */
-		/*
-		 * if (data[2] == GPCT_IndexPhaseLowLow) {
-		 * } else if (data[2] == GPCT_IndexPhaseLowHigh) {
-		 * } else if (data[2] == GPCT_IndexPhaseHighLow) {
-		 * } else if (data[2] == GPCT_IndexPhaseHighHigh) {
-		 * }
-		 */
-		/*  Take into account the index pulse? */
-		if (data[3] == GPCT_RESET_COUNTER_ON_INDEX) {
-			/*  Auto load with INDEX^ */
-			val |= S526_GPCT_MODE_AUTOLOAD_IXRISE;
-		}
-
-		/*  Set Counter Mode Register */
-		val = data[1] & 0xffff;
-		outw(val, dev->iobase + S526_GPCT_MODE_REG(chan));
-
-		/*  Load the pre-load register */
-		s526_gpct_write(dev, chan, data[2]);
-
-		/*  Write the Counter Control Register */
-		if (data[3])
-			outw(data[3] & 0xffff,
-			     dev->iobase + S526_GPCT_CTRL_REG(chan));
-
-		/*  Reset the counter if it is software preload */
-		if ((val & S526_GPCT_MODE_AUTOLOAD_MASK) ==
-		    S526_GPCT_MODE_AUTOLOAD_NONE) {
-			/*  Reset the counter */
-			outw(S526_GPCT_CTRL_CT_RESET,
-			     dev->iobase + S526_GPCT_CTRL_REG(chan));
-			/*  Load the counter from PR0 */
-			outw(S526_GPCT_CTRL_CT_LOAD,
-			     dev->iobase + S526_GPCT_CTRL_REG(chan));
-		}
-#endif
 		break;
 
 	case INSN_CONFIG_GPCT_SINGLE_PULSE_GENERATOR:
-- 
2.35.1

