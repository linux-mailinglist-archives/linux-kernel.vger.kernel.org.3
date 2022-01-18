Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6EA491385
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbiARBiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244080AbiARBiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F95C06161C;
        Mon, 17 Jan 2022 17:38:14 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z22so72914110edd.12;
        Mon, 17 Jan 2022 17:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TtlSp+FB3fnRTy8NVckvnsyBSUC5t1gzmu14osv5biM=;
        b=C+RRGahzm+G2+i9vvsQH3zDjdcF0Q9C+kChwQfmO6nvibGMIipFOw/OTKmidQaYvNk
         EPg1pPOu3G7q3wCduHqpTpXmQp++TZFqKdhb/Qu97GTYBF01T4tn21xJVf2hnNUGESb+
         gUtnY6vXVG8qOA1DFuHOXz0FyUANAOpGNxYmgChycjDKJMqzk66V8K1R1xtjin8RE2fn
         vGDTclrYlHiwBE+qBTShHgvQj0zVjliaXoffWLetR7bvh0HIJqmWRXss0IjJXb7g/RcH
         IsOUzW/zCZvoiHCxfEzx7V8XX0hR/HaBSestc6JFnqlMOtZ0vOBvZMkIuzy6JHB/fhmV
         H0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TtlSp+FB3fnRTy8NVckvnsyBSUC5t1gzmu14osv5biM=;
        b=wIPqUuFOie9kB3rV050+EsVI4pSyLdjbunaiqABui/wZtAV9jG/WRGyN3RW6FNNIt0
         99HpMJC0SmEhPMjcAthPkEIf0O3ENNA3+SMzkpLm0NaZQoa2j1WVkFxoP3NG/tkDI7iF
         1cjKQNwcSJtbt9aJscxAenMfYu0FNbyQJ0lbfLvQL9uN4O0rKlmeTY6efdOWVn5a33GX
         p5pwcXUoFI9JtzEt/fVKMxCZ+DBTIxDNr0R2ZEzZthlCIZ8GvWfPgDF9i9knzmyiUj0A
         a9nD+8Ov7xzf3ogydT/9WB/VqIgMVHYbRKTE8spC/F4pv2M0FrbIguDOj/Z0GjBOMKDv
         vOOQ==
X-Gm-Message-State: AOAM5318G0ON8IciQ4HqDRlzQnBz84ZRI6hlNBuVPXW2EAHCZls7aeIe
        9ucttybQ916v0lsNmwkmtLQ=
X-Google-Smtp-Source: ABdhPJy4T1rMz6A0TBUh/YDgWes/Mjj5Na/B5efgW5QsLS785V0Wv2CTGvBOvmIbBJaYef6YPBSTrw==
X-Received: by 2002:a50:cf86:: with SMTP id h6mr18492440edk.82.1642469893191;
        Mon, 17 Jan 2022 17:38:13 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:12 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 04/17] ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
Date:   Tue, 18 Jan 2022 02:20:34 +0100
Message-Id: <20220118012051.21691-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing snps,dwmac compatible for gmac ipq8064 dtsi.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 824cf13dd037..7cf85b4f6ec8 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1061,7 +1061,7 @@ stmmac_axi_setup: stmmac-axi-config {
 
 		gmac0: ethernet@37000000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37000000 0x200000>;
 			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1085,7 +1085,7 @@ gmac0: ethernet@37000000 {
 
 		gmac1: ethernet@37200000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37200000 0x200000>;
 			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1109,7 +1109,7 @@ gmac1: ethernet@37200000 {
 
 		gmac2: ethernet@37400000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37400000 0x200000>;
 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
@@ -1133,7 +1133,7 @@ gmac2: ethernet@37400000 {
 
 		gmac3: ethernet@37600000 {
 			device_type = "network";
-			compatible = "qcom,ipq806x-gmac";
+			compatible = "qcom,ipq806x-gmac", "snps,dwmac";
 			reg = <0x37600000 0x200000>;
 			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-- 
2.33.1

