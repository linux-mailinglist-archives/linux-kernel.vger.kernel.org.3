Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41965A2FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbiHZTXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbiHZTXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:23:23 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C19BBD1C4;
        Fri, 26 Aug 2022 12:23:21 -0700 (PDT)
Received: from toolbox.int.toradex.com ([104.5.61.88]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LuO6D-1pSrpI3FaB-011fPg;
 Fri, 26 Aug 2022 21:23:03 +0200
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
Subject: [PATCH v1 4/5] clk: imx6sll: add proper spdx license identifier
Date:   Fri, 26 Aug 2022 21:22:51 +0200
Message-Id: <20220826192252.794651-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826192252.794651-1-marcel@ziswiler.com>
References: <20220826192252.794651-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bBK5+ccOcg9oFHuj71fLYRCm5D4tGKkcLhNY9czGB1ZIYOl1ijT
 1Gi5n4SW03McExgteWoyTNYSe6iFb0m7L8wbFi2TFSphKleqalwxiyZHOwekqVaobfM1+em
 4C3zmkd4/FffP0I1GPyKI0mJp5TbsHM7s0mofdqllARZr5TfYqUHOt+ZDKOSYjtGVEJBpX/
 GssUz4AloE94dIjBLY0JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3AetIU6BX+A=:WWYTYyYyqXfMQ1JtnaT7yx
 R8Lxd0DlH7tHg4IRdcV5IFaM1OICVckYETHNv0XIugkbBv5FWc8nmaNExJqqJnIP9G+TdyPAt
 evSY0ebMl0vOlntvU0f3DIau3FykVKeUV6jCmXnr2v34WsVobSOTuqRWSGC5SP4NJTWSFXH2e
 7AynmJ9W6naELYwHXd8VAWYsaNMLoBC+ho0q2EnPrl9pTLf2xjsgJHhkofBSyeC4GcL+e8/bd
 sC9wbJolk7MHRPz37JKoeou4/ZZpdJjV6DwikaF5/YSBI0CUToB8/7ql+QrZkk+l+ON0VnCME
 CUmC3cha6fekIIqpon/xsf7nDO4URTWgwJMRVyDoib1O58AhHloYjhpmMtGei/xHTU+wmoim+
 0RgiCCwx8sg96VhybUBpd7D7wbX6gRbYI1pAYFhutz8swBC/ZZNXL8OwpRIWmP8QMTJITOKP0
 21CVqHFoWVSzMEUyknYGL+wg9vltLsm1jv91iWlr/S4fG7yV6ffHUdP6GPg9Nvh8Q7elwef+i
 LekIjnNQ69KRwzkVsqg4p7Y0N3VFnPkh4hxs8ubT7B6tIM95q5/LFsXqbFpY5DX5rkav2skLE
 w/ulX4sVar7NqSiMsG0qWNu2riSTA15IjI0E4zb/0qp/n1TksI9y0vj22V+7DW0DCbciuLp6E
 UjZhbrr00NQnjGL8nioCKRYBQEeSn9RuwhDaU2mXI66tByq7tJrM1H5joyCLz/fT+fZcHODmA
 K8MIu4dXyTlg39WFbJOULI2zn4yl7agX0ziDhA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes the following error:

include/dt-bindings/clock/imx6sll-clock.h:1: warning: Improper SPDX
 comment style for 'include/dt-bindings/clock/imx6sll-clock.h', please
 use '/*' instead
include/dt-bindings/clock/imx6sll-clock.h:1: warning: Missing or
 malformed SPDX-License-Identifier tag in line 1

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 include/dt-bindings/clock/imx6sll-clock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx6sll-clock.h b/include/dt-bindings/clock/imx6sll-clock.h
index f446710fe63d..494fd0c37fb5 100644
--- a/include/dt-bindings/clock/imx6sll-clock.h
+++ b/include/dt-bindings/clock/imx6sll-clock.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
  * Copyright 2017-2018 NXP.
-- 
2.36.1

