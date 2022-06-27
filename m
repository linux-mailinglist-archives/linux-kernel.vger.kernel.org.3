Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC9D55CDB2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiF0HSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiF0HSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:18:31 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E23935F5A;
        Mon, 27 Jun 2022 00:18:26 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9i8Wbli1rxfAA--.5381S2;
        Mon, 27 Jun 2022 15:18:21 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] modpost: Add line break in the section mismatch warning
Date:   Mon, 27 Jun 2022 15:18:20 +0800
Message-Id: <1656314300-2749-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxr9i8Wbli1rxfAA--.5381S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UWF1UZF1fJryfuFyUZFb_yoW8AF48pa
        yFk3sruryIyr4vqayIkrykZ347J34rWF93C3srCw4DWrsruw1kZr97AF4xZF90yFW8AFWS
        qF18trn5u3yDA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4x
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjX_-PUUUU
        U==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section mismatch warning may be too long, add an line break in it.

Without this patch:

  LD      vmlinux.o
  MODPOST vmlinux.symvers
WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Section mismatch in reference from the variable __ksymtab_prom_init_numa_memory to the function .init.text:prom_init_numa_memory()
The symbol prom_init_numa_memory is exported and annotated __init
Fix this by removing the __init annotation of prom_init_numa_memory or drop the export.

With this patch:

  LD      vmlinux.o
  MODPOST vmlinux.symvers
WARNING: modpost: vmlinux.o(___ksymtab+prom_init_numa_memory+0x0): Section mismatch in reference
from the variable __ksymtab_prom_init_numa_memory to the function .init.text:prom_init_numa_memory()
The symbol prom_init_numa_memory is exported and annotated __init
Fix this by removing the __init annotation of prom_init_numa_memory or drop the export.

This is based on Linux 5.19-rc4.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 620dc8c..4cc894f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1320,8 +1320,8 @@ static void report_sec_mismatch(const char *modname,
 	get_pretty_name(from_is_func, &from, &from_p);
 	get_pretty_name(to_is_func, &to, &to_p);
 
-	warn("%s(%s+0x%llx): Section mismatch in reference from the %s %s%s "
-	     "to the %s %s:%s%s\n",
+	warn("%s(%s+0x%llx): Section mismatch in reference\n"
+	     "from the %s %s%s to the %s %s:%s%s\n",
 	     modname, fromsec, fromaddr, from, fromsym, from_p, to, tosec,
 	     tosym, to_p);
 
-- 
2.1.0

