Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C267847D12C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhLVLog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:44:36 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:44969 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhLVLoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:44:30 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mxpqo-1mGYp11rw6-00zFvk for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021
 12:44:29 +0100
Received: by mail-wr1-f52.google.com with SMTP id a9so4311641wrr.8;
        Wed, 22 Dec 2021 03:44:29 -0800 (PST)
X-Gm-Message-State: AOAM531QCEHD57pOEaqDZmGr05iJKHX+dWRtp5xyBluCQyH9Ry7REkzr
        0GdvW//4sqWvYEY2QOxgZvfi5KYFPQncClGE+f4=
X-Google-Smtp-Source: ABdhPJyMFXz7aqbM7KdvBb77zETinuaSKzit22o64H1Git0wpQHkxlanFxDaPfbOiMZL+6FwJBcCxSM41Y+rYzB+cVs=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr1836953wru.12.1640173469025;
 Wed, 22 Dec 2021 03:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-3-guoren@kernel.org>
 <CAK8P3a3dS=Ne0Pd2qZc8vB2whM7AUcJ1BNbhtf6EEboWAPpSug@mail.gmail.com> <CAJF2gTTN1HZeycK-WOFH0EjmjtBB4T=9de6Qrjs=uhAsLoOFaQ@mail.gmail.com>
In-Reply-To: <CAJF2gTTN1HZeycK-WOFH0EjmjtBB4T=9de6Qrjs=uhAsLoOFaQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Dec 2021 12:44:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3m2Mz4Tvu+3cdji6iq_wvFZsYoyKvnaNKTEjE+ivex6A@mail.gmail.com>
Message-ID: <CAK8P3a3m2Mz4Tvu+3cdji6iq_wvFZsYoyKvnaNKTEjE+ivex6A@mail.gmail.com>
Subject: Re: [PATCH 02/13] riscv: Fixup difference with defconfig
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NcKuRv57fUJ/PqJdFQAJs1tvYpP4e80WQoLjl9H2Wpm7Qf+tOeo
 BZWsaT4Y9j6H4ZL2MfRTMvJImLS16hORmdllpGTjc3udSWUNJvAXyuFd3Lo5ozj7zf6MStf
 Z/I0nQ34emc2Z/NjTidwMNy3IEaw5t+vU3/6LYgJBsOcUg0oOarl5EW6kp+tyDhlPxhivYO
 kEE9ezNDqM794qgxbMB4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dBIY+UQfeSo=:B/21Tc2TG52oY8kkN0RHEr
 soJw7MSqgdixmpnjc5pK3QaF7Z/TCur0hZe4Hwo5LlAXImf/QbnPOkRNXz7zqQhDVh4R7L0rh
 YdUrynooQLu2w7Xp+ZlpuDILUjA2vDOxUMqTUvhqF0OXhC/35i+TB1xBdikogFQyGsbsMdKca
 VoBNTb8UpH45BVPPlbOFjWaKg9s+0UKqJI5zFddHkKl04k05uOROIYqrxk7ASckVx9rKt8Zz1
 C0qul2JqRkevrNgBINfDiur3PdlIgXIddHKhS8Njf325BoQMLqxEb3QaKgk2t6eEPWIqih5jk
 4QRwqvZS/Plz/A3C3e0HSUmXv2ZrI8WMlqNS6grBbzN6KVUi0LLhFlifvQHjRwi/9mWECyZ/q
 uX3QxuVPCPFt4Kydz9pj5DEu51fXxvjX1Nzh2mCLfTFReStMFUi5H3yUiaD3+yMiqZef4leKY
 6IG0nokWmzgqF8Sge2MtwuIDrgEMsg0o3c0Jz+XrtJENt+p1DxIfYfE4cE7qMANwT/T0SkqCj
 tzvvo9w5V5vn8Se/7oz8YBAewLA3n/pwEIdFjuGwKR7VvZae6x0RnK242a7ZtoUMtiZM7fBOT
 OEArqEvzCQGVma/b9BNtYZwiYZC1zHHfB9MheVDsGFyv/1rY6EAJAHo+B0UhHHbFSZb8sp9og
 rLG+NiOD19LKSsolBQ95NQDCagax3F+0qiwV5YHh1ExAMl/mKpzxxXSZ2Dhz0jEZI64kD0NuR
 kFPVYZa5I6E+JVMUkE77oxvjjhhPO2bseZP223ExzIIR/2EmZ///f1DEk+sTmkH9A+tgIJKTF
 PRcTH0dFQw1fJLJHQa3S964+CfGtj+Z8GYOgvoZR5aaX9XeOhw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 12:34 PM Guo Ren <guoren@kernel.org> wrote:
> On Wed, Dec 22, 2021 at 1:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> > If the intention is to keep them in sync, maybe use a fragment for 32-bit
> > mode, like powerpc or mips do.
>
> Some people are familiar with "make rv32_defconfig". There has a
> 32-bit.config fragment config in arch/riscv/configs/.
>
> I've tested with:
>
> make ARCH=riscv CROSS_COMPILE=riscv32-buildroot-linux-gnu-
> EXTRA_CFLAGS+=-g O=../build-rv32/ defconfig 32-bit.config
>
> The above is tested Okay, do you mean we should delete rv32_defconfig?
> I think it's another topic, I just want them the same in "compat"
> patchset.

I think what you can do is to add rv32_defconfig as a target in
arch/riscv/Makefile the same way as rv32_randconfig, and then
delete the other file, that will keep the existing process working
for any existing users.

Given that there are no specific rv32 SoC implementations supported
by the kernel today (other than SOC_VIRT), the number of users
would be close to zero anyway.

       Arnd
