Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF744EC60A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245107AbiC3N4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiC3N4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:56:47 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447516EB00
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:55:02 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id t11so36936180ybi.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q91+udaPfkikoXVsmrkPYxbQ6mQZheByBkLR51EBLso=;
        b=QlKoswTnuWcy0GKiy459UIMZAEil7yMBJAPk3UUCoOZZ3ynW5YzHrKnf0PsG9TiWqj
         zg2BGpmbZxbEorRIE3OGkmJWmkxrm4XX9TX2G3pL2tavv8gYQTDLlIGaAiaP/FlXMkyJ
         7lzBIQYBJy8Id/lRNy4lIEW3RinLniERxKfM2lWEwh5F1bXTZweVL8+HepwydIIaKLIf
         Xu6THxqoocaydEKFo7sp8soJPmIo3s7objjk8Uko6JMY/62lPjizNu+kJhUloAGD+ZHK
         aqTM0FKPvZj3mHDnN0/qmN0PsRRbM05GtcmAe74nSVzsoimN0EYNUIhstvkdEzGCAPQa
         7ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q91+udaPfkikoXVsmrkPYxbQ6mQZheByBkLR51EBLso=;
        b=FXyXNWLKxaHjALurvD9erjZZJSNHH8xqqIhtVKsHlLeMRzhAoeOSRfUjIVkMEWCrbm
         Nlx8TR22fgkuJ2mFvyjVBo/Hm41s1YzhQ6aBYkOUGXBbcsSuLyhPUcEN6YF50jZWbZVY
         i24T9ofEQil/SJM4IOLKzZRDYnlgk9u9S/o53DUOCwPU+JKZuFrS1S2Fv13shnxiZfFt
         4672XKIEi3fD1KayjViNjhbtUAFXUePn0UBu4cro7R771R72kxF/bJZXbBriMF9m9VXw
         qn6ujuZQztJWk7Nx2PncgepzxWvPoWZzNApEuTnVSps13Hofj76eH2Fk5dD3gdqnmstL
         3ycw==
X-Gm-Message-State: AOAM5334MmyB8NoF+zoRmxJFVKwF819Cg2dC59vyRM/943L+hr8FZpLM
        FGCdT39zRTjWaIbkyYLfTHgseURrEiwO1MC/W2QZLQ==
X-Google-Smtp-Source: ABdhPJyqnWcakti9oK8dCIkF3XFE6/D1gUZjFvowPmRBx0Zr0pP1x4y+gBIXnWZwlirsMlRE1F4tkx0flJ8w9wn072g=
X-Received: by 2002:a25:a0c5:0:b0:633:63da:5ead with SMTP id
 i5-20020a25a0c5000000b0063363da5eadmr33457010ybm.412.1648648501392; Wed, 30
 Mar 2022 06:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtk6rpp=0WG9LyfQRCsMbbvf=P7uhMuon4RzZz3UjYVYQ@mail.gmail.com>
 <YkQOoQRUKemBEn02@kroah.com> <CA+G9fYuK2GDqWHuW3oOi2O0h4RWsLLQb9198i-PS=nMf1t0T7w@mail.gmail.com>
 <YkQT0ROhctplAuds@kroah.com>
In-Reply-To: <YkQT0ROhctplAuds@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 30 Mar 2022 19:24:50 +0530
Message-ID: <CA+G9fYv9uNrUTv2TQfV6yW98qQBxhJ9Fg6UwHLJKYbPHEGHFtA@mail.gmail.com>
Subject: Re: mainline: qemu_arm64 boot failed - Failed to start Hostname
 Service - Stopped Serial Getty on ttyAMA0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 at 13:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> > > That's a lot of userspace logs, any kernel logs showing that anything
> > > failed?
> >
> > I do not see kernel logs failures here.
>
> Great, then the kernel is working just fine!  :)
>
> Seriously, without some sort of hint, it's going to be impossible for us
> to know what to do here...

Ander is bisecting this problem.

OTOH, I am looking into test history and found the head commit is booting pass.
The problem report I have sent is a head-1 test report.

This means that, current Linus master boot pass.

Do you see any relation of top fix commit vs the report I sent.

BAD: 965181d7ef7e (head -1 )
GOOD: d888c83fcec75194a8 ( head)

git log 965181d7ef7e..d888c83fcec75194a8

commit d888c83fcec75194a8a48ccd283953bdba7b2550 (HEAD -> linux-master,
linux/master)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Mar 29 23:29:18 2022 -0700

    fs: fix fd table size alignment properly

    Jason Donenfeld reports that my commit 1c24a186398f ("fs: fd tables have
    to be multiples of BITS_PER_LONG") doesn't work, and the reason is an
    embarrassing brown-paper-bag bug.

    Yes, we want to align the number of fds to BITS_PER_LONG, and yes, the
    reason they might not be aligned is because the incoming 'max_fd'
    argument might not be aligned.

    But aligining the argument - while simple - will cause a "infinitely
    big" maxfd (eg NR_OPEN_MAX) to just overflow to zero.  Which most
    definitely isn't what we want either.

    The obvious fix was always just to do the alignment last, but I had
    moved it earlier just to make the patch smaller and the code look
    simpler.  Duh.  It certainly made _me_ look simple.

    Fixes: 1c24a186398f ("fs: fd tables have to be multiples of BITS_PER_LONG")
    Reported-and-tested-by: Jason A. Donenfeld <Jason@zx2c4.com>
    Cc: Fedor Pchelkin <aissur0002@gmail.com>
    Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
    Cc: Christian Brauner <brauner@kernel.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

- Naresh
