Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C99542A28
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiFHI7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiFHI61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:58:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CD3E864C;
        Wed,  8 Jun 2022 01:19:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq6so26870804ejb.11;
        Wed, 08 Jun 2022 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKwjyaH0RghwN0hJKqnq9RMPrTrxsm8tLBDPz0gqc1I=;
        b=EwCy6VHhTYRZJrodfK0ASZnyaCp8ApVDFmi2lMUB70XrB724PIdPEdrzGgh2AzWQ+U
         l+kdbomO18EUwN684FRx3mvOP+ucCczjPS+erMmfR+w7KjgmC8FmPLRUhn4h5Ff70j84
         sUKfpMubQ6IqXKFRLwQWO8Z3y/5XFZCcz7clEYeaFLaCvhWoAbst75xThURqiBfdeqwu
         0/RzTtLG3IMQ5deQv/l9Btr7zU+QGLzM7bE+MUC3vViODYTVGHI0pCfGsplCJUB87vIV
         Zb3KnCoNwmap+6ZnaQucozGA34U9esESnZFgRGnunNPFHsYfDVh3L3HFBgbZFhuYOGyD
         YN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKwjyaH0RghwN0hJKqnq9RMPrTrxsm8tLBDPz0gqc1I=;
        b=N4zNfCujb80Chh6+hipLsLL5z3ImNbgNP9vYv/YVa9QFDGUrn7rda4eeRhwM942cqA
         F+HEj+/WXJvivZjbawVgHJZuO4kLgJ6qx/CPEZUG7Jvir4H6FzRc6YLlGR2PNXY9GFa+
         sIpHbuZW5yFczGSAA2VZC0J8ZpMF3/Oy+OxHvllp698e+N11sItIWtRvXsOUepu8JZpO
         cvDK5doN+lRsWDOQ0jQRBk29ln4UShhD5PuLYf5FdElo2f15dy2cF42CZguDQCMoS/FK
         4HaXoU65oEgGNej/LZWi+JM+rZRoT0S6m1jjxdSSrDfvDVvjaFI6fLoFpMM6JeIyIMGu
         4fDQ==
X-Gm-Message-State: AOAM530TziMrrTO9tBt0QoTviOrL0HCGVt6KxLQEWxxLzwaCVE+3Mvhn
        +ggtLBD2/8rzwvR+xJodp4Y=
X-Google-Smtp-Source: ABdhPJxffay0XJhs8bDRwafqDDC7xdEu2XfWekNGL183hIUb8K95AJZ9EfKBiHPSdOQVwqcJlLazxA==
X-Received: by 2002:a17:907:3f8b:b0:6ff:4721:3cf3 with SMTP id hr11-20020a1709073f8b00b006ff47213cf3mr29848587ejc.48.1654676354832;
        Wed, 08 Jun 2022 01:19:14 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k24-20020aa7c398000000b0042dcac2afc6sm11717403edq.72.2022.06.08.01.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 01:19:13 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: s3c64xx: Fix spelling mistake "hannel" -> "channel"
Date:   Wed,  8 Jun 2022 09:19:12 +0100
Message-Id: <20220608081912.2083086-1-colin.i.king@gmail.com>
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

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 82558e37c735..f56d9c819a76 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -360,7 +360,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 
 	sdd->tx_dma.ch = dma_request_chan(&sdd->pdev->dev, "tx");
 	if (IS_ERR(sdd->tx_dma.ch)) {
-		dev_err(&sdd->pdev->dev, "Failed to get TX DMA hannel\n");
+		dev_err(&sdd->pdev->dev, "Failed to get TX DMA channel\n");
 		dma_release_channel(sdd->rx_dma.ch);
 		sdd->tx_dma.ch = 0;
 		sdd->rx_dma.ch = 0;
-- 
2.35.3

