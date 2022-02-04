Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6FD4AA3BF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376499AbiBDW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:58:30 -0500
Received: from mout.perfora.net ([74.208.4.194]:36665 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357887AbiBDW6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:58:16 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LoFKx-1mZv133FpR-00gL3D;
 Fri, 04 Feb 2022 23:57:57 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/12] arm64: defconfig: build r8169 as a module
Date:   Fri,  4 Feb 2022 23:57:03 +0100
Message-Id: <20220204225706.1539818-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220204225706.1539818-1-marcel@ziswiler.com>
References: <20220204225706.1539818-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4BltYtkzBkJHtEHVYyyQlitYiklvlU+l6RyQ4abgyWP0WM/Qn24
 0Kdb6vEwwIc7RfuZevHbsUX8Pa58RmEFnkKRaRMkiUXzMZ9gUjYcBLgDdIRU3keHo9mwasV
 g9SIKzyCt05JCGECoSu8PVm2yDliZ+3rXc9PQ3XFp+od/12KoRnfsl01fWF/H+3Muk6MaxX
 hlgxL8/fbv6iBnsqF56qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+UucHS4I55c=:rTodgsNKTd/k2KQy7tuhcD
 M/GLakD4YzabYQXISWKwFGV50D6Qwml4bxnvDWsikXunvoHgalRopP16TYrg32JeElxhH4v7r
 hPTgkvuFHiYD56Fb0c71Qr/X2hGq/yYkTZR/xgBQ2CUI8byGCt4ysB6vVSwmk8Ojm3pBd7f38
 awePL/Mb6OSW7a7SXDmKz1K5Ll38/aektY/ZNAF2AMwFuva0nI5oSOxYKKfE94NJGSZ142+Y5
 6LnnrCR8+kTKRw4snQTTkLNnvZvhhZe0YS5d5HP6oO0al0iu1n9Sdy12uCPMPbzt9sTgxFVmj
 PVah6B1kJetZzSIDQg10s6Na5Sf1KtrhNCqnchqKyhK1CzxIAK09YVGwYbxjKng9XTdKslG+0
 tU5MbvZ4ORu1MMoi367LpNdHDH3exgKxt9Ry2nGR3hc3Vzb0UHs4+Jz365zjGhbgAz5v88lX5
 uet9JqOPeY7j6+ARo5eKAg2cN6H2MJ7d4uUTnTnfwI0QVefcejpKdpU8I3jsze1w1zM9KM+FM
 4l3Z3oM6I0UJ+armGWZDb4VRcERr1Lv60SeoryV5fUraf5gFuPHPIksfcO/JJs69FjNzcTpMH
 IfZCyfhqqbwWUOmLbo58tkJhaUxpZ7In9uUs4DM2STLsCXazOfmH4r6D9Hmg+qbs7UXiXFrMI
 PaOJlYfNFBg/0Pq5AopPc1cokLwe3keaQZ4An35lg56rdW9a0b1WPVoA6DNgaKdZ+G/w=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build Realtek Gigabit Ethernet driver as a module.

Network cards based on chipsets this driver supports are ubiquitous both
in regular PCIe as well as mini-PCIe and nowadays even various M.2
formats. It is therefore a suitable card to be used for any kind of PCIe
and/or Gigabit Ethernet testing. As it is not designed in, just enabling
it as a module seems most suitable.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

(no changes since v3)

Changes in v3:
- Add Krzysztof's reviewed-by tag.

Changes in v2:
- Explain why enabling it may be a good idea as requested by Krzysztof.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 27afe24a025a..76334cb698af 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -339,6 +339,7 @@ CONFIG_MLX5_CORE=m
 CONFIG_MLX5_CORE_EN=y
 CONFIG_QCOM_EMAC=m
 CONFIG_RMNET=m
+CONFIG_R8169=m
 CONFIG_SH_ETH=y
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
-- 
2.33.1

