Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B315F4D7E12
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiCNJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiCNJET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:04:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C19528E17;
        Mon, 14 Mar 2022 02:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B15B7612B9;
        Mon, 14 Mar 2022 09:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF57C340F5;
        Mon, 14 Mar 2022 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647248588;
        bh=BCdwikr2vz55Gg6PuMXgetSu2UWOs0MXUsCZC+OCyyE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QahnG01e6jZc0dRks4DF6nDuGYJlCo/qGqpZq0DWYgiIZ0O8MFVA5Vgvgsw15t0qs
         +sJ0J79nzL05Ucf+ZHyJRFRafef1ntTgOFhWjbgPocBgiEcaQnOoq8iWbgesmqr1Bf
         qT2gzJx+BWAzjsGdWwqjnbu3tEA5GcJNa2JwjFLNk6f6Q+8eHjPuKKV9h8nJFMOlB2
         KEOtb7jgBM+sckCHFbFWYUeMyzvzMt0RFO9Pq+jaMcD14udVF1WAK93VegVe9r5/SI
         uFxblV0J6J6LKB6mJZMCf3fgv6PAKKnQKkrvcY5V40tCJv+sDyAfMv6H6WTzfVJNja
         sdQQZSs7hGXzQ==
Received: by mail-yb1-f173.google.com with SMTP id g26so29302888ybj.10;
        Mon, 14 Mar 2022 02:03:08 -0700 (PDT)
X-Gm-Message-State: AOAM532ED3LcxoHqq0BB0oZ8F3gaihBsD20SDOah0jSLiT7+k47OxnJi
        DWQOoTA6bRhEm03eKRH47+nnXoIMLnx/cc3pLsE=
X-Google-Smtp-Source: ABdhPJy8huQQmqnCSx9yI8of1v/BIBOYIbynMrebeBFvdYFpIPCFwVwclYk4awxHfJIfG6+KCP5D5ynA1anQobSsPqQ=
X-Received: by 2002:a25:af8e:0:b0:622:c778:c0a2 with SMTP id
 g14-20020a25af8e000000b00622c778c0a2mr17505799ybh.50.1647248587150; Mon, 14
 Mar 2022 02:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj1kXE02HH7vRUjF3iKAL+1idKTy-oOYyGnBd3g90m6eObBxg@mail.gmail.com>
 <YikByJteDEtKi4Xv@shell.armlinux.org.uk> <CAMj1kXGnwbe=YYWaRxaXioEfTJOdXg9JYcNddO8iifpWLRZCWg@mail.gmail.com>
 <Yinwq3Z9l0selLLS@shell.armlinux.org.uk> <Yin2jQqW+pUWJZ7E@shell.armlinux.org.uk>
 <CAMj1kXGkUJ=-4oA4GvBZNK94A1MrZ7UwKDN_tJRgwq8KF06VmA@mail.gmail.com>
 <CA+G9fYvEANOMekjvtu7agdVYQ_b8OMtxQdyAV2JT_vMdBU3VRA@mail.gmail.com>
 <CAMj1kXEVVZTKX_86bbTfLpFuDriV0-uwCMgSKDP+dzcD1L4XCw@mail.gmail.com>
 <CA+G9fYuO-sy+sZnhSz=A7Xm0LdSp2AT+7jCKLB33tZzK4izj3g@mail.gmail.com>
 <CAMj1kXGb_0FNU7capJEDWTZF2OegmZyBphhH8GuNqL7+YYLjZQ@mail.gmail.com>
 <Yip3GJDbJIYNeg44@shell.armlinux.org.uk> <CA+G9fYsjK7z3VUgaOcs+cCCQWNsXW58pbDqruev6ANLdcswF1g@mail.gmail.com>
In-Reply-To: <CA+G9fYsjK7z3VUgaOcs+cCCQWNsXW58pbDqruev6ANLdcswF1g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 14 Mar 2022 10:02:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEA8TmK_pqDxrEg5==OPfWp8LWEBE=iFhJ8-5cm_DOgyA@mail.gmail.com>
Message-ID: <CAMj1kXEA8TmK_pqDxrEg5==OPfWp8LWEBE=iFhJ8-5cm_DOgyA@mail.gmail.com>
Subject: Re: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 at 10:02, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi  Ard and Russell,
>
> Your three patches applied and tested on x15 tested by Daniel and reported
> kernel crash did not find it after multiple iterations.
>
> ARM: unwind: set frame.pc correctly for current-thread unwinding
> ARM: entry: fix unwinder problems caused by IRQ stacks
> ARM: Revert "unwind: dump exception stack from calling frame"
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>

Thank you Naresh.
