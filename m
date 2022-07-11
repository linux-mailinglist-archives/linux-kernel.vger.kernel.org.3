Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48BF570069
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiGKL00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiGKLZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:25:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081932DCB;
        Mon, 11 Jul 2022 03:59:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so3244161wma.2;
        Mon, 11 Jul 2022 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XbujW824CNr3VEPvbgVSYfLKtCakKHejuLWKhEvhbjo=;
        b=Ro7RqaQin9erMkTrlFHkFXcSaUltN4ETlxyV4BqD/wNP25lWGF0IBaUYLkgB7BYNCa
         e3LLKRpx7dZpRaX5VyTTGkBxu7sV0gabuv6VFisV8Ju30NdNcGhfNETkIv1UrDiq+Wh9
         Wbskb4MIk9FyCEP4YSHcO5j+gkGWYxfqEm7WRlwi38kTKw8+H/BYFP1NvGsC0yLI7Mkl
         tc/ZpPnrVqtSnT1D+dnMNEvbCR6FNDV6Kg6sWca5otq9qXAaQBCfxnjkhXhLpgr6fjDO
         I4UsZ0K/XdIpBI3HicO0mxeBXlNQPFyDIhrQ/JLxOi5HwzHGmEppta9tuoPbb9Y1JgyP
         p2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbujW824CNr3VEPvbgVSYfLKtCakKHejuLWKhEvhbjo=;
        b=FqWXDZxebu30vRhPKryoYouMx8wv4W/us6LqyxVqkE5K9VHlOiNzjW66y7COgueRmE
         dk+2IzUUVSEAbeUNNmTytOQt8ub/wUdTC8OgWJEZnMWTmD5z1q+DgoXxvvrPZ4FBNUgm
         rqkbPZCo0Bl6vC4sLHH/s3GzGpRjawoI8x3Ve9K10OFcoZEgiYh4LCLKSPLjUEspCzKc
         Z+uoa02wqRt8RrOq/C9qY9ltpJI+ko9Htbp0iBnMdaQANAplMt7hCROURqFeDomhyMy0
         1ZkmR1pokaTI07Q50NqDp4ID/YaHt0k59zHxhqJkWncmGwOi3N/AwQ8kxMZEldh/yHdB
         jeRg==
X-Gm-Message-State: AJIora9pI64emmCZIoTgEIAa3ZAXmw0VSero/YTdMpwEIBjqe2mUWq2x
        gML8H325o6eh5NXiV+smrSY=
X-Google-Smtp-Source: AGRyM1tqi7ZNUAz3GiW76AK0ZmwpLEYyrHT1GYYadfaK18P+/cwlZvRqhX15B9CUnjHxExHXhea2Kg==
X-Received: by 2002:a05:600c:34d0:b0:3a1:a05c:b523 with SMTP id d16-20020a05600c34d000b003a1a05cb523mr14829216wmq.94.1657537176580;
        Mon, 11 Jul 2022 03:59:36 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-242-cbl.xnet.hr. [94.253.144.242])
        by smtp.googlemail.com with ESMTPSA id w15-20020a1cf60f000000b003a2c7bf0497sm6504617wmc.16.2022.07.11.03.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:59:36 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v7 4/4] arm64: dts: ipq8074: add APCS support
Date:   Mon, 11 Jul 2022 12:59:31 +0200
Message-Id: <20220711105931.43164-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711105931.43164-1-robimarko@gmail.com>
References: <20220711105931.43164-1-robimarko@gmail.com>
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

APCS now has support for providing the APSS clocks as the child device
for IPQ8074.

So, add the required DT node for APCS and A53PLL which feeds it the PLL
clock for APSS, since APSS will be used for CPU frequency scaling.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v7:
* Drop review tag due to significant changes
* Add A53PLL node
* Add clocks to APCS node

Changes in v3:
* Node does not currently exist in the upstream kernel, so add it instead
of modifying.
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 080796555809..6a13bd3ead55 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -879,6 +879,23 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 				      "axi_m_sticky";
 			status = "disabled";
 		};
+
+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq8074-apcs-apps-global";
+			reg = <0x0b111000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&a53pll>, <&xo>;
+			clock-names = "pll", "xo";
+			#mbox-cells = <1>;
+		};
+
+		a53pll: clock@b116000 {
+			compatible = "qcom,ipq8074-a53pll";
+			reg = <0x0b116000 0x40>;
+			#clock-cells = <0>;
+			clocks = <&xo>;
+			clock-names = "xo";
+		};
 	};
 
 	timer {
-- 
2.36.1

