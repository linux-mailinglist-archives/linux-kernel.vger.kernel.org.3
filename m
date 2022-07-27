Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0358277A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiG0NQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiG0NQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:16:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B717275C7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07124B82161
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C629C433C1;
        Wed, 27 Jul 2022 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658927784;
        bh=d015WWD978FefY4+Y7ek4uzxFKSzSvYYzug/WMJZIB4=;
        h=From:To:Cc:Subject:Date:From;
        b=lLe8Qbf52ipNg/TZlwRbzRJ6xJUo/j9sYuRxMEeo3MIg0duTv/rJpdy9WiqG5CCwn
         f+90PfFvE6Hky9oKdXVUXVkyNd+CgOB/q+gXrhPHRpGrLfW6srU8CZGpMIrj8zVGPX
         rRa1E5fSBPx+kBT8vwMJ/EYS85hhIZLtioYFoBJ3JbwvFheCSeDzwdn7PUg7jMzY5f
         U32/mFB+iS0W5c4zrRJ6Mm8Rvz3B60ucSIkCxr46K6sx2pt2nx5RRbxq8ZgukGkiT2
         EsQSItZqC8LGCL9/IGR9h/WyRx4FLTXr/+sV1qVQn2KmYYFAVs1TcV4gpfYUtRceSV
         aMi4GrNWGTP5w==
Received: by pali.im (Postfix)
        id 4CBA37C3; Wed, 27 Jul 2022 15:16:22 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: armada-38x: Add gpio-ranges for pin muxing
Date:   Wed, 27 Jul 2022 15:16:19 +0200
Message-Id: <20220727131619.3056-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOs are configured by pinmux driver, so add corresponding references.

Fixes: 0d3d96ab0059 ("ARM: mvebu: add Device Tree description of the Armada 380/385 SoCs")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/armada-38x.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index a176898944f7..1590143c52c8 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -298,6 +298,7 @@
 				reg-names = "gpio", "pwm";
 				ngpios = <32>;
 				gpio-controller;
+				gpio-ranges = <&pinctrl 0 0 32>;
 				#gpio-cells = <2>;
 				#pwm-cells = <2>;
 				interrupt-controller;
@@ -316,6 +317,7 @@
 				reg-names = "gpio", "pwm";
 				ngpios = <28>;
 				gpio-controller;
+				gpio-ranges = <&pinctrl 0 32 28>;
 				#gpio-cells = <2>;
 				#pwm-cells = <2>;
 				interrupt-controller;
-- 
2.20.1

