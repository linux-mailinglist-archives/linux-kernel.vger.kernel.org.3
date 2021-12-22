Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD647D307
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbhLVN3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:29:36 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:37617 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241120AbhLVN3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:29:32 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MTRAS-1muYZr1IoG-00Tng4; Wed, 22 Dec 2021 14:29:31 +0100
Received: by mail-wr1-f53.google.com with SMTP id r17so4967891wrc.3;
        Wed, 22 Dec 2021 05:29:31 -0800 (PST)
X-Gm-Message-State: AOAM53018Wn/QovgbxU7od89+8UMdNkllmsQ54zJ+GZTC+YlXsgHiw43
        8a+pz0HeyZ6+Fj9qxH3KMTDjpPObohrT9dgcCkw=
X-Google-Smtp-Source: ABdhPJw0nfzYEJHZ07y3vp99CtMxCtIx4hPphKIiW8tqqMsfij+vBR7u+JaOTSFOhAqaTYEbtHQeGItEWv0smRfi5/Y=
X-Received: by 2002:a5d:484f:: with SMTP id n15mr2115267wrs.219.1640179770964;
 Wed, 22 Dec 2021 05:29:30 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <CAK8P3a37+0=CCE7283VQ4QZ1tZqcU+A2POUGXtvdM46ZMHx-gw@mail.gmail.com>
 <CAJF2gTRAxX0qEcNmw+5N=3jZcJw9YF75oRjT7Y5FUMUkHoSz4Q@mail.gmail.com>
In-Reply-To: <CAJF2gTRAxX0qEcNmw+5N=3jZcJw9YF75oRjT7Y5FUMUkHoSz4Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Dec 2021 14:29:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a07-v8WXxD7SHS0j42=bZgqDrOKGmisiuz=DbvYno5-SQ@mail.gmail.com>
Message-ID: <CAK8P3a07-v8WXxD7SHS0j42=bZgqDrOKGmisiuz=DbvYno5-SQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] riscv: compat: Add COMPAT mode support for rv64
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
X-Provags-ID: V03:K1:Z4AZ0RtUE/bW5imsAOpvq/znjHBp2Dprai2fhoHMCumQ4tCePKb
 XCxNHIcswbH73Up2QxjMWJ5Q2mLLfD1gtx+TiEQaiOuRNhDmLajSP6ese1p/Iy4YS0nha+M
 FKAfHkez+grRQ6no0IQ7ERAUD4Tur/pLT4erhfTYjGFOtJeiLxGMnWb/DMRjGyeUKA6Gz/T
 p6k6sxy+m6E5uRKd7E+ng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qSBnKV9xKxI=:4b9T8BQoEwjMl1WUbcMFag
 +zWzuCcJ57Ya4mZJvKp2snYuxqaH9JQPT4eu7wVs0ppxPIkuiJBak7du11iIEgRBIt8qQV/F/
 gz9tynN6CR124x9La2yE5sVfAfxZQ98lx2FRMaoNVZaGUNXXL1OSDBlWLKduf/2zi34grkxQI
 xzWfPGeI4wP0DdFu1GrYWIGuLzgnMEuPXztoLhpXq/eF2fpSGIoVV752BmXeg2I7ToYTUUXAr
 E7KFHCPaCQAoPkWD24DqXZ6XdMZ6jNPAEZLeVayVmIuTxygqGY9PMv7VJGlYto+/JDHYEZril
 TZEjwr3bMI/f6yzcKvMy/eiymBCUcUnf8Qdo55b5ke5NV6G1Wc9YMgCbpM5OpPZdG/WrSbTQa
 G14jAu+j69STFkCaxt/YM8DZyVCyZwb3zDYwJGXHrWckWIR5mnznSRIt+VUbl29DXDqK1g45E
 XTf+u+XD1iqGqaHz2Cwkjgbt49/iAAe25YgSGqRnw808QxN9P3ko/9vv66txzJTPoRX1lWHif
 aEvJA7IauY/XOQcjWTo0v6SVBDQvLEPWuU1BTO9lJNgyz4riKIhkkt15ud9+PiqaofaPU+70N
 LJQibAB8SEgEqg/Dtrur3zkOPJLOuI2Jo3PY2hb3m024q6lU4+zkaIlj1q9I+2B0jljPfVK+M
 8jADBQEGZQZpSOIhsUJgMrB9Dzvo/5BlIc/J5a8A2npxRVl3ok88ctzZcLyJSPCI7lyo2n6VH
 m37dEfoEvcYWU0vuP3xk83MtAf6sNdseBbw5KWWXAoW6rydObK6itPM1JFF87Xj9pGjPCPTI2
 TKMNgOT3Dsg7xMZBIypBfW9Tfil7vx36lBqzFWsDLQwxa3xJMg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 1:59 PM Guo Ren <guoren@kernel.org> wrote:
> On Wed, Dec 22, 2021 at 2:10 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
>
> > There is still some benefit in b), but it would need to be weighed
> > against the downsides above. Can you explain in more detail what
> > use cases you have in mind, and which CPU cores actually support
> > this mode?
> The most reason is about b), see our customer's product:
> https://www.cnx-software.com/2021/10/25/allwinner-d1s-f133-risc-v-processor-64mb-ddr2/
>
> So I think all our next generation rv64 cores should support
> compat-mode. Compare to releasing rv32-full core, rv64 compat-mode is
> very cheap for our CPU design.
>
> You would get the answer when our new generation CPU is announced and it's soon.
>
> Currently, only qemu supports rv64 compact mode, that is my colleague
> (LIU Zhi Wei) contributed.

Right, that does make a lot of sense. I'm not sure we'll see a lot more of 64MB
DDR2 SiP implementations when a 128MB or even 256MB DDR3 configuration
has almost the same cost, but for any of those sizes I can see why you'd want to
run 32-bit user space, as well as 64-bit kernels.

         Arnd
