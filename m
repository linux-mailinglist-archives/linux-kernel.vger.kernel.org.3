Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5FF4D2B62
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiCIJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiCIJH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:07:28 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C3B16AA6C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:06:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qa43so3375065ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQyR0zO7n2luNlcmsiExWGwlTndourCo+FKtAyqqPd0=;
        b=RLyN0r6C5YbfWHtydEn0F2Yo1Ilq1I2Ep9wUVOiTvXKcyPLOAG36T4ueMr4NK7nYfY
         3/FS81WFD1a9DbwGwq9PYX/AvewP3TUox3RAdeZmlB0Vj1V7LVblIbwPe8bu57lQUV2f
         gSrXqDIrBCB90gRTOicbO3AUCZJnv1iN5uimZtdUM610+cPluso1wYLF/YX++EMKP6gv
         8sJ3Du8s+FqwaqCQnydgPJTdyqSKSUqgBZOfjZff+Fw+4EWZFRyvc4v6SZyFzs0QTYw/
         5vk/4RiWTMatEBjNZ731rQ9uKjojh6oGKnO62ZqnIcJjGakJciV8ZP7biuyafWr5nvAg
         YjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQyR0zO7n2luNlcmsiExWGwlTndourCo+FKtAyqqPd0=;
        b=plFj6npJV/zW6zXPQG7y8TnbvqVk7n//ycl8DgJcF54l9dSJRb0VYMHmALNGbZRT0/
         MnGOrEjKBWf92ASqEfQyWyf1nJu6dABYv/kRUIPgLNhmlj6Y0Fj/nhHvSSvZ5M1wueO0
         KKqBG6P1so5Q/tNoG9B29QpVt0XCQv8P785P2U/i2D4x+rZrZRqlt0lowZ82TngtETv8
         /HS+j4I038etbhw6I/ip1Nb4YPNucEnrCeMpiPwfooxmNAWJjaV9RrTfUtLhxt6MJuIa
         SlgAlAPDG7cspIQFxv2hAPKoRBNjrxZIc41jgOx42B4jRf69LXiqxnYp+KqdWwo49sGB
         TA0A==
X-Gm-Message-State: AOAM5331ejugSQx2HnLq29+JjUU7CKlw9UPTgj1TkPL2RS/SEVPLu92z
        B/8SlZlP9qAo3zELfxqbBvCbHNZfi0EJDOmx
X-Google-Smtp-Source: ABdhPJzA1/r17MIq+cc28OgCL3kMF/cCpX6eBCNvn19IDLs+wIkx2Jvfu4iue8sdQlon7LYrctH4ZQ==
X-Received: by 2002:a17:907:6296:b0:6da:745b:7b40 with SMTP id nd22-20020a170907629600b006da745b7b40mr16849584ejc.750.1646816788283;
        Wed, 09 Mar 2022 01:06:28 -0800 (PST)
Received: from localhost.localdomain ([102.126.147.138])
        by smtp.gmail.com with ESMTPSA id w22-20020a05640234d600b004165de83109sm518067edc.48.2022.03.09.01.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:06:27 -0800 (PST)
From:   Hatim Muhammed <hatimmohammed369@gmail.com>
X-Google-Original-From: Hatim Muhammed
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        Hatim Muhammed <hatimmohammed369@gmail.com>
Subject: [PATCH 6/7] [Staging]: Removed an unnecessary #if
Date:   Wed,  9 Mar 2022 11:06:24 +0200
Message-Id: <20220309090624.12696-1-hatimmohammed369@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

