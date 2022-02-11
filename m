Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B5D4B21BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348513AbiBKJYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:24:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbiBKJYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:24:16 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13850102C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:24:15 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MU0AR-1nj9yI485h-00QfrZ;
 Fri, 11 Feb 2022 10:23:52 +0100
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
Subject: [PATCH v6 02/12] arm64: defconfig: enable taskstats configuration
Date:   Fri, 11 Feb 2022 10:23:12 +0100
Message-Id: <20220211092322.287487-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220211092322.287487-1-marcel@ziswiler.com>
References: <20220211092322.287487-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:15zxzvZFuQ/bWFLh5QvacCMw9EyiOPjf94kzQSvdCY9sHRENisf
 OzyTjAVN2rjt5CCmLcyGwnMacNexFD9hBhiz3OESsqEbHo0T/2WJkElWYjgkXQpgfO03m7Z
 QpCJlPfMF+maGpCZllU25SLmLqn5BgfHSoL7MthU76jaq4cCIO9sXxhn3bM+VMDmfhHs+4i
 4TRDVj5kTDetGPu9QLP/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:apGRYHHNCSM=:mw9pKDX5EC4xcLQUdgMKUN
 SSdXzF4ghdFsXe3vN40wr8AhvVwhl/RfeeEOvpitFahuTFpgE9MZC97FK6cpnnd5hCHOndpfa
 SUJu0bw3CfijPbLTiOhoJSbHvc/RCyCdJ8JfHFUwyqtom3YZpzEKi2gdMdCvcZas2YcS4GCSu
 VI/ThKX7lY9rSKYWnTvnsykHQrG5oJJBqnMiOSFfgOSjRPSdpaBtyPze4oqZPCJr4kli7up/2
 o1Pefo76ZX42Cj2+Xa+ocwoxdi3wY5S6RqFvqPlEYdLWfIULC3j5/CZwfitfPCTG5JAxlhbI3
 HZAt5AA7iiGdgbcVnwXcm84MGYsq/T7XDmipuDfTieBq3r2sQHDNQFFee7ifG3w5JE+nDhI8Y
 c8GnJ10LRPlN9OSvAvawrZ6nCF93Ny/WYWFMQVQ/gUyMjLiQN4B1QfKs8QhV00XdzFDnug0Rz
 SOUd6QcZXi2Z1rnIZqfnJXQXCXKlwf6QPT9rTCM5BE5JpYpPJd9j4L8Pj2cswHUTSe/WjFEbi
 QKch65+StZ1xiV796e37IjNKXEDdv29uN49U8bnT2ygP2CpX9Gun7OwcWPKWGH8vQ4XUmdP3u
 gSd8dNRANlm54P8by3JBM7w4fF1hvdy/x8rEOKcOntLz5ULK3RaPjtRznel6y6spjcd+n5GeN
 DkD3OpYvL/eZoHlCRfUXh6+lWygJBBzf1vhHrckso7nq6rAAdZB7c4iQNYcXcUyJ3Wz4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

