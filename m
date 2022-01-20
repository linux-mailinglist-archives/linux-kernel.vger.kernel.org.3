Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FFD494ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiATJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:29:57 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:56041 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiATJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:29:53 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxHLs-1mM64N2A7E-00xZbC; Thu, 20 Jan 2022 10:29:52 +0100
Received: by mail-ot1-f49.google.com with SMTP id i7-20020a9d68c7000000b0059396529af8so6794249oto.4;
        Thu, 20 Jan 2022 01:29:51 -0800 (PST)
X-Gm-Message-State: AOAM533xER4vvYSSkjzmC84ll/yfTWD7ob6qgWmVDwQObMLSwsyifYc2
        qzShOwSIGZ73Rfj6YIcWcbWfXHW8GdgvURhjqn0=
X-Google-Smtp-Source: ABdhPJw23cQjee+wzKe1BZuP5Egl38StW0xVS2Lx2CrxQkm8C96LIXXcbD+ld7BJcIRLzViPyYDZ1TVXzpuf+zNTwjI=
X-Received: by 2002:a05:6830:2095:: with SMTP id y21mr25066257otq.368.1642670990087;
 Thu, 20 Jan 2022 01:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-7-guoren@kernel.org>
In-Reply-To: <20220120073911.99857-7-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 10:29:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a00uYPBBphpipBoqCnGFwr_C9vDzS1p1iLN==YTVOARug@mail.gmail.com>
Message-ID: <CAK8P3a00uYPBBphpipBoqCnGFwr_C9vDzS1p1iLN==YTVOARug@mail.gmail.com>
Subject: Re: [PATCH V3 06/17] riscv: compat: Add basic compat date type implementation
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
X-Provags-ID: V03:K1:s4Q1DH9lXoshZS2vFPndUrTFcam5Cmc6PQRo9r/B1zlXxInFnE1
 F+WnEDzyOzIcqIxXnbIMAISLi6dWUeMtvJyKdckn8IHL/4qX25H4kMkNiQImQIyFf+8hSy9
 Y5ozmkK8x66ILoDsEH8O+iA8WW/zV2ruLmnetp15zjcsw2Il2KV0pX7TTYBFWR39AIINnAw
 JwfZabmoF5S81gPFtdGdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tFyRVOEcZwM=:qB6pa6wjmW7sOov+3Oy63P
 qhLvcRdEAyI2JHdWOhXN0KVUd5LcQCqSMlxojtTVHH5NlhaeYDI3YN20ZZtj9BqUCUHbBstEt
 RFtY+1XxxuS2LRziFfQs/I+yOWGVo2WMcUPzk1py0bid8B2he1vxxjUCWlC+uGvra3SoRkZyP
 vT/H6WHjXdtoJLEVDADkBRSbTBqskUpgkP6eGPku/LOCz7YoR7VumF/XdSnQnTeR2+HG6K73e
 ondxUGsUMkyPHdI73PvpO6ZNDyi/IUFiMBymMEERJRUNPoybyH1KEvZ0K+QNY7wX6IAzOIGd5
 qeR4mcyzzYS7MCwW2s2RUV2yBIpTNrrkhdr/NG8nU/An0inMBVIpE6NPmwBX6sWp4HB6Gs/+5
 U+4R7Dqh4Rz2UPOL4mIIdznpg8JfbBVIG/rH9HZA08VIlpAXOUwBBy3OjR8IplUCXhrwWXWgz
 fXLNHHCqi8cY/q6q1DhyDUfDvU3ccxREuPCrxHAGkHk1jsl5lDGe1Wvkez/h89zCp21eG/S5S
 m1oDpE5awDdfTYGEoMGTjgBJjxlwuY2Phlrx9WtacNq2P1fh5p9MmIaqp7bz8s17iRZqyKEdt
 Ntm1VMcJYqmXkOXgTk7FSEbjYDIlyTYSVofFmw8/EEyL6HQr9MXa2nb1hWWG/Xwq3ZZMWa//N
 UUSINH0KVs7WUYaySx+LIn63vHhdA1HPx86zxX0Bl8TiesDVGN74NaGNtBst/q3OYhJDtSxnC
 73aWMI72TfkeooR7e2/pVSUDcfadDcqjhxjwwXqE2rbpYLYtZpVFjJDwHPX4+WtJsWQQUV3MR
 5egODidWF3U0KJH7RFZvqsz9+sq/141RlqaXW2+tXh0f3BS128=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:38 AM <guoren@kernel.org> wrote:

> @@ -0,0 +1,136 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_COMPAT_H
> +#define __ASM_COMPAT_H
> +
> +#define compat_mode_t  compat_mode_t
> +typedef u16            compat_mode_t;

I think this one is wrong, as rv32 should get the native definition from

include/uapi/asm-generic/posix_types.h:typedef unsigned int     __kernel_mode_t;

I think it works if you just remove those two lines. The rest looks good to me.

       Arnd
