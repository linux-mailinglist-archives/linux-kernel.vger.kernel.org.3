Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796B5487BBF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348724AbiAGSEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:04:32 -0500
Received: from mout.perfora.net ([74.208.4.196]:43639 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240517AbiAGSEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:25 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MK470-1mnpZu3jB8-00LZm9;
 Fri, 07 Jan 2022 19:04:09 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/14] arm64: defconfig: build lm75 temperature sensor driver as a module
Date:   Fri,  7 Jan 2022 19:03:08 +0100
Message-Id: <20220107180314.1816515-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zNsla55G+0y2j4GN5ahi8nbSFYTvNVmS6ZETu0q0EpLhNgVFW6N
 HoVSd38LZVErTC2WVrwN6/+OSqyunsHOlwtrVm9peDAG3uPjEmqanlEUGX1FlA1unOQsJMt
 W5ZbJk6kO/jlfh9cZqtA1D/ByhsTibjmCNBpLrtmR0nSEgLngNhqKf2IIPJe4X0pnXZdJKI
 C1oBVIPO4j/1z1PPNHgcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pQ7HYORBDy4=:1gcFFLC8urbbfJrRI8rwCm
 ZC9KrGGIhPOtk10KmnDBkU/B3rvAzd0WOnEt9YLXUjn2Dc5qEJS4dGNG7SuVtEElp/y9rJzvD
 bl9sasJyFSTdyQ8chOHiyNKj1CRz0TojTY93lxxc1fgEHoZysQMwgTG4ej5K6kRsgbAXifBR3
 kalhfqWe/Vf6s7ezq98lC4+rQAHmiWHCmXADpLSUGElQDtJX+G8Ab+mWoLLPgy7i/0c7bgAIP
 6tS2lnWD728O49OEWw2QqUlxmzzjRPolfocqbIhqeL1wQUv0yr0NfUXnLwai1pBDcq41xdKJR
 8E/lfQi6p5njHID0xRTRrPeHHnVPlvMKOPYAUtmABO+Ule9e7u2LtWQyKyCXyXafBlrFsDa6q
 35fqPLQkluKD3fQYxgALeq/73+nerVqi+E6LQnBPCAJYXZ9gbslmQFNpvrRc9B51I6dAe/WrZ
 63WFTR8q4LyuTw+ivuG+JBL6hDVh6WqbEdTBVtBNiaS0BvCjVxNBE+kDjijAH2WBZOFCibofx
 KrLos2yprL6dXVpgnRJrtgTiiYAHqA33ulN1sPFYl6dKYr7KklroCSl3XsiFBsgx9ZDuBF8lS
 XcNK5Y8rjTWfSHjKqNl6qNGqNZdra64q9fpzJNIg6SKD6gJH2pEQ510eBsPlgRNNRx1nnq37M
 iSaEfPxspqC8RqP+rInTshzg4iv+NfUg5q81K1pnK/pZs1tOGD+932HGAUQ38VKeFDCEAsoj/
 OjN8ouZGoNC+O6RZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build Maxim Integrated LM75 temperature sensor driver as a module.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1d0fe0bd0059..b4fd61fda35d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -541,6 +541,7 @@ CONFIG_CHARGER_BQ25980=m
 CONFIG_SENSORS_ARM_SCMI=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_JC42=m
+CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_RASPBERRYPI_HWMON=m
-- 
2.33.1

