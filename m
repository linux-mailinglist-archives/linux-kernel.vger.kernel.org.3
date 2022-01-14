Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2EE48EB66
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbiANOP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:15:59 -0500
Received: from mout.perfora.net ([74.208.4.197]:51671 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241454AbiANOP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:15:58 -0500
Received: from localhost.localdomain ([81.221.144.115]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MStu7-1mitu345cz-00RnWn;
 Fri, 14 Jan 2022 15:15:39 +0100
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
Subject: [PATCH v2 04/11] arm64: defconfig: enable pcieaer configuration
Date:   Fri, 14 Jan 2022 15:15:00 +0100
Message-Id: <20220114141507.395271-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220114141507.395271-1-marcel@ziswiler.com>
References: <20220114141507.395271-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZEgfcZo7BP3gaPpucSPM3d+cRtxRR94tlwZBOr5jNpfLM1g69os
 zP7qIDUM/ofV3aHRv/WOhHLLLwJSOKg56XC5wk3EXkNQo3rPISqENgy5+dJrnCyUDxuCG/x
 A2+Djon9KX8/SdVI80RnxlexxGbV8dLHUB+gzjvBNssiZOU0mB/LvbjvO9m8Ul7wPMjVzGw
 PPnzlMw1q/A1WaHoxg2CA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ob6a+xxIvtU=:enGOaLwNztFY9P8UL04Buj
 gxyXX3l9/W1s09OnRxBPwT1JOOOXs/TxrzHFGT6raH8/vTMgafuuE/yallGhWpERdOrgiYkOM
 00V84fRivTLTxQtrEFWEvPkc10wnAM36nScdSfQlKPl9qxpdoT9iUAY8/33dOKoPGTRJ+zYpZ
 ZKIf1Aq4p+QvHZyVNkHhhkSQS36ZysfX2JkNB1Lv6vNsDMc6cXZ7FK+y/AShNFhjpX24rnnBM
 o/5xXVXM40ZxropsM4HWMvX8tgUG082mWs0lL5iLmcaVZO7/IyjirLEL6XE1zEGJjU906vmDq
 PzQWqeOJXxrWSGJr1A8HNqgIoMKvTeTgNkTYndI66sCbCibZB8LKbx5mTePotKLgXWlnFs88Y
 GFmoVNGxVVOBqNhKzwowVMY+GYSWSH9GKUPypfCRqE3kzKbniUfpa5HN4dXjI66fm8hGp5iCL
 tLXSvXgdo/etO/47tsidKLJxY4mh3ee7/cwIXo4uAzO77QwAeMwrFBx7GnkXdIyk9fx7GGEKB
 JcvTs04c1AeFaJlFohdUorZfXd6TE3tJxvUa5eD3kwauk7IeV2kdMF5dwWJZbIAXS1/BT4YRs
 OBmV2/0xh1lG+LgM5LsEYI+IS80UIQwqHQFsCI2F6XRGqq84HDJplIWUR6qXfVqRD8Mzs/CH5
 qsPnHUzeFw8fpyvCrnwkNs2WQgy9ruOi/KvGFKuDXz4auiegS+w3tJt1cI0CsrC/aOUJtNgzb
 g+pBykIF7/cEyTNW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable CONFIG_PCIEAER which is required for CONFIG_ACPI_APEI_PCIEAER.
Commit 8c8ff55b4da7 ("PCI/AER: Don't select CONFIG_PCIEAER by default")
changed it to no longer being enabled by default.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch following full defconfig analysis as requested by Krzysztof.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dec189229c0a..7daf2de6c31a 100644
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

