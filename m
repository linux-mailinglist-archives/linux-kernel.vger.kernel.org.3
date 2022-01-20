Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22C0494C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiATLFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:05:23 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiATLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:04:23 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MJmbB-1mqMtJ1Bo9-00K55w; Thu, 20 Jan 2022 12:04:20 +0100
Received: by mail-oo1-f45.google.com with SMTP id b20-20020a4a3414000000b002dda566aba7so1888654ooa.13;
        Thu, 20 Jan 2022 03:04:19 -0800 (PST)
X-Gm-Message-State: AOAM532CO6xxk8E9jLiCM+zO6LCOrYZPptZaB69JP9XI1jtA299h6MJk
        ngAhhKcUcYmqJuVnlkYx61M0uPsv8i8HF772Gr8=
X-Google-Smtp-Source: ABdhPJxdLg6SDZjsvGmAsYmn2qy9+2h/ODrSB5K/8pY/EXdxIA8KLQS4DyhVSmna3jImvkgL6VaV1O46bPcTyjt0SVc=
X-Received: by 2002:a05:6808:1490:: with SMTP id e16mr6881848oiw.84.1642673470519;
 Thu, 20 Jan 2022 02:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-18-guoren@kernel.org>
In-Reply-To: <20220120073911.99857-18-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 11:10:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1_qwRpfHRyF75WEqfxGxgVnfB15vNS-egQctx7R5-DvA@mail.gmail.com>
Message-ID: <CAK8P3a1_qwRpfHRyF75WEqfxGxgVnfB15vNS-egQctx7R5-DvA@mail.gmail.com>
Subject: Re: [PATCH V3 17/17] KVM: compat: riscv: Prevent KVM_COMPAT from
 being selected
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
X-Provags-ID: V03:K1:j2ac7wj3LsCM9f+9e4oJASCScxFtNHRtjDDmqr4iy577NRpRpAF
 bMlnZKMV2DYLGVHn0K8JkZd3T2GqO0MNYXz6fcH0qw593jQUksbXGnoN9YSzPzIKe/+5lR6
 vkhBO4+bgoTilrYFReGT0M6jgFRRpZLN5x34QH1WXbatlFvqzaiqNUUsFz12Ol1tTe4FtAC
 rXedzAAJ/vw3lOUWSKspw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lXSZfcmtm/Q=:SRkDkTuRkxkElxz6iLbS59
 GIp6kV1MlGEO3mJBtnAbsuOWkQw4kQj/9qsIc+2rcwTpPcav4RPYAGNqu9DqJTWdxcTXNf9dC
 /xmtASxwkvFd4AzugE3Q4gpYN25r9TIZSzjGzEARt0BEGr1ApLRzz7WVuXzGIAYyPiS9XTJoe
 eAgovehaJOZ330IGzXZ7LSk/JNIA3CK+JRDrC0CNIW5kOdMvm9iW41PchyrvZfZe2C594XuH3
 xak/xHfeJFO/2JymqAgswcgw1XUNz8vvfP35bBQ8p3RasPTraw35wKH4EOAn3q26ZFY9w1B9W
 m5gfQHyMh/VPHG2tsWMSoTlax9ph7UhUiN5gh/k58YOsLKyT6ISze7pnBHwhNmXssr8ki0MfD
 pl8/zYlSJ/JiUuODbPcdOT+CTxz252Vsawl+h/vKIPNIY/YzuehZpomjExbGFDZE3fF3h/Rhq
 A/nOx3JB6I9b2My0LG25SOp4uLRaZFobO431tfN+WFR2ibA9IcLJKUCbE6sG3WE3Y1qmuQzNt
 Z1EUZgbjxhoGlLmVxYCxz/lCYk6oWSiHqdZYH6ndPu+P5/ntPFz3hoYDtRbNtVBis/VJaZ+95
 +dOEJFKQMU6hl7wrhwwz2QOoHREd+vGyt67I2d+LwdeR0hwFt6kVEuDRdWRA0r/ZTXIRAzqha
 kDu+CMpRtAKykZ7yJeMkbmM6HFCFbOOWfSJ7PcOd5hGhEobjmAW8MWA+WR2EtUy6CERoxoNMa
 LFarC1NWQZdjgZZ4YJaiE+StPfkuerPENJADsFQ3xCcuHphZVRRO6oFl3BBsfigYILDnoloM8
 3fCM88jEaxZcsKibADiiJb3hBMbiH9Ib9PhlY1WMb5esQikAcg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Current riscv doesn't support the 32bit KVM/arm API. Let's make it
> clear by not selecting KVM_COMPAT.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  virt/kvm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index f4834c20e4a6..a8c5c9f06b3c 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -53,7 +53,7 @@ config KVM_GENERIC_DIRTYLOG_READ_PROTECT
>
>  config KVM_COMPAT
>         def_bool y
> -       depends on KVM && COMPAT && !(S390 || ARM64)
> +       depends on KVM && COMPAT && !(S390 || ARM64 || RISCV)

Maybe this should be flipped around into a positive list now?
The remaining architectures would be mips, powerpc and x86, but it's unclear
if this actually meant to work on all of them, or any potential ones
added in the
future.

       Arnd
