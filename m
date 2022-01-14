Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D448EB6E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241574AbiANOQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:16:21 -0500
Received: from mout.perfora.net ([74.208.4.197]:33835 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241523AbiANOQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:16:11 -0500
Received: from localhost.localdomain ([81.221.144.115]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M07WU-1mKoYK32Bo-00uIey;
 Fri, 14 Jan 2022 15:15:49 +0100
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
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] arm64: defconfig: build imx-sdma as a module
Date:   Fri, 14 Jan 2022 15:15:03 +0100
Message-Id: <20220114141507.395271-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220114141507.395271-1-marcel@ziswiler.com>
References: <20220114141507.395271-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IWfyprK7dIRVwplw/Wn+YVTSDILM+Hjtll4N94MsUR8+v8WnXjC
 VUW7Z//z5cYex6i7y8xnMNcjtc8DZWCdjHiQGVT2r3oODOI32w6/JmJk5W00PEXgRQzuApY
 IVdeQzt8jA4TFAOd+Dp8BG55Jys/BDb0j8gOOOxdLKf9EJN0en5lvWM3O+YodpJeOcNmDyX
 a3G3sgNbGUXgmHsqGeshA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xSNnQfjSrrw=:2dyH8HATRUqiwbyj08up9w
 AJpn+tRnK8PzDU2qBsGMEPfmMPZmaWRwxQAGWK/SvxLZNJAqu+pA0D9n+/mJYcIJRvoi96/w2
 zSTHY28H9gD9QP77ohfVV0LEiftm+mikLzoTYrivtf8MTJAIYDIt098uSDdi1MsOzYbv38OP1
 5F2Ebj8pqhNE8pQrMOvxgjJCDBbHpibwo63Ei6p9H/1/qnchDFn3wTYjsytwK6OE50MfXdLtw
 cuatb7/iDmmVU22oqxBdZ808pSA+TZojQK72hBGrcQ2vFE3aMedKOncCw1wTgoeySPeH5A9K6
 mMeu3aPtlGORdcfbhe2IchmEPj4/kJTUVGVeUt/aJhafZn5khx+5S1RcKvNQte+r4qw+cqQMW
 vtwER565UC4renL/pWEtkiV039Zz2dJMhATMPjsBJDrPucT8MjTiGjXEApwZGuL9VpFJPWDNR
 Bq74wjtpTByoxg+WIKgm1WnJyAE5dC0V2eGEnpy+uirRm2S1Bx/oU4SP7odGSNCy/l40O7VjA
 a3k7XDkW3rQI2Xc67gIykWr/QR/DJrTKCSWFZH1ikt3M/VhB9am0Cscru/xc2kUNZblQn/8+G
 Dfd7YsfYbQNkASrExKQwd8IX+uM9xvrqRQCdmP3fKFZWYj0TwzLDQlK/lAVg21rGwJHFrVYZp
 yreIr6+Onag/EH6Xg4VjH6wlszu297Q2B3qSBglcMVM2HVoTNgwPKHAnKwcFlEouqmKCB5nKZ
 zi+JVIg3DOe3MTUg
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

Changes in v2:
- A similar change got accepted for imx_v6_v7_defconfig. Further
discussion may be found in [1].
[1] https://lore.kernel.org/lkml/20210920144938.314588-6-marcel@ziswiler.com/

 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 872b38613c6c..3d200a149a88 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -927,7 +927,7 @@ CONFIG_DMADEVICES=y
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

