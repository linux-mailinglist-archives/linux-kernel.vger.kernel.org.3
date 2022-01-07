Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD61487BC4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348752AbiAGSEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:04:49 -0500
Received: from mout.perfora.net ([74.208.4.197]:38061 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348722AbiAGSEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:33 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1N0WTY-1mBkfS2l8u-00wY9n;
 Fri, 07 Jan 2022 19:04:15 +0100
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
Subject: [PATCH v1 10/14] arm64: defconfig: build sdio mwifiex as a module
Date:   Fri,  7 Jan 2022 19:03:10 +0100
Message-Id: <20220107180314.1816515-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dIh7h5rlN33PwA3ovKLqpk5xtrn+ocqE3Q+4F0qvAetRS7aV3gh
 T9OCbdFqFB/olMszrN5q3SIOSDLdff/h6EmZGkV1Ux0IRTBISF5CzNa3t0GTCg5ELjqQU7y
 xwYU247UtwMK047lWSmYE2hnO9BPJBnND8DznTzGLZ0mNXMZh16rwtJUbyGpSEntjJMEzjw
 n98hlRJRMht2h5h0Z5IOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hf4QyUbkLcI=:bnqA3jGG/t5smlC3SPKvSL
 MplKTCAxNX2JlnaF22ZlcYmE5WHo5Z7r0w/KWnvJOCwph9sSHlqBmBkVPKK3441IA0M72tWYB
 bKS1jh1FLkwvxFiA3f3v0fz7PW0EMlS799h8bmAjDy5RxXLD1+OG1hoH8EEfSlCo8CyHp6lm2
 mack66J/VAwRThizsv05ZlSq1F6Lv+rGNcUt8LNbRGl7uLsSbT4g3Ag9sz6EaN3HyMtPkXglC
 xrQ5Tn8XTaGMXpu6uMW7ct2OifzvIoBhwyE6u/kpYBltfrdPQ3VwRo4K7EnPMM4eip2/R+UZz
 Ravia2yyJYEJtrK6/NOh+4igAiqYeO0rJsL+FrH3c1KB7yJGhHsHwbclrAc+bFm80rh5yL6Bf
 xQhKa8P/BRebo2jsx7vO0JO1ioFKEFhtdyclMl3BG57viYWXJCr57J2dgFIbbr/bguyH/MR/z
 rp9jsiw95CRCbjVlAP5405thbu9/41MkPpsV5IiWrpCixu7BJ44MOnpj0EjZWoEw4ZSvIPB9n
 onOxhlRZi4+UjkAu1ViFtNRTM/LKbPKOy620EklAfjIm7NFb4uwN6NU3SDnife2KoXa0kD0kj
 i0U3VhMGCAdsbxHsAs4sP43huyLFRdqMl8kTK2nI6fzM/HnC6VWCTECu8p02cFZfV9lAOiMUi
 hrQ1uw1kncClZd0H0T8bspqxJ/Y6vcAGhpVj5R5TURCqdqXW8a8ZcJI7IKxzsgSIIkWA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build NXP (formerly Marvell) SDIO MWIFIEX (CONFIG_MWIFIEX_SDIO) as a
module.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 870404a1957d..cb99bd97e736 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -380,6 +380,7 @@ CONFIG_ATH10K_SNOC=m
 CONFIG_WCN36XX=m
 CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
 CONFIG_MWIFIEX_PCIE=m
 CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
-- 
2.33.1

