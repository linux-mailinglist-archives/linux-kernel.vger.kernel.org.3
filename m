Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBBE5669FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiGELlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiGELlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:41:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A39167E3;
        Tue,  5 Jul 2022 04:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 002A7CE1B58;
        Tue,  5 Jul 2022 11:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59461C341CF;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021256;
        bh=lw2S2Ef1vq5+Ow95i5kULk8+RLiW2dlj/y5wWPo5xw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDfWA4Z85laoeykGWjemLg22kpk97xc/D7Opdknk9i3HHjSdDqonKqzJgMXv1FPOE
         efYIPuWLK2u4D0f3yhtgkTpzZfhE0gOZcgXDMFWwb6md9Upl1FGtLjT3+OhN5LTV6B
         W2NmiajukD3ICLgaZ+PmXXjiiczZNTR8MhBazPcTruU1hMAEX2pHlk1lu4NBnbxbI/
         oo1EIwJzHmgIxbVtWLUAKV/Ns/EtZetncooDBz4CwYu2smGfobY+Lq5iKdaVy6Jj1S
         E4IJgzrvjSuPcQ9XZiOkNqMXZuYlag7y48Dq48HqsfW958v8b2y1xfJ/UN5AJFvUdn
         HQ4PMv3dlkLRg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8gvJ-0005xU-7L; Tue, 05 Jul 2022 13:40:57 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 02/14] arm64: dts: qcom: sm8250: add missing PCIe PHY clock-cells
Date:   Tue,  5 Jul 2022 13:40:20 +0200
Message-Id: <20220705114032.22787-3-johan+linaro@kernel.org>
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

Add the missing '#clock-cells' properties to the PCIe QMP PHY nodes.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 53e0b57c13e4..f45a6cca397f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1892,6 +1892,8 @@ pcie0_lane: phy@1c06200 {
 				clock-names = "pipe0";
 
 				#phy-cells = <0>;
+
+				#clock-cells = <0>;
 				clock-output-names = "pcie_0_pipe_clk";
 			};
 		};
@@ -1998,6 +2000,8 @@ pcie1_lane: phy@1c0e200 {
 				clock-names = "pipe0";
 
 				#phy-cells = <0>;
+
+				#clock-cells = <0>;
 				clock-output-names = "pcie_1_pipe_clk";
 			};
 		};
@@ -2104,6 +2108,8 @@ pcie2_lane: phy@1c16200 {
 				clock-names = "pipe0";
 
 				#phy-cells = <0>;
+
+				#clock-cells = <0>;
 				clock-output-names = "pcie_2_pipe_clk";
 			};
 		};
-- 
2.35.1

