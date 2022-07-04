Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8303564AC0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiGDAVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiGDAVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:21:01 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D34992BEB;
        Sun,  3 Jul 2022 17:21:00 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 04 Jul 2022 09:20:56 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 8DE4C2058456;
        Mon,  4 Jul 2022 09:20:56 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 4 Jul 2022 09:20:56 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 12E9F1DDD;
        Mon,  4 Jul 2022 09:20:56 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 9/9] ARM: dts: uniphier: Remove compatible "snps,dw-pcie-ep" from Pro5 pcie-ep node
Date:   Mon,  4 Jul 2022 09:20:26 +0900
Message-Id: <1656894026-15707-10-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656894026-15707-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1656894026-15707-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UniPhier PCIe endpoint controller doesn't use "snps,dw-pcie-ep" compatible,
so this is no longer needed. Remove the compatible string from the pcie-ep
node to fix the following warning.

  uniphier-pro5-epcore.dtb: pcie@66000000: compatible: ['socionext,uniphier-pro5-pcie-ep', 'snps,dw-pcie-ep'] is too long
      From schema: Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pro5.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 64cdd0c62e55..c3e431b3f643 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -620,8 +620,7 @@ usb1_ssphy0: ss-phy@380 {
 		};
 
 		pcie_ep: pcie-ep@66000000 {
-			compatible = "socionext,uniphier-pro5-pcie-ep",
-				     "snps,dw-pcie-ep";
+			compatible = "socionext,uniphier-pro5-pcie-ep";
 			status = "disabled";
 			reg-names = "dbi", "dbi2", "link", "addr_space";
 			reg = <0x66000000 0x1000>, <0x66001000 0x1000>,
-- 
2.25.1

