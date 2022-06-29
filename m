Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A1E560BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiF2Vfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiF2VfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:35:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8639B3193D;
        Wed, 29 Jun 2022 14:35:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z41so5433825ede.1;
        Wed, 29 Jun 2022 14:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTaZ/9+DRnLhDSj0DOV2C+IIhpHfbKqhWacVmkOB7BY=;
        b=OG9wXeWMbA9jmZ71InLLxD32/gseAKb5oVYBc+PJOAqRdmpfUkjp4fckT0vXOJ8pTi
         ZjyqHyfQb8ee4bgJO6CbxkPrH29191krcCqsTASWl8vZFjriLcJyiF5r37q7cT9xaCMs
         IrqSuKnt1scDz3vaaj/HDPXxtcyi93QjUVUL5FsiWd2EmKjO90IpiMQig2F9AG4QZVCQ
         +CSBnoN9T7ic2o4qbqRGkHg/6DDaFT6m3HAaQ7nnPY+zQTDR2e5KeobRgNQm7Ppy/KAN
         J9UqVrvSVe7LkYrvxhe5RqVi+sDvuN8wJJk34rvhXVLiaJGhutxX0Bl6FgpMErnnmvq1
         vRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTaZ/9+DRnLhDSj0DOV2C+IIhpHfbKqhWacVmkOB7BY=;
        b=sLCFQHyi3ASGvJ2bfrUCmaE/FeJ7w8kUuchl8I65svFw5ROmOHBzfnbmkLX3RrfYwQ
         vnHlzEzG9m4y042HAfKf7NXeCWaIyzEbZSC4wy4oXtCFygBVhnQcM+raJ1vW+HFj1b2s
         Ypj01C1slM+79yE2dqBKhl7tiZNQjPKPGhfwmq3IlHrGG8sBEaE77RrgrNFPW+lwZzy4
         dplOf5wTQ7IN1CXcBots8PotLqOMB/1sTd/VHjUEkPLSnmWoAGuXdEg5rP6mtzzX2+Cp
         jV5OstIh2+Jbw2XTky2wwDY1NxqTV1roxY/OGuptue8w32TAzZezybJK2PIpSRjjZSsS
         73+g==
X-Gm-Message-State: AJIora/iojlTNdJ/uku615JajaM8/vD8+QNdjTaNsB5a3uqALXqvV+Dt
        1NfLZwxD5T7GNJ8vb1phb9k=
X-Google-Smtp-Source: AGRyM1tlSXdF9Iut3FvpE4lFtKgNKps/XSbVGJYdKdrc7jFSNhpFqDmGWLQdYO8tT0vzY1fQ2P7P3A==
X-Received: by 2002:aa7:d5c9:0:b0:435:8099:30e6 with SMTP id d9-20020aa7d5c9000000b00435809930e6mr7084462eds.384.1656538523086;
        Wed, 29 Jun 2022 14:35:23 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-003-132.77.7.pool.telefonica.de. [77.7.3.132])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1709066c8700b0070c4abe4706sm8237889ejr.158.2022.06.29.14.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:35:22 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/8] mtd: rawnand: intel: Remove undocumented compatible string
Date:   Wed, 29 Jun 2022 23:35:04 +0200
Message-Id: <20220629213508.1989600-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
References: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
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

The "intel,nand-controller" compatible string is not part of the
dt-bindings. Remove it from the driver as it's not supposed to be used
without any documentation for it.

Fixes: 0b1039f016e8a3 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index 3df3f32423f9..056835fd4562 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -723,7 +723,6 @@ static int ebu_nand_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ebu_nand_match[] = {
-	{ .compatible = "intel,nand-controller" },
 	{ .compatible = "intel,lgm-ebunand" },
 	{}
 };
-- 
2.37.0

