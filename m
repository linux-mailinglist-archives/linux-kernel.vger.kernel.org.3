Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D3A53F7B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiFGHz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbiFGHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:55:09 -0400
Received: from email.cn (m218-153.88.com [110.43.218.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF69EB41ED;
        Tue,  7 Jun 2022 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=4L3YPE141oNh3e8lowr3lweHFnU5fzGrBsPho
        Ukz4V4=; b=QplFKbzFr3Vq/w82Dxb/jV8yIonStuzz33uThFi1kEH77FdkM6gUa
        erXk5Qod+I0hibyMIqv9wGXgVLAbZWNwc7rd4M4yusu62HnvIup9isIEeAl6ndcn
        fIBgxvkN5s8uSz5MqEMWMpKPwKnLn3zpVgew6C48w9qaqXnqNOLJ4M=
Received: from bobwxc.mipc (unknown [120.242.121.53])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgB3kP8_BJ9ihhcPAA--.47847S2;
        Tue, 07 Jun 2022 15:54:41 +0800 (CST)
Date:   Tue, 7 Jun 2022 15:54:39 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     teng sterling <sterlingteng@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Li Feng <felixlee868@icloud.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs/zh_CN: Update zh_CN/kernel-hacking/hacking.rst to
 5.19-rc1
Message-ID: <Yp8EP2L/Q6MbTGEx@bobwxc.mipc>
References: <Yp41+eTjoPRa4hrl@bobwxc.mipc>
 <CAMU9jJqKQQGD73_ZXTL1NxwihPtun7D2i4e2_RaZe=5HMbz5xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMU9jJqKQQGD73_ZXTL1NxwihPtun7D2i4e2_RaZe=5HMbz5xA@mail.gmail.com>
X-CM-TRANSID: GiKnCgB3kP8_BJ9ihhcPAA--.47847S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFy7AF4UAw4rZr13Ww47twb_yoWxKr4DpF
        sIg3W8GFWjvFy8ArW0ga4I9F15Cws7Way7KF4qy34Syrs0yay7tryqgFWYvaySq34jyFyx
        WFs7WF1F9r1ayrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUqqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04
        k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnLSdPUU
        UUU==
X-Originating-IP: [120.242.121.53]
X-CM-SenderInfo: pere453f6hztlloou0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 10:40:16AM +0800, teng sterling wrote:
> Wu XiangCheng <bobwxc@email.cn> 于2022年6月7日周二 01:20写道：
> >
> > * update to commit f35cf1a59e9a ("Documentation: kernel-hacking: minor
> >   edits for style")
> >
> > * fix a homophone typo reported by Li Feng
> >
> > Reported-by: Li Feng <felixlee868@icloud.com>
> > Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

Thank you!

> 
> BTW,
> b4 doesn't seem to work for this patch, but I manually downloaded the
> email for a build test and it was fine. :)

Unable to reproduce. Check the version of b4?

❯ b4 --version
0.8.0
❯ b4 am Yp41+eTjoPRa4hrl@bobwxc.mipc
Looking up https://lore.kernel.org/r/Yp41%2BeTjoPRa4hrl%40bobwxc.mipc
Grabbing thread from lore.kernel.org/all/Yp41%2BeTjoPRa4hrl%40bobwxc.mipc/t.mbox.gz
Analyzing 2 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH] docs/zh_CN: Update zh_CN/kernel-hacking/hacking.rst to 5.19-rc1
  ---
  ✓ Signed: openpgp/bobwxc@email.cn
  ✓ Signed: DKIM/email.cn
---
Total patches: 1
---
NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
     Msg From: teng sterling <sterlingteng@gmail.com>
NOTE: Rerun with -S to apply them anyway
---
 Link: https://lore.kernel.org/r/Yp41+eTjoPRa4hrl@bobwxc.mipc
 Base: not specified
       git am ./20220607_bobwxc_docs_zh_cn_update_zh_cn_kernel_hacking_hacking_rst_to_5_19_rc1.mbx

--
Thanks,
	Wu

> 
> log:
> $../b4/b4.sh am Yp41+eTjoPRa4hrl@bobwxc.mipc
> Looking up https://lore.kernel.org/r/Yp41%2BeTjoPRa4hrl%40bobwxc.mipc
> Grabbing thread from
> lore.kernel.org/all/Yp41%2BeTjoPRa4hrl%40bobwxc.mipc/t.mbox.gz
> Analyzing 1 messages in the thread
> Checking attestation on all messages, may take a moment...
> Traceback (most recent call last):
>   File "/home/siyanteng/b4/b4/command.py", line 263, in <module>
> ......
> 
> Thanks,
> Yanteng
> > ---
> >  .../zh_CN/kernel-hacking/hacking.rst          | 22 +++++++++----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/translations/zh_CN/kernel-hacking/hacking.rst b/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
> > index f2bc154c5bcc..bda79646bb1e 100644
> > --- a/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
> > +++ b/Documentation/translations/zh_CN/kernel-hacking/hacking.rst
> > @@ -81,7 +81,7 @@
> >  过硬件中断）的“软件中断”将运行（ ``kernel/softirq.c`` ）。
> >
> >  此处完成了许多真正的中断处理工作。在向SMP过渡的早期，只有“bottom halves下半
> > -部”（BHs）机制，无法利用多个CPU的优势。在从那些一团糟的就电脑切换过来后不久，
> > +部”（BHs）机制，无法利用多个CPU的优势。在从那些一团糟的旧电脑切换过来后不久，
> >  我们放弃了这个限制，转而使用“软中断”。
> >
> >  ``include/linux/interrupt.h`` 列出了不同的软中断。定时器软中断是一个非常重要
> > @@ -95,8 +95,7 @@
> >
> >  .. warning::
> >
> > -    “tasklet”这个名字是误导性的：它们与“任务”无关，可能更多与当时
> > -    阿列克谢·库兹涅佐夫享用的糟糕伏特加有关。
> > +    “tasklet”这个名字是误导性的：它们与“任务”无关。
> >
> >  你可以使用 :c:func:`in_softirq()` 宏（ ``include/linux/preempt.h`` ）来确认
> >  是否处于软中断（或子任务）中。
> > @@ -247,7 +246,7 @@ Provide mechanism not policy”。
> >      与 :c:func:`put_user()` 和 :c:func:`get_user()` 不同，它们返回未复制的
> >      数据量（即0仍然意味着成功）。
> >
> > -【是的，这个愚蠢的接口真心让我尴尬。火爆的口水仗大概每年都会发生。
> > +【是的，这个讨厌的接口真心让我尴尬。火爆的口水仗大概每年都会发生。
> >  —— Rusty Russell】
> >
> >  这些函数可以隐式睡眠。它不应该在用户上下文之外调用（没有意义）、调用时禁用中断
> > @@ -538,9 +537,9 @@ Documentation/core-api/symbol-namespaces.rst 。
> >
> >  Linus和其他开发人员有时会更改开发内核中的函数或结构体名称；这样做不仅是为了
> >  让每个人都保持警惕，还反映了一个重大的更改（例如，不能再在打开中断的情况下
> > -调用，或者执行额外的检查，或者不执行以前捕获的检查）。通常这会附带一个linux
> > -内核邮件列表中相当全面的注释；请搜索存档以查看。简单地对文件进行全局替换通常
> > -会让事情变得 **更糟** 。
> > +调用，或者执行额外的检查，或者不执行以前捕获的检查）。通常这会附带发送一个
> > +相当全面的注释到相应的内核邮件列表中；请搜索存档以查看。简单地对文件进行全局
> > +替换通常只会让事情变得 **更糟** 。
> >
> >  初始化结构体成员
> >  ------------------
> > @@ -610,7 +609,7 @@ C++
> >
> >  为了让你的东西更正式、补丁更整洁，还有一些工作要做：
> >
> > --  搞清楚你在谁的地界儿上干活。查看源文件的顶部、 ``MAINTAINERS`` 文件以及
> > +-  搞清楚你修改的代码属于谁。查看源文件的根目录、 ``MAINTAINERS`` 文件以及
> >     ``CREDITS`` 文件的最后一部分。你应该和此人协调，确保你没有重新发明轮子，
> >     或者尝试一些已经被拒绝的东西。
> >
> > @@ -629,9 +628,10 @@ C++
> >     “obj-$(CONFIG_xxx) += xxx.o”。语法记录在
> >     Documentation/kbuild/makefiles.rst 。
> >
> > --  如果你做了一些有意义的事情，那可以把自己放进 ``CREDITS`` ，通常不止一个
> > -   文件（无论如何你的名字都应该在源文件的顶部）。维护人员意味着您希望在对
> > -   子系统进行更改时得到询问，并了解缺陷；这意味着对某部分代码做出更多承诺。
> > +-  如果你认为自己做了一些有意义的事情，可以把自己放进 ``CREDITS`` ，通常不
> > +   止一个文件（无论如何你的名字都应该在源文件的顶部）。  ``MAINTAINERS``
> > +   意味着您希望在对子系统进行更改时得到询问，并了解缺陷；这意味着对某部分
> > +   代码做出更多承诺。
> >
> >  -  最后，别忘记去阅读 Documentation/process/submitting-patches.rst ，
> >     也许还有 Documentation/process/submitting-drivers.rst 。
> > --
> > 2.30.2
> >

