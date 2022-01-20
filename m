Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442FD494BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359843AbiATK0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:26:39 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:44115 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359849AbiATK0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:26:31 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MDQqk-1n3JeX0LO2-00AXcO; Thu, 20 Jan 2022 11:26:27 +0100
Received: by mail-lf1-f48.google.com with SMTP id y15so11517075lfa.9;
        Thu, 20 Jan 2022 02:26:26 -0800 (PST)
X-Gm-Message-State: AOAM532xDvuVhYMxLbcdtQvp1d215j2HzuUlfURZ/QSlKIUEAP93LuhQ
        lJwQvU/b2Qy7BZzYhvoUfCXyYvnAagNvyxJqJA8=
X-Google-Smtp-Source: ABdhPJzWEQOVmrSCBjLkthqjYvCekql2pWig3E9/sv1NmQbjWn/17+5wGi2Yo7L626/g8+PxrkZBITeqW35NrwNIykU=
X-Received: by 2002:adf:e193:: with SMTP id az19mr26654977wrb.407.1642671389935;
 Thu, 20 Jan 2022 01:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-11-guoren@kernel.org>
In-Reply-To: <20220120073911.99857-11-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 10:36:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2HaeFGdOr4Rm_ZcEP0rjh2Mo53=-ZRnEPtFfnmzfeE6g@mail.gmail.com>
Message-ID: <CAK8P3a2HaeFGdOr4Rm_ZcEP0rjh2Mo53=-ZRnEPtFfnmzfeE6g@mail.gmail.com>
Subject: Re: [PATCH V3 10/17] riscv: compat: Add elf.h implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WdJOJl6YzyOdYWVXjRix9lYlHeJZIv5iJHrmuIVaDqLFDQ1EiIK
 8+AmjN/KKi39Y40ytr6lStCUPCk86RSetD7Ky3Ku8gyGxI7YopXEt67RLk4AX8/csNLQdYO
 +nH6rV1G3fN6/PaqLe5OLSandGt6MRuf141GUaLa/4skCLaq3vNWJR7zzbwREBG2EE+IYfX
 Thlr52eI5vQmDhLO/Mm6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DnKiGbdM/8k=:DRqsKQ77GSg8KHbAgZc+SZ
 xYFxbfQqvCJspxrhWKsImyHPbulWQ4yZGeFgNNDZPNAcqNwBeIVOsy8KeBSR0QH/SwYJlb9ii
 ESwmuJSK5zLXC1cQypxj0W3S0lLsI5G5gZ99wENyaucJ4Cfe5Akz7pMW2AEHOI1byUVo++Q/S
 CIZjmKRY3oRSr+WtDxHPUgBeYIlSPgXIrvw2OOtz5lX6j3NL3uCBIkd2Hl+qCy7KJZum1HCiZ
 Wg5JLB/sDb5WYTCvshUT6/XvYXOZ08D16dYT25wu9IwdXR7Bau53RuKgguLaUFA0his6viv+A
 sOqoAx6UItWZZmvXrbsjfN8wVn0AeDJWJFvKRM79c5qUUJIx9/qPIlG+OYgHYdQRh8HcK7abp
 mm2Fo37LlXhk00Yfy/ecOV2Pd822p9D2QRpW6qG/FPQYZBkj1qBtx57hbqQ0xlig9Ck5U0T0h
 fvrhs4eFoZYO31eLzGXikMSUynq8ughF25dkceX2E7MRNLLkk9nbEd/QDV+d1YBB6DtudThgk
 /EhVobqFKFRM1Xmvh6YJyIYXARdNpR4ZJHdd0EwzVvR/yDMZrmI1bnAsDUsRscqApZ/UKGs1v
 VmEbwroWt6mHxQZrnv6yDCnPK1woeryJHv+/xjBSQjGbd94n96FcKvSHQe02fXKqh5PFcWRLT
 boGJLwfdkLOCMjAh2BSDZ7iK8hENyuf64lkT/qjV/zpXa3s86RJZGgJVn5jh1azZVsderb2hf
 vLduqGkL47xCAqUnEaB2m1E5k4VdvTKbibkPZ5T8scins26WZzDDYRpBM822r5YKwxZzz4MAv
 c+Bba5wIaPsJ6+ldV1uC9zYkY4F4/Fp75wYGi2Vf99HStHbLdhzaUhsGXtUf6l1AtNBNwlA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Implement necessary type and macro for compat elf. See the code
> comment for detail.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> +
> +/*
> + * FIXME: not sure SET_PERSONALITY for compat process is right!
> + */
> +#define SET_PERSONALITY(ex)                                    \
> +do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)              \
> +               set_thread_flag(TIF_32BIT);                     \
> +       else                                                    \
> +               clear_thread_flag(TIF_32BIT);                   \
> +       if (personality(current->personality) != PER_LINUX32)   \
> +               set_personality(PER_LINUX |                     \
> +                       (current->personality & (~PER_MASK)));  \
> +} while (0)
> +

The implementation looks good to me now,  you can remove that comment above it.

        Arnd
