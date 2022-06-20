Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758D4552203
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244292AbiFTQNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244581AbiFTQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:13:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A97320F41
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:13:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id fd6so13049512edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 09:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTBobJXlYojyiPuoiGakzWp1LNp9Hmf1kPFPL+YFjuU=;
        b=Z2FNRA7u2LLcUrUvQs+FJ2dEU+YijDHxhCrG+X1wgYWjq56qob/PK0xsbwP9y42Km5
         tCe0jbAUqlp72BLWYFSh3h348IT+RudkYIdwYI0CjDJ1Wdw7uNDZp7u1D2ohghtSNewg
         A6PNMpTjcZdT3dZAnKo5i9bC2elkxU7yMcDuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTBobJXlYojyiPuoiGakzWp1LNp9Hmf1kPFPL+YFjuU=;
        b=6JyIfT07MiuKaymf93Q4a4qZc9s4sHlZnrh5MxIuQCFJCRLhNsyx7j9R9fZnED2Zdf
         x+HYbO5hFy/sbgTIyf9DYMAtUXNy+iG7L/i23L3STeMW+ct5uy0gNGobpNcH3/UadH44
         8p7+5xvLA5IWcCXoRRR9nTbkHBetawNOBxtMS/T4TSM95M0i6ciruPOjV1x8R4knV59N
         /fDVRAbqcJ6wb5ttrCiOPnEZo2/11aZPtiATUO69cufihIr0/v6Xs82QuXsoUiT9Sje8
         R7wI1XWvdR7Lj2Db0JOmDIwCVYXRRtDxULRtYqrtOKcL9ipftISvFX1/M8TC+bwylOJV
         zmbw==
X-Gm-Message-State: AJIora/mhBfO3ev5qO4kHtqOww/bER8hh7j1GRdkAm16DN3nV/+F35UT
        jWoCrj3UwJrMBY2RRWydtMbKAA==
X-Google-Smtp-Source: AGRyM1t4rKYsmMlXm8gObs2t1ACZ3UyvbDMakD1qXb7dfuU+sMK4uUr6B4BGPOY9VVtk3RrrwPxQWQ==
X-Received: by 2002:aa7:c50c:0:b0:435:66b7:3dad with SMTP id o12-20020aa7c50c000000b0043566b73dadmr19468607edq.397.1655741606729;
        Mon, 20 Jun 2022 09:13:26 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-55-189.cust.vodafonedsl.it. [188.217.55.189])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090653da00b00706c1327f4bsm6209772ejo.23.2022.06.20.09.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:13:26 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        jacopo@jmondi.org,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: rockchip: px30: max drive-strength for cif_clkout_m0
Date:   Mon, 20 Jun 2022 18:13:18 +0200
Message-Id: <20220620161321.1898840-2-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620161321.1898840-1-tommaso.merciai@amarulasolutions.com>
References: <20220620161321.1898840-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add max drive-strength for cif_clkout_m0. This fix the issue that
sometimes camera ov5695 is not probed correctly.
Tested on PX30_Mini_EVB_V11_20190507

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Tested-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
Changes since v1:
 - Drop off 1. use regulator_bulk_enable/regulator_bulk disable instead of for 
   loop into ov5695 power_on/power_off

 arch/arm64/boot/dts/rockchip/px30-evb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-evb.dts b/arch/arm64/boot/dts/rockchip/px30-evb.dts
index 73003efeec86..cc73d4bfc5b1 100644
--- a/arch/arm64/boot/dts/rockchip/px30-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-evb.dts
@@ -536,6 +536,13 @@ wifi_enable_h: wifi-enable-h {
 				<0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	cif-m0 {
+		cif_clkout_m0: cif-clkout-m0 {
+			rockchip,pins =
+				<2 RK_PB3 1 &pcfg_pull_none_12ma>;
+		};
+	};
 };
 
 &pmu_io_domains {
-- 
2.25.1

