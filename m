Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8CD4F8978
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiDGUoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiDGUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:44:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF25394A32
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:34:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bh17so13231505ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4demkHQ8Fg0Aca60O/7JU7pagAyPbUQlML8jEugCG4=;
        b=faF6ayajtjqODf8i8x4Ee4sgq1q3Fe8w5GIBNd6EUxYhTh8lRr3ScB1O2+f/eFZVB7
         WBZuT4ZezncXpe3w3YfCgXtmZ9ME1HUKZCh7SMj18BdBBLX61EI2U6s/TlRJ2XnOnROK
         CBSmDDp2XF77fg+vfg4nylz11gURLu/w9p9t9U7ins3Z5+XVdzzfmyQi/UDZohlf/hSl
         6zfP7PMuZ7D/yis5OyxXt6AirCAXefP5nyXCPBWGl367EWAh1GzSdImNZbK4X1i7HBSa
         voE2I93cGhnsbCRAHteqmmHiYjHWMuzbqRTyegl56f5fMmWddGdye9mBnm7QBXCU5N8b
         IShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w4demkHQ8Fg0Aca60O/7JU7pagAyPbUQlML8jEugCG4=;
        b=xa2ahuVedCqbgWUxiYwYC2QuhIFPlR4rtBDiVkEzrVx5ocoUEVyet3K1Gde4qFRzbP
         xx3RDz6PfTM5rvbdXr3JoGVj7yXPiLbjLp8uLK7dlR6XNeo+5tEMlDPuQsh3C4o51uxJ
         LY61AL6IIkSjTwhhrYVtdrXxmMpVREdbzU1kL+5bz+tqZvV0bHySgkbaqmYqSxAySa//
         EwnW5r6X5m7Dv4HP0Q/vdzr0yoveN9GROQjOrF+PN5HoDgXb43RAwQs4pQyZrsGjO+oV
         8eFTlsUhMfYe/48Acob5At/ayuSBLB/qJMuwJdgWkpPjbTwxbHaf/MsQrn42oHaLBB/8
         RRyg==
X-Gm-Message-State: AOAM531GeSqKXz6nm7w5YzptW6dWwpGWY36F5dJ948F7i50pNJ7QKylc
        L4JRWPZpvtwLMdsG92I/tfZpzw==
X-Google-Smtp-Source: ABdhPJxEDGr4Jf8tpwen4hc/gkUEJCBUHaMs6G9kK5gOiZYqgWgJpng5I7H46vgQYhy+G8VXg0Ns5g==
X-Received: by 2002:a17:906:1ec3:b0:6cf:d118:59e2 with SMTP id m3-20020a1709061ec300b006cfd11859e2mr15195488ejj.767.1649363647213;
        Thu, 07 Apr 2022 13:34:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id p13-20020a50d88d000000b0041cd1a083f7sm6134799edj.1.2022.04.07.13.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:34:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: mediatek: align operating-points table name with dtschema
Date:   Thu,  7 Apr 2022 22:34:01 +0200
Message-Id: <20220407203402.33356-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the name of operating-points node to dtschema to fix warnings like:

  arch/arm64/boot/dts/mediatek/mt8173-elm.dt.yaml:
    opp_table0: $nodename:0: 'opp_table0' does not match '^opp-table(-[a-z0-9]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi  | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8183.dtsi  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index a27b7628c5f7..16905596316d 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -19,7 +19,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	cluster0_opp: opp_table0 {
+	cluster0_opp: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 		opp00 {
@@ -36,7 +36,7 @@ opp02 {
 		};
 	};
 
-	cluster1_opp: opp_table1 {
+	cluster1_opp: opp-table-1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 		opp00 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 2b7d331a4588..acb775ca682e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -57,7 +57,7 @@ aliases {
 		serial3 = &uart3;
 	};
 
-	cluster0_opp: opp_table0 {
+	cluster0_opp: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 		opp-507000000 {
@@ -94,7 +94,7 @@ opp-1703000000 {
 		};
 	};
 
-	cluster1_opp: opp_table1 {
+	cluster1_opp: opp-table-1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 		opp-507000000 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 4b08691ed39e..3129e7783902 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -197,7 +197,7 @@ CLUSTER_SLEEP1: cluster-sleep-1 {
 		};
 	};
 
-	gpu_opp_table: opp_table0 {
+	gpu_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-- 
2.32.0

