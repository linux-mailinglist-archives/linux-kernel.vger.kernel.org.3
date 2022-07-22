Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEDF57E95A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiGVV4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiGVVzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:55:42 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B4E2872C;
        Fri, 22 Jul 2022 14:55:41 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MJzv9-1oFpYw450H-001U0n;
 Fri, 22 Jul 2022 23:55:28 +0200
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
Subject: [PATCH v2 12/12] clk: imx8mm: don't use multiple blank lines
Date:   Fri, 22 Jul 2022 23:54:45 +0200
Message-Id: <20220722215445.3548530-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W2K1hk6sSrZYWoqW9yUz1L0+y7LY4l2HE3yBSfIYEstsQzrcf9N
 3ssv222wak43XOr8KP/nYq+UpG2laB3bLx4SvGFLO/L3QZrK1gZ5rHeW5h33/dWDvPiioxu
 dM/t3XMrPKeXOkfE6ceRtzx5tcpeQlrk28o/z8IdtNUTVyLPTxEadWv5IIATEUKfki9SjEp
 BOySWRyHc+nJobfltQuFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cDdhPD1Y09w=:RzOQ+h42/2Pnf7mvqBctRJ
 +g7vvNna96da4vEiQA1qcUMLrRdvP4GB/+3XbDDFYpoDvhIsEFoLg5haJC4fLuKs7sRVAA1FH
 i6RhsQvvMYPfR0UxhNsaIwTEmq7GY4N73NwnxHarh2o2FmrYQrfaaAYVD4IujIgND6QVJDiQK
 6Lvl4P/U3cqE5c4cQrSYqugq5Pyg8SxT/ZN9kjrWr3avlBP89GcSC+RdKfYzCvj/rs7GYgR5L
 wt6WK57+Wb9cgcpXY5hTS09J96SfY+velBv6yidsomx1gRCIjSiZu3jYFok98GAKEpSyKULd4
 Izi0KkeHmSbT544R1zDU17RA65KEAH624llC/UUYGcbUsd94u7w1a8f+JNv5pSTfOQmzAPYgV
 08QWfr5QvQKTQfj8aBjl1v/BTSqn8hxe/BST4p2AwL9MF4ivyve+xpzq4nO5grtI4SM6sgCrn
 SfAoLyrTpqMSzWl7JfV7PKUOVsDkIjburKmTYUyQNyi0oupy7UIL66ccvTOHVnqsR28XFnD6A
 eZs1zj+WjgvuyxkFaBIxM7aRHZh9DhHrNKspD57ib5Pnm7SfxtTWZt/Su8SEH+vi9f3S6qAxc
 Wum3IpVGU5aq3pCjnTrYfEWZ6DoXoz5BEzfoB7nYV+iWuPjqgAY129QQVw/Yfhl0Ik5DyimGy
 xUlO3wLLOih/96At0A+cxu6SzAMeEa6NMHACwPPL9S8Wd6/mIUKh/iwXrKWV5EhJJ9VWBlxbN
 N4GTDnLoq07tRSdFmRt4X2iVSe3c8NJ6rgg/j/S0w4xCzO1vXkVVHf0j07Y=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v1)

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

