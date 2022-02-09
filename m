Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C714AEF2E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiBIKVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiBIKVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:21:24 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDFCE08E798
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:15:51 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MMX5X-1nZgaN0dVf-00JeSf;
 Wed, 09 Feb 2022 11:01:44 +0100
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
Subject: [PATCH v5 07/12] arm64: defconfig: enable imx8m pcie phy driver
Date:   Wed,  9 Feb 2022 11:00:50 +0100
Message-Id: <20220209100055.181389-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220209100055.181389-1-marcel@ziswiler.com>
References: <20220209100055.181389-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:b8SxDQe9Yb+nS3ipl49PK5HYshZb8p5+G1Rd2UQm9N7ousmmQ2g
 LRG+Upfp1tpC3xqPuysmqDGep2HL1khFHOCJHbIplt9mKpKOOygNFfFelL1Chqa5HawjDzh
 1zV6N+2J6ZK3NqxLy0sBQkwZkg0tN/0bCBaAkCiiYjvO0SZbW9ozndIzlW/e9l0q3byMGoZ
 iXP4DdpiKmaWAQfoVPVyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hBcK5ZOCS4k=:hq0GLYH8hEm4hucAtivki7
 PE6YnXKhaAG9BaHC7OG93baGW0Pa2Wo6eWMVfuAqv9Z7ocWRMV/qLNwSmDCybE2OLcCNOs61A
 BBUlwxhl+BZv7jcLLQOS0crOJ597Wh0qWyRq8JbYI67VEqFHFDK/bjmZbuSmuPKFbtYUjrbZO
 +puGt9xnSYKWHEGMqn/FDPmfOWmVlXO/qFJ7DLzvcrsuooznXh+bo7ICeFvGoJOUpskt2lDyw
 b5i5mFphva+OUEfyYyNLNEYz9HWByBt2R9DZFuHmbJX/m6y3e8lC8LzYIVXNc8G1BvyVbo/08
 r2Ec/o6YUnBbvebFhQrSOJtKPPp8047dvXvgzLYVKpTdaGthSg2mHkYi3BSrfVrSqrndGLQHz
 59VT4RNmyjIA9CUMZ775+3QwCtCPWy2WzcWidVfhSLmXNvGHhFCyvBm5IFS3Pz2aWXlJSkBk0
 SwyiNUOBHsh9DW7oDOfQQJHlu+1KYxJDYSsfIuXScLebskfuCzKBhub/xNzr7Uoiwa1cJJA3S
 EZEzOzFGyVWPUc8chsRKsQuEg1VV1DBqhXTUiU+30z/7MUn6LQ7EQ9CgRGBMox2QjIZ3njMfI
 5sttxDrBiR0T+7eVkqDaSg7YJMRA0NgX4dJfZppurlw8j91RE1hSDxmZcP2CigjzoWV9kOim8
 4NnnUFmecq5tPtzMkUBkMlfBqEK06QrK+/DbIcdVql6Eroepy+5jY/U1d2+wuwQnBhldqKDrF
 ld4l7ALV4Fc8reNeszR3ViucebvPTY+kqbEreEeHA0hrnZixg54oHHF3TNUabRu80pGdIdeGp
 aoHI1Kr/af7eN2FgBOxLGJP363p6A==
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

