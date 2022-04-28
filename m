Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B89512E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbiD1IWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344026AbiD1IWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:22:09 -0400
X-Greylist: delayed 59258 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Apr 2022 01:18:55 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31CB98F64;
        Thu, 28 Apr 2022 01:18:55 -0700 (PDT)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M4alK-1nkXKC04ve-001jPs; Thu, 28 Apr 2022 10:18:54 +0200
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ef5380669cso44273927b3.9;
        Thu, 28 Apr 2022 01:18:53 -0700 (PDT)
X-Gm-Message-State: AOAM5337WtLlM78gl1pVxgifqdiUANpxx44GtCXrWalC0+xXzp8oLEc+
        El8LWVScNHqXtz0kSt6+GXjdgm8snio1x7JoSDI=
X-Google-Smtp-Source: ABdhPJzNcyUE96yIKfingrUoTIL3guadENrUU/cTPjSAa0f6J6wZPur6AUZO6jPQ0V8dk6KmmwLZLALTy5jbc4NNKwU=
X-Received: by 2002:a0d:d101:0:b0:2eb:4bd7:bcc1 with SMTP id
 t1-20020a0dd101000000b002eb4bd7bcc1mr31901346ywd.495.1651133932740; Thu, 28
 Apr 2022 01:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1645772606.git.quic_saipraka@quicinc.com>
 <3de35c9f4a3a070d197bab499acefc709a6f5336.1645772606.git.quic_saipraka@quicinc.com>
 <YmorayBozWWRlTpP@kroah.com> <96dc5e2e-5d88-52ce-c295-779603e668f2@quicinc.com>
 <YmpD3tIQK2iiqt46@kroah.com>
In-Reply-To: <YmpD3tIQK2iiqt46@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Apr 2022 10:18:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3o7BacAo1fWOLvVxyMrfNV95P1-wUB1t5deLah=nZOwg@mail.gmail.com>
Message-ID: <CAK8P3a3o7BacAo1fWOLvVxyMrfNV95P1-wUB1t5deLah=nZOwg@mail.gmail.com>
Subject: Re: [PATCHv11 6/6] asm-generic/io: Add logging support for MMIO accessors
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, quic_psodagud@quicinc.com,
        quic_tsoni@quicinc.com, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ctt4JGQoCaDxhTQJgAWz3JeVF91z/YeOmpyuVjhazpYPduG3wcK
 ZXA7TS2FWrsgYATGNINLYx6U0qsy7J5quMDpMTOFCce/lTA37RsG3RQFPRlAQWAzpt6KQfC
 CJ6aO3pHCjiKKpmjGJocwQCaXUT0xqVYkGHvhzSb7XTh1xuOfIp6De/i/gPDneb0N9PayRW
 Dj70fILIElI72AXiVz3sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1e0MUThB7l4=:nISJtVioTKGN5NnIU2evXC
 gepwTog1yAJq7FQsb4zLJ91Z1JJaKuGGLY5sBjWhcJ89p7IeVUHKFXFojeHlwPI2UMhfDQr1G
 5oivqOWvQ0iq3S06GyFov4VIh/HnST+vEFci8zBAiOZY8q2fqL0Bx/XmvxCCXMmTJO3hIitTZ
 ovps0jWHQ7eX0UD8u7j00BWcEK21r0HoisGXpumkrGZcZWB6j9pAsJF/8HMpVF4m0IhP2p4oh
 O13qzDl0ObdJ1wwv3V8KUUUwJjYNJwaECXgtb0Tf4hcL73r6mOqo5ijHD7KAQFlyeGlf2IHo7
 HxSXmUWDIs2EGU5Y4ggTuEslQSFdyg3tO0ZIIeHe7LNjEn36kdOqxGRuIQrPgBlVy0nDmgIVS
 6E8hLW1XwUl8jZ9DRxd/0gCXP77DF7+O79uYQmgXWVoc6jU7CA3R6dvkpOey9RNcI8n8DD58d
 ZhVMwr9ZeKjiIF4xP1xZMUmeZ4LJVFDR4P74N9YWEWKDT2i/xFIYUbs31l3o7gwFtYYBdTCVp
 qBceRCEoUD66xExg7lMqB8sIxoWESmpoprV8+rJ+4qHfUXvc6YlGFSjVyQYwVgSamqOsee0gK
 7e9P1wp40LlviXM3nMjWl30Q3WlEo7pZ9iBh21ESFi5boC4L4lzX+ACZoUibA00biIM1gydmz
 XSweBi2UwIPX836UkHkgeWttXJamEmZZGy4/SmTf/xuTrzKKibVStfCRswrxs+FRsxSs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 9:35 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 28, 2022 at 12:59:13PM +0530, Sai Prakash Ranjan wrote:
> > On 4/28/2022 11:21 AM, Greg KH wrote:
> > > On Thu, Apr 28, 2022 at 09:00:13AM +0530, Sai Prakash Ranjan wrote:
>
> > -D__NO_FORTIFY, -D__DISABLE_EXPORTS, -DDISABLE_BRANCH_PROFILING".
>
> Those are compiler flags that affect gcc, not kernel code functionality.

It's normal for invasive instrumentation to need flags to disable them. If you
look at mm/kasan/Makefile, you see

KASAN_SANITIZE := n
UBSAN_SANITIZE := n
KCOV_INSTRUMENT := n
CC_FLAGS_KASAN_RUNTIME += -DDISABLE_BRANCH_PROFILING
CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)

all of which disable one of the instrumentation options, either per file
or per directory, in order to break recursion.

I don't know where exactly there is a problem with recursion in
the MMIO trace, but I can imagine that one of the other instrumentations
ends up doing an MMIO operation on some machine.

The part you obviously need to avoid is that running 'perf record'
to trace the MMIOs itself triggers more MMIO.

> > > Also, I see that this "disable the trace" feature has already been asked
> > > for for 2 other drivers in the Android kernel tree, why not include
> > > those changes here as well?  That kind of shows that this new feature is
> > > limited in that driver authors are already wanting it disabled, even
> > > before it is accepted.
> >
> > That can be done later on top of this series right? This series mainly deals with adding
> > initial support for such tracing, there could be numerous drivers who might or might
> > not want the feature which can be added onto later. We can't actually identify all
> > the driver requirements upfront. As an example, we have already used the flag to
> > disable tracing for nVHE KVM, so we know how to use the flag.
>
> Again, make it explicit in the driver file itself that it is doing this,
> not in the Makefile, and I will not have any objections.

We discussed a few options already, but we can revisit this again. The
current solution has a per-file compile-time switch and a global runtime
switch for the tracepoint.

I think moving the tracepoint into the header would make it a per-file
runtime switch (depending on how it gets inlined etc). I think that would
avoid the need for having the compile-time disable switch, but may result
in an excessive number of tracepoints.

       Arnd
