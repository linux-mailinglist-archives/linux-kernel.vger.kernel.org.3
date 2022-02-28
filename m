Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A924C78E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiB1Tti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiB1TtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:49:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39803F65F2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:48:15 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i20so6316567wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0XDEkVzi02ucM2UrKM/vf81RC1FXZtbtWIn7AE/m+k=;
        b=Dg/YhTchN/dzit9dPs906M4E2c8W9YbYDdJDkUr+sgVevUcFyxD1MKfKC4NCejyEV3
         4uooanL4NNVwCzcV0SMou47PR33uiMQn0iqzquGP8ILqcc/7MU0lAHcAl7U1qkAr9qpJ
         SlqOFUJLzEBZ9XD28j/6CndjNKuVW422jLD3SbyONOO4fQafuu7NYo9xNXGz/R9HjWmO
         RIEGNQVlAfpbMe8Ak/5lZAMLzj0ddUiKlni1mDB8z6/yvOPsBSuoB+6udugXRuGDm1R3
         kpL7K1PNtOpgxJvF/8DJ4aq7Gkg5MU6NmxkxgaI6OnnZ7TeMU5jFkn7Un7SyZRFwhbSo
         68Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0XDEkVzi02ucM2UrKM/vf81RC1FXZtbtWIn7AE/m+k=;
        b=OJZVzt8B4RtjmRQALgIF6DBZFqqFNngsH4hvX3//IB8MmI7Kofh+/psv2voVP74FMY
         uUhboiBvLUIxQbgabs0XTcl3VRZMLpwN83IiplpC+o29++LXbMsZQjVsFPXdoI2XA4Vt
         RNCjvTrCUURhqJnOT00QJmV5EHcIxTuZwvoH0kMwEMcAvvbCcMV1XsV7T1K7lhzx7e8G
         c/Zm4Mat9ArLVod15e8CaPqJrgCsx1vLya2dUATtaoeQGJUWAUgsdxeOodHeHsHH888l
         F/cBuEE0N9cgYEkObbhnZ6X12UoceFHdlEUrbvU4uQpj3xWIqYmPprwpe7sV6buYZaUK
         GWzg==
X-Gm-Message-State: AOAM532/JpRJriO6a6SLHxjzwZ0M1zT6ydbeolEYt7OYJzf5hlyh6lXW
        d5mZjgmR7oLzVzfXNBp5ZUgLlHCcNR5Ibw==
X-Google-Smtp-Source: ABdhPJwkZpmQZMj24miJa4rIAkZ9zDJCidU+xH/RIv5ZF56eOWbqUySS6AbKxsXIgvWROOl6Z6N/1A==
X-Received: by 2002:a05:600c:198f:b0:380:fa8f:be22 with SMTP id t15-20020a05600c198f00b00380fa8fbe22mr14268130wmq.43.1646077252461;
        Mon, 28 Feb 2022 11:40:52 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v25-20020a05600c215900b0038117f41728sm274143wml.43.2022.02.28.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 11:40:52 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 12/16] ARM: dts: rk3288: crypto do not need dma clock
Date:   Mon, 28 Feb 2022 19:40:33 +0000
Message-Id: <20220228194037.1600509-13-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228194037.1600509-1-clabbe@baylibre.com>
References: <20220228194037.1600509-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA clock is already enabled by DMA and so crypto does not need to
handle it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 26b9bbe310af..64be7d4a2d39 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -976,8 +976,8 @@ crypto: crypto@ff8a0000 {
 		reg = <0x0 0xff8a0000 0x0 0x4000>;
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
-			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
-		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
+			 <&cru SCLK_CRYPTO>;
+		clock-names = "aclk", "hclk", "sclk";
 		resets = <&cru SRST_CRYPTO>;
 		reset-names = "crypto-rst";
 	};
-- 
2.34.1

