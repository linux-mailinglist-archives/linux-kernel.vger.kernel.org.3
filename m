Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F120B4BAE64
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiBRAaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiBRAaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5905C5E769;
        Thu, 17 Feb 2022 16:29:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u1so11720157wrg.11;
        Thu, 17 Feb 2022 16:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=euWm74Y3jISSO1sWJ+0XYAZDNCwsMCsz02f2aIK5ErM=;
        b=SOjCimwm42P+WbykPNnjiNuKPfxnl+6csZBIFzbOa44iyaojUD3TWQu6tApnICqQcO
         MPoJ1brXkoyTBf1g7b3Xdiu2f2gDs7D0oqwpX8Qo21ViW6OEBGC7I3S2bBZZ4tdihQLu
         pKq5NwXfRUh3JuHpJUqvg42vyYvX/nFEhdE8UWUsWuyIZMZ+875C0qNhCeDdXphDb558
         8mglzOOqT2KvVFf+vFCZExszxHwxeH6o4oj0cHbs2qL5Z03Ye5xct2fYe4en4pvy95C0
         CGCYvNFeKj9Sv4Jbh7WlxznzZ0b3wmihFxEF4MypXS17JXyEQ8SlgrhrnypiPZ/4swUM
         M6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=euWm74Y3jISSO1sWJ+0XYAZDNCwsMCsz02f2aIK5ErM=;
        b=sa8+CQ/G5UhjQMBqBbu7GN/QRcwQfSUYZC6hJLi9jir7UkI7sd7il9LroSdZ7uVP5L
         qn/dBSS2bxNpnqjXN4psLZ1AYIjUX+KH8x3IHyFVOMvNaMd96ttkMlXZpdeenABK7h35
         NCmdonWk1//0abSXxFlnK6XF36cUC6h36LyjdDKSCNW33RKgGhVE/CyRe+AEv6IfF9jL
         1mMeryvQOnQAeEpREktHsN8u8fpe39Ad95eFxAawFKM8GXwIGWzvCwsoIOVHulitAQCI
         TAX7awN1q9F1YSVPhslh+qC+Ox/jiR0SHSi834vxd9RcUN6MIc5Yi6JGcldy+W07eYqN
         fnHg==
X-Gm-Message-State: AOAM530I+sg7QH1yvPO+nVbdDPGsEZTxPRgEVjEEaqc8digQs2VrDV2T
        4/m1WNAhr7qQ+Zjb8jPc7BM=
X-Google-Smtp-Source: ABdhPJz8mWgDyeJrKdPe3MSTGoi3fG0MOi/QEKzl7jj90oHwOW6jZFKJXdEpqMJo+5UZWyeIO5/mcg==
X-Received: by 2002:adf:8030:0:b0:1e3:2f93:477c with SMTP id 45-20020adf8030000000b001e32f93477cmr4181179wrk.462.1645144197812;
        Thu, 17 Feb 2022 16:29:57 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:29:57 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 02/18] ARM: dts: qcom: add gsbi6 missing definition for ipq8064
Date:   Fri, 18 Feb 2022 01:29:40 +0100
Message-Id: <20220218002956.6590-3-ansuelsmth@gmail.com>
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

Add gsbi6 missing definition for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 40 +++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cc6ca9013ab1..b309bc0fbbcd 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -665,6 +665,46 @@ spi@1a280000 {
 			};
 		};
 
+		gsbi6: gsbi@16500000 {
+			status = "disabled";
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <6>;
+			reg = <0x16500000 0x100>;
+			clocks = <&gcc GSBI6_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			syscon-tcsr = <&tcsr>;
+
+			gsbi6_i2c: i2c@16580000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16580000 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			gsbi6_spi: spi@16580000 {
+				compatible = "qcom,spi-qup-v1.1.1";
+				reg = <0x16580000 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gsbi7: gsbi@16600000 {
 			status = "disabled";
 			compatible = "qcom,gsbi-v1.0.0";
-- 
2.34.1

