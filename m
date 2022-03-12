Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB94D6E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiCLLkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiCLLkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:40:09 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C01E533D;
        Sat, 12 Mar 2022 03:39:03 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z4so9630787pgh.12;
        Sat, 12 Mar 2022 03:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufFXgb2lwd0tMRRQZ0gkTsahetqwRZ2fEgJvYvwNlfI=;
        b=O/F88OF3blUa65/YrgA1Q//P0JguQVoTa7u7/fi6wvFuyt9xfp5L4jio9YD36a+JDE
         yZve7w7ESMd9v3uhnNBk7bhxy8kuRuiHymYi0M7wGKfPDoDwXb7kKsY9JaG0QDuqZda1
         nhXvp17b5NttiJRLStktFNqUZwUhuuvNBshGiF7dQKjLUjWAXj2fvKjWUKPfQReCRs8f
         GIZDjl0Z0ks8hnf0+7QmXtYpsknm0vJC/yvgFL4IFcCb/vtpfpcZKHQzwBLnl05T/Cxt
         Hd2iH77AHa5eZ6H5mg7wqYiWfdP1hFQpdalT0jzvzBY0+heCvFdvffxogPv8FazFDAxZ
         QFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufFXgb2lwd0tMRRQZ0gkTsahetqwRZ2fEgJvYvwNlfI=;
        b=d1UzdNJoRBupZpN2t3Xg0PtUrRExlybCvVXNvZtXTZ3fr3kLaE6Zyz248gz17mvic4
         tG7uhjOkNilIqF5a8AMU2xOSQBzIJBBZr4xTC7yeiN3qtxGqGS6pMIyd9KmvBU6ZrVoF
         VfwpcO4e3NwCMrOb3Wb2dc/g9nucYg0B5Arz7fIImFi0cqBLPt+VXf0QAWjzns5IjJeZ
         LMX0TFOX4oPDKWSISKWarMRQMt7GStpWHPbSzse89TlbKjrNRA5t3Voeqm2DXJSj7Ak8
         hz/iIy0KbmON063XRRhLB3HOIgLv83aQTU2D091u0WCn9KKwMgLaLn9lGoXEXJFz8TzY
         GBCg==
X-Gm-Message-State: AOAM530q8tczxig1eG9Hm46fXiaSzRd46r7Op36veTPdC4x0fyhLx02I
        eF5MiqV4mbSzyLm4vXkqKSU=
X-Google-Smtp-Source: ABdhPJz8bUbZddf6xihbY/KeStTohL4DIwSrGHPiP8obOOvKo/5JiqIWT9hbxCSSwj7RHibTNTsEzA==
X-Received: by 2002:a63:6906:0:b0:36c:8493:dadf with SMTP id e6-20020a636906000000b0036c8493dadfmr12453760pgc.80.1647085142788;
        Sat, 12 Mar 2022 03:39:02 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id h6-20020a636c06000000b00363a2533b17sm11065191pgc.8.2022.03.12.03.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 03:39:02 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] ARM: dts: integratorap: Update spi node properties
Date:   Sat, 12 Mar 2022 17:08:50 +0530
Message-Id: <20220312113853.63446-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
References: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
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

As per spi pl022 binding, SPI clock name is "sspclk" and not "spiclk".
Fix it.

Also update ssp node name to enable spi bindings check.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v3:
- Reword commit message

v2:
-Remove ssp alias

 arch/arm/boot/dts/integratorap-im-pd1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/integratorap-im-pd1.dts b/arch/arm/boot/dts/integratorap-im-pd1.dts
index d47bfb66d069..4c22e4436271 100644
--- a/arch/arm/boot/dts/integratorap-im-pd1.dts
+++ b/arch/arm/boot/dts/integratorap-im-pd1.dts
@@ -178,12 +178,12 @@ uart@200000 {
 		clock-names = "uartclk", "apb_pclk";
 	};
 
-	ssp@300000 {
+	spi@300000 {
 		compatible = "arm,pl022", "arm,primecell";
 		reg = <0x00300000 0x1000>;
 		interrupts-extended = <&impd1_vic 3>;
 		clocks = <&impd1_sspclk>, <&sysclk>;
-		clock-names = "spiclk", "apb_pclk";
+		clock-names = "sspclk", "apb_pclk";
 	};
 
 	impd1_gpio0: gpio@400000 {
-- 
2.25.1

