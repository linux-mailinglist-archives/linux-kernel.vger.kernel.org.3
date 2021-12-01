Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503644648F5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347809AbhLAHms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:42:48 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:41785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347744AbhLAHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:42:47 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MPK73-1nFEwq37Hx-00PawJ for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021
 08:39:25 +0100
Received: by mail-wr1-f49.google.com with SMTP id v11so50097273wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 23:39:25 -0800 (PST)
X-Gm-Message-State: AOAM530TNBDgbgoNLpLACDnEoc8L/1TN9gbD8vqKIcpHwZ9Ln/EjRe15
        WFmzlBvKGXM2fx3IVd2uVGxC0LBK/yjkKmfHkCI=
X-Google-Smtp-Source: ABdhPJwvNRVCL/nM2dpSEG/anSd9Li4NuYP7RMZkVtAHnEbwsCl1N0uPe/rmQ6Ou9gQAQd5lqVHhjNQqzRJaTmxtW60=
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr4768401wri.137.1638344365444;
 Tue, 30 Nov 2021 23:39:25 -0800 (PST)
MIME-Version: 1.0
References: <202112011148.XrnWip5a-lkp@intel.com>
In-Reply-To: <202112011148.XrnWip5a-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Dec 2021 08:39:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0c+zE22ouZKF66gfoqNJuCZTv0r3nnDR+AjxgCLgE87A@mail.gmail.com>
Message-ID: <CAK8P3a0c+zE22ouZKF66gfoqNJuCZTv0r3nnDR+AjxgCLgE87A@mail.gmail.com>
Subject: Re: [ardb:for-kernelci 18/28] arch/arm/mach-footbridge/common.c:102:6:
 warning: no previous prototype for function 'dc21285_handle_irq'
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NuMjmCrvqU7/zV+jfMK+wzCGfg03OmEBBJp5CX7IyNvu/X5S1xv
 pclQcnmhFC3SBA9UZ3SYXAvy1UuWoFkHbiD6/pJrmKXnY2iqD0lN96FPvK7x9vwTV5+G3US
 eY8EL9Wp3D5P4CfKWxC3sRd/pHunM8WZrgbnI99TEvCNJOuILVoiDN8jNW/8dIpqZHb8Joi
 mMbjkbPmGW1RHHOjA4Imw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T+W2dBg9OJ4=:57HtRRMgV1HTNP+c2t3l6R
 NA22pWoHmUI1gFC4r7zUVkicWJGU2xtuyczGcC0UcexXqi8SbxQvQj4ZrhjfpOc9aoaMn8gre
 +5lBG0Zn7f1N8ZBxMWmZfuMCi0bF/pWKla7FI/a6kazVKt+VHX3JE/ciqbArKMX4lLwY5bfDG
 NST460+og0e5m09D/SIak/OQc713jGzcMIINH/i79SjXGum+T1B7wvw6Qqw1j2sk4wh9llKYw
 wmpyZDKtsLkPTdkgNe6VZlm9d4/rwLWpmHM1/yvhWSjXJIbhyw1z2zEwvv+1sNzDI1GZEI8La
 0jZcCEG6mTmvpejCJ/DeGVDtIx/VjEObkExznO1rZ1EU2kqQtHMMBpAkXpg8k6g07N03s+Bjt
 pnmXUA7pgVoirArFgGXg4WUcCJadQg8SKibAwfdguQtQ6Ud8TE2fo24slK151JWRp/M/1xPoP
 LS7CMpjz4cwqqRsobZBerNucs4c4jjC9Hjc9rNqXMxPGv92KfeQL1KTS9EI50MidefTRLbrKw
 x2cIRSO/77niJMrkwDQUh/4XVgZI3IebWZv0DkFWooRLwT3j9JH+CIxSxgZ7HYKiOdsSKuesV
 szESngPOjkiY3LEWiYDPpFHFpl8INg8Dgy+o8bfdUywen6Mp1zHUJ81MvdVngkPE0yPdAz2Us
 j2RNs3II/ZPlVo7/WNy8ZjRvDXBNZcY5rF3oY2l+Mhoe6ESMtjgSlheOcky35Qu7Ev4U=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 4:42 AM kernel test robot <lkp@intel.com> wrote:
>
>    arch/arm/mach-footbridge/common.c:102:1: note: declare 'static' if the function is not intended to be used outside of this translation unit

Correct, thanks for the report!

Ard, I assume you can fix this up in your tree.

         Arnd
