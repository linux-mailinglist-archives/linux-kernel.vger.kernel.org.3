Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26ADC4734DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbhLMTVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240549AbhLMTVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:21:41 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B99AC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:21:41 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so18506056otg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q53CkhpHffWksyF1itBHjjAo6QAyBy2ZgN1efbikzuw=;
        b=TpZK3f6OoKyakiXvISJLDpN1SQDEtqSw06x8oq7MAf/EhrcLpwzwlxqAAsuhPRBlBZ
         wHLgLFz8FWGh1Tt/3RwZ3J6e+qbjVjYrC+HoxLxBUu5ii0hUOYdvh7DkjySd28tvnm9F
         bISOeeuuAh7jEyA9/1WJozx9QTsxFGJZxjZ/1J/Be1PoWm5agHEnJgRy784TKPb0cTjg
         7pQuYp/wFfifbL5ePe36w6c9uWPJ0G6QyQ5k/KIXMAjjnWgHHZ3/Ed/RCgj1EBrOloeu
         o0xjlb1nDQiQ2xkTHFz+DfE+zdnLOMioANUXa3I2Fk+lXGpxokOj9phu6VUnBnm/aqMe
         MP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q53CkhpHffWksyF1itBHjjAo6QAyBy2ZgN1efbikzuw=;
        b=mq7gRXL3s565Fsox+E15larkxWMS03aoxvqcvF9SRQ+W5t9Pmla/TzlDaRlhdO+JXF
         OUHIeA+DQTB7W43ED8RG1ve2uV8mJjmagncmLT0KVnqhXIb8MdG8dBJBas4+QXU5hdSV
         2VVqkuvRiHDN4C/bePv/5a9XWzwt5SVEL9DoL9Hi3evNKLRkdxI1UPuwMz04rjVCX9HG
         g+1mghykXe/cPoUVrK9Zln9hjvjOkOUoL5hgl09dfF3t7Z4HE6o2YcjNrmR+xe8pPYVW
         LE5XrkUC414mwcsOzBIetlleCiPooU7Hmv0UwS0z9M8ui+4+8oYi3tyC8GiT9IaAb46m
         sxVA==
X-Gm-Message-State: AOAM533bl1PqajqfgsZWdaL9f8poeqUFvXNyfdcmS59PA7jjXESpEuBr
        4DnVdb8F61mRCQXhSUocall4zAC1Rrtxgnq1LKAtvw==
X-Google-Smtp-Source: ABdhPJyjfZbz7ZWGYCsyCFyT4yAR4kjpNIxYUZfsK6dxnxuosAsMPuaSC3dk1eG2WrixZHegqDxVMNmvzWttkfDfjxg=
X-Received: by 2002:a9d:5190:: with SMTP id y16mr466346otg.364.1639423300336;
 Mon, 13 Dec 2021 11:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20211213092939.074326017@linuxfoundation.org> <20211213103536.GC17683@duo.ucw.cz>
 <YbdAE9r9GXZlnyfr@kroah.com>
In-Reply-To: <YbdAE9r9GXZlnyfr@kroah.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 13 Dec 2021 13:21:28 -0600
Message-ID: <CAEUSe794fvuFwWPDvTeK1TRZw3OizSWOdDsVzVdj+SuWZA_LxA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/132] 5.10.85-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, 13 Dec 2021 at 06:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Dec 13, 2021 at 11:35:36AM +0100, Pavel Machek wrote:
> > Hi!
> >
> > > This is the start of the stable review cycle for the 5.10.85 release.
> > > There are 132 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> >
> > I'm getting a lot of build failures -- missing gmp.h:
> >
> >   UPD     include/generated/utsrelease.h
> > 1317In file included from /builds/hVatwYBy/68/cip-project/cip-testing/l=
inux-stable-rc-ci/gcc/gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm=
-linux-gnueabi/8.1.0/plugin/include/gcc-plugin.h:28:0,
> > 1318                 from scripts/gcc-plugins/gcc-common.h:7,
> > 1319                 from scripts/gcc-plugins/arm_ssp_per_task_plugin.c=
:3:
> > 1320/builds/hVatwYBy/68/cip-project/cip-testing/linux-stable-rc-ci/gcc/=
gcc-8.1.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/8.1.0/p=
lugin/include/system.h:687:10: fatal error: gmp.h: No such file or director=
y
> > 1321 #include <gmp.h>
> > 1322          ^~~~~~~
> > 1323compilation terminated.
> > 1324scripts/gcc-plugins/Makefile:47: recipe for target 'scripts/gcc-plu=
gins/arm_ssp_per_task_plugin.so' failed
> > 1325
> >
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/li=
nux-5.10.y
>
> What gcc plugins are you trying to build with?

We saw a similar problem with mainline/next about a year ago, after
v5.10 was released. In our case it failed with gmp.h because
libmpc-dev was not installed on the host; then libiberty-dev was
needed too, but that was not sufficient and kept failing with this:

| In file included from
/poky/build/tmp-lkft-glibc/work/am57xx_evm-linaro-linux-gnueabi/linux-gener=
ic-mainline/5.14+gitAUTOINC+7d2a07b769-r0/recipe-sysroot-native/usr/bin/arm=
-linaro-linux-gnueabi/../../lib/arm-linaro-linux-gnueabi/gcc/arm-linaro-lin=
ux-gnueabi/7.3.0/plugin/include/gcc-plugin.h:28,
|                  from
/poky/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/scripts/gcc=
-plugins/gcc-common.h:7,
|                  from
/poky/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/scripts/gcc=
-plugins/arm_ssp_per_task_plugin.c:3:
| /poky/build/tmp-lkft-glibc/work/am57xx_evm-linaro-linux-gnueabi/linux-gen=
eric-mainline/5.14+gitAUTOINC+7d2a07b769-r0/recipe-sysroot-native/usr/bin/a=
rm-linaro-linux-gnueabi/../../lib/arm-linaro-linux-gnueabi/gcc/arm-linaro-l=
inux-gnueabi/7.3.0/plugin/include/system.h:691:10:
fatal error: libiberty.h: No such file or directory
|  #include "libiberty.h"
|           ^~~~~~~~~~~~~
| compilation terminated.
| make[3]: *** [/poky/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-so=
urce/scripts/gcc-plugins/Makefile:48:
scripts/gcc-plugins/arm_ssp_per_task_plugin.so] Error 1
| make[2]: *** [/poky/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-so=
urce/scripts/Makefile.build:514:
scripts/gcc-plugins] Error 2

We worked around it by setting this in our (legacy) Arm 32-bits builds:

  CONFIG_GCC_PLUGINS=3Dn
  CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK=3Dn

This is with GCC 7.3.3 cross-compiling from within OpenEmbedded
(Sumo). Our newer system works fine with GCC 8, 9, 10, 11 and the
Clangs.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
