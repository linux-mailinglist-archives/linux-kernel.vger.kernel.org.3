Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2147C65D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbhLUSVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:21:24 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:46917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhLUSVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:21:23 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M8hlZ-1n4OSx0VyD-004fwu; Tue, 21 Dec 2021 19:21:22 +0100
Received: by mail-wm1-f49.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so34129wmc.2;
        Tue, 21 Dec 2021 10:21:22 -0800 (PST)
X-Gm-Message-State: AOAM531pl7k46UzFX4Fak24MYBH43CTcK4qdlxuR6Woca1wkJ7/vAeNk
        i19RfFFYw7+HzluxwQ1mcBfYLYMStSqvBIa3xZU=
X-Google-Smtp-Source: ABdhPJw3TJbiACgmivSiGV6Ovdpm/sI3dlEmQg3biddqmxGYHcWMbTvf71OOdSqw57SexlZ7eGP2xjVH+Fbbqj6aNz4=
X-Received: by 2002:a1c:8013:: with SMTP id b19mr3508436wmd.35.1640107277923;
 Tue, 21 Dec 2021 09:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-9-guoren@kernel.org>
In-Reply-To: <20211221163532.2636028-9-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 18:21:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0-ZOwoC_Ft+TiKAXdETcqU5XPS+9DZGkA+bB73SNCCbQ@mail.gmail.com>
Message-ID: <CAK8P3a0-ZOwoC_Ft+TiKAXdETcqU5XPS+9DZGkA+bB73SNCCbQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] riscv: compat: Add COMPAT Kbuild skeletal support
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
X-Provags-ID: V03:K1:mETcs4M/PlmEpqYoutCidqdOBUgzTKm+YvUu0EV38NQlLJWzp/u
 rimjCHJz/EzQBtVj25hQ2Rqt0H8jw6gRzS+dnPLcg4xAnFLBI6c1gf2Y3Fji0PxwFeAoLbN
 38hj9MuzEMBfFhCkr0UoEUhJ6QCMTFbDvbqDKT+3nJohpkhtWIA8zgK8Jkn808SNjplia+r
 biIj510kHdAda2xqh78GQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PnIjAVFE+c4=:3RJYMaKSkHfVgBpZs1+r0y
 xCx2rcD3isSBEelaq6TeDHEAtAl0A9cv4PEWKVN03G9XdxuH6RnlJ7NcqBA6CitS1WUxmXbw/
 ADbv+5ZxEEhsidOONvBtClrL1E8yj6/UfLwW8fTX0LFgI3Ha4iU9mjMCFs6oW9dvDNUxidY/g
 1/Yh+FvotHU9C75qKRS7H2j5kaJowR1UYy8qApOoUmtCVtK+JydAdcNvB7EufMQcJIYxcNrUh
 buGp3jk1JyaJ7dz+Qta99w31bFeJ7lc8UyMYAdgdyxUqwxdAd8X3ut+/rmXsnbfwNeSDuigQo
 aRYjaENbo+wZHGZYhAPeB6CJvX1QoXyEiToR+ZLN33DaTq5oBGf+Hgm+DXGTio3Q9JUoQRkz6
 SFtZ5K2d4+Yj7SPUFVQSCKmIV83A/AMhoMg3/L7K+VQSt8fQQTvF/1whn62sa9+LuzvFJVKD1
 rH6RgxucojCv6eX2AENHa18K9al1J775WFNc1hel7yLTI2/o67vxLUDam2/6K0g9khACDsmZq
 Lxs5Qp8ktInGaQ+Byjc7vaO6vUkYIeeLnfVWg9rv5RzEOH+VbHz3y3J6HsxWYSPaZ+PKV07Y4
 zsnqywymPf0BPMy5xAVcxsHdCccix2mzROb61cGvMJhrXgazidjgKuqyRNVcNWnT32K5QDWs8
 SZTYHvwcBtIfL31ZHzTlnODJinWiIaTQUk2mdtbcN3tsA+89G065rAulX8h0XlBHNbVpEW3FH
 d2oSpp0ZBpTLEmsF0yPpEHzJ/G5AUPErggK8TSsGOdfpE4dQRnvb1JCK3mEU2iaLcHjG5nWkO
 twIrq8trq+jmVrY9VXZoM5x9QAHQVr0cZEGYoby51Ed4KASXJo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> +
> +config SYSVIPC_COMPAT
> +       def_bool y
> +       depends on COMPAT && SYSVIPC

Can this be moved to init/Kconfig next to SYSVIPC?

> +
> +COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
> +{
> +       return 0;
> +}

This confused me a bit while reviewing, would it make sense to reorder the
patches to add the three missing functions first instead of adding the
dummy and then replacing it?


        Arnd
