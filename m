Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BEE487BCB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiAGSGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:06:36 -0500
Received: from mout.perfora.net ([74.208.4.194]:48281 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240522AbiAGSEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:38 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MnqT8-1mZN8Y43S6-00pHqr;
 Fri, 07 Jan 2022 19:03:57 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Will Deacon <will@kernel.org>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v1 04/14] arm64: defconfig: enable bpf/cgroup firewalling
Date:   Fri,  7 Jan 2022 19:03:04 +0100
Message-Id: <20220107180314.1816515-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hnmCG4gNJe/WfYxTTdBLiKuTD21o0vH1c0vKJTADHuWy4MsGR2l
 YQBGK1mg00A33MLbiZvQGzNRlncHl83cidX1ZhNCWOlI1n6ZzYPzrsEyYqYWg9VCEBJ+rwE
 xvdW2v+w8JUdUJwFRvQxPDIfCWLEaYrguHyD1QOOOkjYPocsRRZfOyd8wW8sGTzwR8U+H5Z
 PCcpvlARSo+Em6Nh31yGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FooxGjKyGYw=:H2U7u+X0UTs8/Hheog0UBe
 H9mniLEzmTQwh9gg0LPb8yzNJm56adDPVhCxJBKURYzYL/zwsgx3RiETKvLhbRHrIfBnOSA1B
 O1Tz0qURYuQN4pkWJhbdcH3tILbEhj/VOjA5eLvnn5yvcO4s32gbtMQLBsutlR+1PQK3wUSdG
 lr2JQBDpvxwFMjShLM4q0gnVwndVd2HYlC6TCfy3AbXsTaM/AY6Hbl8Ouu8PBKE6F6ts1ugO7
 bYFnmg7YOw6DBYSnKR6m9UMLV0YKiClcePDSKQEBenMSmj4C+pBN1raXZCU9r70akgDuGCn8E
 LbXEnjwHAxlrvZN7X4Jkkkn4PfBcvLY8D0F31GBSFz1cNxCVVduJbdzg+kv7ChSLC+vo5MlHR
 wTV1Z2sEST8Y68qAhegrJmIq0ejXnYKX8VvbiMjv6pJ3CozypTvDxYmDnGibeK3T34gUsbKho
 SI6xDDxcljnmtwDUrBW9PYjOSvEEyGqufH5LYjJFoR4pkQbcVcMiJF6ulR1IZv0SIURlgWKFt
 6Re+tou7ad2qljCb+9q05RTrJHSAkkv0FF4d8FeOaGck7eI8EH2qLw4JqwuNZa6pyfvfoCA7f
 9mY48zbD0nDAMZOy2erSdv91b7AsFtcL0ih9C9YIoYsfhtKA0jjX3avc9ISJJV8N6NpD3jHkj
 bW5f9HywjryCGge8VYsff2k/5aBiR3Nl6FzQtOe2wJQ1z334NZDu0waXguHlErdJyFIgLv+8p
 kmMsAnj6GSwMNb5+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This avoids the following systemd warning:

[    2.618538] systemd[1]: system-getty.slice: unit configures an IP
 firewall, but the local system does not support BPF/cgroup firewalling.
[    2.630916] systemd[1]: (This warning is only shown for the first
 unit using IP firewalling.)

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 79e4bf9f4c2c..3c8106c5776a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -3,6 +3,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
 CONFIG_BPF_JIT=y
 CONFIG_IRQ_TIME_ACCOUNTING=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -18,6 +19,7 @@ CONFIG_CPUSETS=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_BPF=y
 CONFIG_USER_NS=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
-- 
2.33.1

