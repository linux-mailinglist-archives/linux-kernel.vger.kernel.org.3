Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A55648EB69
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbiANOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:16:04 -0500
Received: from mout.perfora.net ([74.208.4.196]:60841 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241463AbiANOQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:16:00 -0500
Received: from localhost.localdomain ([81.221.144.115]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LwJuC-1mH1Co1EBa-017zlO;
 Fri, 14 Jan 2022 15:15:36 +0100
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
Subject: [PATCH v2 03/11] arm64: defconfig: enable taskstats configuration
Date:   Fri, 14 Jan 2022 15:14:59 +0100
Message-Id: <20220114141507.395271-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220114141507.395271-1-marcel@ziswiler.com>
References: <20220114141507.395271-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2Xnq74mnLwrPxX+qwu74AC0E4xogu5MtdNlAGQ3aZMxKixdsiTx
 bwucnllV1Le4wta/c0fzM2urxKW1mN1WucLZrb+/W7f+dtqj0GrqjNTTui7HHW2w00wmn8l
 dECMoyxPvsxRjym05/b71pxNHwV9mtbp00126gXN1tDxAgVWUi2dDWmdrKRyWftckmSM2j5
 izsXJt96QH0DAWuTm4f4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zFE3nTVDIbw=:P0ZdtCAcknUij4s3WqTqFv
 w6xz7d6w0d1MoTuyQkrEAzVSEan/2gHruO3J05t0UQwO21cFBO1Mdf9E+flSqLVrq7NS1t3fy
 GWoZiBocOvMr2B62boqOk4TF8WmfDcSDFX0xXl+vTAqY1hU4XSrej6jjbqbpx2m9WdC/TLVP4
 Si/ctou2e2ZLdkftmgMOeZy821FDNA1RlXVxLXqg8NVnNIvHTt2v6OKqVgK8t2UAVwMgL5pws
 DTC0g2F1RICxx0xHHl0J4Iw5wICURCheUmbAyo4HLF1wzAhnvJ91HOhEgHvsRSr1F+7RPR7J5
 vReQhWimgMOoM0TytW5DfIe0mCne1OlVCSelcnwIddnvyoCIDVY3fq6++O0OLh+sZvqjJP1cM
 R/pxjTA/wph83JyrdpfjBqfsyXRwwrKNhmwSR7tLgM3Uh+dKKvcCMA+0PKz3/kleelTpmEYdr
 WbFusshbhonEWfcsaE+OfPIYSg2soCPGMwhVlxZHb16INOzkHMoZLAsXq9pQVPBTVo22ccweb
 VV9M7WHpJp8DHOcFabf+nm67SEIB1yynUhU4e73olkKIrQyhQl5zNyLGFl+cT7oXl9h7D5WGj
 UA5L4xKuTpG7g7xlGJNP1skxkNGA+qUO/KztL17XuDPia2keT1XIJomupTzqCUTAFamA/flbb
 AQHXjpijruktmj75KxIgDk008VjHUgsbG4OeMiK44NzIGzI++RcT4OwcvcutmZSguT40=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable CONFIG_TASKSTATS which is required for CONFIG_TASK_XACCT (and
subsequently CONFIG_TASK_IO_ACCOUNTING). Previously, taskstats got
pulled in by KVM but that got changed in commit 63b3f96e1a98
("kvm: Select SCHED_INFO instead of TASK_DELAY_ACCT").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch following full defconfig analysis as requested by Krzysztof.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cc5d3ba166b1..dec189229c0a 100644
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

