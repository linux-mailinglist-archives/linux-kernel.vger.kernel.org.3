Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2F34B21C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348585AbiBKJYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:24:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346096AbiBKJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:24:29 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7EB108E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:24:27 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MJijq-1nHMER2KBQ-001Ctk;
 Fri, 11 Feb 2022 10:24:12 +0100
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
Subject: [PATCH v6 08/12] arm64: defconfig: build imx-sdma as a module
Date:   Fri, 11 Feb 2022 10:23:18 +0100
Message-Id: <20220211092322.287487-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220211092322.287487-1-marcel@ziswiler.com>
References: <20220211092322.287487-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:x9c4gjh9hHYAgSeII/gObDvEv4qoJIF6+WGaPRpcrk0BYX1pwHc
 SLxsOL1aQQ6w+oeCEfBZomqHBuzomc8C5psrx1V7WhSTSZL4mM5+vLbRmEhgBIDIgfDctTG
 7xQQJsPoNAvQIdK01apJ7chjTT22bGl1zPQSkM1V84QQsDFlc+WIQ7LkhxtZB4gaBrshr3+
 sWVpMQzJe0j0wmhwsQQNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sLUHNjBeOMo=:Ap8RGDA8peacWxxEcKMjzy
 2fLx173lG3ddivX+CoI1UQt09gbCn9HSIgNPp2Q3KpXUkF1JzKJNEMJ8sqxCbJCcY426LVPVP
 t6gfKrTMNAiKezVriFWLxdee2cpNA0Rr/gLvnSDlNPeGox0ZleB6L7YvbYvEMtfCp+t8f40dw
 /5nJBEtMETxZkDAwI6Hx0w1UZLebifS94HuJrKv63bByeNIxk2ELyp62Qxn0vEW2I0WMkSuZZ
 zrMCX5OcbWd80EPiDxDzga33FcF72ddMkhfRy3Lufv3iRQ3XUDPAu2X3ZnAFQhSuY8jx5c1dB
 eNUAm9FXr8+PN0plZVGojZho/3qOL5TLtohf/e98dNQTAwZNWEVTtIEuhs4OnKPr7oYV8HZMI
 jW2vZPVONqu8qRkoyvR4SJESfn7SYMxcGaJTpsxFupiesC4NNDKqw5CbrI0BJnreFrgeJ+lVJ
 cvNf4XdMs4WyXocaH0eWFTf1W24K19cRa9cZzcdVHxulSjLSMAqD5h25yydjtzng6nCA27XsX
 h/rG7mE2SujJBQPcDYFmjMjwFvCxPH8bniAOc3EOhaZxYFRWrZf1BIaBRNzHJ+YAgz95rApxO
 hzsHJYDnpmZUme31m6mifJAIQgbmLyoDL1Gpx4iUYIzN358Oofr8IZb6+5g6WIdCJA5+ZJPoA
 ZEWurOSV1eqQfrVVLzb2oLk+FkRLPOVYuS6J0glitGXXhmUEq6svqH6fyAzPoVn7MJe3ds2tF
 axFa7qh59CLmQeax
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

