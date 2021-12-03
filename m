Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FE0467797
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380889AbhLCMpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhLCMph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:45:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE2CC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 04:42:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso4464949wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 04:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVxUZTA48fwXv3Wn0ogrdcDO6KHcU9G34XXI6zScy3k=;
        b=pSqANDTUS3mKwQ6erhSvkVg4ZEzzkjyx+o3qZM3kCJr6TXy6uSTMHytzkn8bhUEvx4
         XQwRoPPkfjinuY/islUOD3oiw2SyCV3KkYZ+oHW6fvNXE/ezyPRJi5iYF2Kua5YH4t2L
         ixSc5TBrsBBPoqlTPlP1vseZmWtoHoUeMLbrkq08K9yYzmaS3H4xKb80J3g9ClxIBtFX
         WUEW8RKqBFUyPDqwP5a7t9VQt1BH2RCRpYkY5MqroIarMhYnV6Iswzx31MuIQhGYWAA6
         H9IRXX2re7Smr0pYsZ0bhFWOX7CkJ8QzQUFiHGuaoWj3hn4ftpGEv8bxV9WI+YX3vTiz
         57EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVxUZTA48fwXv3Wn0ogrdcDO6KHcU9G34XXI6zScy3k=;
        b=lE8XHXzzIMdzWCLxx6xSxwkNea24YlzXw4XSZu/yLDuPoSC2SqOcH74rSP+2drAjOM
         SzZUt93+ok8AklsB0p1mVe+DUnymEGE/yNrJu0FPnnSzMDJAUihvmY3ZbzaD64iZVpw+
         FUEyOTjdOkU/FVdqlvpga96bOXVCxQ62dnUjbrwDUSG8SL7iw00kR3NGy6a9tl/aW34m
         ZoYa5LrEd0civGshL03WKOjtjKWMtfDG9So3T/pS8N+emXJZkWKXM0rETz1RlDibqx8L
         n4cCwuK9yiJJ4wSa/p16YHHE+2KyyFHqWxW7vIdFmiGJ7lhqhgZF7v+FGqt4w0sLZpp4
         4Uxw==
X-Gm-Message-State: AOAM532nB15SkKRDFafIcBVmwrecHGyemc13xuIy5p8yOVaP5MZbrbSF
        JzNe+9ayvjIcCGi5laTrS8uI15wPOcmjueRU1l15eg==
X-Google-Smtp-Source: ABdhPJy4KJ4UCDPG+oIVWlnscWS/tdV/WYUTDmpki1SQxXs5uGRrTAY9O/eZUHIboP0pxfWDG141mtM0NwWazl+Dk1A=
X-Received: by 2002:a7b:c194:: with SMTP id y20mr15092030wmi.61.1638535331744;
 Fri, 03 Dec 2021 04:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20211202235823.1926970-1-atishp@atishpatra.org>
In-Reply-To: <20211202235823.1926970-1-atishp@atishpatra.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 3 Dec 2021 18:11:59 +0530
Message-ID: <CAAhSdy3jvmSUBjVm+YP3PBqRt50UUmq9ci68f7gZdOfXCoBQjA@mail.gmail.com>
Subject: Re: [PATCH v3] MAINTAINERS: Update Atish's email address
To:     Atish Patra <atishp@atishpatra.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 5:29 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> I am no longer employed by western digital. Update my email address to
> personal one and add entries to .mailmap as well.
>
> Signed-off-by: Atish Patra <atishp@atishpatra.org>

I have queued this for 5.17

Thanks,
Anup

> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.mailmap b/.mailmap
> index 6277bb27b4bf..23f6b0a60adf 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -50,6 +50,7 @@ Archit Taneja <archit@ti.com>
>  Ard Biesheuvel <ardb@kernel.org> <ard.biesheuvel@linaro.org>
>  Arnaud Patard <arnaud.patard@rtp-net.org>
>  Arnd Bergmann <arnd@arndb.de>
> +Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com> <atishp@rivosinc.com>
>  Axel Dyks <xl@xlsigned.net>
>  Axel Lin <axel.lin@gmail.com>
>  Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5250298d2817..6c2a34da0314 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10434,7 +10434,7 @@ F:      arch/powerpc/kvm/
>
>  KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)
>  M:     Anup Patel <anup.patel@wdc.com>
> -R:     Atish Patra <atish.patra@wdc.com>
> +R:     Atish Patra <atishp@atishpatra.org>
>  L:     kvm@vger.kernel.org
>  L:     kvm-riscv@lists.infradead.org
>  L:     linux-riscv@lists.infradead.org
> --
> 2.33.1
>
