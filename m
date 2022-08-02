Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36876587EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiHBP0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHBP0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DBD23A;
        Tue,  2 Aug 2022 08:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F69960B15;
        Tue,  2 Aug 2022 15:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B96C433D6;
        Tue,  2 Aug 2022 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659454011;
        bh=RHjZB2kMGtHEaCOdFMvCSAeVR4EhdJaXClRbcGLGN24=;
        h=From:To:Cc:Subject:Date:From;
        b=WrlFhzGsxyDTURexn3b0etu7SaGVGAtdJ0mf8eXtdcUgGiHYoEojebCD05ZyWYJPT
         JRyKfP4ops68tMEjxSBYz0ZCW8uX1k7EePuoqtG2rkiDTtqFEczLcb2r7GA/e0H5tb
         3g0UGHCmBzzvEP+oc77tT7YqUmFP+q8atNDqqNBHNuT6GFIuOkcgOOqU/aI5eM3fwZ
         rYkIzp5wE9sS3nSLPcIg1+K6Uci3X27N0sz2ZrpGaxSg5qqMA1MiO1JHLT2Knf2ny6
         oWesYTYkPLcP4ytqIwrmMm2CwCbwBlvikjd2usD4q1ZaJBtfm4A2/UMmZXgpL1LPJJ
         9X6diiL8BU6wA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oItnW-0000f1-Tb; Tue, 02 Aug 2022 17:27:07 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc7280: move USB wakeup-source property
Date:   Tue,  2 Aug 2022 17:26:42 +0200
Message-Id: <20220802152642.2516-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the USB-controller wakeup-source property to the dwc3 glue node to
match the updated binding.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

This one can be applied once the following series has been merged:

	https://lore.kernel.org/all/20220802151404.1797-1-johan+linaro@kernel.org

Johan


 arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 13d7f267b289..dac3b69e314f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3374,6 +3374,8 @@ usb_1: usb@a6f8800 {
 					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_USB3_0 0>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
+			wakeup-source;
+
 			usb_1_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0 0x0a600000 0 0xe000>;
@@ -3384,7 +3386,6 @@ usb_1_dwc3: usb@a600000 {
 				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
 				maximum-speed = "super-speed";
-				wakeup-source;
 			};
 		};
 
-- 
2.35.1

