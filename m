Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55705A7876
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiHaIEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHaIEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:04:37 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F327C32F5;
        Wed, 31 Aug 2022 01:04:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id DBE8EDF8D9;
        Wed, 31 Aug 2022 01:03:42 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HoFfwWJ9Hs3T; Wed, 31 Aug 2022 01:03:42 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1661933022; bh=pTAM1GG6G97KUgnlgXB/M7yFHEvP6eRofoU5RlNqxKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRbLYS6OJx6shFzLIrYUFTZtfUFEPfnMa8+PbfRdSKLzinAbkNEz5gtFf2yxhlW+g
         W4Uiw9YjLga3qQvf609FRTudkrJJm0LRGUlpcSpY12VFCJ8tRARz72yjqMt5xhWf50
         G86nH9ClvaHXqz/FiMNdg873VidJjMMhF0skSMnFQDvyIfYqo32dKBys2whykDmoue
         3c0HvYbmRWf86PAhGB6ivTJgr4Jcfi1iDY6s+ruU5GS/dmLGfy/R3yV1fFetnBZH41
         UTU1zIeXOPY3UmYIQZyDpaWgOsVjrGbmQQNumLfDvub85LuxZrKX6vdEBTNKITW0GF
         B0J1s/NS1aC3g==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org, Angus Ainslie <angus@akkea.ca>
Subject: [PATCH v1 5/5] arm64: dts: imx8mq-librem5: add usb-role-switch property to dwc3
Date:   Wed, 31 Aug 2022 10:03:01 +0200
Message-Id: <20220831080301.1092737-6-martin.kepplinger@puri.sm>
In-Reply-To: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
References: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
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
index d5c7c35d2e85f..e685a636ca6c4 100644
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

