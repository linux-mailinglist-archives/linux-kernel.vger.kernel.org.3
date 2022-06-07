Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6AA53F9EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbiFGJgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbiFGJfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:35:39 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CBEDE64D7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:35:38 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx707oG59igiYeAA--.40558S2;
        Tue, 07 Jun 2022 17:35:36 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH] samples: Use KSYM_NAME_LEN for fprobe and kprobes
Date:   Tue,  7 Jun 2022 17:35:36 +0800
Message-Id: <1654594536-2915-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx707oG59igiYeAA--.40558S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1DJr4fAr1DWFyxJFyDtrb_yoW5XF1DpF
        1q9ayagr45AF1UJ39xJw1rW34Iq34kur47GF4rGw18t3W29r1kAFWxta1UKaykZF9Yq3W3
        Gr42gryrJryxJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUUPl13UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better and enough to use KSYM_NAME_LEN for fprobe and kprobes
in samples, no need to define and use the other values.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 samples/fprobe/fprobe_example.c     | 9 ++++-----
 samples/kprobes/kprobe_example.c    | 5 ++---
 samples/kprobes/kretprobe_example.c | 5 ++---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index 24d3cf1..1ed1a69 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -19,13 +19,12 @@
 #include <linux/slab.h>
 
 #define BACKTRACE_DEPTH 16
-#define MAX_SYMBOL_LEN 4096
 struct fprobe sample_probe;
 
-static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
-module_param_string(symbol, symbol, sizeof(symbol), 0644);
-static char nosymbol[MAX_SYMBOL_LEN] = "";
-module_param_string(nosymbol, nosymbol, sizeof(nosymbol), 0644);
+static char symbol[KSYM_NAME_LEN] = "kernel_clone";
+module_param_string(symbol, symbol, KSYM_NAME_LEN, 0644);
+static char nosymbol[KSYM_NAME_LEN] = "";
+module_param_string(nosymbol, nosymbol, KSYM_NAME_LEN, 0644);
 static bool stackdump = true;
 module_param(stackdump, bool, 0644);
 
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

