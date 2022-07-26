Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689D2580E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiGZIII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiGZIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:08:01 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9FDF22;
        Tue, 26 Jul 2022 01:07:59 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26Q6ZL6f009501;
        Tue, 26 Jul 2022 10:07:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=rLtXOZaBhBJ4Za2tM1rJodMY0MHpDsHiAJ70GxqUcbQ=;
 b=Wb4JJUJHYSYjqw6b0xWIAeAelATOOeYGasY2WMVOSY6shkMLfn/1H5FGIH6bOC8h1f3+
 9C1QS0dLtUcB5+EF1WY2WSeQSMVkP6MCu+4DbSvcdnc+ipwMuTlAIzn0qA1MItQ4ivX1
 kHoXt3eqwR4J6neJrWTuh4OEusIfUA7DPEGuQkvJjpsGMhgMBRZcu94G98GN09RcvDfQ
 YoXyJW7Ze1+bTLkShzF4Xf9ZJm9MTJZ9k/pCP3XVUo9ScZYcRlgPtzLYJ7SETmDWvF5k
 B9F+6ICeiu/xgUDkQrpfg9y5AAcljoJIhQ0nAfdW/nSO+rCpFDKO23mH85rKjbnNCTZZ tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hhp6aq1rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 10:07:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CF2FA100038;
        Tue, 26 Jul 2022 10:07:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C68F62128A4;
        Tue, 26 Jul 2022 10:07:31 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 26 Jul
 2022 10:07:31 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mka@chromium.org>, <alexandre.torgue@foss.st.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <arnd@arndb.de>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 3/4] ARM: dts: stm32: add support for USB2514B onboard hub on stm32mp15xx-dkx
Date:   Tue, 26 Jul 2022 10:07:07 +0200
Message-ID: <20220726080708.162547-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726080708.162547-1-fabrice.gasnier@foss.st.com>
References: <20220726080708.162547-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_02,2022-07-25_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for USB2514B onboard hub on stm32mp15 DK boards. The HUB
is supplied by a 3v3 PMIC regulator.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 333c2af97130a..8b48d3c89a047 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -677,6 +677,14 @@ &usart3 {
 &usbh_ehci {
 	phys = <&usbphyc_port0>;
 	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	/* onboard HUB */
+	hub@1 {
+		compatible = "usb424,2514";
+		reg = <1>;
+		vdd-supply = <&v3v3>;
+	};
 };
 
 &usbotg_hs {
-- 
2.25.1

