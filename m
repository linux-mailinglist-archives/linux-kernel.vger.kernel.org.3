Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90504AEF2A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiBIKVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiBIKVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:21:09 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F79EE08E7B7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:15:54 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Ma1LU-1nnj1f1f3U-00VyFm;
 Wed, 09 Feb 2022 11:01:27 +0100
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
Subject: [PATCH v5 02/12] arm64: defconfig: enable taskstats configuration
Date:   Wed,  9 Feb 2022 11:00:45 +0100
Message-Id: <20220209100055.181389-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220209100055.181389-1-marcel@ziswiler.com>
References: <20220209100055.181389-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8vC0NplGUz3Mq/ThYyGvledPttIIUyaUn6qmHCAk/UZ+5N4EQsV
 g8PO5Qybfve9FRYC/kC0smblYLpUyWa5wjOjTw3Z59vBfkW6G0znO+WCWy69kuFnVU9xD1K
 wdCK/Nwd2LYpkjOTGll3M5wNo+F5vfgmSw3D9Pu+YA21qvdIuUhRdnBIGXVnUZERQP22yIV
 JTawx2IU6xBaL9dr4Dq4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k0twE7iPq08=:ja5PO1oU+zo4hKTRkL88fm
 fdoyEeamLU83xig87SiuqNxjvxocGJNjj0gBcc64kvCE2og+Us25G+wTKNqXpx0eLvbc5Rt7m
 9hcgEN6VSODSrcREd5nN/MkCq8gzHOBljzFMnwzmW7TCAvD8APtZRZaZNMuTLQbx2homdrVn6
 z33aEl5amh72dwuJD2R0HR+MUiRYbcFDc6Bui7RXK+hFNnc6JwZHNqJdCZOefoI4Hb/0eFG9o
 4p+XqFlEt6NGG6H8w6KmtePKFvzU6nmusBoW6VVXsyy/FtYVbz4dA+PsaCAe+C5Vul/prR6sB
 q1Nk5tzm/6OuEjAv81hO3Zmzlnk/eV+muehUUg1N0YayiOCbzy2lVtfK/0ODYus3xLBaGbQkM
 7xOqn9XUizwgRNQltdS/Xdl2i+tcy18CYoRL+OeMrikthM06fTA+GbKpyDB+W8/RUK90CNc8u
 CIm70tO9oO/bW+2A5RAYu59LjkYLBOPoQqcwRmyaFPxco9jpsunKuEhABzAxdO3G0pmULLK7I
 YiUhkKl2snLqgUV6H8Gb+C20xq0ejYuzWOxx5t3QDwx+etatPtJTbuRsK177SwgsoTBprd4/9
 ES3bmIY/4OG9vkXZpAjoKvFDoOe8Can2RcC3zB+VG/HKgUywsZW3GmiuQhbVeUxD2kWiH4Lc2
 ZLRGFL983P+LbpimQdio9ibibF/SxTyKbjd12PAOXLp0o/VcXRW+nLQj1aFiSmmvy9fh6+wAD
 pv0JIyIuqhASsE5R+zE04nXwYFavbfOeB0AlmdJg1VXX/koFgasypWkAU1XgLMvwcglyXZU98
 Mm5mj5T6oCiuwyLHs4zXjqnBkYl9Q==
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

