Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D223C559BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiFXOgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiFXOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:35:41 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3E795DC36;
        Fri, 24 Jun 2022 07:35:10 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id E3DCF16C2;
        Fri, 24 Jun 2022 17:17:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com E3DCF16C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656080266;
        bh=k9bAgIwAU1eSDSAOvId6WLyM2VAwff02HhIivmyRPvg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Klm+jqAmLdOp9klTxYxXrTP5VcPkIzyufPE5vJFG6uL3wCDvPEN3vkUbtaSkhwVoT
         dzkX2E4xmoqPg49FF4c+4uqO2mFTzt3Je0C8ryrbUOVqtBB9gmzzggYfe36Mh0y7Rk
         5nXJ3UOUh81ockly/RGDK0tfAy98jfiGaF59MmFI=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:16:27 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-usb@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-snps-arc@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v9 2/5] arm: dts: lpc18xx: Harmonize EHCI/OHCI DT nodes name
Date:   Fri, 24 Jun 2022 17:16:18 +0300
Message-ID: <20220624141622.7149-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with the Generic EHCI/OHCI bindings the corresponding node
name is suppose to comply with the Generic USB HCD DT schema, which
requires the USB nodes to have the name acceptable by the regexp:
"^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
nodes are correctly named.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 10b8249b8ab6..82ffd7b0ad8a 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -121,7 +121,7 @@ mmcsd: mmcsd@40004000 {
 			status = "disabled";
 		};
 
-		usb0: ehci@40006100 {
+		usb0: usb@40006100 {
 			compatible = "nxp,lpc1850-ehci", "generic-ehci";
 			reg = <0x40006100 0x100>;
 			interrupts = <8>;
@@ -133,7 +133,7 @@ usb0: ehci@40006100 {
 			status = "disabled";
 		};
 
-		usb1: ehci@40007100 {
+		usb1: usb@40007100 {
 			compatible = "nxp,lpc1850-ehci", "generic-ehci";
 			reg = <0x40007100 0x100>;
 			interrupts = <9>;
-- 
2.35.1

