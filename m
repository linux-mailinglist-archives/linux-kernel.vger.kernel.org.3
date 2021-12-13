Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BCD4728E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhLMKQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:16:19 -0500
Received: from mail.loongson.cn ([114.242.206.163]:59316 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232051AbhLMJ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:58:06 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxXN0lGbdhlAIAAA--.85S4;
        Mon, 13 Dec 2021 17:58:00 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jason Self <jason@bluehome.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] MIPS: Makefile: Remove "ifdef need-compiler" for Kbuild.platforms
Date:   Mon, 13 Dec 2021 17:57:57 +0800
Message-Id: <1639389477-17586-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639389477-17586-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639389477-17586-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9BxXN0lGbdhlAIAAA--.85S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWkXF4UJF13Zr18Zw47urg_yoW3trX_K3
        9Fk3W0kw1rXrn3W3y2qw45Wryqy398Crn5CwnxXrnxXa45ta1kGFWkta48JF4rXF4v9r4r
        tFyfZFnrCr92gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-xFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
        0Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjfUe1v3UUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 13ceb48bc19c ("MIPS: Loongson2ef: Remove unnecessary
{as,cc}-option calls"), no need to use "ifdef need-compiler" for
Kbuild.platforms, because the cause of the build issue mentioned
in commit 0706f74f719e ("MIPS: fix *-pkg builds for loongson2ef
platform") has been disappeared, so just remove it.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index ace7f03..e036fc0 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -253,9 +253,7 @@ endif
 #
 # Board-dependent options and extra files
 #
-ifdef need-compiler
 include $(srctree)/arch/mips/Kbuild.platforms
-endif
 
 ifdef CONFIG_PHYSICAL_START
 load-y					= $(CONFIG_PHYSICAL_START)
-- 
2.1.0

