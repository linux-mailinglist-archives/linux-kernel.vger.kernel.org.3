Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B222516DDD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384464AbiEBKGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384493AbiEBKG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:06:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A9015816;
        Mon,  2 May 2022 03:02:48 -0700 (PDT)
From:   Viraj Shah <viraj.shah@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651485767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6/BAB9p5q4hz+/n012rImtlYhnNEb1aerIdTRWZQ5U=;
        b=qevAM3ihOFB7k4QkmixlJCeSNX3FV/YJRZltA8wWRs0/xrZ0eRD1c3pJslidWpJoViM69+
        2vGMNhQtUgLsNvS6led+g9B65k+DD0j9r/uE0oREDJZRIIFVNFQ/FO15Izt8L703baE+6l
        kIp14BL8vFAD/kcocn/Sp31bHHt8lN12Pq0KONJcEYhV1mnLMCpm544H2Z2lRwRs+AaUC0
        oWhvSGganj2BJJiqVv8QaugTbfisgeQI+LMbx6pDCETpp4C4DabHYvNs1M6HpZoFX5/5Eh
        E8GgNkVswJJw693ABmvgyzfVrN+9qZtHUd+ZgPqQTP4i21EqaIzrhPFf/12jyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651485767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6/BAB9p5q4hz+/n012rImtlYhnNEb1aerIdTRWZQ5U=;
        b=WeO5qxihZottFUJEZLEhgqozHQL0kBLD5lB+kOkd8WXIQkPXlbrJMWIvLpHlMpTD1Fon5R
        8nB7eAbGo+LhTEBQ==
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] arm64: dts: imx8mm.dtsi: Add resets for dispmix power domain.
Date:   Mon,  2 May 2022 12:02:33 +0200
Message-Id: <20220502100233.6023-5-viraj.shah@linutronix.de>
In-Reply-To: <20220502100233.6023-1-viraj.shah@linutronix.de>
References: <20220502100233.6023-1-viraj.shah@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resets are controlled from src. From reference manual page
959, display controller needs DISP_RESET bit to be set to reset
dispmix.

Signed-off-by: Viraj Shah <viraj.shah@linutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 1ee05677c2dd..11a6cae5bb99 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -734,6 +734,7 @@
 						assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>,
 									 <&clk IMX8MM_SYS_PLL1_800M>;
 						assigned-clock-rates = <500000000>, <200000000>;
+						resets = <&src IMX8MQ_RESET_DISP_RESET>;
 					};
 
 					pgc_mipi: power-domain@11 {
-- 
2.20.1

