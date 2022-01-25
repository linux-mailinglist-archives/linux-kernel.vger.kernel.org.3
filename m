Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88EE49BF29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbiAYWxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiAYWwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:52:47 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB5DC061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:52:47 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d18so8062936plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWfMgnceP3WNDhbbX8eL5TtVhp988kv+nIi980hVt9M=;
        b=mLs3FRh8AoMm97R70t9K+b92xF7pHWbm9IlS6mJi+fR488otarAvNiw0dF1FthzNYU
         vxHCkvSAQvZJ44eJXWYo/yeXiGD6Ft4twLaB/V87Jqadr39Z57Y0qqf5hACOgtri0M2O
         tzpyNzDQK2scwbqZ4J8GT9S1+jhHHm8inOUqAlTwNfy1KAIVZbHSSTfZ64+VSFY2cKHA
         K5Ey2zr/YzQ3uJmmSwa5yocYkz0Filv2KCfGP7hO65siu95zt0KL2FH35qBA0dRq2On8
         LBDowfH8Eyjf7JFL+ooropxmccKktFN50pbbvLabB7d1vRsBuij3rpDDS5OpNEDz8JVS
         /CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZWfMgnceP3WNDhbbX8eL5TtVhp988kv+nIi980hVt9M=;
        b=E3pueohL9OhKAhNuWiLaBpIIzdItIFQ+RYx1O51yJmqzTHj//vy/8B8QaiXDXwmr+a
         3U1RIYTtoEGASEq98qb/Daxx0cf/SgdQlRljXlrLKpOMQYmvwmlsgVk9TURVGSd1V1Uo
         w9dML7xliZ1FB/zrPNfk5QSLo8Zo/mzdjHbthMRFnMVf+ltPRLIZc5jZoRayMCdmAjV+
         8wZTXNGP7r7JMvJ3yaHe/m7bJJGECESQFwlHcQDmHgIG+FVoFK+1ObeFZzamKahti7In
         X4jlaVzG9RPnhJu/UAUNL/y/YZbtWZrsREajZL5dRpk9wXuT7QBtTU70MvxTk0ZmuK23
         FMsQ==
X-Gm-Message-State: AOAM5308aHRkJLpg1tKWrBrvJABQ8cHuIrBAi4DgKrps1uvDpMF9zNOJ
        Qi0psfEtPUctoKcU8hLevkvfHDdif/Q=
X-Google-Smtp-Source: ABdhPJwqxRDRTRsp6A8LruKcke8RE+wvSNE+TXzWM9Mm8YCSFHd1tBRXIYzPjoqOnDHoY3H70+IS6g==
X-Received: by 2002:a17:902:6bc9:b0:149:fdf1:f031 with SMTP id m9-20020a1709026bc900b00149fdf1f031mr20329013plt.58.1643151166761;
        Tue, 25 Jan 2022 14:52:46 -0800 (PST)
Received: from 7YHHR73.igp.broadcom.net (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id me4sm1449899pjb.26.2022.01.25.14.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:52:46 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: rawnand: brcmnand: Fix sparse warnings in bcma_nand
Date:   Tue, 25 Jan 2022 14:52:43 -0800
Message-Id: <20220125225243.15201-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse was unhappy about the way we woulc call cpu_to_be32/be32_to_cpu,
apply the appropriate casting to silence the warnings.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/ZNHPJFYLO64EGI5QUT7HZ63J7O5J2G7N/
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/bcma_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/bcma_nand.c b/drivers/mtd/nand/raw/brcmnand/bcma_nand.c
index d7c62988c452..dd27977919fb 100644
--- a/drivers/mtd/nand/raw/brcmnand/bcma_nand.c
+++ b/drivers/mtd/nand/raw/brcmnand/bcma_nand.c
@@ -58,7 +58,7 @@ static u32 brcmnand_bcma_read_reg(struct brcmnand_soc *soc, u32 offset)
 
 	/* Swap if necessary */
 	if (brcmnand_bcma_needs_swapping(offset))
-		val = be32_to_cpu(val);
+		val = be32_to_cpu((__force __be32)val);
 	return val;
 }
 
@@ -75,7 +75,7 @@ static void brcmnand_bcma_write_reg(struct brcmnand_soc *soc, u32 val,
 
 	/* Swap if necessary */
 	if (brcmnand_bcma_needs_swapping(offset))
-		val = cpu_to_be32(val);
+		val = (__force u32)cpu_to_be32(val);
 
 	bcma_cc_write32(sc->cc, offset, val);
 }
-- 
2.25.1

