Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1857A893
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbiGSUvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240385AbiGSUv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:51:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BEC5FAC9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:51:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q16so11466348pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tWj+Tj/y/i/0qwwBOcJAxizlMqe1RocItPE2akyhLeI=;
        b=QqAp6C9Ot2OUxEdK0Vxczq1+sB18TvGiwRAL4t3xGJBOQbngC0mBQM7pU3pG7OkF45
         cuhme/T2NYS0Ke+Yw83Pa6iXkRFEV2+bSwyfERWoG18Fac6e0Ersm3NWJZGDHxuVO2HR
         yX++yCRwxH2InH7BF4c2BwEzZuf4+1rhBq1wk1cVGQS5rbwusF8ID7vj6nUf0N37mAAt
         Jx5yqp9m2AESvGSsYDRefdXHVjKk4eSdzqU/s2Zw3O+rVtiH2hX0pE5dvFDAlt3uL9Vn
         AJo8MvTiUNl/cOHFLThLLn12RCFmAnNfeHK5Lbw0dI5GqBY2U/nGzLoLcvrQCxAnzvX7
         Sfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWj+Tj/y/i/0qwwBOcJAxizlMqe1RocItPE2akyhLeI=;
        b=ITcbodxfqyFe8buB0UOv9xdlwDAO+yf1dgH3b5/HqKERnXXVUsReNJULhocx5RT3s6
         HqYqfEmds3u/0BPXn0nGp8x4Ym7RWYoGAzKQzA6ZQe1w5iPzcj+bpIHq4F7QfIjETRcw
         P2JNOiNHdw6pNR7kiMMAJKR0uJ9IH8eHFXkcIoFgYiz18mVop9PWPpgCglkYS56CCGYK
         z/lU0GgQwjVCGCB96XOPpXtPed3mlT65r6mz3PIVIlHvxliZN6sprarjeWea5DtdDfYc
         fg+jVkr/fGnx5eabjt17a7i5kYVwLLzdGIPuiyxaQLBpiSe1MB8zUZGdnsixr0aSTVXR
         HoZA==
X-Gm-Message-State: AJIora/kjwMcz38pZT9qv45IL/pWJHSMe+1zVBV/aw91NCfFGbYQZ1gZ
        uYNVxfx2ldek2fFIz4lUHA/lSw==
X-Google-Smtp-Source: AGRyM1uc88s+D41jOioP3Vay/EaTZ/gyjlUmb0QI6ibi2ri80bmXk8cO4sEwiXPljG0BEWtQGWCALg==
X-Received: by 2002:a63:2a8f:0:b0:412:5278:b90 with SMTP id q137-20020a632a8f000000b0041252780b90mr30319589pgq.363.1658263876420;
        Tue, 19 Jul 2022 13:51:16 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:709e:6fec:df37:6562:5a80])
        by smtp.gmail.com with ESMTPSA id n1-20020a622701000000b00525496442ccsm11929173pfn.216.2022.07.19.13.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:51:15 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh@kernel.org,
        linux-leds@vger.kernel.org, pavel@ucw.cz,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: qrb5165-rb5: Fix 'dtbs_check' error for led nodes
Date:   Wed, 20 Jul 2022 02:20:58 +0530
Message-Id: <20220719205058.1004942-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220719205058.1004942-1-bhupesh.sharma@linaro.org>
References: <20220719205058.1004942-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make dtbs_check currently reports the following errors
with qrb5165-rb5 led nodes:

arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb:
 leds: 'bt', 'user4', 'wlan' do not match any of the regexes:
  '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Fix the same.

Also while at it, fix a blank line issue in the led
node.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index a7278928efc1..bf8077a1cf9a 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -58,7 +58,7 @@ hdmi_con: endpoint {
 	leds {
 		compatible = "gpio-leds";
 
-		user4 {
+		led-user4 {
 			label = "green:user4";
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_GREEN>;
@@ -67,7 +67,7 @@ user4 {
 			default-state = "off";
 		};
 
-		wlan {
+		led-wlan {
 			label = "yellow:wlan";
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_YELLOW>;
@@ -76,7 +76,7 @@ wlan {
 			default-state = "off";
 		};
 
-		bt {
+		led-bt {
 			label = "blue:bt";
 			function = LED_FUNCTION_BLUETOOTH;
 			color = <LED_COLOR_ID_BLUE>;
@@ -84,7 +84,6 @@ bt {
 			linux,default-trigger = "bluetooth-power";
 			default-state = "off";
 		};
-
 	};
 
 	lt9611_1v2: lt9611-vdd12-regulator {
-- 
2.35.3

