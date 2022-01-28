Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428B449FD82
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349936AbiA1QCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:02:22 -0500
Received: from mout.perfora.net ([74.208.4.197]:49287 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349810AbiA1QCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:02:11 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LuOAL-1mDqgP3UQx-011inW;
 Fri, 28 Jan 2022 17:01:47 +0100
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
Subject: [PATCH v3 08/12] arm64: defconfig: build imx-sdma as a module
Date:   Fri, 28 Jan 2022 17:00:56 +0100
Message-Id: <20220128160100.1228537-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128160100.1228537-1-marcel@ziswiler.com>
References: <20220128160100.1228537-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VbYE3OQn9px71agU7+XX89Ux5FVPNU/QL66vC2TN6/hi7Fb+ZmX
 swCG3yfnK2aaqpKBYlklGzaXmx+GoEO/HA6rgE9Rl44h/zIiGRnOpHpqyJmRr52p8HU+Num
 fAtUJrRl4aepmedpg+V9DNa6S2v5blg0+KMWqKWxT3fhbUSIAM76SaomjG56eqj99YRxiNp
 w+X7nWF3PzN6GagljRFSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:divO/MUWwCE=:nQ3dno9ZSgQUVnwLaBPmMF
 9kNEe6w0WqTfsIfiZKUssyhTQPJLLyoYwTv6/Y35zfCfj3Rzc7lZ3E9yt/43/6WKS+TGzB0qX
 81gnDIAcbQCot966D81gGoLJw2kR6B5xaNLhGsfWq9/Uz5rkde8g148xi+zZ42YBsziVfHJXF
 eoEdetILYjZXBiJtFBtY1+Y19nl1bkjk4DS3jGmmzeifATK+L/nYfaRQ/cb6GPGQVv8XdRiww
 9eXoBzpX4vHyxFYJSo28Ohq/VraswVf/+GUw+fwDwhnNUF+g9/1CJ1Gwkf6C1Yoy5sMEnDLfA
 QwyiUoBoinf3P9tYO+iUDBqJWq4a9KnBiDoejO5ytSPSv8VhiEZds+hl1Cf98UU8M5GaNJoJ3
 8u2bWI4u/sI/pWyvR2TDuZ/DHBYM3G2gry0bpAaasY/92cZX6A/2ANm8k61TqjvOMgrJQz3lO
 IUT+o9O7ijfJ89PMo7kZ0dI3DYgCJLy+4x13pTkogHXBrAnDeO9Yn36ClbCxvv6qzg53vTUM+
 uHeLop0DsjB3ijD/6jldC8F6M5TThz/UMpshRsAXq7pRx9OKoBBWNZ0/hzCSaIvQbtwvw2bbN
 Rl0KCcVFDldZwt5ztTYAeD1/wW1YMdCgc9wKk4vezqfftpKfL5laOezHapv6l6VuPqC0SPLtw
 QR8iqff51khtJSF8wXNmVUKE+Vaw+InKH5qq/8LjXX+0UKhk8ItBJ3hqWsNXU7eLGpJQ=
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

