Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639DF4837E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 21:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiACUHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 15:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiACUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 15:07:32 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBE0C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 12:07:32 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i3so87481372ybh.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 12:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbgreVCiEHgCG7aY6u4MJ7Oi9knhaQBb0PijPJXiNlE=;
        b=Ug2aGC6fWeNCO1keuZBREN8KgoJ5KgxZIK0jnIE6LBhMT67LDL1d2r08NXa1Oph9u1
         hEMKC3Ud3Lp8Sw30Bhwm8ljui6Kg63s3FvSUWhSrxu/ouC88EsP1fjC3aPPwe6Yul1Mu
         +1B+06b+EqkG8vb00h52GaITHyV2cAapWMEM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbgreVCiEHgCG7aY6u4MJ7Oi9knhaQBb0PijPJXiNlE=;
        b=v3hLETHCjfwHFSuiasCWPCnRjNed4646sEi3u6XzefW++3L9Buo8fLTt480fQyeIuU
         0KBd+E9LVP3bxllKjETnrM7b2+hxtkloq5cVn38nbxneI1PA2JgTb4U/Dn2uG+Bp16th
         ua7UhtRoMCOVc8GDwUn0wOLW2Vbdhw1Nlk3AhSoNVcFFdm82BfaNZ3Z9y5RTmej8r0xY
         i9glvKjoBFzgNTp73TZ815gXpoq3YOr5jpyXx31/3x0Ut1VDyxMCEKLLErMQPV5aJRqa
         IYbS+6YO6mBErSsegO3CK2EhHY3mdQcQW/kq1+Z8gMzLcZ/bkZ0xhZWX5/popMXKJ4DK
         8swQ==
X-Gm-Message-State: AOAM531vYVPLdfUMGdyhWX+MW38O4SMPNpkDtXjs4rZLBBkLyyaxlCxd
        10GAfRoaEzklQIbDyttb9CBEj5gzoO1++1fosSTf
X-Google-Smtp-Source: ABdhPJyLaCL3lkSBDwcmsLSguA/UKUZF+d8Vo0g7Oy8C5hV5j93Eigi66HBwNkLkCVL27rVRzAkKwITbcMcGhZ3Gvu4=
X-Received: by 2002:a5b:ec2:: with SMTP id a2mr40883815ybs.713.1641240451632;
 Mon, 03 Jan 2022 12:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20220103133759.103814-1-anup@brainfault.org>
In-Reply-To: <20220103133759.103814-1-anup@brainfault.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 3 Jan 2022 12:07:21 -0800
Message-ID: <CAOnJCUJkVT9W6X+oe1CHjnHLUFs11Z_3qeXnats9pUcxCUiDPw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Anup's email address
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kvm-riscv@lists.infradead.org, KVM General <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 3, 2022 at 5:38 AM Anup Patel <anup@brainfault.org> wrote:
>
> I am no longer work at Western Digital so update my email address to
> personal one and add entries to .mailmap as well.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index e951cf1b1730..f5d327f0c4be 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -46,6 +46,7 @@ Andy Adamson <andros@citi.umich.edu>
>  Antoine Tenart <atenart@kernel.org> <antoine.tenart@bootlin.com>
>  Antoine Tenart <atenart@kernel.org> <antoine.tenart@free-electrons.com>
>  Antonio Ospite <ao2@ao2.it> <ao2@amarulasolutions.com>
> +Anup Patel <anup@brainfault.org> <anup.patel@wdc.com>
>  Archit Taneja <archit@ti.com>
>  Ard Biesheuvel <ardb@kernel.org> <ard.biesheuvel@linaro.org>
>  Arnaud Patard <arnaud.patard@rtp-net.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e8241451b49..aa7769f8c779 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10443,7 +10443,7 @@ F:      arch/powerpc/kernel/kvm*
>  F:     arch/powerpc/kvm/
>
>  KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)
> -M:     Anup Patel <anup.patel@wdc.com>
> +M:     Anup Patel <anup@brainfault.org>
>  R:     Atish Patra <atishp@atishpatra.org>
>  L:     kvm@vger.kernel.org
>  L:     kvm-riscv@lists.infradead.org
> --
> 2.25.1
>

Acked-by: Atish Patra <atishp@rivosinc.com>


-- 
Regards,
Atish
