Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838114B21BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348574AbiBKJYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:24:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348551AbiBKJY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:24:28 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3061086
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:24:24 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MVw6g-1npUh631po-00X1WO;
 Fri, 11 Feb 2022 10:24:09 +0100
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
Subject: [PATCH v6 07/12] arm64: defconfig: enable imx8m pcie phy driver
Date:   Fri, 11 Feb 2022 10:23:17 +0100
Message-Id: <20220211092322.287487-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220211092322.287487-1-marcel@ziswiler.com>
References: <20220211092322.287487-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lZM0zeaEIt7IwE3AgtWxZuFrJajI1rhw1So25fjxE3pROObSXug
 Z6QJAy7H4f9Ecuyg8H3SOHibJ+lZroOTI4HnOjjugmYm6a4CINVvitMJjqHN/n40TG7pHeJ
 qkHkco/eXi6FNxdc9Two3VI2NNnIG0p7CTT9HDastDcjtLR6EZ1RPzrRv4TJTWB7RpIyMu9
 t8gf4Ia3reA3HYfyfGwXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vOqwhe2kVik=:Km6AHcqmlqc9U0BWGaove2
 SwMwLc81oIT346Cxpw41ohH2CY9Nk+63VfqQ7dyevcyCRPIT+zrxpw6WMgnp6IyOvJG/yDd/s
 eogBn0E9UMU6sil4kaRTCXdqV/nMEwBb7dGG7rFLpvy1GQb8Hkt6c0jk1X2jygoQMA32EAqvj
 segrnK1Ue0SqpYTWMj2tUUukNrDc5Wv2nc6EXxwJ4GFdt8xaFJARPwgyV+2+EjKRW3Oby+/Fn
 ieDFnoFd1+hPLpr31Pb1fbjQkmtB/KJyPbCGdImTyzT2Xcmp7oPRRSQI9gyKoKuyNb1D37ZWp
 f9CJr8ELk0fajMGmT7p3nEiQ+XtLFLRpmy9RYwtsQHFudx/BUU0TjllxLzlehHjiIM2u3MTsR
 SxJ/YE3tZ1qK2unrmxTZxc/KFHnp+009cbwkzIjc3411F34B5PmZ9IWceuLV+0lNIv+Wm8V0h
 jS0Z/1+34lJyIXlDTFpTcpClJ4PLwRwuzdIs2GGJCD47cSW6PUMFR89+7gEPddMpTt7rSGP66
 lGRwBiNMG2aZBgkV2P19KOaeYYILBoOLyybRC8tXBQIqaYa+pr6JvLh8eKxo0QHMsXZ6NeI8o
 CoICM4h1wnnOGi6H72zhVROqDadX1wZb8ooMx4xJQPIlSajiRqnKSeUoJtLGxZUKGlo9ED9Db
 +mbvOlMCqZQTPcYRkfMu+jpwjeeV4xqLIL7Q7tl62+S7RHqK1ixIUdKipwWNW5g9QKLxwS3Sj
 SfTXrXjYd7bv90Os
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

