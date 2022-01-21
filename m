Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1937495CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379776AbiAUJeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:34:46 -0500
Received: from comms.puri.sm ([159.203.221.185]:56234 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379766AbiAUJeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:34:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C8F4BE0098;
        Fri, 21 Jan 2022 01:34:14 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9fyX1SIeGlv0; Fri, 21 Jan 2022 01:34:14 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 2/2] arm64: dts: imx8mq-librem5: fix mipi_csi1 port number to sensor
Date:   Fri, 21 Jan 2022 10:33:26 +0100
Message-Id: <20220121093326.2388251-3-martin.kepplinger@puri.sm>
In-Reply-To: <20220121093326.2388251-1-martin.kepplinger@puri.sm>
References: <20220121093326.2388251-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the previous commit fixed a hardware description bug for imx8mq,
we need to fix up all DT users like this. The mipi_csi port@0
is connected to the sensor, not port@1.

Fixes: fed7603597fa ("arm64: dts: imx8mq-librem5: describe the selfie cam")
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index f3e3418f7edc..2d4a472af6a9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1115,8 +1115,8 @@ &mipi_csi1 {
 	status = "okay";
 
 	ports {
-		port@1 {
-			reg = <1>;
+		port@0 {
+			reg = <0>;
 
 			mipi1_sensor_ep: endpoint {
 				remote-endpoint = <&camera1_ep>;
-- 
2.30.2

