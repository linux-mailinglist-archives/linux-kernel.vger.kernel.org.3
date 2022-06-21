Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BF4552F16
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348834AbiFUJrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349266AbiFUJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:47:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3E827B37;
        Tue, 21 Jun 2022 02:47:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so9012134wma.4;
        Tue, 21 Jun 2022 02:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3ZCR9iVeq6ZAfU5TRz3a90s4e4BlA0vDBwbjjM5RfY=;
        b=dkpM687CjGEtZhDZ8rCYb6sL/az4iSWToMOUg+fg5uLqGa7P6ahCru2Owl3HEpvPwX
         Oi2/89PQEieIpg84jOUXJ6Y5Cpwan5pt5ljmadId3m5MbuBe8aDrPUBRkLJ1DwUs5vWH
         Hb+UNstb7VY6U0dpCsXJ8mzrWHs2oKbbg8uQq2dSWJgaYjKUILISHN5l90u7VVYrZw7C
         a2mbYQ1UCK2dxrxyamx/HQWb7akAs/5Zn1dBqO/ju2XEVFLnj1ttNHBVNzIpyuQmuUrS
         xXmDCobmZKLeuP1mQInRZKtYBvlasJyz9NP6QUtJxDPiAIjJHGxG1fITu5HgBGY7Aj+h
         2EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3ZCR9iVeq6ZAfU5TRz3a90s4e4BlA0vDBwbjjM5RfY=;
        b=J3PisXJDyU3cpslpTuV/iLVzz79t1L/2OSOkwPLl5WhYlbKBm18JFGGd78OE8adv6J
         aGjWz6Lqdl0jUz/YAshZaeA+L27WAqGyXMYyPqU8DDPRQ5ozDv9I7xtYlNgizWVsy7mx
         MmN9Nn8wIqZbFi1QZ2oCs0fzPaS2yHdcfFuqGguSiX/9WuxC4e8vUbwW8VTSLwMJl4T2
         I0IjF0GVh4aJJIf6ep8AH8JNZcZcGUOeM0KCP4ezhUvSb8osZYB+O/z2agOOvyPUkDBd
         K1KV2be+cWR419SiHPdrbj02UsvhfrYmGOl1URKJWacWW8EFetjBHv746ST7c6YBZ8+a
         OTZQ==
X-Gm-Message-State: AJIora/h9uSw+iDYUK1zvI3KxYuFmWcpWYBZJ5ayh8wsmVjK6ZBV7zYU
        FGn1zWuctY6PxFar26L9YLw=
X-Google-Smtp-Source: AGRyM1sjQlqfYgzhZtmD5KyrTu1rLV5cg8wZwFoDW7+iQXmmb5YxwYnxnBrasq/IQhB/AjTjOu85qQ==
X-Received: by 2002:a05:600c:3505:b0:39c:93d4:5eec with SMTP id h5-20020a05600c350500b0039c93d45eecmr28551855wmq.179.1655804857770;
        Tue, 21 Jun 2022 02:47:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r15-20020adff70f000000b002185d79dc7fsm15323739wrp.75.2022.06.21.02.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 02:47:37 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: adc: qcom-spmi-rradc: Fix spelling mistake "coherrency" -> "coherency"
Date:   Tue, 21 Jun 2022 10:47:36 +0100
Message-Id: <20220621094736.90436-1-colin.i.king@gmail.com>
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
 drivers/iio/adc/qcom-spmi-rradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-rradc.c b/drivers/iio/adc/qcom-spmi-rradc.c
index 87f349782108..56a713766954 100644
--- a/drivers/iio/adc/qcom-spmi-rradc.c
+++ b/drivers/iio/adc/qcom-spmi-rradc.c
@@ -295,7 +295,7 @@ static int rradc_read(struct rradc_chip *chip, u16 addr, __le16 *buf, int len)
 	}
 
 	if (retry_cnt == RR_ADC_COHERENT_CHECK_RETRY)
-		dev_err(chip->dev, "Retry exceeded for coherrency check\n");
+		dev_err(chip->dev, "Retry exceeded for coherency check\n");
 
 	return ret;
 }
-- 
2.35.3

