Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46FA5425C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiFHFAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 01:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiFHE7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:59:16 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C73222AE9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:31:48 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx708L+p9iq4InAA--.61590S2;
        Wed, 08 Jun 2022 09:23:23 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] samples: Use KSYM_NAME_LEN for kprobes
Date:   Wed,  8 Jun 2022 09:23:22 +0800
Message-Id: <1654651402-21552-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx708L+p9iq4InAA--.61590S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr45CF4ruw4xXF18ZFy3CFg_yoW8AF17pF
        1qy34Ygr4rZr1UJ39xJw18W34Iq34DZr47Gr4rW34UtasF9r1kAr4xtF4jqw4kuF9Yqa13
        Jr4Igr98JryxJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        W8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAF
        wVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUg4SOUUU
        UU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better and enough to use KSYM_NAME_LEN for kprobes
in samples, no need to define and use the other values.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 samples/kprobes/kprobe_example.c    | 5 ++---
 samples/kprobes/kretprobe_example.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index f991a66..fd346f5 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -16,9 +16,8 @@
 #include <linux/module.h>
 #include <linux/kprobes.h>
 
-#define MAX_SYMBOL_LEN	64
-static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
-module_param_string(symbol, symbol, sizeof(symbol), 0644);
+static char symbol[KSYM_NAME_LEN] = "kernel_clone";
+module_param_string(symbol, symbol, KSYM_NAME_LEN, 0644);
 
 /* For each probe you need to allocate a kprobe structure */
 static struct kprobe kp = {
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 228321e..cbf1654 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -23,11 +23,10 @@
 #include <linux/module.h>
 #include <linux/kprobes.h>
 #include <linux/ktime.h>
-#include <linux/limits.h>
 #include <linux/sched.h>
 
-static char func_name[NAME_MAX] = "kernel_clone";
-module_param_string(func, func_name, NAME_MAX, S_IRUGO);
+static char func_name[KSYM_NAME_LEN] = "kernel_clone";
+module_param_string(func, func_name, KSYM_NAME_LEN, 0644);
 MODULE_PARM_DESC(func, "Function to kretprobe; this module will report the"
 			" function's execution time");
 
-- 
2.1.0

