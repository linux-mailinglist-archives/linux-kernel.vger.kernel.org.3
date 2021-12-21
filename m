Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5147C680
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbhLUS1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:27:44 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:57841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbhLUS1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:27:43 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M3lgJ-1mzT0n0c1j-000rN3; Tue, 21 Dec 2021 19:27:42 +0100
Received: by mail-wr1-f44.google.com with SMTP id v7so21371833wrv.12;
        Tue, 21 Dec 2021 10:27:42 -0800 (PST)
X-Gm-Message-State: AOAM530t98g5HXwcRIsBlqBE2l1Ez9+V3qFuQHb+eteU6pDQRNKylJnY
        4qeaZcCnj1SexybhtNjuRORBWr1uDN74QPACRO8=
X-Google-Smtp-Source: ABdhPJznn56uiIqEQGonQeMXabHARNb1MKKouJb7pEiJqRUGi0z4LrTZSA40EkADjYddnL79plKTAJq+Gzpiid35E7s=
X-Received: by 2002:a5d:6d0e:: with SMTP id e14mr3598547wrq.407.1640108340516;
 Tue, 21 Dec 2021 09:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org>
In-Reply-To: <20211221163532.2636028-1-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 18:38:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a37+0=CCE7283VQ4QZ1tZqcU+A2POUGXtvdM46ZMHx-gw@mail.gmail.com>
Message-ID: <CAK8P3a37+0=CCE7283VQ4QZ1tZqcU+A2POUGXtvdM46ZMHx-gw@mail.gmail.com>
Subject: Re: [PATCH 00/13] riscv: compat: Add COMPAT mode support for rv64
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        Drew Fustini <drew@beagleboard.org>, wangjunqiang@iscas.ac.cn,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UViDA59wo0S+JsDByocl07FN0iybuFgyTypYXB/iY5vHr2mBvR0
 lOl9K7841JZXIUyBWaRiLNOJoqm/RcottcwAsUQi+I+GkWY6ruD2l21RVFOubLsVtPytdjK
 OZRZEnvX5rBTqXAjItaulel/cEKI25LXhxEyiu7VZJyvojKGeXfrvAYwR+3aiRYei2bTZaw
 rPLwnnnsMuKeYOGC3ibpQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lrO5q1wt7OE=:t9Zqj/dmTSDfzdJkyN1luX
 aJsUpvnTN90/4oaaH9vpy7hvsntSuvIO3I623+nypeqh6hfd3U5+vhCcVMCAcrK69fuyrPl0e
 iEHwqBkabn8jIgPOVnRN75xHyCbkUC1kk/sCS4BoheWRefMpyZ37AJmwEBsDAbD/vWUZ8pE0s
 9sCQnLEl6Db/8AHXUIlk7uVIai7yppkKlpSLeXEccJEpKZ6UV7yEO5EvbTwI7nodGVcFJgZVE
 Hh0bhbOD6i08dhBCHGU2qIwOZQA1Iy8Lg+QkrDSFuH5VXSSO4WjIVcXgizMckIMmY3O1IaNnp
 3zfIcBywP+rq3k/8mW6MYoXI62SwyOU5UtFeMC1oRKx8Dk6W9kbH876O3DXs2SzqWTN45iDHv
 dpbRh7smgupF/j7jqGh9sELC+WbWPJxmOuZKQ0XNqaHEdGlKt5gEuq92TbOVcj5gJWyteCHR/
 hbA/tnVov3I0JDPgcE8YHfzw4yHrwqRzCjzdKMpzQqZG1K8EdUrrivina3br4k6ZOu/7f/HTl
 IvHuTGz98oPG8OJeB1hXG26spuc3lQnkmMY9/5by0LvUi1dC5ENZTCbof7KecIOi+zqx0eygn
 hK7OJIsAa/WYN+JJempIOYWz/4jcrujcwvQ+9wiGTR2sdmBtsqwfFZMxeAMTRA0edkmvT3/gS
 NNCyfU1KeLZpz2/80J9fuHknjXmUjlpI5t0VcikZpma3C1akIQtHe0V3qZte12iqIifn+bNOd
 DNHkm9GgVFepw1+YKjg35uh8bna4p6uRnny06ubJaAxJ0Qur2capHAW1wC7AYQ05GdZGTDuuL
 MPXv17kCfYVmmhj6kdJnj4BE2oHkWtXd7ZuHo8dKHC0/0x/Oag=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Currently, most 64-bit architectures (x86, parisc, powerpc, arm64,
> s390, mips, sparc) have supported COMPAT mode. But they all have
> history issues and can't use standard linux unistd.h. RISC-V would
> be first standard __SYSCALL_COMPAT user of include/uapi/asm-generic
> /unistd.h.
>
> The patchset are based on v5.16-rc6, you can compare rv64-compat32
> v.s. rv32-whole in qemu with following step:

Looks good overall, see my individual replies for minor comments I had.

I think there is a bigger question to answer though, which is whether this is
actually a useful feature for rv64. In general, there are two reasons for
wanting compat mode:

a) compatibility with existing binaries and distros

b) reducing the memory footprint of user space in a memory constrained
environment, either deeply embedded or in a container.

For the other architectures, a) is clearly the main driver, but equally so
this is not the case on riscv, which does not have any legacy 32-bit
code. Without that, adding compat mode would mainly introduce a
second ABI to a lot of environments that at the moment only need to
support one, and that adds complexity to the implementation and
the extra attack surface of the second syscall ABI when an exploit
may be possible only in compat mode.

There is still some benefit in b), but it would need to be weighed
against the downsides above. Can you explain in more detail what
use cases you have in mind, and which CPU cores actually support
this mode?

         Arnd
