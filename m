Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506F3487BC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348776AbiAGSEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:04:51 -0500
Received: from mout.perfora.net ([74.208.4.196]:59605 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348765AbiAGSEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:41 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MAftU-1nCXQi2jZA-00B19H;
 Fri, 07 Jan 2022 19:04:21 +0100
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
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/14] arm64: defconfig: build nuvoton nau8822 as module
Date:   Fri,  7 Jan 2022 19:03:12 +0100
Message-Id: <20220107180314.1816515-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RglWCQL/ycUWyK+EpYkHFPQu6qaub6+P0Mf8rU0Pw4AWhXkEkM/
 uXmNufRiXy5Lyhd7XJcC46n1iVsonv8BMNAwXtfbC7zlKwzYeKk9WVNDYl6zECduLoVP7BS
 PUB821Ai7Sm1Q4hBHUdpOREj/VnQ8GxEYvp2FOpp/hR8K9KtxQANbN/rlywd22I+/UbwQpx
 8+SAgKpTf/Xgb0R9kYkHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vcXZeGr1upk=:O+23h08cI1MSbpJ3GwmgF6
 BtQkSO99Wa9W2EBjGTnJJF/kwMT/M3S1VNUn/idvvdg1KvdLPl2aVEnFKb0eCMEm/3EwyG0CO
 kLPb7u8+SmgPE3SZd1TeKJdDXWiRA2n//n6EWD6wxuFZqkSQK2uWe0TqJx5+M7auiBB8JnVr5
 H8gHkm6kXqnv1tdSB6JL4sBZzlXqUVOrU9nSVba9lYjS5HR+Xs9dDx/mJjMDs9xiFkcMwJ3pp
 ekPkCSdImrBrFh4dheQRPkv0OzPFbbm6ftz3AI/aSX2nNau8MalQIsz5NzcXs4A5N2qJM9d1V
 YM4XBV61y5rEc11mRuBSQbeLDAiZGhDQwj1yi2BJI5gtDCi8DAMlAw1PkcLo2CD+pqzrSAqOd
 FwJ4Tq/PxFx7MWez14sGBZ/PSv/wuVIQV0x/RNtssDDSNsCotHo8ZnsBUGj9PaMWTFql/GqA6
 fHICld6gOANSmo1FIVgf/G+wyYnoAzOWVudeJpReFQxYlITeIXLq62K66RDont/w8dlDI1O9p
 epQSpDTEqy1QXoW0K9H3miMh5LlZrubAFPKJ3tlWoDSZ5DtNDusp+GHLbI81ayGtFGtTrui1Y
 vultvU0pqKosD4m1CEii89ixG0kPFoUCdkw2t1wAW5f86yXDfgqkNRjTkUNw8q+8p+W9lUXvf
 CAGEkPbL+PmJYXgoQmDBi2nqeyv5fAbdqrk9jTw8uMfdaGT11YaWJ2jz7NfPFpf1C9mmfPdIR
 v7tSeDgxz1/av4w/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build Nuvoton NAU8822 sound SoC driver as a module.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fe4da2a167ff..c6140cdd461c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -789,6 +789,7 @@ CONFIG_SND_SOC_WM8960=m
 CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SOC_WM8978=m
 CONFIG_SND_SOC_WSA881X=m
+CONFIG_SND_SOC_NAU8822=m
 CONFIG_SND_SOC_LPASS_WSA_MACRO=m
 CONFIG_SND_SOC_LPASS_VA_MACRO=m
 CONFIG_SND_SIMPLE_CARD=m
-- 
2.33.1

