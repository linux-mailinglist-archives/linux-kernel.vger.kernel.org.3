Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63283473ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244046AbhLNCnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:43:50 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:60615 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLNCnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:43:49 -0500
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 1BE2hKX6029367;
        Tue, 14 Dec 2021 11:43:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 1BE2hKX6029367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639449800;
        bh=zWqJkJ3Yer8HZi2smObNDPfx03+U9OxUYa5hXSXfyaQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KlDH3nQZxLc00O2/ojRRSkPKbMHJwoJ+9glPrPZ/xHnelPuCc1QpiPwpR+30cLugF
         iYR7yCwYC7639ql4xtW8JYVZjCY5rDwCv3snD5P1j2RN322fU4jkWvQjtKDMs5DIAZ
         JvNhwduGgPRdOZtgzcsruFTaHjuWlgwZuisABffnBxffedW/aRxb7t4/sC2rN+lmjR
         iscrjA8cpvRcUutKCRsuyRzzGJSAf9Mvq/xpMGAAEmcddeLAZDVyLI3063t/gBZtJQ
         Q2lHOlMKHvUYJirwawrMGkmQcv8rx4rcEP866xZukFl1RTjEBBhcYFgdisx6q+hZ0T
         z9qNi/HgZaMEw==
X-Nifty-SrcIP: [209.85.210.169]
Received: by mail-pf1-f169.google.com with SMTP id k26so16615919pfp.10;
        Mon, 13 Dec 2021 18:43:20 -0800 (PST)
X-Gm-Message-State: AOAM531oiHT85jqDGcreGNcKKZUNkNnNX0BfNhxxgiC1e+8SPcoLG1iy
        j+Kja9Co5zV/bomkj8LusS433tLoarbcG5a8y34=
X-Google-Smtp-Source: ABdhPJzDOB73Nb3ghIR/shFcM9taeEmYxVyIAEUWqwjrtD8gW7JVcPgHQkWoCDG4QAswQn4c40AYgIdzmFXXSlM66GE=
X-Received: by 2002:a65:430a:: with SMTP id j10mr1850778pgq.126.1639449799860;
 Mon, 13 Dec 2021 18:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20211213092939.074326017@linuxfoundation.org> <20211213103536.GC17683@duo.ucw.cz>
In-Reply-To: <20211213103536.GC17683@duo.ucw.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Dec 2021 11:42:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQ=m5jN3_fcD7B=-30V4S=XUf9axcQHjDJkihoDzn2mA@mail.gmail.com>
Message-ID: <CAK7LNASQ=m5jN3_fcD7B=-30V4S=XUf9axcQHjDJkihoDzn2mA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/132] 5.10.85-rc1 review
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Cc: Shuah Khan" <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 7:36 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > This is the start of the stable review cycle for the 5.10.85 release.
> > There are 132 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> I'm getting a lot of build failures -- missing gmp.h:
>
>   UPD     include/generated/utsrelease.h
> 1317In file included from /builds/hVatwYBy/68/cip-project/cip-testing/linux-stable-rc-ci/gcc/gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/8.1.0/plugin/include/gcc-plugin.h:28:0,
> 1318                 from scripts/gcc-plugins/gcc-common.h:7,
> 1319                 from scripts/gcc-plugins/arm_ssp_per_task_plugin.c:3:
> 1320/builds/hVatwYBy/68/cip-project/cip-testing/linux-stable-rc-ci/gcc/gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/8.1.0/plugin/include/system.h:687:10: fatal error: gmp.h: No such file or directory
> 1321 #include <gmp.h>
> 1322          ^~~~~~~
> 1323compilation terminated.
> 1324scripts/gcc-plugins/Makefile:47: recipe for target 'scripts/gcc-plugins/arm_ssp_per_task_plugin.so' failed
> 1325
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-5.10.y
>
> Best regards,
>                                                                 Pavel
>
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Does "apt install libgmp-dev" or
"dnf install gmp-devel" help you?


-- 
Best Regards
Masahiro Yamada
