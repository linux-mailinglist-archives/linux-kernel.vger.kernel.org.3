Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302944FE44E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356829AbiDLPFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiDLPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:05:14 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C35053B79
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:02:54 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ebf3746f87so109510897b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIbAv5l0ZDXFk0gGIWaCaLe3jbR9/lI410ENmUvMqQM=;
        b=kqj7qkJtL52OMGGmJXvu1R3jZsA6PdEDUae03GdOxaXFOJEtGO+7NTCEKbsuU5Q34R
         rzPMBK9/ZwZD9yftgLkTROTmNn+/sBaar5THDESNfmrFMQJMz0X9ngst5zUE4YvJVYi6
         NZ8VXVcQDFoYY//Jj/YXjqSxeROU0d7ullSZU4vrad54yHL2pzsX2GPeLVK/tdDbGkn0
         fTqrCVLQM1S95I4QeK4JAQIwE1br/bo46rTBbyJmtrSIc3u5rpL/XZyX0wkiVwCGPL/T
         lB0IWS6+TrtCKhBwlBvI2KNcHMu4SAEJCt4gZ9jbTHDl4SMFnm5BV/L5jrWXcxuSp7Ec
         tzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIbAv5l0ZDXFk0gGIWaCaLe3jbR9/lI410ENmUvMqQM=;
        b=c6kzNWUcJLfDzwhppSIGSXs9oJjltxr47AVlO7pytDaZEbfgdCL97J7b8dCUnzNpEa
         YWJEHGEFDZOf8yB6yzSzfvPC0JDdzkBvFCRzPzyd6GgxTx1lkmXnDBcGo/dkWySvzEbD
         wcYOhYKKfM3WlVq5VPmi53vW+akdivu0vcOXdWUApXU8PDUydcNqT0XC+ZHGPizss5TM
         oZpyKrASBgZD9Q9QR7tHhhS3B11U7GDT6i5Mmy3hg/C0iJ86wjsqk7/qpphdjyqbxSIF
         YoJuaHQ+0i9lxdY2K7tobjtCP1/z4RsLj/z3RtmpcodKppi1r/kwyEDiAmrVgRnbOeX3
         WLEg==
X-Gm-Message-State: AOAM533M2S4Y+2iOUM1W2GDNcdVKFY0nwNjQJuYUbubJ+MdfICTjmdnP
        nCSFlGkp8aT30EumRtezenNfFscWa1GQUeN4l3oacg==
X-Google-Smtp-Source: ABdhPJzhfSOvSjw+lOkAS14qwaHBIyYhHdoZcI0eRgLT+Oq6elsNJ0n3LPb6oFnFFgQ75oSoy4zjNkaN2iTGbdlHfkI=
X-Received: by 2002:a81:4e58:0:b0:2eb:5da0:e706 with SMTP id
 c85-20020a814e58000000b002eb5da0e706mr30458489ywb.412.1649775773341; Tue, 12
 Apr 2022 08:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220412062942.022903016@linuxfoundation.org> <CA+G9fYseyeNoxQwEWtiiU8dLs_1coNa+sdV-1nqoif6tER_46Q@mail.gmail.com>
In-Reply-To: <CA+G9fYseyeNoxQwEWtiiU8dLs_1coNa+sdV-1nqoif6tER_46Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Apr 2022 17:02:17 +0200
Message-ID: <CANpmjNP4-jG=kW8FoQpmt4X64en5G=Gd-3zaBebPL7xDFFOHmA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/277] 5.15.34-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 at 16:16, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 12 Apr 2022 at 12:11, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.15.34 release.
> > There are 277 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 14 Apr 2022 06:28:59 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.34-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
>
> On linux stable-rc 5.15 x86 and i386 builds failed due to below error [1]
> with config [2].
>
> The finding is when kunit config is enabled the builds pass.
> CONFIG_KUNIT=y
>
> But with CONFIG_KUNIT not set the builds failed.
>
> x86_64-linux-gnu-ld: mm/kfence/core.o: in function `__kfence_alloc':
> core.c:(.text+0x901): undefined reference to `filter_irq_stacks'
> make[1]: *** [/builds/linux/Makefile:1183: vmlinux] Error 1
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> I see these three commits, I will bisect and get back to you
>
> 2f222c87ceb4 kfence: limit currently covered allocations when pool nearly full
> e25487912879 kfence: move saving stack trace of allocations into
> __kfence_alloc()
> d99355395380 kfence: count unexpectedly skipped allocations

My guess is that this commit is missing:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f39f21b3ddc7fc0f87eb6dc75ddc81b5bbfb7672

Thanks,
-- Marco
