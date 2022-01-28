Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9CD49FD7A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349794AbiA1QB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:01:57 -0500
Received: from mout.perfora.net ([74.208.4.194]:36251 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244755AbiA1QBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:01:55 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MDiSu-1n1xMy370w-00H9aR;
 Fri, 28 Jan 2022 17:01:31 +0100
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
Subject: [PATCH v3 03/12] arm64: defconfig: enable pcieaer configuration
Date:   Fri, 28 Jan 2022 17:00:51 +0100
Message-Id: <20220128160100.1228537-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128160100.1228537-1-marcel@ziswiler.com>
References: <20220128160100.1228537-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N4Ddk6p9Jju/5ZMnVZEmrewz96edNzoyGka9KmkzfuoRI9PhsV/
 dycttpPr89+//rydTwgnhoKXi6945kGURGFsMUExRDNpNIwV3WRK3nH4wgS9bGI7mYh4Fti
 /ccbyh+d2AT0vLmy7WLOnnAxqEN7XWlsjObDm2sw2mfFLCboYWCB/NVE9U3ZeouM0DMF/3f
 Xtwy24vvz4Aq8SgTUSEEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:v8KtjtfLk+U=:g5MYLNJQv4A4/l7Ey36ssx
 qW5k9U4P6U0l1JSX09U2/N0nvbdBa9pliq0yjFCPC9cm5uW0c+r0R55PviuuSBXv95AWRdiUA
 ltdzxsz3elkVXyUDIxmiQVfdFdDxwnUBjMnWPcmjhjL5Km71ElYz4gNpOMIFBrp+1rFuPw68w
 w4IfBDKHcut5xU/mIWhEqBFqSrE5xzpkMlHZyFV8CSt6lylJO3NetiFExMaeizb8/e/Z7x8qq
 +H82PCzL8+lA/uKDi7j7w+/trSw93nUalSzCgwgLLDzhTJ2vedqHdSZYTP3eNuNXeJd/7TGIU
 DqtroJRqJ6QbpyUfCNbxUbe8ej9vDDQ/EaL3tDNBc1LVbaOFqkewmHKlPw8joCHH+MxxCT6+Q
 VdIdGIRItRV3usP1Ms4f1D2RhVxDOHeE6nF46uw9PR/xHius82hpTajUz0x6ogl8Y+rRujkeR
 lg/bsnziP/p7uNZZebFjkmvJl4lNjMTUl1TwnWB2acZ4ZGHCO1x+XQaa+hCo0pUerLf2pnBLF
 09Zs4KiGEnjH3007jDItZk94PiOF0nfDIN+ypVSHwh4aagVcC1iwj//k1pdRxXBOEfHiFDir0
 RsM7TDFuOa5rGHAqLoCTXeYEU4/d+RbKg2CjvZTnSzzvVL/ErfKKkqD265wiAkky9NNNqqKsy
 WtLZ7KNhVYgaRDkRe6jbrIo8tsX/kwGK5cnt2EzMpoeFClLmDK0VSp+603JKcHk8Dtfk=
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

