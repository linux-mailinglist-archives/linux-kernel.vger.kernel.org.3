Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D0C4C6DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiB1NUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiB1NUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:20:19 -0500
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 05:19:40 PST
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF58220FF;
        Mon, 28 Feb 2022 05:19:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 60BF7DF67F;
        Mon, 28 Feb 2022 05:12:40 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DEBaQBv-q0qf; Mon, 28 Feb 2022 05:12:39 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, krzysztof.kozlowski@canonical.com,
        shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, kernel@puri.sm, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 1/5] arm64: dts: imx8mq-librem5: make the volume buttons a wakeup source
Date:   Mon, 28 Feb 2022 14:12:18 +0100
Message-Id: <20220228131222.917137-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220228131222.917137-1-martin.kepplinger@puri.sm>
References: <20220228131222.917137-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They turn on the display currently so to be consistent, let's make
them wake the system from suspend as well.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 05c16376b4d8..0d391468bf21 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -42,6 +42,7 @@ vol-down {
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 			debounce-interval = <50>;
+			wakeup-source;
 		};
 
 		vol-up {
@@ -49,6 +50,7 @@ vol-up {
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 			debounce-interval = <50>;
+			wakeup-source;
 		};
 	};
 
-- 
2.30.2

