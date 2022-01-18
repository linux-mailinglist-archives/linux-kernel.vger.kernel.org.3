Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACBE491F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 06:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiARFbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 00:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiARFbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 00:31:16 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71996C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 21:31:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso1759622wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 21:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8RGE/DAeu/cF6MyOFk6fwmpPGM88lrl7wdwFAKJ4BE=;
        b=CEzdGWMBnd1J8rXO2caxD/gWSoNQevjJ/4T3wgxwnRqZ5iqNwq0UqmPEwUar/p7Jjl
         z5BzjHTCxfI9GVbPhoUfyXKYeWi56lbfbGLtsFXP+XKq4bw2AcoR+QpiV7jBgs8Tyw6p
         wQH9/ehapJ6DKhZsQSa3u9iyVXUJbSMLjOinpaCXBjwavCvTnKBT4ufuUNMyFlg041gQ
         BCEsoEZCsWZSzeyO/2fcF0VxjPhHidNNYSxQY42sbq5Ioqpyv8MupwS5Emo7JvRy/m1R
         BqXL6z+efN9KaKM7HMfppkbSjJABnNl41OVHTNQHUW+HVZi+QZELZBmsYrKzCjr/4ML/
         g+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8RGE/DAeu/cF6MyOFk6fwmpPGM88lrl7wdwFAKJ4BE=;
        b=3hS2oIFFPsgGptG2KOjVdN1HoHjuKb6sPbcwoi4xSYMjiiJ6fZMFq3sTF+nccndjMA
         nOxR4q25R51Wt+OIX+ZRa1lfNxN3d7NnbuUE3KKP9ciJxYJyTKrjT2izwbSAe500gfuk
         fYJ2h/+y+zLRn62z4YjXpnpIUjAaOqHtJCpzUFJAkb7hdnn65qcGHqB8CqbsiYNqLnQv
         5hQPmDQDLcQYnHh0a4ILZvv02x/a+OcXIG9w0nqQeg0SwXuMAOHHKqxEInvxj47jgxZC
         MsXMedmnZKsq+MujakipVW1kNhwuUc9Ny0G8b8USHAT2Plwqu7YfKgcBx1zyQrehSSjc
         RIcw==
X-Gm-Message-State: AOAM531YESp+d64rzjFNct6HZK5YlEEUWi+Ul4qjce2O8374OcLfo9Fx
        zYLAVaDOKtkZkWc1O0C6ghcmhH0qyZExQqSBoprnig==
X-Google-Smtp-Source: ABdhPJz30QM3hgkUK8tGy9J8I/MAob8XT1qi6GJq/uClq3+JKuP5JkWkKU0Bb5Djvfnpc84vLhCmyRyBZcy4L+ejSNQ=
X-Received: by 2002:adf:9d81:: with SMTP id p1mr22027128wre.313.1642483874927;
 Mon, 17 Jan 2022 21:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20211225054647.1750577-1-atishp@rivosinc.com> <20211225054647.1750577-10-atishp@rivosinc.com>
In-Reply-To: <20211225054647.1750577-10-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 18 Jan 2022 11:01:03 +0530
Message-ID: <CAAhSdy1cyGwwq6BDO5Xv_TfR6Pbk26hKDWQZSUWKTTX0A6iHxw@mail.gmail.com>
Subject: Re: [v5 9/9] MAINTAINERS: Add entry for RISC-V PMU drivers
To:     Atish Patra <atishp@atishpatra.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 11:17 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> From: Atish Patra <atish.patra@wdc.com>
>
> Add myself and Anup as maintainer for RISC-V PMU drivers.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9af529acb6a6..6232ae05e12c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16056,6 +16056,15 @@ S:     Maintained
>  F:     drivers/mtd/nand/raw/r852.c
>  F:     drivers/mtd/nand/raw/r852.h
>
> +RISC-V PMU DRIVERS
> +M:     Atish Patra <atishp@atishpatra.org>
> +M:     Anup Patel <anup@brainfault.org>

Please use "R:" instead of "M:" for me.

> +L:     linux-riscv@lists.infradead.org
> +S:     Supported
> +F:     drivers/perf/riscv_pmu.c
> +F:     drivers/perf/riscv_pmu_legacy.c
> +F:     drivers/perf/riscv_pmu_sbi.c
> +
>  RISC-V ARCHITECTURE
>  M:     Paul Walmsley <paul.walmsley@sifive.com>
>  M:     Palmer Dabbelt <palmer@dabbelt.com>
> --
> 2.33.1
>

Regards,
Anup
