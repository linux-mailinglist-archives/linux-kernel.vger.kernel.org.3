Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5E2552201
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244395AbiFTQNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbiFTQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:13:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991BE201A8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:13:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n20so15320195ejz.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xvFY1kJeejdwrQbhws2bUmgFOGvqBabSRSqYJrTktOo=;
        b=qUAYBfrCjlgPdw+vFkZCS6N98mtPEEFcJCL8AnfynhtMykKxG+BzaV7AxDybinThvp
         xTQGJKuczKViwBOXmc+MsM6lCQnDXmz8FP/Pp7hx2uYOHjW74tHDUpOzGhpkPebZO9VM
         Zh8GX+gGS/VEX535KxBfyMIg7M4u+ddiEpyr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xvFY1kJeejdwrQbhws2bUmgFOGvqBabSRSqYJrTktOo=;
        b=7mjqskMGF3CL/hoaG7e6PUt04P9B1DA1hKp6+xxlmCuv6cgEtIyiKA7cEBHuaPvxze
         xrs0cC/CjMCND2wgwwssEX1L/3ZjpnEyGlTeW5sVQZ5B41n4KagjDOFkOtGRAFxN9Fu7
         PMflJk/iCk8NnPHDywvOO6nxXIcrrMHKaAcZRwzZ6eDUvaG9IaHC7rum9nEC6B1/GYMD
         te/W+Cln9XpvJMytdD4ikD211okUQHF2oDO4nRdmv/phPrtrpWo3pcDkD5UqtfQBtL4s
         UoRgmW/fpp5n1jKlDnR/Tn6M76LLeYkmWVM646t869cS/kTOtTxfSLVIypOG7L134u96
         L6eA==
X-Gm-Message-State: AJIora+vSgDOITkQyTwzALFkFjs+1+uGFBI1SR9mMY5ZJGh1b/boCyQO
        2Sq7ditvyIeOm+RHCG4t5YWitGhaD+mBbg==
X-Google-Smtp-Source: AGRyM1ulld7kB/Wo+OfSshWGx9VazvunF150Uw54sGVldCpyVXW+uBryqi3H0Dg+V7Ipf/pR5TJvKA==
X-Received: by 2002:a17:907:16ab:b0:711:f0dd:91c with SMTP id hc43-20020a17090716ab00b00711f0dd091cmr21057880ejc.575.1655741610214;
        Mon, 20 Jun 2022 09:13:30 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-55-189.cust.vodafonedsl.it. [188.217.55.189])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090653da00b00706c1327f4bsm6209772ejo.23.2022.06.20.09.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:13:29 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        jacopo@jmondi.org,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: rockchip: px30: add mux for mipi-pdn pad
Date:   Mon, 20 Jun 2022 18:13:19 +0200
Message-Id: <20220620161321.1898840-3-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620161321.1898840-1-tommaso.merciai@amarulasolutions.com>
References: <20220620161321.1898840-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add right mux for mipi-pdn. Mux this pad as gpio2 14

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Tested-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
 arch/arm64/boot/dts/rockchip/px30-evb.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index cc73d4bfc5b1..aee7fecdfc15 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -449,8 +449,8 @@ ov5695: ov5695@36 {
 		dvdd-supply = <&vcc1v5_dvp>;
 		dovdd-supply = <&vcc1v8_dvp>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&cif_clkout_m0>;
 		reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&cif_clkout_m0 &mipi_pdn>;
 
 		port {
 			ucam_out: endpoint {
@@ -543,6 +543,12 @@ cif_clkout_m0: cif-clkout-m0 {
 				<2 RK_PB3 1 &pcfg_pull_none_12ma>;
 		};
 	};
+
+	mipi {
+		mipi_pdn: mipi-pdn {
+			rockchip,pins = <2 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pmu_io_domains {
-- 
2.25.1

