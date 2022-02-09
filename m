Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B674AEF2D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiBIKU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiBIKUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:20:52 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BAFE08E7A5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:15:52 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mo7aJ-1o5OpV4Ayh-00pZP3;
 Wed, 09 Feb 2022 11:01:47 +0100
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
Subject: [PATCH v5 08/12] arm64: defconfig: build imx-sdma as a module
Date:   Wed,  9 Feb 2022 11:00:51 +0100
Message-Id: <20220209100055.181389-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220209100055.181389-1-marcel@ziswiler.com>
References: <20220209100055.181389-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9ic7kC5N62T8D1ZciNvAZsix7jrQDa/+Ubin8FoE6e6lzPJTQYi
 xHFFIHaf8K3ror8peOpJ0pATgs1ykurnFftdKY7MMgJIV/Wy5er+f4eVcIP53eT1dUgYN2J
 hQPx5VxpBzVPic2hV/FTwVnriWbaeU3mRVNgG2yXzqUVKBrY8YUNBFDeYDUj/58L6WOGCCM
 X/7JF2YMuQXIWQoXgRfQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hBlAXPDCYFw=:1rnBOLGEQgLf4UnMS4KU8f
 7i3Hng/0qk4pwVXhQBcEa+Ghf8HJs3OoybxEYmvBNRZ4mUBseIk+NZMGcSdA1vUQBKj9cqEhI
 8cjzWChMzr5vFItx9tZwrQXODmZdHck/XpYH/IOZzYQ1y2BrMqed5dOsyuRFHAbbI9WgVmkVx
 4N5z6xolj4grQVH5/bQafnnpq9IUnHQYKVNGCy9af2FUN7rNbZb+IgeLfmj3pdazUP3Iblbej
 ZkY7bxqkYOrLrSU5XKcL/maAczO2LodkOQYUeOT3xzs7ftETG9JYszmM8UdQDbUqUZpWqYIQ7
 /JcieSSY5lj+Wc8QAqqN0de8BimYjDg2eZ3jhN6DCVRRYl213A/BN0pSdgDRV9YkYxys8z7KP
 n/9Pa0NrwF7jk1FvMrYmlW/ve4Aua2yNKFHUJ/uh2Njjg7RmuNFoanjS5NXvMCfyrwRJF79U9
 0lx7oLm61/V6mn4GKZAO3GoXE4vyIvd+n+O2oNFmL3bpraDrLytGvL2Qpc4snDHZFGgdq8UA9
 Xz4HV0Wk+ZOVjh2q28Vo2gP7WW0fhiMdHrobouhXd4Ap3C685ixzj3Eu/VRhNtomX4gD9vg0e
 D7aC+D4BHJRONVUvIRrrtIXV+XSJuRSYo+I/66py0ewGciCmUkFfQy94XmK2Xs1PFeJPkR6Ku
 dSE0fCvQtr2v+kiIry6lnkWI4g1Yq5izaRtU+F3gjADHsSTcoLuuMdCc0V4F+fVeeAmeHtVoG
 +YJYz5xfEK5ftIzbsoe7p1W6KWfsbeG1CYndfM15w8CWTsoQ6ZVkUORL8yvTp4PQ3k8gZDbcW
 gFu9JfEtNXgJM7yufoAbQP7oS4eDg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

