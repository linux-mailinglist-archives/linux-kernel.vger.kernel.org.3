Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC3157D49F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiGUUGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiGUUGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:06:02 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8AF70E41;
        Thu, 21 Jul 2022 13:05:51 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N2EcM-1nVyz33C3S-013eqi;
 Thu, 21 Jul 2022 22:00:32 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/12] clk: imx8mm: don't use multiple blank lines
Date:   Thu, 21 Jul 2022 21:59:35 +0200
Message-Id: <20220721195936.1082422-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dR22pRh9FFpDKCHYA5F6Iwy4bJ5r+Z5lgDQHLY3MMytbO6krkQx
 gqVymQr3icTKY2cuOIDoHa4CSSv5yYd1+D4nIudj9HoyA2b05MwZIoSLbJnEuy08EoopPCr
 CyBgfoPSQfrMsCF67w9qdVczpeZb68+i8ijDzY4rMUcsAzzcYO/TDlIfIOnnHmsd7/N8kW0
 wEypyyob5cV1NTghCpk3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D2I4JPn7FEI=:TsASVQtiu57rMYZuJD0/mn
 F7K8LoBPn4aPs1kNjOC70UTsMTdVR5skP/M898ezujKSfcQLi4//zgzMI7+e8Kr5+kSbeoKOO
 m24t9CZjW+vFqWvEi9c8HNdPSSLAzBvKqCmxPTbmyxh/xKhQRg6izMCDpho9+t4HhVLrqiYo9
 +GFH650AkNfykqkd/gD3F0OSE7DE0y1QdhzUfWXmTIIuKUjAgOwtnVVDwPebN6pg5cFIo8vj+
 vOSk4X+pKp739qbYbrTBDbjBvwNfTCF8/WcAri1A14bQ1OI60e6DB/Voctr1LemhUK9P26oEu
 QRR7fzOSzeNTMo1b1MXquZx1Uv+W1FCYjbuxqiHEZn4cuLmxzYFw56kLS96fTdNoeWChCNQ6O
 g+viWpG0wtkyh9Oq85j+8mtJtFrDFl+OAV3NO741EL4RP0IMB9oyKYosDZuIw0z8Ex+0wScZI
 1l9REE84V1mP/RXS+pFIx/XwfySKzgm5/aaPbgiztKyI01WC0QbhvmDy1oRwEHMmRVBC+fCPf
 Gdy8wTp/rI4+MRbvceQ6Kt4Ids0x7VqpJfErzKiE5CdScfbW/bmfY50GGH5vkeX/FGbC8zds9
 f7iYIbCo69w5JVpEsNoh53t4oZAfL4TjTJ651X+Y/kl+o3uubOjWl8Gy2ArMeQwGCYPN2y9+U
 yOogLH2H57N/+97f06RhfXWuzC8W1LU3Xi8RCE5UX55ksV3sPbx5BiYsXtGQk7up0b3HQmCdZ
 CGa+AKHIrTt6fEfBsLUVY0v+fla0rfP5zXRNeVLsOYFfmEKE6+/jQaD0vw4=
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

include/dt-bindings/clock/imx8mm-clock.h:284: check: Please don't use
 multiple blank lines

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 include/dt-bindings/clock/imx8mm-clock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings/clock/imx8mm-clock.h
index 47c6f7f9582c..1f768b2eeb1a 100644
--- a/include/dt-bindings/clock/imx8mm-clock.h
+++ b/include/dt-bindings/clock/imx8mm-clock.h
@@ -281,7 +281,6 @@
 #define IMX8MM_CLK_CLKOUT2_DIV			256
 #define IMX8MM_CLK_CLKOUT2			257
 
-
 #define IMX8MM_CLK_END				258
 
 #endif
-- 
2.35.1

