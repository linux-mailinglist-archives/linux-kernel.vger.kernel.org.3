Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9510E58AB28
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbiHEM5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240881AbiHEM47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:56:59 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A81328719;
        Fri,  5 Aug 2022 05:56:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h13so3171332wrf.6;
        Fri, 05 Aug 2022 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tdktkdyoss6MPtWcDNXEp8QoORxZwPnYjcB5REPGiQo=;
        b=OSkPRZN6X00ZnwdYODz3BqQFJz0cTxlx4ZzBtSe4jpVuyA+EAtR8ZCRTGtWssasCtI
         JPEibItr1eH4zQlnwWqoNmiOEwftcB1TJtFMSNNxgXiOdnOeVO8Ki3b5n2NkkI7NbZzW
         +Rle2I2M0IQNcfBTXgsCtLtVx2Q1pBIvzyCRtlnRnFn8laoNP0+11YU/PGTqa8HMf6D+
         2kpvAUccVDNwnD8BsYmKnKdxQO9NBsHPPkTXIpMDKbL7c3xg0F1vIP8HrQdBmkdtMZWp
         N9fN7ckGs7bTs4KUZsKqRxStybFDptbwa3vxMtYy92l9OnZhsW8A+GXubgxoNzqiMa4M
         4Pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tdktkdyoss6MPtWcDNXEp8QoORxZwPnYjcB5REPGiQo=;
        b=iroqVjOH/Om4G8KABUkjl5AyYxKpNVHq1V/wiUq3g/Ovg9d7dtm8GJ/U5xYGctVNx/
         zxbbe1fT01qg2c8KDNoEanAbmq+IBEJi9+MBZCxGKvF1Nb+xzgm/T3yUj7vkRJfgOIYE
         pZzm8Lub5rsGPiIR3Ja9bqhjyq0e7lG8Kw0vxdqVwAF2R/CEefhN8PHhwfeshzd/ToXG
         Emi+C1yOdBRJOlUnHh9ytCanKKQXf6OORjkeg7rlJmY3MvUqml7ZJKRqucfYq62k53M1
         JsKie9PSxyv4yBaXyC0km1ltZtG9IxP1Cyw2wLcauGDqyZWZ2zEDGAoDMNRsaSSfrBpo
         DwgQ==
X-Gm-Message-State: ACgBeo0WJ76qmEMh2KauUORgbhBBDqPE02ASop82a60cDmhKQJGzsbW3
        thAmvzIfBEqpX3wdY76uFVLJd/5XjeoXaXFC
X-Google-Smtp-Source: AA6agR7lFaFf1EZ4qUuP857h9tRe63pqmkOx6LwGZ/CX7EHwv84Y9sspkJUZH9s10FqYb6n9PL+Mow==
X-Received: by 2002:adf:ce89:0:b0:220:6cc5:aff8 with SMTP id r9-20020adfce89000000b002206cc5aff8mr4301687wrn.396.1659704216667;
        Fri, 05 Aug 2022 05:56:56 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b0021d7ad6b9fdsm3866500wrt.57.2022.08.05.05.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 05:56:56 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ieee1394: Use correct function names in comment blocks
Date:   Fri,  5 Aug 2022 13:56:55 +0100
Message-Id: <20220805125655.2347072-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

The incorrect function name is being used in the comment for functions
init_ohci1394_dma_on_all_controllers and setup_ohci1394_dma. Correct
these comments.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/firewire/init_ohci1394_dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/init_ohci1394_dma.c b/drivers/firewire/init_ohci1394_dma.c
index 659256927b42..11796931f9c4 100644
--- a/drivers/firewire/init_ohci1394_dma.c
+++ b/drivers/firewire/init_ohci1394_dma.c
@@ -251,7 +251,8 @@ static inline void __init init_ohci1394_controller(int num, int slot, int func)
 }
 
 /**
- * debug_init_ohci1394_dma - scan for OHCI1394 controllers and init DMA on them
+ * init_ohci1394_dma_on_all_controllers - scan for OHCI1394 controllers and
+ * init DMA on them
  * Scans the whole PCI space for OHCI1394 controllers and inits DMA on them
  */
 void __init init_ohci1394_dma_on_all_controllers(void)
@@ -283,7 +284,7 @@ void __init init_ohci1394_dma_on_all_controllers(void)
 }
 
 /**
- * setup_init_ohci1394_early - enables early OHCI1394 DMA initialization
+ * setup_ohci1394_dma - enables early OHCI1394 DMA initialization
  */
 static int __init setup_ohci1394_dma(char *opt)
 {
-- 
2.35.3

