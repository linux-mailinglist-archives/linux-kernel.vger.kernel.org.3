Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016B757F9E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiGYHIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYHIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:08:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4B4DEC7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:08:40 -0700 (PDT)
Received: from mail-ed1-f49.google.com ([209.85.208.49]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MfpKZ-1naVuI0IQ5-00gFg3 for <linux-kernel@vger.kernel.org>; Mon, 25 Jul
 2022 09:08:39 +0200
Received: by mail-ed1-f49.google.com with SMTP id z15so859147edc.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:08:39 -0700 (PDT)
X-Gm-Message-State: AJIora/4v150fb0HZR4Hm+UF3PPNkVjkDYpQMcuzguLLPP35Ih047ixq
        TtErkf/qnIiW8UCZpTraTmcxrk2hAkKPoz9A+ew=
X-Google-Smtp-Source: AGRyM1tlBDTGYGMdEtAzM8YjBusv7obdsIb0Rh2X5JBZzixsvidrbXN3KXbGdXtRFdoyYjFOeu/a5YbjrMzzkCrbpV0=
X-Received: by 2002:a05:6402:331d:b0:43b:ee33:8a5e with SMTP id
 e29-20020a056402331d00b0043bee338a5emr5364735eda.49.1658732918750; Mon, 25
 Jul 2022 00:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com> <6a85baa4-80cc-a715-b5f5-fcc276d44010@huawei.com>
In-Reply-To: <6a85baa4-80cc-a715-b5f5-fcc276d44010@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Jul 2022 09:08:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2VaG1UB4pB0=9K=qfS_Mjyiiuy+ngOU4ttKMoZTQ4Tbw@mail.gmail.com>
Message-ID: <CAK8P3a2VaG1UB4pB0=9K=qfS_Mjyiiuy+ngOU4ttKMoZTQ4Tbw@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
To:     John Garry <john.garry@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        jpoimboe@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:v9bMzUgyLiTfKuzieFy79C12gR1Nqd3b0jpTHekF9X9ZQ01ieqg
 H86OSOi2oMiG5cPW0TT5WX8hLnR8KCAhOLYYuiRX1beA2eqvEOPQjIyEypi1x9decd9Ovt9
 7Cp8Abbe4ns3oQdXqOo9mB8tVr35EYN3KqcB5G9bXOi1xoJHQ+MQIJ9KWKTknMWrz7nUfwt
 Rd27cT7ff9v9jW5SCz/Yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g+rFT8D7kZw=:3Nvq37rNOmEGGbXeKVTCss
 g6Q3OIitCRrSwgqnNkaLT1gVVgSqdF+i8c9aJQ00YKNqx989GX4qaMFA0n3YmYD0GrjHmknMn
 JNFegVz8tZrgQFCldBlktthaLuVvn6/2ztKQuAA/POY33pIwZpK/mIlkLkTfsjNI1OeQ2fU62
 9ZpM34fxgqhgpHz/v2Vb35LQ9RgQbsOk/XsSrkxY/XQ4N25u+EU3R705A8Ix4Ywj4nj30MBZ1
 xRK7+xHYD+HhCIvya9K6jYR4U6rlU4qme8QRMDxsEa9OIypKqRQhAOvBHN45QCbkRtruYyS5g
 Qo8RW9Q361M10w05ioEHabI43kBihndIR9nEKGRXYn09s/hPsJsQBo4rUuh8J++faIoj86kLI
 vcbFxCKkkABaRWfhHiim+/f/LmoZzC6busKKuYoKU7kMBX1PMcV5TbPM44v8xUWXKeTHQGx7h
 P8byKlCB9cJxVuO4Wn3lrfs2B7uBRDS/SrilWhMVarK3cpUwfh59BFxyKEg6Tx9xsQEor51lT
 tdDxXFaHt8k0N0crUtmciX7CUEZlF2JS1t+u1R+Nqoqbq4IeonRqHSmeeTKXIzy/etjwt1mDj
 Udl3no7kWRN4nm+DRtqahVvuVRIZGzqm4Sewx/6E30Z32HyMaV9qgfEUBsgrFA0tQ/bLn7v3b
 vQJYKmJ7e8V5WfXchMLv/NImLjJskIOH9UiEMwg1da5NEu1Pv16JdRliKHMh/JCerKWFuRew9
 UHlLoBNgJvMWrDZB1W2aJkj1DJLMYedXkKPN2mB+yGCwxSmECVpndrWtQD2v+Zq3EFtWSsacl
 fyhDVKABNqyPtkwjU80WcoN7MqoxrZg4ZWcV+MofJM4VNse5/4aRU//g0sgqocWGLz15r50hA
 PN71s7n3orjSnzyTHV9A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 8:50 AM John Garry <john.garry@huawei.com> wrote:
> On 24/07/2022 21:35, Arnd Bergmann wrote:
> >> Note: this is based on next-20220722 and it may be wiser to sync the
> >> defconfig manually (instead of using 1/2). Indeed I am not sure what is
> >> the policy is of sync'ing this anyway.
> > I only synchronized the 32-bit defconfig files in my tree, not the 64-bit
> > one. However, I can't really apply your patch 2/2 because you appear
> > to  mix refreshing the order of the options with changes that remove
> > options that are gone after a 'savedefconfig', risking that we miss
> > other bugs as well, as seen from your diffstat:
> >
> >   1 file changed, 36 insertions(+), 48 deletions(-)
> >
> > I have refreshed this one as well now, which on my tree gives me
> >
> >   1 file changed, 31 insertions(+), 31 deletions(-)
>
> I am not sure what you are doing in this refresh - can you share the
> steps? I guess that you sync with the savedefconfig and then manually
> edit the resultant defconfig to restore the configs which were getting
> deleting (and not just moved around).

Yes, I did it manually using vimdiff here. I had scripted this for the
arm32 defconfigs, but my script was a bit fragile so this seemed easier.

You can find my commit at
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?h=arm/defconfig&id=abf73c76121d8417998356a1cccfccd17f5cfd11

> > These should be checked manually to find out why savedefconfig
> > no longer shows them, it could be either a bug (a new dependency,
> > renamed option, a driver randomly selects another subsystem, etc)
> > that we need to fix, or a harmless change (driver was removed,
> > option is now intended to be default-enabled, ...)
> >
> > If you want to help more, can you check some or all of the above
> > and send patches to either re-enable the options or remove them
> > individually with explanations about why they are no longer
> > part of the savedefconfig output?
>
> ok, I can check them.

Thanks!

        Arnd
