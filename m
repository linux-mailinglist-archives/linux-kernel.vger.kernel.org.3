Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13554AA3C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377228AbiBDW6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:58:24 -0500
Received: from mout.perfora.net ([74.208.4.194]:41057 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358982AbiBDW6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:58:07 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LnQ7c-1mZddQ3oSc-00hilI;
 Fri, 04 Feb 2022 23:57:51 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Adam Ford <aford173@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/12] arm64: defconfig: enable imx8m pcie phy driver
Date:   Fri,  4 Feb 2022 23:57:01 +0100
Message-Id: <20220204225706.1539818-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220204225706.1539818-1-marcel@ziswiler.com>
References: <20220204225706.1539818-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LPdGHBlQKIg57PrAjWhLk7NZPljYZeRltv3lzViB6z7eR6c+jmR
 FtfQJ0gXoEk5kFGSs5P9ZBH5uMvDNOuU0BtuC395OwytJzDy2xodmRs/bbUVZ1cYuBw9tWf
 QZap2AXqkPcPbW6dRAp55zgU0DKeNtjXm2nt88+4hQlDuEYkhczBXeryEegNm206thH97YH
 QRIqiA1zri4MjAl9nGMrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dXkHFfTYa4M=:Z7AEvYifE7iFMlZTvrA47P
 /bUBLerCf+pkzBBO1dtJ5xsaoERYiyLb1K9ydweSaSnOlzvbJUTxtbqiMZoABq/Voxds4stNS
 Gqflg25PkfqcG+h9bdSlcym+5f3uj9zLhkZ2LPxnHTk5q8xZUMWyaTX4AvgDPmgmBlae1U54m
 V16lgUR/sMk1XBQkmaoJoxpLtfP/byjC1IZZmi/eOrbctNt2OZ38GTNzWjuBzZfxHf1F7CBtB
 w0N+WtHnsWoJRR55saggNc99R57k2kBOENMdSQIN8cB4AHW3SEXo0gsxEWVWGzGL5JrOnUzaL
 ujvAa82H1LL2hyTQceGdpNECEeaErIiC0WlV7+MA3zA6JNdIGV97LgEKGfFjEUQdBI91C6O4/
 dxpwgkfrRv/Yse1vUF2WT7SyBhKP+oFqGm6602giabzgW427W2xtDfT1QsWNnJ3LKX3hxCYI3
 1QRQHh218EeksI4hXMc0CLuKz/rcuT4kUBuz+5rlX502U9HF2wUcFrTqIkL4EdyvUbFUtZ805
 CIkOHvXQAcWH131e+xo1UeISLQOsc/nSFBISL4YSAIz4tS7DjHgWpp1EHYkq/hFzVjEIaAzoS
 JycfXxdtpP5qtvVlB13V3bjH5EJ7eTVN6z16lTeJ/xUv5fUjRXOU4kpWtxeYOL2eFmYX/Fw54
 nZPZm3y0FuHKk/3aww5yNqfX7Ko+kln8l/J3iiCH3qiPIS82kV64ozAn/+5GWYRoz2wM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This enables the i.MX 8M PCIe PHY driver (CONFIG_PHY_FSL_IMX8M_PCIE)
required for PCIe functionality.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

(no changes since v3)

Changes in v3:
- New patch enabling imx8m pcie phy driver in arm64 defconfig.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 444fec9ec73a..0fed8477e72e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1121,6 +1121,7 @@ CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_MIXEL_MIPI_DPHY=m
+CONFIG_PHY_FSL_IMX8M_PCIE=y
 CONFIG_PHY_HI6220_USB=y
 CONFIG_PHY_HISTB_COMBPHY=y
 CONFIG_PHY_HISI_INNO_USB2=y
-- 
2.33.1

