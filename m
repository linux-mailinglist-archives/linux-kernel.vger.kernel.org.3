Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A7B4BAE7A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiBRAac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiBRAa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351575EDC1;
        Thu, 17 Feb 2022 16:30:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w11so11755261wra.4;
        Thu, 17 Feb 2022 16:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HaRnE8BmXyYhZNxTaM4707HmvMVx0HBK+GA9V0wW38o=;
        b=IwjIGP6NFd6Pdn/c3hMXEwBSQ9gH86h9cEZlFmWt9+k1ojmWAFy8Ul4kAkaETGFn3z
         b2hXUcLbTWJyd4B5aaF59RjFCqaXXDM/fnru8Q1SXl4H4z53e1xnPdZCdPBKP3SL2JoI
         Q/kOaXporD++rl9ZDObWXty1XP6opADImOk+3qJ0AS6mC8OJ6WFJSASZYn+zq6qRRrV0
         udvloFRW3pfsHuFWQULCAsLDcG0tEJL97L5fVMTF9LsPJLEi0Q++R15+YnO9pot305/1
         MeGZ73uvchM1NbUeKVlY3K5rpZ6bM/+YHjme9ZTRXr3n9GNwCOW3PDBhM0UqQqMqvfLC
         1udQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HaRnE8BmXyYhZNxTaM4707HmvMVx0HBK+GA9V0wW38o=;
        b=L0HYByWKXmh4SNxyN4q3/wZZkKWGu95/b531CZbiC/KscvwjaL9G+sfPLaZuNOSodO
         xFdXmyN6rJ0SBDIRm8SUESRroI3ZRSnW0+d3TXUdS0RrVDp7Q/+edsYznyPnNzM8tuvV
         lDWx0InPEjcQRkWAQvAlMROXxA3Iwqwn9oSxiHoKZNFTE6uQ71FSvJ0vpqpOQjqBjSox
         CLH87ZHPv3WW94u7FUKRIyoSJSSGnVW7qxIEVV0hEC1z46cvbtsjhkTdpNLIqaOd68B3
         0pWA0ASbwb7UK/vGX8Zl7jO7OLugfRlZ6iLmYBLct6tXYEPdWLJ8wvhXyEYPythZcAbB
         OzKQ==
X-Gm-Message-State: AOAM532VaIkJTCuUgSWKFRNWANVEaJtOnkBXLnAXz3FHW6l1LbzM46yP
        oEc9QlwCYrZcwZPeyQvk4Rk=
X-Google-Smtp-Source: ABdhPJw8Ri0RL2q9DQqAy3eDeIjayTDJ4sOuR4fTGt8IIqGPF7+MiI3qrW/72Tc1iEo5cHzVlUJfOA==
X-Received: by 2002:a05:6000:1546:b0:1e8:7b68:4f4e with SMTP id 6-20020a056000154600b001e87b684f4emr4139240wry.30.1645144200687;
        Thu, 17 Feb 2022 16:30:00 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:00 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 05/18] ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
Date:   Fri, 18 Feb 2022 01:29:43 +0100
Message-Id: <20220218002956.6590-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
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

Add missing snps,dwmac compatible for gmac ipq8064 dtsi.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 0938838a4af8..9d658fcc1f12 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1075,7 +1075,7 @@ stmmac_axi_setup: stmmac-axi-config {
 
 		gmac0: ethernet@37000000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37000000 0x200000>;
 			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1099,7 +1099,7 @@ gmac0: ethernet@37000000 {
 
 		gmac1: ethernet@37200000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37200000 0x200000>;
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1123,7 +1123,7 @@ gmac1: ethernet@37200000 {
 
 		gmac2: ethernet@37400000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37400000 0x200000>;
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1147,7 +1147,7 @@ gmac2: ethernet@37400000 {
 
 		gmac3: ethernet@37600000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37600000 0x200000>;
 			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-- 
2.34.1

