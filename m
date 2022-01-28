Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D122649FD7E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349812AbiA1QCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:02:18 -0500
Received: from mout.perfora.net ([74.208.4.197]:44835 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349888AbiA1QCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:02:07 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M0wfZ-1mOp2w36qt-00v4xC;
 Fri, 28 Jan 2022 17:01:50 +0100
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
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/12] arm64: defconfig: build r8169 as a module
Date:   Fri, 28 Jan 2022 17:00:57 +0100
Message-Id: <20220128160100.1228537-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128160100.1228537-1-marcel@ziswiler.com>
References: <20220128160100.1228537-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:M7fbjrxAKGY4O1Oz+P2Ij7tZXUeGkAUVssV7pnqXwjC0dd8siAc
 vkZfkiSkY5L+P55064ciuvRbvZFcJhxZ+nJ+MErQiKRbeW/OwQwWe/KbuUGsfPHlBinkwxc
 RqWtIrQTn6z1wj9Bi4kRzQvTzg6T89ajMFvRt4LIVo6X2sHhAj2YPreTNJl/bJUF2zJzAiD
 nvpMtffVgCslC7laZvtxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oSzgZR/aXrY=:XBs+Uw7emkQXAJM2AVFMsZ
 FH9rgXF9OD71eRmfCyAa5AfP3VWGVcQlcsqO5KAtv+++zJqglzgmaDCdktO/CfAqIj6xD3ZZu
 ExqC9YRaSpLQNF2qb5FqiHl01C4coouD6PzQhq8szGfhdpfFBlDytRSaV2qY7SlsS1WgtqP9m
 dYVkTWHEJdAyzW5SRPCuRWSBZmmDr80GRHzFahc+hUx3YYq14KDIcsRVL2KXgMGDMEPk5UURi
 0DuyrRrI1TvELcpzFDbCtzL7TTuwZpkWysXaqZCqmc/wPbxf9tHkNNhxRfpaBKgWTzH4lTrGl
 PETKs+3qnH3FBPTdhG5FIi8pbBB2AgAnwGUWwb4/tG6AAz94LBjMkfefrNd80ardzBn6DK/Rg
 OHRFBsMH7LhBBjjXHKOWCpxC1+SUdtQV5xEpRnbKcFu9aTusrWy9r8NMgt0NnRKg8IIjUO4cd
 FJfeDgHrDNR6uXdLPWGMSsIGdJ+Y32bCEw0TEz6wPq09gsxQkOtuFOIjya/XSf1ELn8D4GfO/
 9obWgQSSLshuhfrh1H1OEQJ8+NSs+gq06KOodAl1VuD7Bc1z0qz8Tn3WJ5dWaR9KOR8nq7Z1b
 8Df/qfQ7sk27eYO1TZPFBq/95A1M466gkLuEUHuYR8iwGPwGFhWDMfZZUgZwa38+wqQ7x57ah
 SeCzhwBEvYGJm/Hgvct92DqoWBeEG+mfLE5pPlSg4PXbZhdtAp1+5TrCr86JaOBw+H7YUqoHG
 /BCTufDt48sFxh2N
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

