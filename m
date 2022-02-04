Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EC74AA3BB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359233AbiBDW6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:58:08 -0500
Received: from mout.perfora.net ([74.208.4.196]:53461 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357590AbiBDW57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:57:59 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MLePl-1nGON03EvL-000vh3;
 Fri, 04 Feb 2022 23:57:38 +0100
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
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/12] arm64: defconfig: enable pcieaer configuration
Date:   Fri,  4 Feb 2022 23:56:57 +0100
Message-Id: <20220204225706.1539818-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220204225706.1539818-1-marcel@ziswiler.com>
References: <20220204225706.1539818-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UqanT1xaP8eMN9abmstxaVMuP7QX9mmZ7BxlvfMxzR4u/AmTumJ
 13B1EVeRK7eWV4h5w59QFHwFc+mpVBKrJYSssUR4fhbhsHlPyNt7Z6KSOM90h+Gt2sTesAX
 aslXjR+weryByXMQkOTcYmNIOsY0Rb+n3SjEkxGgCNMqqdaFwNIBJC3Ow+2/+h7Zu4kWU5k
 dpSRv+EKs22WSB4JmPVcQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I7aHHXsVS08=:oCexXDroam+tVDSuOfkycC
 K+udiCEZ92C3eqnRNIRgvHv5V5JhJz2Hy6KENWo0rR8o0BNGkQDd4r7Wl6X/ayoW4Lw2TrDkD
 rmmfxwKh7QstU3eaNr7uvQm5lRDeWNfSHYUmpoyXBKTOQHpwmPrMsZCNjvq+geUarU+xmRyOz
 8mSsUok3mClX7QpTs1vBA16sZ11DbiRMdNxl2hkQWNjLINgfKLMwmv8IMyecIkJOneWIqMTT3
 OH3rpQkx/sbL5AE1cdgkZ0tzHnHGIh0rFtWYcU1Q2tMO4e4RCSnGQNCu2xmtlDghtDkaB8AkA
 3NfNpsmfLwWUM5XIw7kUK/phX0RbMmFc0D3aCeXIu6sd+nF6Z74ElOpHMw3AovasLEHCl51qT
 rES7NmHFZnxJ9lL+Qhtj1nrDeFlkWQeNuQTRNHsk+K3g3miuModGb0zGxlxkvl6zcDtxC0Cm9
 3iSg6oaYHTT1e7as4oFTy1syFsyRsGJoqN1qniA1/FRheY/T29IIDlOgLzJqN0PLWIDwl4CAh
 rUUhpk6zIds3kkWYklT27024ibF5n8sSoU24o2usgupkorkyc58bOjRo21NaHmbouCzIAvOtg
 De0oiVMvlz9GZEJUglVNZ76ObncpzNchz2DzevAS19rRBszrXtwvRVYHrYOk3lVaM9+cPjt+Y
 OXiwscORqi9jSZA+fwggHOLLkVNvMc4uTvfEtZEGbqOBgGV+YakG8siB8xnJ8n5cdYggL4+K9
 5AP63cEPOpv6Q+QJ
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

