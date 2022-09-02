Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC415AAA51
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbiIBImr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiIBImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:42:43 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473529DB54;
        Fri,  2 Sep 2022 01:42:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 19BDEDFC97;
        Fri,  2 Sep 2022 01:42:43 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qth0n9K1XUrE; Fri,  2 Sep 2022 01:42:42 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1662108162; bh=f5pKOXHbGKD/nYgQOSeg2/+MMasiz7zAAfiGLG+NTJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=urzOoLmeLNMFJMJGbZH/mv+bUIioZASCyXEWUEs2h6UkYtL9SnNZBry6M8PYWC1P4
         CSz6PEo2ndgfEJt1dSTtqNONizhTft7zfQVUSFwpco5QwwF15rk+gApgUlhWLhQIGp
         QMgSIFLU/dfs6ISLZl810Gf3KEJs1wF1EbuktFiwEob0OaPduYK5R7L+Ey2FhusM1Y
         5atxY7Ecp2uBE9TwFvMGK0XaL8QreXs9toiAt16FHf36VYJ/i7M1HDQXDXNxtrrwta
         DszHDcvvrwEIMkPqZduprCTOgXGsMY2k1itfV2CUJJxCnF1PcUW36HFfJy1ejLMGNp
         gpAW/o/inxEVw==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v2 5/6] arm64: dts: imx8mq-librem5: add usb-role-switch property to dwc3
Date:   Fri,  2 Sep 2022 10:42:15 +0200
Message-Id: <20220902084216.1259202-6-martin.kepplinger@puri.sm>
In-Reply-To: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
References: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angus Ainslie <angus@akkea.ca>

In order to enable (PD and data) role switching on the Librem 5 phone,
add the usb-role-switch property to imx8mq's dwc3 node.

Signed-off-by: Angus Ainslie <angus@akkea.ca>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index f07d1c6e97777..058d6ecf109b2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1302,6 +1302,7 @@ &usb_dwc3_0 {
 	#size-cells = <0>;
 	dr_mode = "otg";
 	snps,dis_u3_susphy_quirk;
+	usb-role-switch;
 	status = "okay";
 
 	port@0 {
-- 
2.30.2

