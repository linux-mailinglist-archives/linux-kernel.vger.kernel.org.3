Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A5A53ECE5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiFFRSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiFFRSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:18:13 -0400
Received: from email.cn (m218-171.88.com [110.43.218.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20606EC69;
        Mon,  6 Jun 2022 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=DRZpgfFHXujVu6xJM+YtvkphwxLfh/2huzfyk
        42s2hM=; b=Ni+4yPGUE9bUczBzwqdCsseKujRl/zboFAqaAeiB/DhHAccVp2Fau
        8eQj0XDm1kuXjaxeGKxHz5iQy28IaCdO8YRcnFOzFjTIANMieezCDUvQ+x0cslUI
        Ve4M4dFNWeiE5Mi7mHeEOuzZECas08PjnObaFb7hvwy1siKUTqAx1Q=
Received: from bobwxc.mipc (unknown [120.242.68.234])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgBXgiT7NZ5idUsLAA--.34292S2;
        Tue, 07 Jun 2022 01:14:36 +0800 (CST)
Date:   Tue, 7 Jun 2022 01:14:33 +0800
From:   Wu XiangCheng <bobwxc@email.cn>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, Li Feng <felixlee868@icloud.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: Update zh_CN/kernel-hacking/hacking.rst to
 5.19-rc1
Message-ID: <Yp41+eTjoPRa4hrl@bobwxc.mipc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Developer-Signature: v=1; a=openpgp-sha256; l=4633; h=from:subject;
 bh=R4VA0XQH7pOT4Jeus2Xonm2ufN2vgnsQj0FKd0TPHcE=;
 b=owEB7QES/pANAwAKAbZbKBIigrCFAcsmYgBinjXBQaY+FjnjqTAUfa47gjeE61NurKQpizp9THlY
 EKhW3+yJAbMEAAEKAB0WIQRFujdTmQmloK0WXU+2WygSIoKwhQUCYp41wQAKCRC2WygSIoKwhXBbC/
 97Bvo1A9KKeoLdwbcuDQhF2NtuulyB4p8QOpZlnyRCNAdDn6zEt9/7MpSDYTwhekbxGjTf0eWw6rvY
 2rSS+05xP7YKjv/dCNtil0lBCiUZsi8Tp4FPjnGmFrBnC7ckrTGBy8H2LAU8dfMgTVJpaqGqXx5tuU
 iaQrQiiFAvrl4SK/EsmsGgNLWZYBd36hjwS+RV4QIoJlm7XU1MO9ISPStQ67g1foDtS10V9lHEbjSZ
 wmW8GVH8jImalwUExh8mL02H5VrzaPiGAUcWP94V1WaDTjS94IDZ4cdQqCourdniFOH52YUODXFWJ/
 4i8xBBAh15QUjWICYQxziywXTqPqfOT6w7Epjp29n/j5ASnKQMUeJYPL69d+9z23IB3VPfrDna0NcF
 kLX80As2vxZFKVjdCzGXrLjzE94UeWyTNq+TnUUFdaaeuZ1s1FNtX7esvXMoo9KY9RoN4opvJvPPxH
 7VgSYaJKP/+TMRghCWiNWHO4QUvpPVqU8DLsevXDPauY8=
X-Developer-Key: i=bobwxc@email.cn; a=openpgp;
 fpr=2BF2A4AA2F0730C3279ED01D32684A40BCA7AEA7
X-CM-TRANSID: LCKnCgBXgiT7NZ5idUsLAA--.34292S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF45trWftw4kXFy5Jr4Utwb_yoW7XF4kpF
        ZIk34xKr1FyryDZrW0ga4IkF1UCa97W3y7KF40yrySyr90qa9IyFZ0gFWrXF4fX342yFW2
        gFs5uFyrur12krDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUqSb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04
        k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU-KZXDUUU
        U
X-Originating-IP: [120.242.68.234]
X-CM-SenderInfo: pere453f6hztlloou0/
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* update to commit f35cf1a59e9a ("Documentation: kernel-hacking: minor
  edits for style")

* fix a homophone typo reported by Li Feng

Reported-by: Li Feng <felixlee868@icloud.com>
Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
---
 .../zh_CN/kernel-hacking/hacking.rst          | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/translations/zh_CN/kernel-hacking/hacking.rst b/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
index f2bc154c5bcc..bda79646bb1e 100644
--- a/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
+++ b/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
@@ -81,7 +81,7 @@
 过硬件中断）的“软件中断”将运行（ ``kernel/softirq.c`` ）。
 
 此处完成了许多真正的中断处理工作。在向SMP过渡的早期，只有“bottom halves下半
-部”（BHs）机制，无法利用多个CPU的优势。在从那些一团糟的就电脑切换过来后不久，
+部”（BHs）机制，无法利用多个CPU的优势。在从那些一团糟的旧电脑切换过来后不久，
 我们放弃了这个限制，转而使用“软中断”。
 
 ``include/linux/interrupt.h`` 列出了不同的软中断。定时器软中断是一个非常重要
@@ -95,8 +95,7 @@
 
 .. warning::
 
-    “tasklet”这个名字是误导性的：它们与“任务”无关，可能更多与当时
-    阿列克谢·库兹涅佐夫享用的糟糕伏特加有关。
+    “tasklet”这个名字是误导性的：它们与“任务”无关。
 
 你可以使用 :c:func:`in_softirq()` 宏（ ``include/linux/preempt.h`` ）来确认
 是否处于软中断（或子任务）中。
@@ -247,7 +246,7 @@ Provide mechanism not policy”。
     与 :c:func:`put_user()` 和 :c:func:`get_user()` 不同，它们返回未复制的
     数据量（即0仍然意味着成功）。
 
-【是的，这个愚蠢的接口真心让我尴尬。火爆的口水仗大概每年都会发生。
+【是的，这个讨厌的接口真心让我尴尬。火爆的口水仗大概每年都会发生。
 —— Rusty Russell】
 
 这些函数可以隐式睡眠。它不应该在用户上下文之外调用（没有意义）、调用时禁用中断
@@ -538,9 +537,9 @@ Documentation/core-api/symbol-namespaces.rst 。
 
 Linus和其他开发人员有时会更改开发内核中的函数或结构体名称；这样做不仅是为了
 让每个人都保持警惕，还反映了一个重大的更改（例如，不能再在打开中断的情况下
-调用，或者执行额外的检查，或者不执行以前捕获的检查）。通常这会附带一个linux
-内核邮件列表中相当全面的注释；请搜索存档以查看。简单地对文件进行全局替换通常
-会让事情变得 **更糟** 。
+调用，或者执行额外的检查，或者不执行以前捕获的检查）。通常这会附带发送一个
+相当全面的注释到相应的内核邮件列表中；请搜索存档以查看。简单地对文件进行全局
+替换通常只会让事情变得 **更糟** 。
 
 初始化结构体成员
 ------------------
@@ -610,7 +609,7 @@ C++
 
 为了让你的东西更正式、补丁更整洁，还有一些工作要做：
 
--  搞清楚你在谁的地界儿上干活。查看源文件的顶部、 ``MAINTAINERS`` 文件以及
+-  搞清楚你修改的代码属于谁。查看源文件的根目录、 ``MAINTAINERS`` 文件以及
    ``CREDITS`` 文件的最后一部分。你应该和此人协调，确保你没有重新发明轮子，
    或者尝试一些已经被拒绝的东西。
 
@@ -629,9 +628,10 @@ C++
    “obj-$(CONFIG_xxx) += xxx.o”。语法记录在
    Documentation/kbuild/makefiles.rst 。
 
--  如果你做了一些有意义的事情，那可以把自己放进 ``CREDITS`` ，通常不止一个
-   文件（无论如何你的名字都应该在源文件的顶部）。维护人员意味着您希望在对
-   子系统进行更改时得到询问，并了解缺陷；这意味着对某部分代码做出更多承诺。
+-  如果你认为自己做了一些有意义的事情，可以把自己放进 ``CREDITS`` ，通常不
+   止一个文件（无论如何你的名字都应该在源文件的顶部）。  ``MAINTAINERS``
+   意味着您希望在对子系统进行更改时得到询问，并了解缺陷；这意味着对某部分
+   代码做出更多承诺。
 
 -  最后，别忘记去阅读 Documentation/process/submitting-patches.rst ，
    也许还有 Documentation/process/submitting-drivers.rst 。
-- 
2.30.2

