Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DB449FD7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349866AbiA1QCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:02:15 -0500
Received: from mout.perfora.net ([74.208.4.197]:46979 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349873AbiA1QCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:02:03 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MXanQ-1miDYX42pq-00WUZr;
 Fri, 28 Jan 2022 17:01:44 +0100
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
Subject: [PATCH v3 07/12] arm64: defconfig: enable imx8m pcie phy driver
Date:   Fri, 28 Jan 2022 17:00:55 +0100
Message-Id: <20220128160100.1228537-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128160100.1228537-1-marcel@ziswiler.com>
References: <20220128160100.1228537-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qdVeKON3tDfhHPbSloapjtGC/AyacnrjYeFxYON3deJItLA+NmD
 iOiDgksmRjp0Vn66F87GkrmFGKN5q+A2V6MQeTf4FlHuGTo/GemD9gol5h3tHqR8pF4uorj
 j/GPL8HJoGECshia9RhqrWBZAmwPHGEQli4mPz1fUuxy6Idgf0/02KjOpfCTuIHRjlEYa0A
 llrlgAHIZ1xqqTTI2/ojQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3P5/YaAgiPc=:CamSGoDhZO9mRdOcVonv57
 +7aZ1qg5+6ygdaGfDilHpdD/mEXLigpjKwNVfGGiKnGe5ufks8Pr5iO3eoa4g3PML6mx6GD37
 uBAXvHcqQIuUdNLKgSk9/JT5o0ZcZIWub7ZG3wpJAcl3ej7SrK/n1+Iv+zYd3AJwfC3z9wL5F
 D93R9L27i1vkLQ8ez034aycMjMjlLr54FKHJQ+U9mZaze0Ec9X6b+OzIR1ynmIbg6JBWZJ3dU
 kJivKk314x0pQJEhaYOFAVYyV4Bn0VAWmDsJ+81jNfNF0pNTp3djn+hiHy8lgzGGgCuV+mtww
 EQuZo07qZ9Aox2qlx5WVUnAWpvWul6fQ5mLKYIVGXQNuLceTy2ZOHborT1+BxYYdw2byr8NS7
 ks6KZbUd2PKNmW0j7XB659KQPZgOHpDeYiFJCocxORbiAL2BqPd6BaijMnLTVUz2XUTfiBjhT
 vgI5JERXlV8N7XjILcpfvkk4yDGUF4tohTzOznCDErBnvNmtgnlJJzo5luXb0oNzRVcRuyI5+
 IVy7uBIeT21HQTDts1Rie3wnRWtbmmJ3MYGXmna3936zNU7vl8rjy4rxw2/TBwoYDyuvnTRLK
 xaW2xb1YjsPzKU3P0ozPW3FSL4DMOskJhd+FGmUp1Sn8OH/S0EhfMA7nBLrY0ixODOMbTpkzT
 145F912CH03SkrEprVFErmk+I3YItxD+wG0dCRB/DitltXPiwwP5eCKjhjjowczyBGK+JCjS4
 BCMY34JD5SQxImaM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This enables the i.MX 8M PCIe PHY driver (CONFIG_PHY_FSL_IMX8M_PCIE)
required for PCIe functionality.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

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

