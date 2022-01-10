Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1474897CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245022AbiAJLpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:45:24 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:47905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245002AbiAJLna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:43:30 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MlbPO-1mhCz0102k-00ikU9; Mon, 10 Jan 2022 12:43:24 +0100
Received: by mail-wr1-f44.google.com with SMTP id x4so1027657wru.7;
        Mon, 10 Jan 2022 03:43:24 -0800 (PST)
X-Gm-Message-State: AOAM532cJ9YupYp5rv8tKPmIheJoY7X4QmkcE3vWoQQYsa0bkqTHzigf
        8WPRdoJ7E9PyVsphGN03UXBrneNCeEzEgJ7Rf74=
X-Google-Smtp-Source: ABdhPJzLcQEl2WnX1Puj9mlVNbd4vaTr3cFkZQMjDOmTeJ+poLBbKI4XZ3sC+IOr25uQ9in4zKpCyj1iJaRs8pYrhxQ=
X-Received: by 2002:adf:fd46:: with SMTP id h6mr1566034wrs.192.1641815003810;
 Mon, 10 Jan 2022 03:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20211228143958.3409187-1-guoren@kernel.org> <20211228143958.3409187-2-guoren@kernel.org>
In-Reply-To: <20211228143958.3409187-2-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 10 Jan 2022 12:43:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0E+2=BnKienWp_VuT2g=YcEfP81SJmgbrLWZbdhRXXrA@mail.gmail.com>
Message-ID: <CAK8P3a0E+2=BnKienWp_VuT2g=YcEfP81SJmgbrLWZbdhRXXrA@mail.gmail.com>
Subject: Re: [PATCH V2 01/17] kconfig: Add SYSVIPC_COMPAT for all architectures
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
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
X-Provags-ID: V03:K1:gutJNwyMuuTtGpDlfeICZuij2FOpsCzptA9h7G3xYohePOG8wKa
 qLxKJ4cSljVVu53YMy4KjvsBLQp6JzHVB5xgM5u7sKr8Li3uOQGuGolvY+AP18ofbAUYtEn
 17QIiccD7/rATL7HkGsYkc1VAivZ6REBlXybI/+YaL//Ll0zotVZqqyqfRpfNkNVz3C1YeM
 NHXHlq3+dgA6ndJsz0R5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lIN9WQRIHgU=:w3Mgy0NJruiLGOp8UgCTRy
 DwAfYFVcA2r6tMoTf7wKf+wr86VTzN6lilV4UIlVq3UkdLC1VS18A7f9LztizjXGNu7ty8rGs
 zzCHNhnqaebVjPf+mvnyxUypKUv60af+F1jqSSxFS0pb++TkTZzdUzlHWUQauhWKEw+fODzXZ
 O/lhb1Pdd9rcjpk+rR1z4tGrbAp69CAUjb9iCmQ9F3tTGwrOkk4NrsIcTNt8pgkvK3AwmrSjB
 TFE36mGbyRrpaqby3AQLBTduwb6YdNaMQpFsjy5hWNQQeSj3wDZ0TZ1u/DtG7OF73truS+TnB
 0s/pKf07mel9631+weh3fOuk5fe4i49kyguCJ21NuN/Nv270I0N58iJ00Px370VxUWshXnGBj
 E34D1oVgRdqaOw+LLSEt3cfFuBp7s/vUwJvJf8nHsr2wvK1WWhMoCW1PwkDsphNuI4h2k6Unf
 aws0Ikhe/tBPbeqi7ZX7sMvCuYWuc49bLojb3jnFkRqHsp8krBz4/CvH1BsDBOytTspYu4KAG
 0uFQyf+ypSvcfWET6c9Zib1eQKQdNTwYZVcTPsWxxf1r4/Tp+/c0fEtJONnuvwUldBfsQ5rtQ
 PbleS2KTKPD/ZxGlzU32bdob65SBnqlCcbVhSx3WaVZZqsR0WwTs9psxPMNYnBXbwZeRyfJwZ
 nXyylD/cS34+Zx7B20UKnCG+ksFoq+h1c/i2U+qpkbMKuFNKpi0Q0eaHU0HJgAM0ldtvDHngX
 Adj69Jln3pU2Pa9K9LyvfAdWtNC27hHVsLOoN6Ax8+pL5NBrdz6Gd3Yr6PSVXTdxl4qC8B3Cg
 VzXcMU68MLDnNULfiqyGSnQZnXC0STc6g2OzgLtJp3ibWoMGYc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 3:39 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The existing per-arch definitions are pretty much historic cruft.
> Move SYSVIPC_COMPAT into init/Kconfig.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christoph Hellwig <hch@infradead.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
