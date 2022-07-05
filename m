Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1035669F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiGELlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiGELk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A7140B9;
        Tue,  5 Jul 2022 04:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 949E26163C;
        Tue,  5 Jul 2022 11:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF29C341E4;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021256;
        bh=oCHWJnh4WCZO6yPBPtBBm6bMnITR3d1GfoV37ZS+LIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+NSJoDuWvEiXU4Jz+eG7gi02nH4oTWHvFW/ihyPGx4dQoKaYmatoqRIQfUkCk1od
         ZQVO7WAAfj9OUkHKiStU9t8200Yl1KgL9t4UkeEq0SPWk5JOII3RXbLI7dR05N7fLN
         mi1gIki/L6vU3lgbWrEZS5q19JOG4U6mHeK5Ee0bEHw6XLPk0Ka/65q1hhihyEX49S
         lzn8ASAZMJe9Buc6d67mptmdcwc0XOVM8TnnVZ+2/2uf3R4m/gKENabLMLsxqVVvR2
         JF47JVlpQ5iOjpKI7DvpldKKToKkccTrsd1HDvXqRartrWabL71erZ4JUKfPov5JZU
         GQXCQ3nviVnPw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8gvJ-0005xp-Qr; Tue, 05 Jul 2022 13:40:57 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 09/14] arm64: dts: qcom: sc8280xp: drop UFS PHY clock-cells
Date:   Tue,  5 Jul 2022 13:40:27 +0200
Message-Id: <20220705114032.22787-10-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705114032.22787-1-johan+linaro@kernel.org>
References: <20220705114032.22787-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP UFS PHY provides more than one symbol clock and would need an
index to differentiate the clocks, but none of this is described by the
binding currently.

Drop the incorrect '#clock-cells' property for now.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 345a19a6e874..ce4df4e814fe 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1447,7 +1447,6 @@ ufs_mem_phy_lanes: phy@1d87400 {
 				      <0 0x01d87800 0 0x108>,
 				      <0 0x01d87a00 0 0x1e0>;
 				#phy-cells = <0>;
-				#clock-cells = <0>;
 			};
 		};
 
@@ -1517,7 +1516,6 @@ ufs_card_phy_lanes: phy@1da7400 {
 				      <0 0x01da7800 0 0x108>,
 				      <0 0x01da7a00 0 0x1e0>;
 				#phy-cells = <0>;
-				#clock-cells = <0>;
 			};
 		};
 
-- 
2.35.1

