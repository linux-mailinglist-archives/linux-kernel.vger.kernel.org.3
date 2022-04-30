Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ECF516081
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245348AbiD3Uyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 16:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245242AbiD3Uyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 16:54:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C3F5371B;
        Sat, 30 Apr 2022 13:51:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b24so12654682edu.10;
        Sat, 30 Apr 2022 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ksfYzQBn7UrcwfXPR8oQDY9eW9oGago9RfblkVMga0=;
        b=lbbeV85svKR/bRew4SlVcnU7nKENj7PIy5vr9kwC7wZyk9oAw4Cf5Qom1isdGy3HNN
         /ExHhd318S12iwxEtUbgOARjqB0JZYGM2gx0U9ef/mkFbtAjitQk3koipNBKCh9hgTqD
         t5WzLDarBpvId3J0h8ctSKY6jqYgXVaR8IpZEloFpNIzFRDFLlG9KtkpjwcMYkjggY2t
         FPieRX/dsaudrRpHaTrJwBbXNLlWUsx9ljtji0/VV6vZDs15ExiamaEP7MM/UfJlLa3I
         Y3isqioUi0RZBY9G56FRKoxJnQKH1Z9gINsKiTdueNyBvHKg+bvXaF+R1YGd7ntgwRPN
         Gw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ksfYzQBn7UrcwfXPR8oQDY9eW9oGago9RfblkVMga0=;
        b=UQ4/ZkS5NxwrUHa5Fj99zxcMJYsBQc7NaxFOQXgvXK77TsNrtmqqiY7dsUYBJiltSV
         AFVHxs2wljtIJ4W4g0+YnLi5hN1RTMncsurKfwrzokh96jPgvIOrKSvhwTTG2HxnEWMq
         9xGj2opY0m9VcbmMdurJxyBQMSRG3Hp16kRp/V6Gc0am+W98pUOXJw1yzcZhCS/ZYnTx
         yhYph+tzOiOxucpMycTYMgvX1tuL5fyLUbRIEWueOI86A92hx8yAASxNAV1fOcSIE+hq
         I/2EKnMyWDqqPrnlyk+3GDdN9berOMviXps73JljlyQXdAU413HLBJmLCXGKcfP8TG/G
         kLyA==
X-Gm-Message-State: AOAM5335Vv6LZC5mFqK00u24gf/5/jCn8X/UIX4HO8okKoASlyh2DzmS
        uQyXHmGRbZZTmtKdxo483mtc40BPUEPnfw==
X-Google-Smtp-Source: ABdhPJyK4z4U7e4b9q0BbzIwYcjagpOwUuAvrQ8PA11smPbHiuEIm63CGxBatjpbvYaT1pRfgL+0Dg==
X-Received: by 2002:a05:6402:3488:b0:427:b4ec:991b with SMTP id v8-20020a056402348800b00427b4ec991bmr1157230edc.319.1651351871415;
        Sat, 30 Apr 2022 13:51:11 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-113.zg.cable.xnet.hr. [94.253.165.113])
        by smtp.googlemail.com with ESMTPSA id p14-20020a056402154e00b0042617ba63a8sm4457852edx.50.2022.04.30.13.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 13:51:10 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        thara.gopinath@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 5/5] arm64: dts: ipq8074: add thermal nodes
Date:   Sat, 30 Apr 2022 22:51:01 +0200
Message-Id: <20220430205101.459782-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430205101.459782-1-robimarko@gmail.com>
References: <20220430205101.459782-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has a tsens v2.3.0 peripheral which monitors
temperatures around the various subsystems on the
die.

So lets add the tsens and thermal zone nodes, passive
CPU cooling will come in later patches after CPU frequency
scaling is supported.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 96 +++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index afbae86cf6d3..76e02490b968 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -332,6 +332,16 @@ prng: rng@e3000 {
 			status = "disabled";
 		};
 
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq8074-tsens";
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "combined";
+			#qcom,sensors = <16>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		cryptobam: dma-controller@704000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x00704000 0x20000>;
@@ -1092,4 +1102,90 @@ wifi: wifi@c0000000 {
 			status = "disabled";
 		};
 	};
+
+	thermal-zones {
+		nss-top-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 4>;
+		};
+
+		nss0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 5>;
+		};
+
+		nss1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 6>;
+		};
+
+		wcss-phya0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 7>;
+		};
+
+		wcss-phya1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 8>;
+		};
+
+		cpu0_thermal: cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 9>;
+		};
+
+		cpu1_thermal: cpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 10>;
+		};
+
+		cpu2_thermal: cpu2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 11>;
+		};
+
+		cpu3_thermal: cpu3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 12>;
+		};
+
+		cluster_thermal: cluster-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 13>;
+		};
+
+		wcss-phyb0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 14>;
+		};
+
+		wcss-phyb1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 15>;
+		};
+	};
 };
-- 
2.35.1

