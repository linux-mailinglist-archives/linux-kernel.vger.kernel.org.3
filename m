Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D7A559C15
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiFXOgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiFXOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:35:41 -0400
X-Greylist: delayed 1115 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jun 2022 07:35:12 PDT
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C45CB5DF10;
        Fri, 24 Jun 2022 07:35:10 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id E54E616C6;
        Fri, 24 Jun 2022 17:17:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com E54E616C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656080268;
        bh=dQq5OIsnVRth+sqzHkFlLdBrOb42QdxbS+CEp9Nsxcw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=KeUXpB9bEA0u9yM7Z2Ev9snyCvK8y8lKnsRCFAiWur9+aSzfP+/uMp/3F131g9uAe
         XVxjrqtrh9QIemz8UmkQzuU1Me9/FA1UrMTniWYthPE9bA32Rz8BOvbJd1r5dPwOI4
         fT7ClKUUCylTGTFzMfmnQ+QUFVJ9Fdlh0dDLEdpM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:16:29 +0300
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
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-snps-arc@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v9 5/5] arm64: dts: apm: Harmonize DWC USB3 DT nodes name
Date:   Fri, 24 Jun 2022 17:16:21 +0300
Message-ID: <20220624141622.7149-6-Sergey.Semin@baikalelectronics.ru>
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

In accordance with the DWC USB3 bindings the corresponding node
name is suppose to comply with the Generic USB HCD DT schema, which
requires the USB nodes to have the name acceptable by the regexp:
"^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
named despite of the warning comment about possible backward
compatibility issues.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 4 ++--
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index a83c82c50e29..832dd85b00bd 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -597,8 +597,8 @@ serial0: serial@10600000 {
 			interrupts = <0x0 0x4c 0x4>;
 		};
 
-		/* Do not change dwusb name, coded for backward compatibility */
-		usb0: dwusb@19000000 {
+		/* Node-name might need to be coded as dwusb for backward compatibility */
+		usb0: usb@19000000 {
 			status = "disabled";
 			compatible = "snps,dwc3";
 			reg =  <0x0 0x19000000 0x0 0x100000>;
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 0f37e77f5459..1520a945b7f9 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -923,8 +923,8 @@ sata3: sata@1a800000 {
 			phy-names = "sata-phy";
 		};
 
-		/* Do not change dwusb name, coded for backward compatibility */
-		usb0: dwusb@19000000 {
+		/* Node-name might need to be coded as dwusb for backward compatibility */
+		usb0: usb@19000000 {
 			status = "disabled";
 			compatible = "snps,dwc3";
 			reg =  <0x0 0x19000000 0x0 0x100000>;
@@ -933,7 +933,7 @@ usb0: dwusb@19000000 {
 			dr_mode = "host";
 		};
 
-		usb1: dwusb@19800000 {
+		usb1: usb@19800000 {
 			status = "disabled";
 			compatible = "snps,dwc3";
 			reg =  <0x0 0x19800000 0x0 0x100000>;
-- 
2.35.1

