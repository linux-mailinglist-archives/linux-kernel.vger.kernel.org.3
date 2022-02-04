Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A2B4AA3C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348213AbiBDW61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:58:27 -0500
Received: from mout.perfora.net ([74.208.4.197]:40687 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358550AbiBDW6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:58:13 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MScio-1moeTV3Bx6-00RVEk;
 Fri, 04 Feb 2022 23:57:54 +0100
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/12] arm64: defconfig: build imx-sdma as a module
Date:   Fri,  4 Feb 2022 23:57:02 +0100
Message-Id: <20220204225706.1539818-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220204225706.1539818-1-marcel@ziswiler.com>
References: <20220204225706.1539818-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VfBcHa5yRHVyvGSFhHssrMxeXmRqlYuTpX+79BShxNTjTcMUNxh
 yBQSemHfzG3atTk9qwAQ99d9aLWLwjVtJGoOCTPCUOJJhLIJbJpRmnXB6Q9swkF+qFKu/Kc
 wOYUjIrADFIoiM4jjRLVqP5wcT11rXtzJfOoC7vtRyww/ykQ81eTergFvBf/JcYM0vN4LFK
 er2twwmUvyR7FW+DBIROA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lLNTMf5hoSQ=:dVwhjXTCeRhIqnhU3QOJZY
 kdZryXf09x/zW3AVADYonIgZMW4kVQ1VJM7GJE5U2oM6WadSnosuQfdVoHeSwAMjz50alKisb
 oAG1SxYPH/5x9Sz9LhVYISausi22Wd8diUpD8kelpL7WrmauB0MD3SV4tjXa+vJ8MnJ0Q1XkB
 RKzYz9V5NbsHXjYrnN2sjANREWRhQ6mKoq7f9PEQwibMPNH7cOcaBtZrJRouAqFD3khE11h7i
 /RAve9ViBNtx3keu82ynlMTEGWX3iwlG5EVdMuRmqC5h1SPcYJeIEIUF2W6mIfdiDDlEudB9B
 p8XPQJ2Yr8YeevgwtkrWFs6uY1fMUe/FA2kDq3Kdi43oS6XAMiHgGGTkqDVXXi8SJ8WjuQbY5
 9DQhHkadn74DqctPqlJGQ/uCY5pd+YIic455OpkKz3sVEZJ2UR+x05YFaOn1cnVz4P6lRtKEt
 SUtOXLXUxUG/zeK8+saCkMXsvS1k0gglm75rrucyVTk0//nFZxdC5gLThDPpAXaAZSEqfw10t
 roAMRk+mHYYxglvgFpZH/NON5oSPsYpSAk/KdLFgGEAHSkDJuyDfpYwgr5Bzn7p6YcLZaXW8I
 MYmBnp/Ph4+vBJiouXaxtN1NQV0o5drPsfC8I2mqDeyiKbe7xqIPgwGNHyCMJaWgnlSrIzEUM
 FqqMFGDwD/974EKDGLMV1XlsVgLPL0L5MdoG0uHSttWCtuZxBplDtOtat3OvfxpSjD5oFyl5s
 I1rmgRax7lWbfVAf
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

(no changes since v2)

Changes in v2:
- A similar change got accepted for imx_v6_v7_defconfig. Further
  discussion may be found in [1].
[1] https://lore.kernel.org/lkml/20210920144938.314588-6-marcel@ziswiler.com/

 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0fed8477e72e..27afe24a025a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -928,7 +928,7 @@ CONFIG_DMADEVICES=y
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

