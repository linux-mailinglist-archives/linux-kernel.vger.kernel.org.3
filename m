Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB32B5A2FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344600AbiHZTXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245744AbiHZTXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:23:24 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48372BD1D2;
        Fri, 26 Aug 2022 12:23:22 -0700 (PDT)
Received: from toolbox.int.toradex.com ([104.5.61.88]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MPWEB-1oVlW53gpd-004oE6;
 Fri, 26 Aug 2022 21:23:05 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] dt-bindings: imx8ulp: clock: no spaces before tabs
Date:   Fri, 26 Aug 2022 21:22:52 +0200
Message-Id: <20220826192252.794651-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826192252.794651-1-marcel@ziswiler.com>
References: <20220826192252.794651-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ES5uhZqsEUlBK7GTpMvT/NxRIaK9SDvd9PRFIVTeZNZqiJ526Ia
 uJ0+tv/XCtCVdaH+l4q5t+GSY6FIDdkVEGDDc4nG2NXevFY+zpKovV5FAr9UPvP4uDPWXTi
 +/njE7+gzJoG/xKyVPzgS1Nt+J6QH14ORWveIL7xywzh4+POCeb71giLohNvxPq/XgNf0Dt
 lcP7biWiCAzDwcmF7271Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AkABm4LBPYU=:yMLqG2XhIAuaaH1Xr+zj/e
 6CcXu7iEXVwCfoETIJGU+g2v1ixKglrfnKPstZmYmdLTGB69dwyyT6nt6x3Z6tzHmU5VUuOOZ
 G2AkjeNa+8m3gvAydKv0NGotZUHN1iYB9x+xSq/scKzPYuY3RJ1G6GVGjYa5bC0+DnK538b9Z
 KCMC/Ga87GMUAGqh1rdbhW6Q/KjDfTCezsO8EIzKpoUadZrJFO40wSLOKI9G4TAVo15WcH1U4
 8tfKtXYiBqiWiLk79o0hdxjDUv2Bn1CYsImB46e8T1WjTUfWAm1qD8dV3DMkCDIqtHXkbSffT
 o69yUPk1kzY9EGMj31d3G09vpdjAe0t+Bj8V97ad1MIstQvZ2RAxb12vc0rzcH/6DLxIwX5j2
 UzQrrm6zpfwlaDiC2j94pd6NeMAersRckKFZaDVel/UFxqmZFzpN1FETHW5udUqRVetYzJTjJ
 TRCY7LqIMDmbl9uOfPsNfDbu/VDMbbzNkQfTJKBXsFc407QxsxHHKu1OQ47PR/3F6fmx3/GRK
 qS5oJO/Zp5NkcWoL9mkkhCuhIHy2HFQMS/VydaXWCdDCaNFCe5BdMoeMcX0DLOSTM9baxwUax
 ppN+gWu1pTe2665/ChArPTHpp7uAwpyYAToqVXe/ISmZhRIvmgp9Ok+wLgcrjBmQxccTS2h4d
 hXI0o9/o32NA5hhBNcAqrC2GXosM6SLyXzIj+mYc/JyaI1r48uNxPxp8pAvDl9ZN5se1KO+mc
 /4dLwsCkZrfJJIECr+EbjRmsIB9N9eh2GUfJhA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes the following warnings:

include/dt-bindings/clock/imx8ulp-clock.h:204: warning: please, no space
 before tabs
include/dt-bindings/clock/imx8ulp-clock.h:215: warning: please, no space
 before tabs

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 include/dt-bindings/clock/imx8ulp-clock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/imx8ulp-clock.h b/include/dt-bindings/clock/imx8ulp-clock.h
index 953ecfe8ebcc..827404fadf5c 100644
--- a/include/dt-bindings/clock/imx8ulp-clock.h
+++ b/include/dt-bindings/clock/imx8ulp-clock.h
@@ -201,7 +201,7 @@
 #define IMX8ULP_CLK_SAI7		2
 #define IMX8ULP_CLK_SPDIF		3
 #define IMX8ULP_CLK_ISI			4
-#define IMX8ULP_CLK_CSI_REGS 		5
+#define IMX8ULP_CLK_CSI_REGS		5
 #define IMX8ULP_CLK_PCTLD		6
 #define IMX8ULP_CLK_CSI			7
 #define IMX8ULP_CLK_DSI			8
@@ -212,7 +212,7 @@
 #define IMX8ULP_CLK_GPU2D		13
 #define IMX8ULP_CLK_GPU3D		14
 #define IMX8ULP_CLK_DC_NANO		15
-#define IMX8ULP_CLK_CSI_CLK_UI 		16
+#define IMX8ULP_CLK_CSI_CLK_UI		16
 #define IMX8ULP_CLK_CSI_CLK_ESC		17
 #define IMX8ULP_CLK_RGPIOD		18
 #define IMX8ULP_CLK_DMA2_MP		19
-- 
2.36.1

