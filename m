Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B260B5732EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiGMJgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiGMJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:35:57 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB9F5105
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:35:38 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id p13so6374231ilq.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hCvbhUuE7iA1/u1sNKoZ3id9VEaO10A7n+3QCiRIug=;
        b=hfH7DEq5PaONpaOoC647h1QB7wqN7ibRVfxQ+Xv95kLw7AhVojhtcQgrKDqLicU4QE
         GwcQYYXHEXeoVPCquIZ/TOddIAdtxbFMosgwecmOQV58ZycM9NzoI78HyWgQC++dJMNd
         dWW8QSN+yFeLDmP3WyS4cskhDfC3zUx5N3EirLIjL/KbsUFyv7j9BWkRqLdC8wKIlFwv
         nZx+6pkV+ELrnrsconDcEOSD6uM+uc8CjOWQBLyNVxXssJ2QillHuTmCAO3IqbRJLriG
         fmunFgvzm1yDRy9Hz+eP9qiBqd0Rn5VQtCzXMnkTEfqmspVhCtT8okVrktepS73pNCjm
         ReFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hCvbhUuE7iA1/u1sNKoZ3id9VEaO10A7n+3QCiRIug=;
        b=X4XFCDD2/xgGYxxWkDLeeFDCegaysorr3365llKbazvvwdTKl/vkYAJilh7hqgktjc
         4FC7P+WAjdbM70RRzli+FOteZ/uju0lCHaWGkr0BN6DUKdaDLm0eikYZslS7K1tnmonO
         2/KDwa0n6slnlCLl493Osds02SbeeYl3gS1C7b/KClvjXcwFEht64xL4oinx9Y7WZRQj
         u2R/xEUJEYfidNGZszKuK90a+ftWGjXok/4Te0WFO+SNElE8dOj1DVcM2G04XDLCnq9a
         3v/nQZw2d9QKk/xO6ILdDFbrJqyyytWoBbCPlrqB48mFodX6y7UZRmGbWd1GLMSx6kD1
         w0ZQ==
X-Gm-Message-State: AJIora/nDmX64131T9C+zRAhxzInj5yk+h3M1Du3XPxA404gW+bPzhEo
        CzZodaxidLlmebzmB38PoUpsflkjcZjD1hEy3FgHqA==
X-Google-Smtp-Source: AGRyM1t9eiVKIpWe4xlNSO62SErkGf4i8C+vihhnHmuNi/We+kH/fQZ2vpDcp0Tiu2AjZh1r5+/53BhiqZgn9YTo1sk=
X-Received: by 2002:a05:6e02:1549:b0:2dc:616a:1dd4 with SMTP id
 j9-20020a056e02154900b002dc616a1dd4mr1338068ilu.131.1657704938001; Wed, 13
 Jul 2022 02:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220712183246.394947160@linuxfoundation.org> <6acd1cd0-25aa-eb9c-4176-49f623f79301@gmail.com>
In-Reply-To: <6acd1cd0-25aa-eb9c-4176-49f623f79301@gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Jul 2022 15:05:26 +0530
Message-ID: <CA+G9fYsBFy65-Y1Yo_Zr_bJWGV6QYhMaEhyaShOG+qoOD7pu+w@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/130] 5.10.131-rc1 review
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
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

On Wed, 13 Jul 2022 at 04:45, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 7/12/22 11:37, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.131 release.
> > There are 130 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 14 Jul 2022 18:32:19 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.131-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h


> perf fails to build with:

I have also noticed perf build failed.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

In file included from util/intel-pt-decoder/intel-pt-insn-decoder.c:15:
util/intel-pt-decoder/../../../arch/x86/lib/insn.c:13:10: fatal error:
asm/inat.h: No such file or directory
   13 | #include <asm/inat.h> /* __ignore_sync_check__ */
      |          ^~~~~~~~~~~~
compilation terminated.

Build log:
https://builds.tuxbuild.com/2BrKWlDZbrZwQIfxzeMf6fv37sn/

>    CC
> /local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
> In file included from util/intel-pt-decoder/intel-pt-insn-decoder.c:15:
> util/intel-pt-decoder/../../../arch/x86/lib/insn.c:13:10: fatal error:
> asm/inat.h: No such file or directory
>   #include <asm/inat.h> /* __ignore_sync_check__ */
>            ^~~~~~~~~~~~
> compilation terminated.
> make[7]: *** [util/intel-pt-decoder/Build:14:
> /local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o]
> Error 1
> make[6]: ***
> [/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/build/Makefile.build:139:
> intel-pt-decoder] Error 2
> make[5]: ***
> [/local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/build/Makefile.build:139:
> util] Error 2
> make[4]: *** [Makefile.perf:643:
> /local/users/fainelli/buildroot/output/arm64/build/linux-custom/tools/perf/perf-in.o]
> Error 2
> make[3]: *** [Makefile.perf:229: sub-make] Error 2
> make[2]: *** [Makefile:70: all] Error 2
> make[1]: *** [package/pkg-generic.mk:294:
> /local/users/fainelli/buildroot/output/arm64/build/linux-tools/.stamp_built]
> Error 2
> make: *** [Makefile:27: _all] Error 2
>
> you will need to pick this patch as well:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0705ef64d1ff52b817e278ca6e28095585ff31e1
>
> With that one applied:
>
> On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels:
>
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> --
> Florian

- Naresh
