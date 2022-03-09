Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C34D39D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbiCITRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiCITQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBB0111DD9;
        Wed,  9 Mar 2022 11:15:37 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso2092445wmr.1;
        Wed, 09 Mar 2022 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+iKSK1JPdMxtPZUR65QR2T54u6Sz+eMVcd/vOmqJ94=;
        b=L9Fa/qg75tCOPAP72P9xkx7napTqm50XluouA34I8GGoBmaOdH85yK9k6nXK113Zq2
         0nIdEH1obdg1Bg0fh5LPhfozTJClWsf3IupnNbYJZevveuqTy99PPzp4w7zRteDW+NUi
         RHG38RY6PAByTAe0rHwUtm4EucTIsGieyivuCcm2ZMrvm0NXrZpodmfryDvybZiV1SO2
         glFO36R2GS9ozE/EbRU4ve4RsZVPHRfMCatsZEzTazwpkOggNJMfL/tuy9SScq/HCfO5
         4KqQa8MnJxI2bL9t8ZDFuYTWcYLiN/XcClKX3ThxNMufV3aDK/aYGHcMr8HRyb6JxyAw
         3kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+iKSK1JPdMxtPZUR65QR2T54u6Sz+eMVcd/vOmqJ94=;
        b=RTIXYHDrEI3L/olWpW38bRuZeLMHnnHqNn2EhI/XsM8JJ9lPl5wY3N8wJRmCK+iCdH
         CvQh8182Qf6I/pmOZ6GzEOZondfnPh3+lh9KlEVLUYzP1sbu+c5cAKDBcCxH9pEcCMLz
         gCG7QSS2YK5PIp7VQbjAFQGuMi/Ue+/qZ2TkBZAZYfIDefzfg4RmS0ejjWn93EXwSXEq
         wCjCFJ9oLl7U7VpLV56UC7s0DINLoJ1abGyklv4x0i2ipFDxuMhyU1VzQQ4NRiUh9fWK
         2rryqSo0ml4sf4h6L/+jeKBJ+xtSUxgpD+9jqgrD5nb84ES2I/faRLfHxZtixvVsZ2Wr
         Y0Zg==
X-Gm-Message-State: AOAM531XjQHZWPcg2LG4nkNaXbGsmT4xgcn+6sz6fA71I2BhwkbiviS9
        Ftqwt6RHvPK4TMxpgTsvnDI=
X-Google-Smtp-Source: ABdhPJwjbDHO5ZaO/4cbbXb3ybJtWS6pVdcf7hfcCt5IcZxZgEoJZSezi32NFe8bvi14dAF7SoktPA==
X-Received: by 2002:a05:600c:321a:b0:389:6f67:340 with SMTP id r26-20020a05600c321a00b003896f670340mr8808647wmp.167.1646853336439;
        Wed, 09 Mar 2022 11:15:36 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:35 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 15/18] ARM: dts: qcom: add multiple missing binding for cpu and l2 for ipq8064
Date:   Wed,  9 Mar 2022 20:01:49 +0100
Message-Id: <20220309190152.7998-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
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

Add multiple binding for cpu node, l2 node and add idle-states
definition for ipq8064 dtsi.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 629e22236f5b..1079572f4f5d 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -30,6 +30,16 @@ cpu0: cpu@0 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			clocks = <&kraitcc 0>, <&kraitcc 4>;
+			clock-names = "cpu", "l2";
+			clock-latency = <100000>;
+			cpu-supply = <&smb208_s2a>;
+			operating-points-v2 = <&opp_table0>;
+			voltage-tolerance = <5>;
+			cooling-min-state = <0>;
+			cooling-max-state = <10>;
+			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		cpu1: cpu@1 {
@@ -40,11 +50,37 @@ cpu1: cpu@1 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			clocks = <&kraitcc 1>, <&kraitcc 4>;
+			clock-names = "cpu", "l2";
+			clock-latency = <100000>;
+			cpu-supply = <&smb208_s2b>;
+			operating-points-v2 = <&opp_table0>;
+			voltage-tolerance = <5>;
+			cooling-min-state = <0>;
+			cooling-max-state = <10>;
+			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_SPC>;
+		};
+
+		idle-states {
+			CPU_SPC: spc {
+				compatible = "qcom,idle-state-spc";
+				status = "disabled";
+				entry-latency-us = <400>;
+				exit-latency-us = <900>;
+				min-residency-us = <3000>;
+			};
 		};
 
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			qcom,saw = <&saw_l2>;
+
+			clocks = <&kraitcc 4>;
+			clock-names = "l2";
+			l2-supply = <&smb208_s1a>;
+			operating-points-v2 = <&opp_table_l2>;
 		};
 	};
 
-- 
2.34.1

