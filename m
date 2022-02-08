Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B94AD1BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347714AbiBHGqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiBHGq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:46:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0D5C0401EF;
        Mon,  7 Feb 2022 22:46:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1E39B817D3;
        Tue,  8 Feb 2022 06:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A111C340EF;
        Tue,  8 Feb 2022 06:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644302785;
        bh=2PAnZavsBCQOKNxqtrXZdWKUJUHNnqRJ7TmptXf/CRI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aZguFV60JHW+Wl0UK/7jImD5iZ2QyXQpzBt2ompSVpfx2aQhZEjUM/zO+w4OCyYjO
         Ui7QIfN2W+z7gDxc1JnzsBfKQGN5s/TidYc4jPISzyO16D28so+IP+DFawLRSyKpns
         MtBJstEnQ5981dxzm3YL8z19G7ENfBkuRCNzxN2IvUMLjf9TzEJzYjKtXmqCKZaGoc
         FfTw2C5fYhe90ThXnp9UV9mNdaSjUw/uHcSkovseC69NWwoCFUfXeZ5reXLThoqoGx
         bANovyFliDK25n3uatfa3UAFy5sf13833yXs/7YUhwTgdzfWinwP5Tis+yV2BuNVZp
         UTLCA4gjJG6bg==
Received: by mail-vs1-f49.google.com with SMTP id x13so2326998vsl.10;
        Mon, 07 Feb 2022 22:46:25 -0800 (PST)
X-Gm-Message-State: AOAM5325NT05H0xuDU2VwAM17pxW8LB3PUiY81RyOjDLW8Lgi3r74U6b
        02hZepEU5I/tEf7dpifyajl5LWNRCivBs/ybnAs=
X-Google-Smtp-Source: ABdhPJwcITGI3/F3NjBB05kTSNDFumGOEbnmXBce8eySQQ05hqGWKQ34yPQabBtqVtUZuP1cB0KdFDlqpj6pHvBDoD4=
X-Received: by 2002:a67:e0d9:: with SMTP id m25mr1147574vsl.51.1644302784590;
 Mon, 07 Feb 2022 22:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20220126114452.692512-1-apatel@ventanamicro.com> <20220126114452.692512-9-apatel@ventanamicro.com>
In-Reply-To: <20220126114452.692512-9-apatel@ventanamicro.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 8 Feb 2022 14:46:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQsSn1KBgX2bg2LiSUbCmbGD3oF5KcmK5gq2Dd49BWDBQ@mail.gmail.com>
Message-ID: <CAJF2gTQsSn1KBgX2bg2LiSUbCmbGD3oF5KcmK5gq2Dd49BWDBQ@mail.gmail.com>
Subject: Re: [PATCH v10 8/8] RISC-V: Enable RISC-V SBI CPU Idle driver for
 QEMU virt machine
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another question:

Have you put "idle-states {" in qemu's DTS? or how do you test your patches?

On Wed, Jan 26, 2022 at 7:51 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> From: Anup Patel <anup.patel@wdc.com>
>
> We enable RISC-V SBI CPU Idle driver for QEMU virt machine to test
> SBI HSM Supend on QEMU.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/Kconfig.socs           | 3 +++
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  3 files changed, 5 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 6ec44a22278a..f4097a815201 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -36,6 +36,9 @@ config SOC_VIRT
>         select GOLDFISH
>         select RTC_DRV_GOLDFISH if RTC_CLASS
>         select SIFIVE_PLIC
> +       select PM_GENERIC_DOMAINS if PM
> +       select PM_GENERIC_DOMAINS_OF if PM && OF
> +       select RISCV_SBI_CPUIDLE if CPU_IDLE
>         help
>           This enables support for QEMU Virt Machine.
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index a5e0482a4969..b8c882b70b02 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -20,6 +20,7 @@ CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y
> +CONFIG_PM=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_VIRTUALIZATION=y
>  CONFIG_KVM=m
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index d1b87db54d68..6f9a7c89bff9 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -20,6 +20,7 @@ CONFIG_SOC_VIRT=y
>  CONFIG_ARCH_RV32I=y
>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y
> +CONFIG_PM=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_VIRTUALIZATION=y
>  CONFIG_KVM=m
> --
> 2.25.1
>
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
