Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33134D2B85
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiCIJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiCIJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:13:17 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C3D16DAD1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:12:18 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id c20so1960095edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQyR0zO7n2luNlcmsiExWGwlTndourCo+FKtAyqqPd0=;
        b=VqaFBaT1fZWZLqBlrq2LJAEqf+ye6qEFFWoGTWMSlasfydecGesDwwf3QeqrIZ03Hz
         9cNij4dCoJloGpYyM6wRz+ijmCDSYfvRnlTCjIcF2qsz5VGMfv+Dq/ViajONTqkCB5uE
         1XVnUguMC3DPc6ers+f8J3kj2oa5Ho5vxETaINyduDtEoIXUFJi8am1K2TW3GML8Z9mH
         O5gEfgU7r+HKVp665WdnQfudR6IL1MglbGbglPygj9K6j68Vbz+duyG9sUXvtJqxNo5O
         uPKmiH5vfypTBIGfUdTHxyoxZSqtyTjThx8mZCLOwzlB7efW3+FyeO87C+nKahnV9OAl
         GGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQyR0zO7n2luNlcmsiExWGwlTndourCo+FKtAyqqPd0=;
        b=66St2V4PoGzgf1goOV3Qs0u9aaqIIKXyecXI6ev9ltzM6Bdk7zTXYqaSftVhp+aepi
         fOTjqnzXRyBiJ6lxn7lQu6c8o8qU6L4pk+IQmVrs3jZHZdDpjuVcWzqcgWBfQpXDcfBW
         fmq6dT22NvY8T4BkM7zczW5S5UI63oGGCZEgfgDuDKzPOhB/M7xBU6pDqX59pb3BBXZR
         nVxH67bFRoyemh5c+Fu2uJ39Pbs01JsMBJfADfUJ6Q0zJzudxLiA8Yzl0NzR32XBGFiV
         UXrTnljTopSPGJr8CN8dfPGwq8V3Qi6K03r5YXVkpLD3n5MhWbITskmzj6cHJ8Oz9g2W
         WesQ==
X-Gm-Message-State: AOAM532TbvlM8J8gTXR3ygd7gKuJBJVRaVVI9BaDMYIVMy2iZANZCYQ2
        h3/KfojeEMSsP0mcxByQv3hBfdpoAlG31vjS
X-Google-Smtp-Source: ABdhPJxBbjuLDZ/JsxksWzgPVEra5ZeaUsIifGHk4mExu8GbBy/m7CKkufDyTgjZ9bvmRDl2lmHMUg==
X-Received: by 2002:a05:6402:216:b0:416:279d:b314 with SMTP id t22-20020a056402021600b00416279db314mr18520688edv.75.1646817137179;
        Wed, 09 Mar 2022 01:12:17 -0800 (PST)
Received: from localhost.localdomain ([102.126.147.138])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090626d700b006cfcd39645fsm483253ejc.88.2022.03.09.01.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:12:16 -0800 (PST)
From:   Hatim Muhammed <hatimmohammed369@gmail.com>
X-Google-Original-From: Hatim Muhammed
To:     linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, abbotti@mev.co.uk, hsweeten@visionengravers.com,
        Hatim Muhammed <hatimmohammed369@gmail.com>
Subject: [PATCH 6/8] [Staging]: Removed an unnecessary #if
Date:   Wed,  9 Mar 2022 11:12:13 +0200
Message-Id: <20220309091213.13203-1-hatimmohammed369@gmail.com>
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

