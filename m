Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BAA4AEF21
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiBIKRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiBIKRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:17:46 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0966FE0497A0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:13:32 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MIxeQ-1nb4A344ks-00KTo4;
 Wed, 09 Feb 2022 11:01:50 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
Subject: [PATCH v5 09/12] arm64: defconfig: build r8169 as a module
Date:   Wed,  9 Feb 2022 11:00:52 +0100
Message-Id: <20220209100055.181389-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220209100055.181389-1-marcel@ziswiler.com>
References: <20220209100055.181389-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zca5Ikn+zSTc0G04hEpk0h1B3qaKVnnooqQMUOAa1KckuGcu7lO
 3bKM0SlaI3YHnkvHVkj1iX8PoJKewteaHVRde4AVVkfjZPj9JwFon+T4jNIUO9A/CHAsSWK
 3GBSaYF4DWT7DGClM71AD2CQspSGaGyfdAIZUBeuQOKztX6rEtAOLcc4e7qSA/sy8LsFZAx
 3f3FuIys0px05z0i2qtTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m91hP4wkmAA=:0DIAMEQwN88GFQTxoZOe/2
 D/Z2J1ellX3CPspjtKIOlviyYShtSNY8kzDsZ1+v8uX3HdfSXfjuAJt2GXKpMBA3hexKCMLWL
 mZhDVeQDqGg0WAVlp9yitEigweMoa16DRLUpZ1BaGBjOPv+N9R+EkmYcbTE/jsHH61fy4Y/13
 5UDodxm5dEwJwBQn5zJEGGDzhoODhLZquiKmEIxQr7kecZM7/5Ux8alqF6Oxjv/pml0oIc+Ya
 jMnDny+iKfFMGnt0Lj9HNhyLgu2Kn7wFY8km1He/9v64JacfFfP/NKmWDZPmTX2d7FXNaY0k8
 dB2snYGgW0FQh3ThTOBrPK4cqiABNoZN4ZKJ3WR/jYXEnJjVVrZSu+5+BXZXikh04WNHv48iI
 fN5Tku76t3R171GCDJ2ag+N+SSJkvVKV6F9E8//l+NsDFo5n9w2Zf76LdJHziybqJCubXonlr
 3oKEgXe+YcIAzX2Dmvua/LF16gvaZvWfjFfq28VNfhlvpoQo7tuZE+ptd2+NXYl3EaSeXdlRg
 W+eN64/vMxEUjxKAE/TA4AWp6ikeADbSy/P7H6nIaX+7amaelevvlQCkc4+M4l5GO9JOmcMDM
 W/wRrVmrl/vcFjX+BBt7eX4xekV5GOK3yvG06yr9vOfkUXvAGe0+k1wfenJ2BRsdOUXUGqM9T
 fKiuOOEx/3nSWCWO4gWnAzpj8KZzgQjRUVW4jzn0ecZq2i4H2q04iz/9QdFbFcp8LtZDqeCbZ
 4x64jnU3YgW1ez4I5nxRKDdcAD4nHPUoZOXkHv2/E5Nqb93eQO3Z2GmEgug5ycTp2HWucSlCx
 ceFPCqv+Y8i3YocqkJr17YQD7YSNQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

