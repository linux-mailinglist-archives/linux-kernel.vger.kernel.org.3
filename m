Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9730349FD79
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbiA1QBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:01:55 -0500
Received: from mout.perfora.net ([74.208.4.197]:44765 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240275AbiA1QBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:01:53 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MehX4-1mtjsV1bqq-00OCZV;
 Fri, 28 Jan 2022 17:01:27 +0100
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
Subject: [PATCH v3 02/12] arm64: defconfig: enable taskstats configuration
Date:   Fri, 28 Jan 2022 17:00:50 +0100
Message-Id: <20220128160100.1228537-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128160100.1228537-1-marcel@ziswiler.com>
References: <20220128160100.1228537-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Bls3vD3D4I52dndQWer56Br8z0AiS3qTYqdmgZ4n40bzbS0r9AB
 NiDVPWn0zOaWEvmqCoS6yXBacmZEo3iBT9uzFWk6LCfunob2qy+ojM62a7DhIHTEJHtWICq
 9G/DFj55DNfNstU1iuvm76VAxe+UZU78WsjcW8EeETzsG11QmLRGqlxEf388DDKqgGyckA0
 W5Q+Q2CP+EfackEyyir/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ioP21XAimqY=:RarCGpCf4BTne1rKbcXvxn
 vVLYStlgbYobi79DYSGq+AJs67+yrs9NhNqXN6CJClZJlkWJBpsc2zPrUXSQAP6c10eYH1QGI
 9esWMrYzqKtWxpXeGA/OVjICq5Mky7bAshYkHlu2NfHQR+LeC2Il/0lho9EBk3aF18DAEjSAq
 mbYHzw9Zcrtq2ApNsBZVURWCCH0Ck6b54JJix0/sQFMRvuFxMmW1yEi62IN9l3vzpRwe0z6z+
 sdKgnelGKsLDxdfsfTTSwVcawNDuki5D1WQGtLCIz16eyNnM9mZw3j19os8ar3tP7xF2MGQvs
 TcELHjkw6SnEzZBknJ3mVDPgsMZsaDllWsmbMA6w2Fig4+6BFlva7QnYPge/+IYeKHjPjx3Dm
 74+iwac5EWYJ36CvcedFAA1buPPen1Bun6ykD6NuMuwtW9SA3JFKLSMGqU9GVvddg9I94Z0nW
 LswMBraCH3+CIBFxs/gGcK+xi30BDUKJc7v9YxinmI8p7tTgLwU5V1EANvCcnmLLwqz3OgU99
 g6HkEfVdfFs5YYLygC3DRl0oMzFMTFQ9P+WaA8krDKNJqEVpIeb6KUNrIS8hHmWsYSDao8E09
 BPZ03W9+irwZGJP4RofSIDHpVqBCa8dmTXxGM0dwrASh94VyIO+rxnpVYybVQaqE9Drb7tjDj
 2VW5Z8+7M2Qpti2vb/mAxw8WlAoWK+4Ym43VVPjhhF60Q5a3mnGMxqd2ZOghF2LPuK8s=
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

