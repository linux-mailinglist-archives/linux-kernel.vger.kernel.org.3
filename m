Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE1487BC5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348701AbiAGSEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:04:50 -0500
Received: from mout.perfora.net ([74.208.4.197]:35379 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348746AbiAGSEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:39 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MJElb-1mn0Ek28wl-00KkIK;
 Fri, 07 Jan 2022 19:04:17 +0100
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
Subject: [PATCH v1 11/14] arm64: defconfig: build nxp bluetooth as modules
Date:   Fri,  7 Jan 2022 19:03:11 +0100
Message-Id: <20220107180314.1816515-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:b8pr+w1Bj96Ykq461BfzP2tIqNnB9QoA5G8wBeRKSgopjB5JjyL
 C7mArpYOKp5rixeXr+yraL+z5G7DYvOhf+MEa18SOk2wdPdpoXXrl5RiUoUZfT/SfZ0WSRD
 aVfYZV/Hkrn3o1j/KMuh72BdDwONlKExl0orhshNy+bGu+CUFPaxsrEJtA5cZkU2ZJHiPT4
 JwRwRKQ0ROlDFHGc9tNpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q2vBfPD++90=:sSu0vsV4r/Ns6l76g0jhUi
 vm+eSRRrydicCM6Ig1hPMmpVmv3HWno7s8GVIMlVgNhJn8ftIXJbF6ZSCvllLLeOjTAKQ4cpk
 6fcl7IFUqqqYefN7p69hmeaIzqBWwJD70V+8u2AnY6ol2jV6FUqnLy/+2j8ZPrswE2vNuPh7Y
 9EVjoO1djMjW9FJ4LlxT9xOvYRdXdzxKosAxr3LXciFmi53y46hWMxmD7lVyWQxQenM3eZ/fZ
 vcxjE7eKem5m2l1iZoEC9SLUgRkIu8LGj64LDb797+0HXiFzCrnWyEfCQkmN+zrSV8K4wpmkn
 scI/sQhJ4y34WEQPa2OSD+Rl7wXPCXR7IgWzPUORFNrZU3IsyZDtGy2hfPmufa3ktgHRCldp2
 CTJPZJ0UcmPtwur42cOCq6OqlMtlPapjRUpVpo7qgN6CHLLBfnVDcAXQbZxainjM5fXXi0zPP
 wqUKInyvfcPdAa5jlB8MuLlPm761RRnKP017OAtw9e7YnvKGy3Vzb9L/z06qcLoVcERtfKUbz
 jlgr7qSr4xTLdqwm3Frwqizu4+KfxQvh1kAhIeoKyNKe0eofWw9znGqzfs9/6jEGhZias0m1j
 oz8Kby1HK4MTqINVewEFt+UdvgxrFWj8oZEqIy420hrcRO7wrQKADWncs+4R9gF9NzTrLWOAS
 kxq0Yf7aP7/t2dF1VUupMkJ55FVJ5iAkqwgExLu1wEGooMVRSr5EutPDR2D2q2VoIyJvEdep1
 INupwpDTGQHQvcRp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build NXP (formerly Marvell) SDIO as well as UART based Bluetooth
(CONFIG_BT_HCIUART_MRVL, CONFIG_BT_MRVL and CONFIG_BT_MRVL_SDIO) as
modules.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cb99bd97e736..fe4da2a167ff 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -184,6 +184,9 @@ CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_LL=y
 CONFIG_BT_HCIUART_BCM=y
 CONFIG_BT_HCIUART_QCA=y
+CONFIG_BT_HCIUART_MRVL=y
+CONFIG_BT_MRVL=m
+CONFIG_BT_MRVL_SDIO=m
 CONFIG_BT_QCOMSMD=m
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
-- 
2.33.1

