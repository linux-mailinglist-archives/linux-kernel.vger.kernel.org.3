Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9563A4AEFF4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiBIL3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiBIL3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:29:22 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5D7E0987D4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:22:47 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MZkUt-1nmu571sm7-00WnbF;
 Wed, 09 Feb 2022 11:01:30 +0100
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
Subject: [PATCH v5 03/12] arm64: defconfig: enable pcieaer configuration
Date:   Wed,  9 Feb 2022 11:00:46 +0100
Message-Id: <20220209100055.181389-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220209100055.181389-1-marcel@ziswiler.com>
References: <20220209100055.181389-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ImXBglx5IJOFnqXkkH0uWKtrW4VUbDcr2vn403khVMa1OrPD/FZ
 AXJrnJHGms3H1QlJAK8imEw9mcltPgWEMpk9b/fJtytCREbH+CjyX/0NI8knjfiMvcGmFTU
 Pu1kP6VncsgvzSTway6j9pzvf5KCBaroWrpKGAjFXDjRc4BiROTbfrcHxS54Di18Kv7Z/23
 kAOnAmeYkrDX858rRlNVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3K+ObxKopuw=:47XH1pwFP2sRRj4TyJlQ0u
 mz4O22uas/EkSVMqUWXJC9cBYI7dJAG5QDXmvqQ2tygAXMQSXi1yhrsUspt9CSifBsD2mGru1
 T2wjxGe4yaNym91tqBSFQJSNm/i1lOWFKPnF6SFuX4VFe7MeYtLalFI73tdEWxdaPL260xFzj
 4Zui/xt84kSH1ubxkuHa5XViYxJ2v/KXtVMKzu9v/1QbCf8OQ5ZA+ek+2dbQBOfIj967cXnUE
 Mv6V39ICeC/1zBbcKy2USP2g6a4NyOs8M6zBNYwnFCguocwFvhBd4GtNkE4Dnl1t8iX3PnG+T
 JhupkhYIJ66ukdgoCI+7L1nK5TN9zQI5+KO21clwlqvDQ01bjJLpQA4vfOcH4l0ZiPtj/6m0O
 WkQaAwmZk9pOd6VZ35+ZOc5YHnl9Nz17ZQe6PalV9BzUfnV0V1kTiM5RuU7l/+75Tr70Ed5hA
 bzNJkZkg1Xf87DpUusnaVf1wQU5uzwHjOYnjKf43d0gmAEB/iVKgrAklRn6sUQNiaMQNaMhKm
 3MRfvAlatgt1xCfxH5cy9vzj+u2wctYYmXGKtBaO3vHvLPjDjC3EWgkqnAat6YnwgBM9KJior
 PQBmR7kTr6zKGYpXyo+ov3VxTAUKjkDrGQFtam4qThQyAsME19qXTb+qsp1P46cRbA0DfXzzU
 QN6MX0H2d9OxApTo/hq+KIeAdxhCMsNREvCqxCOnFnRMxEQkYlybdtpcqWBF2BfaFKo21LVcU
 mUmc91Wo8cdXUJuQ1F8SvlOHdInywXwIW+HITvcQYl8+LSYoj2I+LiylUW0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable CONFIG_PCIEAER which is required for CONFIG_ACPI_APEI_PCIEAER.
Commit 8c8ff55b4da7 ("PCI/AER: Don't select CONFIG_PCIEAER by default")
changed it to no longer being enabled by default.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

(no changes since v3)

Changes in v3:
- Add Krzysztof's reviewed-by tag.

Changes in v2:
- New patch following full defconfig analysis as requested by Krzysztof.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b057b08c0fc2..c37dace3e89d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -211,6 +211,7 @@ CONFIG_NFC_NCI=m
 CONFIG_NFC_S3FWRN5_I2C=m
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
+CONFIG_PCIEAER=y
 CONFIG_PCI_IOV=y
 CONFIG_PCI_PASID=y
 CONFIG_HOTPLUG_PCI=y
-- 
2.33.1

