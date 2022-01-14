Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3643148EB6D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbiANOQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:16:14 -0500
Received: from mout.perfora.net ([74.208.4.197]:58165 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241494AbiANOQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:16:07 -0500
Received: from localhost.localdomain ([81.221.144.115]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MaHks-1mt3RX1juC-00JrRg;
 Fri, 14 Jan 2022 15:15:51 +0100
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
Subject: [PATCH v2 08/11] arm64: defconfig: build r8169 as a module
Date:   Fri, 14 Jan 2022 15:15:04 +0100
Message-Id: <20220114141507.395271-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220114141507.395271-1-marcel@ziswiler.com>
References: <20220114141507.395271-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8VK3Gn9EHQKtj0NJ9xaiS//+uovuP5rGKlLzB0vD5AVer+OIZSd
 GBOKAMlIvRrX3ZA3IBqP/VFa0OfGNL7HtK5N+VsbtEhOzNsnaVffCvLWUa14o3rTf0z153N
 31VobKDH3Qr5xRewhJXa8l01waXM5eiKnGCv8HmqX59/8P7o5t5sM/TPmD7Dpuf8nIFH+0L
 f6+48SYz3WINDD60L0T7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Auu/L54a/mM=:diuqp2BWKAzSBsD3jb0DA0
 DBi36vtNDmjVRAs9YFTSI+g1nXnVz34MIh/jZbRVJS0VlshReGHm2Ne+uQxcM7BnhPtFqs/sS
 oAV4RmsGuEYZ1HhrrhLed0apBcoHbe1Ql6bbTqqPJKmD/dxN3FTCbf35wv4Yljq4UD2DnVnB4
 1ksGttHRQ42NW+7dI0nFXNndJI8N/vA6B+S7R910ttnvMARTKjqJjWFkntbymTx+g0WSuUZQN
 19eXTuF9UiOh14M5Xvr1oOqmcPaX6X/POhRHFGvBgUDylmOHxEmTwHyo4qeDgHHW9cqQfA+Oz
 QgTo0a+ZIF9iP4Wu2p+EP4GfSNaM9IavHyWjcHChGd4DvIJ9YlbNSLBi/+INwVSGRUU6IxzzF
 Y3RcZOROcA9TgMKWowmllrIDpOm79GTmrX0ibqr/VThruSSVUGHGuTDTEDpneYCF/re+gwBaR
 sObAUxm8M+dcNvIvPcmvODQTLOBexVEo7bCUZvaYnbv22KM8WK50RExEy/BI0ISHBA4MmYoff
 ZQ+sQZe+RyqQG7lQoLBxws94ASTgd7UsQTS4mEloiB/fKAe+Yg0KlidljyMIL7F5m2EG3O2ir
 FZnMZnvR8zNliMQzU2QkOAqZ6t+afH2VfJizfcPMsuniVIIQHQQrQ9kZ5/R+VtNJFLwE9P1P5
 hdMOuOOGugmtlrPOBKRUzzHWs5ZdkT6Pqp50hFaZ+FYFDz3vj6QV/rT9b/OebgPT9WvY=
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

---

Changes in v2:
- Explain why enabling it may be a good idea as requested by Krzysztof.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3d200a149a88..f80d7fb53b7e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -338,6 +338,7 @@ CONFIG_MLX5_CORE=m
 CONFIG_MLX5_CORE_EN=y
 CONFIG_QCOM_EMAC=m
 CONFIG_RMNET=m
+CONFIG_R8169=m
 CONFIG_SH_ETH=y
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
-- 
2.33.1

