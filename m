Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5B520403
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbiEISBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbiEISBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:01:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6111EAF0B;
        Mon,  9 May 2022 10:57:32 -0700 (PDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4KxpmB64sVz4ySW;
        Tue, 10 May 2022 03:57:30 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kxpm53q4Tz4xcY;
        Tue, 10 May 2022 03:57:25 +1000 (AEST)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tao Ren <rentao.bupt@gmail.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Subject: [PATCH v7 10/11] ARM: dts: aspeed-g4: Set spi-max-frequency for all flashes
Date:   Mon,  9 May 2022 19:56:15 +0200
Message-Id: <20220509175616.1089346-11-clg@kaod.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509175616.1089346-1-clg@kaod.org>
References: <20220509175616.1089346-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Set "spi-max-frequency" to 50 MHz for all the flashes under the FMC
controller to ensure the clock frequency is calculated correctly.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 1c6354cec9f2..530491ae5eb2 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -72,24 +72,28 @@ flash@1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-rx-bus-width = <2>;
+				spi-max-frequency = <50000000>;
 				status = "disabled";
 			};
 			flash@2 {
 				reg = < 2 >;
 				compatible = "jedec,spi-nor";
 				spi-rx-bus-width = <2>;
+				spi-max-frequency = <50000000>;
 				status = "disabled";
 			};
 			flash@3 {
 				reg = < 3 >;
 				compatible = "jedec,spi-nor";
 				spi-rx-bus-width = <2>;
+				spi-max-frequency = <50000000>;
 				status = "disabled";
 			};
 			flash@4 {
 				reg = < 4 >;
 				compatible = "jedec,spi-nor";
 				spi-rx-bus-width = <2>;
+				spi-max-frequency = <50000000>;
 				status = "disabled";
 			};
 		};
-- 
2.35.1

