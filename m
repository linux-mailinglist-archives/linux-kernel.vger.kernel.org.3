Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC06487BBD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348682AbiAGSEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:04:24 -0500
Received: from mout.perfora.net ([74.208.4.197]:49893 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348691AbiAGSEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:21 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N95Jb-1mLPiq3mHn-0168oO;
 Fri, 07 Jan 2022 19:04:00 +0100
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
Subject: [PATCH v1 05/14] arm64: defconfig: build imx-sdma as a module
Date:   Fri,  7 Jan 2022 19:03:05 +0100
Message-Id: <20220107180314.1816515-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BcdyTzJ84BOiDNZUbrK+SIejDKC6BM+zNeMfOGD5U/Qt/kTKufR
 +U6mRXZ1cNprbbbV1bJkQy8wf2oGghtEPBzLcDYZx5qSPc1xVA14VNjb6/gN2Ab0euOBjV2
 /QrepTp0+PVZtPu9h+6qlNrIyP/hyK8eUhJviFYJTnGn19khFfVlnd1DrOncnDWyozV/vbt
 3oU1W05Lot/bExq8aZRNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gw/FK02oY2g=:y2X3EcwK0+bzrp2TERXelz
 xO5kBFByccLGVRgWyF9hyQrg2N845MEYoW01txcuQIZgNL2MQkz9FDh4+9x+Rm0neTYYmUVNz
 rHztsHGSMkrzvxUFtg4sEnIMH5DwdZRuw6gUSotsxcQ5qprpEojAHA5nLdV5LpQd3NfdubDT0
 E/pNhf/40IukED4BA2YMLAYsGrThIHV83Q/MEgdO4a3kBskX/UZHwfYAXSUEituTfb+q0QMzr
 DACYRpofEalPtMCfJoMwa0MVfwuiv6WQAa3VCc2mGOKbYh7OmHWmqM2Ni+zi9LhLFSazM7SMe
 CVUONbjQIQ6R6x8so2WlTUvnkQpjg/B8IetPDvuIbbSEUOj5mkXLia+pIOqjEgba8sv54os6G
 GGZZJxZeT0r9srXP39DRrarQpnGtdYPmYSsz47AjSK/5Zlu1d/DBWYI1pyU5oR/t7CyYA2qco
 sxZmMfz5gL0eqRNyffLq+HMBPBES+HAt+q4YVRoMI45J7/S5MzTNUV4tifIpxcwrBLv/CGXrY
 vMjIMcpt71C2URVsJCHuErjkDnlyQ683O6rYarIY5UVxQd4NfydoofR0fGGHvDGLosKfQ4OHI
 +ZMEkfWeAfFyEoFWg7+wy+JBp6TuLp3L8hBVKfPnsdmWYk6hup3OoFS63x4JzkhbtN1luKQN5
 8Bc/JMGNgvFJorgXu97O3+WEE0MeDYonZskdBLluMFmOcV15hdHlzat997M4c8w/+kg2UQ3md
 KM7JLvz4eZK/T0ij
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This avoids firmware load error and sysfs fallback reported as follows:

[    0.199448] imx-sdma 302c0000.dma-controller: Direct firmware load
 for imx/sdma/sdma-imx7d.bin failed with error -2
[    0.199487] imx-sdma 302c0000.dma-controller: Falling back to sysfs
 fallback for: imx/sdma/sdma-imx7d.bin

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3c8106c5776a..a18785a827dc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -915,7 +915,7 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
 CONFIG_DMA_SUN6I=m
 CONFIG_FSL_EDMA=y
-CONFIG_IMX_SDMA=y
+CONFIG_IMX_SDMA=m
 CONFIG_K3_DMA=y
 CONFIG_MV_XOR=y
 CONFIG_MV_XOR_V2=y
-- 
2.33.1

