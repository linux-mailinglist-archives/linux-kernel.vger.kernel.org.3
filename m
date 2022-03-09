Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8C4D38B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiCISZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbiCISZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:25:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8E45AA70;
        Wed,  9 Mar 2022 10:24:13 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id bx5so3075925pjb.3;
        Wed, 09 Mar 2022 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WyFR/kU7qEinohcbAhpnze0ZURr4Dc+TGzdf/KYIuI8=;
        b=DdJi19NuBfgMY1qs8tcQOYFivoeapErXkr1ckIthF2873grIvIUQGdMyHZFoDO9w5s
         +qnVRzesNobZJRkXvP7I6XF9prHoZmGgc4sTykK25sVlu+geSHPbxdheBrG/f5ar2yEN
         vbhfJW24VWlsU0nDdg1j12LNZk2P1AFvpckKbrs7QJ+4QEKzRICGhD9K/5H50uXoYQE/
         c8s40DdxU1X0Uve2m8tgC0Jn/fCIkGKGFwFxsEhxRnkixQXmXQVEwjPAAg/0/BMHll2f
         Sb+2KaBO0QmiWcqWI553k3ZmIwMBeB7rPrkJmuNv/q/gL4N0lwA/otmPh2uZqbBET2b6
         lV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WyFR/kU7qEinohcbAhpnze0ZURr4Dc+TGzdf/KYIuI8=;
        b=NqGg/ZQzaAIJnShfB9IXV8goCNl24hxy5rb4XIAf1qXjjbUMeQ9NRAqz+iPErCOsmk
         OTPtCrEQwM/9WA9DpVRcywaMYc9xbH3PLF9LGKhkYtKAKE/MfmbScD/LNWcU63aMr6YW
         XpK2VyYGsFaflYrUzdGm81wjcqcW0QFrf4GWxWFESi0uoG1qGRjYcqw71R5o7ZGc/jgC
         xy86+XNuA6Yir/Fe0q4UP3MiikyZLO32eX3upuzWnksOPuywnwhIWiNmGLFAlzg/ANvH
         B8Hn+Nn4oHDluM/9p/FalE56Om2VPGA4gHuctPS2cEBvldXl4TAWIZDRQt/inXfmp+hF
         Ig6A==
X-Gm-Message-State: AOAM533D6UwZBx23eA8RNsPTLekSAIK3b2+RcwZgpXwN/4ISZHH56mAW
        kAKLbCXxBRwSlxzoBGXheDo=
X-Google-Smtp-Source: ABdhPJwdPdgLlQnIryYBH0cEHLNlT+wD+rPXDzNWdLOnxmy/ZVoIgRf5UmtLdf5XZCOZTUdpeYMOcw==
X-Received: by 2002:a17:902:e811:b0:151:f486:a32f with SMTP id u17-20020a170902e81100b00151f486a32fmr719693plg.141.1646850253390;
        Wed, 09 Mar 2022 10:24:13 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b004f754dd3d4csm3950988pfc.3.2022.03.09.10.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:24:13 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Chanho Min <chanho.min@lge.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 2/2] arm64: dts: seattle: Update spi node properties
Date:   Wed,  9 Mar 2022 23:54:03 +0530
Message-Id: <20220309182403.12968-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309182403.12968-1-singh.kuldeep87k@gmail.com>
References: <20220309182403.12968-1-singh.kuldeep87k@gmail.com>
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

PL022 binding require two clocks to be defined but AMD seattle platform
does't comply with binding and define only one clock.

Update spi clocks and clocks-names property by adding appropriate clock
reference to make it compliant with bindings.

CC: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index b664e7af74eb..2aa21d98d560 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -113,8 +113,8 @@ spi0: spi@e1020000 {
 			reg = <0 0xe1020000 0 0x1000>;
 			spi-controller;
 			interrupts = <0 330 4>;
-			clocks = <&uartspiclk_100mhz>;
-			clock-names = "apb_pclk";
+			clocks = <&uartspiclk_100mhz>, <&uartspiclk_100mhz>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		spi1: spi@e1030000 {
@@ -123,8 +123,8 @@ spi1: spi@e1030000 {
 			reg = <0 0xe1030000 0 0x1000>;
 			spi-controller;
 			interrupts = <0 329 4>;
-			clocks = <&uartspiclk_100mhz>;
-			clock-names = "apb_pclk";
+			clocks = <&uartspiclk_100mhz>, <&uartspiclk_100mhz>;
+			clock-names = "sspclk", "apb_pclk";
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.25.1

