Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD757E959
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiGVV4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbiGVVzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:38 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F37820F4F;
        Fri, 22 Jul 2022 14:55:37 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MOgc4-1oB8jk1px8-006Ayo;
 Fri, 22 Jul 2022 23:55:22 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] arm64: dts: imx8mp-verdin: don't use multiple blank lines
Date:   Fri, 22 Jul 2022 23:54:43 +0200
Message-Id: <20220722215445.3548530-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OsiFIq341pgIuDoQVj9rgZZ5mouwimODufNtt2x9+LkwsGGrra2
 A9Q7Qp+4qvGWW56jnmAS37zXZp6pOvXSUujXo6xGYMcwZSXoM4vOqMq0hqp6IfPTN9bq82B
 h6zLHEp4/pENEh7FUeVJcFDXU0f90V8btYet9yl5a7PO31BmCni/ci2exNDbSM6IB/ZQQqm
 pW3rS5QiXFFaccGfy7t1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n98cL0Ru4+o=:A/eY1hPYWt0dw3Jk0W35Jg
 I3qc+puDSTJeXBk9X3QlEnudf2GngsTkS+Ay+KrYQRLEwgRy/8i3eQqhhQjUf7NYVMEk4TAS9
 eRbVt8CBnzZq1DEnLjXCktkwWia3HVx115FfdBZ0Ry3+hVE9Yyfudd/Rncsf+31m8lfyLMGXa
 CcQsocL+BftbCob3P4WJFPE48rhWELkc7Nrai1KuC1RE12WQR7TnFeSnaKTB5b5z/PR4/DGyc
 1UwIANHUpL1whemCxXMZDxjtDkMND8OaQSDh9hjgjVAeVkBPDiuSUsQoMzYz7nn+adFv2thPL
 B4YDKnp1M9rDpWZYP4I1K45qsKNmXmUD/A02ipG6Nimz1LLxzCJfhebwuUa0BQpffnDGyiG07
 bU/qVJ8MjAixt4ZG1XEz8trBy2CBLaw+Gsumai38Q9U+ix5Qs6/fRt5vkmffML/Og27afDg5j
 JW0/41i3ul7hZYF4Sh8sovz384OnPrcGsgj65HhZ4iyUm/w12tMRAYxRw6WkEhrAaBGwapIYR
 ziPMHAkTUQafiD5jnrB9lHxHJX+8GSTNdqbvaeu5rt/0WP4N9DzlXgg3t6A0BGf8SwIvmlkE/
 ifBpMCDXnZ+NkzGbuCIopO4CXkQyUPAlLnN9IjncR+YloYDJZIqoJ4tIQPYovkTZy+dyuMt8z
 sOz0NnUoEaWDkhe/zo4rlR7C7zxMnWOpNWaMVz71rmLP7a17d8B4BBoIoQ9uzItC9Ndo7XC1v
 3Ggf+kaBak2L9Rfb4bEN4mbVgHAm9rb8imQkKZVd62bsMLl2qAoJTfKiCfA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid the following checkpatch warning:

arch/arm/boot/dts/imx8mp-verdin.dtsi:281: check: Please don't use
 multiple blank lines

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index c5987bdbb383..f062fdbb2719 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -286,7 +286,6 @@ &flexcan1 {
 	status = "disabled";
 };
 
-
 /* Verdin CAN_2 */
 &flexcan2 {
 	pinctrl-names = "default";
-- 
2.35.1

