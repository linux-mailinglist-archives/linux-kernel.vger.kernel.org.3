Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E194C6C89
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbiB1Mb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiB1MbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:31:24 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7695B75203
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:30:45 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id q11so10567330pln.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTdaYyO7BCAGNKSC2MWHao5kqhDNJ7241TMEcNLnGmI=;
        b=xZXFG6gst/2wMMOV4VQQwCn7XSlZDiwhGYdG9ZITVuWzvnuJFIBRLdDhscattRJNA/
         0iWcMIJDnOF9hd+BekyVX9ZxjCWlDgTIg+QD0Decxvz+S7mrT2R0FNBuwOuPEibxX2+o
         yEOE1gk4mlbFJOS5V31W1eiwm1fOupV7/5S8CUBJmpyYNhuCmN2UbS+JQypm21CiqyrO
         t6+Xyett1/j+jMd4G+Wlpk/T42/Hac6zHWUrf78Vhe57b5TYAbzqedODBg+ChyXjd1eQ
         V5IvYHvINDFDZjsnDU/3w5phflJJr5/EWlncmUXNBWtZTL+oUDsHK9By6utlWqeMzEEX
         a2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTdaYyO7BCAGNKSC2MWHao5kqhDNJ7241TMEcNLnGmI=;
        b=n0xs9AcMRoVRu1gsfJZH2TK2RG5D8W8NKW5oe22GrgJGfdQ4CCHihsxdz5nLIr9VDD
         VM4JT7tyuOrdzEVwmYzGfAZtls0oe+UFi1Dt5kH1Uvi0GsExjw1sQyT999LbeQwXcmFF
         zWOp8xZj/dQj60N10EM4my9IsUaonSV7LzX3vAIEFg2IqA1UOhsHGdYTJ4t5NIj+3vcj
         qkDlOUyz0W2d4DAtOeiQSLL+nIwNVeRumzTrlR6F7lX18G2L0jMRXAuQ3yWk8YWgA9Zn
         30CdvIzoXs0m0/vbcfeOE+FevgFE+vGR1a+eiUkdLRvlrbAQsbbDoxI8j2TYgB0QqzYP
         vm8g==
X-Gm-Message-State: AOAM532UX5iRF49MpuPki7WE6+92Bl3NL7fH+NCFlbBM5yGWaim1ZJfQ
        xczkc3BwQ6SP8nZ4d8dCiFEK/Q==
X-Google-Smtp-Source: ABdhPJzKsV3eHjoLgbKe7QfzMGneFHSKdf+oVN9ovRH/PBzA2MPzhkXuzpM3u7iZYV33pewy/PyGKw==
X-Received: by 2002:a17:902:e5d1:b0:14f:f8b1:a9bf with SMTP id u17-20020a170902e5d100b0014ff8b1a9bfmr20646551plf.35.1646051444962;
        Mon, 28 Feb 2022 04:30:44 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id f7-20020a056a0022c700b004f0e9d686dcsm13790001pfj.137.2022.02.28.04.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:30:44 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, shawn.guo@linaro.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 3/8] arm64: dts: qcom: msm8996-xiaomi: Drop max-microamp and vddp-ref-clk properties from QMP PHY
Date:   Mon, 28 Feb 2022 18:00:14 +0530
Message-Id: <20220228123019.382037-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228123019.382037-1-bhupesh.sharma@linaro.org>
References: <20220228123019.382037-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following properties are not supported and causing dtbs_check
warnings.

    - vdda-phy-max-microamp
    - vdda-pll-max-microamp
    - vddp-ref-clk-max-microamp
    - vddp-ref-clk-always-on

arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml: phy@627000:
   'vdda-phy-max-microamp', 'vddp-ref-clk-always-on', 'vddp-ref-clk-max-microamp'
    do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'

Drop them from QMP PHY nodes for 'msm8996-xiaomi' dts.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index 7a9fcbe9bb31..f6f6b2e89a36 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -337,12 +337,7 @@ &ufsphy {
 	vdda-phy-supply = <&vreg_l28a_0p925>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
 
-	vdda-phy-max-microamp = <18380>;
-	vdda-pll-max-microamp = <9440>;
-
 	vddp-ref-clk-supply = <&vreg_l25a_1p2>;
-	vddp-ref-clk-max-microamp = <100>;
-	vddp-ref-clk-always-on;
 };
 
 &venus {
-- 
2.35.1

