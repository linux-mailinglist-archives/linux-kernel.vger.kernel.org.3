Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DF04B09C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbiBJJlh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Feb 2022 04:41:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbiBJJl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:41:27 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652A10BD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:41:25 -0800 (PST)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MA88C-1nTfkU014k-00BYfr; Thu, 10 Feb 2022 10:41:24 +0100
Received: by mail-wr1-f42.google.com with SMTP id k18so8410970wrg.11;
        Thu, 10 Feb 2022 01:41:23 -0800 (PST)
X-Gm-Message-State: AOAM532FlZbzThx9zWPgYSmUFoDGJC+hFyS/v5J9R9p3sn2ApYzDZ5x/
        Sas5baxFJwnIk2DNNyhzU/HFySxP3/sv7fmPsNc=
X-Google-Smtp-Source: ABdhPJwFAXHn/oxpkrKGkjNdQCVhvPPwJqoR18BfcNL1lEqEkdOenRkU6MzFWE9oH1War435497Ub7+zNJE6VpNe5D8=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr691958wrn.317.1644486083668;
 Thu, 10 Feb 2022 01:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20220210021129.3386083-1-masahiroy@kernel.org> <20220210021129.3386083-6-masahiroy@kernel.org>
In-Reply-To: <20220210021129.3386083-6-masahiroy@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 10 Feb 2022 10:41:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3biD8Fmd2GMTkwPtU1ezinvyvbBZqey0cAiJh4_5svKQ@mail.gmail.com>
Message-ID: <CAK8P3a3biD8Fmd2GMTkwPtU1ezinvyvbBZqey0cAiJh4_5svKQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] kexec.h: add linux/kexec.h to UAPI compile-test coverage
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:ehHi4GhNJ7W0pBtKH6PXaACeiIpDdyufnrP9Kn4RSrxY28y506Y
 tv9ROIN7wsDt+fkuc5im9FXCHrt9coUqTp3xS9sWgFw+iTVimamqcQgewNppZi1G3ClkwZW
 xugVn7mWYP6SWeR6MrYmS9BMtbcJnmI5hl1No4L9BGvXOdlfxLE39JGiB3h2vgLq4htBNdU
 +jNNPTtNf61R3gOmmRw+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Y1Zfim1SUg=:lshKHt9XIcC0g53QA+RLsv
 9WnMb6OzI5qOpw+NJPIY6CBfQzRSCSeROAbBop4dkbcW/g20rWCqgfUty7I0oP3aaLkE+LTZH
 h5KRm1ePW2qaG3mEz7VsWj2sjyiakZ4L2AyDbEHL28NuXnNQoeD8JPolqvgNAoA9YRgNIRi1I
 /c8g2EyQ9NbJuRJCNgIfjv14cD1N8RhTIo0zTpRM06nHejtOqeabE5oYojFnDxeBgfrUq/N+l
 boQoNbNS8iBgb/gmuSFcvW7R9d4JgC3AF9oOpPPE12GhmC5BvbSiz0Ab+HUSe4dzEKaeezrok
 HlBzv72A6SqXb/ikM+6R1/XeQ2jzsGLj2mq8I/wFMftD96OWf5wsjtzFsPe9PhJYzuiF8YwMY
 CaKsmc/NxoZuVV8MwRvQe47utwsgq7TOcu8uG5tBHz/BpX4w47w37pV1pBMFlx6yfNGlJXOt2
 6uHaE2CZyhzTE+M3FZNKrzD5huQ8H1yon3Gzztx/SjmJ40uGzxXXNfaFrFcGNE+NTVBcn0Yqw
 m0r+9ww9j9rsF1aY1AUDaiA/ZundGUOdBr6sv89X/xYVYfUhFOspUtED+ODyGLyD2HC7zDAP2
 KDosPz5RaKcy17Xo6a71ymPSNbb5kDs+9Z4RRCcGm5gYx7EoOe+kx5+91drfLJ2x4U62igUyj
 nvHZg1HemWfLvgssN6i1NbEOk0EntJ05nSrr6F3i7priwHHbi5XISMXa1QzkwxvMyoxv8OGba
 MFt6+DrSNdIUACPdUfvPwfMIPIibnWhh8wcwovunF3Vvy0I+Ui8ROZG7hETUfziT4+JXqopiv
 cQ4wm/Pfe7uACyWDN/oFxHsfO1wRnRvGfsUoA1Uy8MZzMsCPc0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 3:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> linux/kexec.h is currently excluded from the UAPI compile-test because
> of the errors like follows:
>
>     HDRTEST usr/include/linux/kexec.h
>   In file included from <command-line>:
>   ./usr/include/linux/kexec.h:56:9: error: unknown type name ‘size_t’
>      56 |         size_t bufsz;
>         |         ^~~~~~
>   ./usr/include/linux/kexec.h:58:9: error: unknown type name ‘size_t’
>      58 |         size_t memsz;
>         |         ^~~~~~
>
> The errors can be fixed by replacing size_t with __kernel_size_t.
>
> Then, remove the no-header-test entry from user/include/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
