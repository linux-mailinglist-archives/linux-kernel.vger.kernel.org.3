Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919A746F9C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 05:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbhLJEIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 23:08:47 -0500
Received: from mail.loongson.cn ([114.242.206.163]:46276 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229605AbhLJEIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 23:08:47 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axmsjy0bJhv7oFAA--.12411S2;
        Fri, 10 Dec 2021 12:05:06 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jason Self <jason@bluehome.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] MIPS: Makefile: Remove "ifdef need-compiler" for Kbuild.platforms
Date:   Fri, 10 Dec 2021 12:05:05 +0800
Message-Id: <1639109105-1545-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Axmsjy0bJhv7oFAA--.12411S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWkXF4UJF13Zr18Zw47urg_yoWfAFc_Kr
        WIk3W8C34rXrn3W3y2qw1UXryjy398Grn3CwnxXrnxXa45t3WkGFWkJa48JF4rZr4q9r4r
        tFWfZFnrCr92gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r45MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0OTmDUUUUU==
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

v2: fix the typo "casue" --> "cause" in the commit message,
    sorry for that.

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

