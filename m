Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384C2473B49
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhLNDJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:09:16 -0500
Received: from mail.loongson.cn ([114.242.206.163]:48944 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235250AbhLNDJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:09:12 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxXN3PCrhhHngAAA--.2717S4;
        Tue, 14 Dec 2021 11:09:06 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Jason Self <jason@bluehome.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] MIPS: Makefile: Remove "ifdef need-compiler" for Kbuild.platforms
Date:   Tue, 14 Dec 2021 11:09:02 +0800
Message-Id: <1639451342-7029-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1639451342-7029-1-git-send-email-yangtiezhu@loongson.cn>
References: <1639451342-7029-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9BxXN3PCrhhHngAAA--.2717S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWkXF4UJF13Zr18Zw47urg_yoWfuwbEyw
        sFkw1Fkw1rXrna93y2qw43uryjy3yDGwn5CwnxXrnxXwn8ta1kJFWDtws5JF4rXr4vvr4r
        J3WfJFnrurnFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfAYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7
        IE14v26r15M28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CE
        w4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6x
        kF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
        6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r48MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0La9DUUUUU==
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
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
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

