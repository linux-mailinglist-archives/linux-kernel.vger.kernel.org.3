Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D4A49AE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452518AbiAYIta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452171AbiAYIpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:45:38 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918FEC06C5B2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 23:19:54 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id i62so12569917ybg.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 23:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zemX1b6TJ8preP7NBXduR0Q+ixTKnGjWqI4oVSUxJQM=;
        b=ULwRLrFEYm108CDMrUWSDAjZ5CNZj7xP47ZhW6t5cSurZtNEpy8S1q65A4RaDVKx12
         Bun3OqnuM6P09OUGoTcZpk9ocmDZjs7lAYDSJMmGWqstk5fja0AefHFEveaAcAPAn/9C
         ZJVkh8z2L5HWXJwB9tAiaQUlfaegKhzuR++Y2/r8arrEl3mAZDL0MKx+WCwLZZWJyqwO
         CM+pJpEIKHtrozEByp/X9nC+GR7FoyLBorufFQn8LEs2nSFOoVXIQBQbjr7SJCpijZwL
         P8R+EXKhPUNeaxLdFAzvHx5QKvXJr3o8+6LsiLVWlYKolaygMAidzxGJc7N1rhgGjSJq
         Jz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zemX1b6TJ8preP7NBXduR0Q+ixTKnGjWqI4oVSUxJQM=;
        b=YDUtdvedxkm3KOApuf6eWbm6KiXCD73Xg7ljiBga/+7ARxuLBgR67F6n0wIgWiRGcR
         ePCDS0Q6ZHZyZUkoWcWMkLh02VG8qaxcjAKz7Uny1Y9qrnMjco94mn0PiGehN3lBNJfE
         3Ri2e8QL/4ak2lOVYozIPnNrJANaIXaLyeo+A8FXu7yHCJQRYG+dy7FORFmUE/ki21QP
         uECZxFDY6Eh4Kl4tSIsrEa2E/AkhvvOyYSKY9HX7US+JNSioIgrj7guHDk2/RNmd71P3
         pa0mSaXArzhEFSmt8Vgm0yvVzqwgM2I+DT28WYVBETb4WAyPSK2r+O9/4ns4KtHl6/ZR
         WfCw==
X-Gm-Message-State: AOAM533nL1ly8PexRMxZUL3hJDqXn1ffLY1Ksta3ZYGSM+f9ympzqbMR
        BwCO7Jm9nACOlCPJzxDji3yDXvZgf0KYLs/Eqe3wVA==
X-Google-Smtp-Source: ABdhPJzSCNIwSW9knqOAWRknnTZN1kDocqrpGezHGXfDLZyDvdZTj/Sd+9zHZuCWNPheDPwKCUWGePMrat72HKT+abc=
X-Received: by 2002:a81:1186:0:b0:2ca:287c:6cd5 with SMTP id
 00721157ae682-2ca287c6f97mr4858637b3.378.1643095193592; Mon, 24 Jan 2022
 23:19:53 -0800 (PST)
MIME-Version: 1.0
References: <20220124183953.750177707@linuxfoundation.org> <e2c9b01d-0500-645f-b4cc-f8dcb769996e@linaro.org>
In-Reply-To: <e2c9b01d-0500-645f-b4cc-f8dcb769996e@linaro.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Jan 2022 12:49:42 +0530
Message-ID: <CA+G9fYsvgQyUNBnySuiOrAXRrh4_ZAnqygZ0A5y7pGO5vrXAYA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/320] 5.4.174-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, stable@vger.kernel.org,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 05:10, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wro=
te:
>
> Hello!
>
> On 1/24/22 12:39, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.174 release.
> > There are 320 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 26 Jan 2022 18:39:11 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.174-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>


Regressions detected on arm, arm64, i386, x86, parisc.
There are two build breaks,

This is on Perf on arm, arm64, i386, x86:

>
>    libbpf.c: In function 'bpf_object__elf_collect':
>    libbpf.c:1581:31: error: i nvalid type argument of '->' (have 'GElf_Sh=
dr' {aka 'Elf64_Shdr'})
>     1581 |                         if (sh->sh_type !=3D SHT_PROGBITS)
>          |                               ^~
>    libbpf.c:1585:31: error: invalid type argument of '->' (have 'GElf_Shd=
r' {aka 'Elf64_Shdr'})
>     1585 |                         if (sh->sh_type !=3D SHT_PROGBITS)
>          |                               ^~
>    make[4]: *** [/builds/linux/tools/build/Makefile.build:97: /home/tuxbu=
ild/.cache/tuxmake/builds/current/staticobjs/libbpf.o] Error 1

This is due to,
commit b98ad671ae465a1a4f76d1438b97cd8172e0ce14
libbpf: Validate that .BTF and .BTF.ext sections contain data
        [ Upstream commit 62554d52e71797eefa3fc15b54008038837bb2d4 ]


This is from PA-RISC with gcc-8, gcc-9, gcc-10, gcc-11:

>    /builds/linux/drivers/parisc/sba_iommu.c: In function 'sba_io_pdir_ent=
ry':
>    /builds/linux/arch/parisc/include/asm/special_insns.h:11:3: error: exp=
ected ':' or ')' before 'ASM_EXCEPTIONTABLE_ENTRY'
>       ASM_EXCEPTIONTABLE_ENTRY(8b, 9b) \
>       ^~~~~~~~~~~~~~~~~~~~~~~~
>
>

Bisection of the latter points to "parisc: Fix lpa and lpa_user defines".

commit 73c8c7ecdc141c20c9dbc8f3ec176e233942b0d9
parisc: Fix lpa and lpa_user defines
    [ commit db19c6f1a2a353cc8dec35b4789733a3cf6e2838 upstream ]

>
> Greetings!
>
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org
