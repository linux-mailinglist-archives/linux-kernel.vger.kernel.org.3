Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A999C4AA3BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357625AbiBDW57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:57:59 -0500
Received: from mout.perfora.net ([74.208.4.196]:37359 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356908AbiBDW5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:57:55 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M91ND-1n3hKN3LKP-00CSIJ;
 Fri, 04 Feb 2022 23:57:35 +0100
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
Subject: [PATCH v4 02/12] arm64: defconfig: enable taskstats configuration
Date:   Fri,  4 Feb 2022 23:56:56 +0100
Message-Id: <20220204225706.1539818-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220204225706.1539818-1-marcel@ziswiler.com>
References: <20220204225706.1539818-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nTfj0kNp5rIuIemip80qCEYFOUF1su4lDCnoMhqAm9p20XTGSlI
 fU39XDeelP93yF3fm9zIo4RTJ7WIwx20xLMDyEyqoZJWHvGP9syufazKDXuYrdsBmb8mzfO
 u8egpt9/jHnutdMPeo0nVGRiBtqIpRYBIHTzABniBAOVGtusz23hkAJ7mpj0U6bJVBLixbp
 rkA5uDDLgLeOrJuEGOnzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FAQyr4LTaqg=:oo2Xj0Ai0VbTYxASeV29xD
 KWrgKIqnS9+f4tvGPltn7pD8zDHcvRRTaQ986+8WFM+3V7EDuco5wHFEHXmbLgXDH0QUNzCGE
 sfK3sGNbwcq5KG0fJUTdcQYAEreDDm2+2x4hiEo17kbwwOZF3D4+GRvggkXRmApxgB0jItXjn
 grWlPYv+fK4C0m6I/0aoGaRwuWSJyI+/vo3pAKAn6HUtsVIXo4VxdcYACpvtY0KZGmddQCQMh
 nVciJWfxZeJX70RExvcjDUOkWSvvscNNON7AyPmDRFAqScMMNd7sBdT0SgggGiz14+6+KVsDB
 PR31W87ePw/AAkmFI/2ptQi/bjCn6WO9ge62kJTrCQZsSwAp2WEkx6eAALeE44JKsvu82Wkqn
 94Ff9hrisfRbS7tIN7lyCBNH0SBs9mhVjtJ38TMN/NZ3ZdhD1g9wuglbdg40DTSMHUiYKzd9U
 k2Rb0qS68zfPm4HySw/XtQ8x4XLRgCVPLPecz/lMrYwmf0kyTKaDbbgIXcdlYt7Cct5Yvueg7
 MZV5qgaaSHMYeeIlDmmYw9781aeksrcRQkKxiLruF6jQtazfzfLIRK3wjyjs8aTWmuOWSeY/W
 Iqm3vaJ0AIK9x2rij2M6mDnWWH36vnpdjhtC5xq7A2hVm0aTqrY+t9dyFMk7L2CE2+/JU0XTh
 P3KtLq6r/kUEJlXTAC12L/oUh7BYSH+YrLV6iqq2y8q+m8PxRoWyP5H3Bo6kOaFYudqaGooRq
 PAnAynwNMbw+Cehc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable CONFIG_TASKSTATS which is required for CONFIG_TASK_XACCT (and
subsequently CONFIG_TASK_IO_ACCOUNTING). Previously, taskstats got
pulled in by KVM but that got changed in commit 63b3f96e1a98
("kvm: Select SCHED_INFO instead of TASK_DELAY_ACCT").

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
index 30516dc0b70e..b057b08c0fc2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -7,6 +7,7 @@ CONFIG_PREEMPT=y
 CONFIG_IRQ_TIME_ACCOUNTING=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_TASKSTATS=y
 CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_IKCONFIG=y
-- 
2.33.1

