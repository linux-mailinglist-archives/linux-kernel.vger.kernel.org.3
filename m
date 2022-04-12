Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A324FE3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356655AbiDLOiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244461AbiDLOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:38:07 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3F35BE6C;
        Tue, 12 Apr 2022 07:35:48 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0B09622239;
        Tue, 12 Apr 2022 16:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649774146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s23tGVg5wfsxakK5pO6iL+Jzfw1pM3exjiQaOm1BYgk=;
        b=hcSDKp8yvOYM1X/auajUFIy2zmhU59ZbK9GxqJXte96X/3m8v4ZyaZQRUglRLP3okRPO0R
        bQTiL5rJv21ilNbKdqqYUtRniSNChW+LzjkGEfyuoAs1G8/Jh/JBczd9wY9KinoodtcoV6
        c2UNgJOBvTSEv6wZrhe9vlT4hrdBdZQ=
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 0/2] arm64: dts: imx8mn: add 8MNANOD3L-EVK device tree
Date:   Tue, 12 Apr 2022 16:32:36 +0200
Message-Id: <20220412143238.1925059-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

Add support for the 8MNANOD3L-EVK which features a NXP IMX8MN SoC.

Patch 1 was formerly postet separately, but never picked up. So I've bumped
its version and added the actual device tree. Please note, there wasn't a
v1 nor a v2 of patch 2.

Michael Walle (2):
  dt-bindings: arm: fsl: add IMX8MN DDR3L eval board
  arm64: dts: imx8mn: add 8MNANOD3L-EVK device tree

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8mn-ddr3l-evk.dts   | 114 ++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dts

-- 
2.30.2

