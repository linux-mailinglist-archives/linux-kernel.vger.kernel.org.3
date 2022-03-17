Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4464DC9CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbiCQPYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiCQPX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:23:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052AF205BC5;
        Thu, 17 Mar 2022 08:22:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y22so7012274eds.2;
        Thu, 17 Mar 2022 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8H54sfvdL/4X++pvjE1/MSrXb+cFUQ9o4BK+QFfxJU=;
        b=pRA6Up9dD0rUtPDJrB0AH/PWFD3oL2KdsZ7UzFHwBtyggyUH+P1ttBKYKdq21kAZbO
         NHgNoruf07++8kDBgjGi4Bxc6/Tw69F2DywP+RgvHTdTGB5q0UHUY09M/A8pW+v1gQC1
         8UxPQXw3FYnpiFMu24s0e8tZGVdvyo/uiacheqL14Q0miLdmTZk8e44JIUl318H9WtHG
         gYAV1u47M5iQ7orKFXTWShCSBF35S9AOHxQN2f8TnZbYPxXMqwPBZdGumksy+fmEgaCU
         JGuNlip3ZDJmtdTS5Zn64xE3YIjTMS6W+uU8kvwiPnLqq1ZI+DJlhWmkJyDbVmcC4e5G
         hknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8H54sfvdL/4X++pvjE1/MSrXb+cFUQ9o4BK+QFfxJU=;
        b=7xblLGAO6qw+mSs4MaYKLJ13i1jANjVtyDCQQlrvUEx39BBLZzVFTD41JDTV5shuvk
         sPD3pAc/2yNz7wiXCszRvI0PwoLY16CtiRwx0FGilqEfxAmQB4iW99ntgaN1XWJYBocj
         Kc0k3x6cdArMMZOWYqYCJAmr8A72AXmxvPI5TOTyMDmwUHRv9o84BKT0i8GzI1as4SzA
         eXC3qEsNo9iJ6BpI/fnQGuCVGPtjcSkPgky8DB2b6zjJC2ApDgiZ0Ll5eywWpVG2/LYS
         sF3o6y4INdPP9Zh9yM/fvGKEJDDjoNXfVhaBbdO/66+o8noi+EdsQjFG0wACxzNY+cYF
         Ig3Q==
X-Gm-Message-State: AOAM533GXwF85+v58IF9eQmT6rlYgOq2yzFOkCs76U9ANBCUGGO/fjic
        eksn0L04DDW2XzQaAplJ1jD05XFe8Qpm2lA+mTM=
X-Google-Smtp-Source: ABdhPJz9AETMDAdvnaU5NvyiuEIC1DDzJVxNN7AH5e18+PR0R1OzGrJFZUrvInr/5as2pBdebPik3W4aAEBewdc4NA4=
X-Received: by 2002:a05:6402:3715:b0:410:a415:fd95 with SMTP id
 ek21-20020a056402371500b00410a415fd95mr5017644edb.288.1647530561296; Thu, 17
 Mar 2022 08:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
In-Reply-To: <YjMcZexG/kJepYDi@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 17 Mar 2022 23:22:28 +0800
Message-ID: <CAABZP2wZgZGAg5iVry21suEZ3e2PXhAhfwLvRCPvMRU5+zGG+g@mail.gmail.com>
Subject: Re: RCU: undefined reference to irq_work_queue
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     rcu <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 17, 2022 at 8:48 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> Hello RCU folks,
>
> I like to use minimal configuration for kernel development.
> when building with tinyconfig + CONFIG_PREEMPT=y on arm64:
I invoke cross compiler to reproduce the bug on my X86 machine
$make  ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
CC=aarch64-linux-gnu-gcc-10 tinyconfig
let CONFIG_PREEMPT=y  in .config
$make  ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
CC=aarch64-linux-gnu-gcc-10 -j 16
LD      vmlinux
aarch64-linux-gnu-ld: kernel/rcu/update.o: in function `call_rcu_tasks':
update.c:(.text+0xb30): undefined reference to `irq_work_queue'
update.c:(.text+0xb30): relocation truncated to fit: R_AARCH64_CALL26
against undefined symbol `irq_work_queue'
>
> ld: kernel/rcu/update.o: in function `call_rcu_tasks':
> update.c:(.text+0xb2c): undefined reference to `irq_work_queue'
> update.c:(.text+0xb2c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `irq_work_queue'
> make: *** [Makefile:1155: vmlinux] Error 1
>
> It seems RCU calls irq_work_queue() without checking if CONFIG_IRQ_WORK is enabled.
>
> --
> Thank you, You are awesome!
> Hyeonggon :-)
Meanwhile, there is no error for doing the same to build X86 kernel.
I think the reason is:
arch/x86/Kconfig select PERF_EVENT
and PERF_EVENT select IRQ_WORK

Hope my little research could provide some clues to solve the problem ;-)

You are welcome
Cheers
Zhouyi
