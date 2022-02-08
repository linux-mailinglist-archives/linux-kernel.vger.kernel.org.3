Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4404AD17D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347286AbiBHG0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiBHG0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:26:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7200C0401DC;
        Mon,  7 Feb 2022 22:26:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 811F8B81854;
        Tue,  8 Feb 2022 06:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC76C340F2;
        Tue,  8 Feb 2022 06:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644301588;
        bh=HIuCEKBnx2neFGe2TzYeuJVUlLTSD+WZPGwlgjCCuXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T9v/Dz0S1HpzoAwIBZvdu5DREqs+MdQzq9y55DHTQDwk2sn3pmvKSlv+GpfgCVTvV
         WfRWeusIuQzCfT2yyD8t04yJ/s3vViOSbz0a9Z/f5ayoUux9/YwxA7AfmFvKsbIriM
         CUvjWc1SmMF2pjmXGoFdMzwGfgyxP41s59LNfmalvMXvTGHrB8IjXJaPwKpz3rODn2
         WzkmTp8eIJmPjzo4yqOJPBsA8fAyVcKPNXUBBre2JNUrieVwuelVz/VrsbrB7pXbas
         HK9f03shLil5H84Uzil62wV17maN1jN99Fs7UheuvIyLIHRiwucQDztUqSCdWPvfBR
         25twB4iSaCk5g==
Received: by mail-vk1-f176.google.com with SMTP id k128so1531181vkk.10;
        Mon, 07 Feb 2022 22:26:28 -0800 (PST)
X-Gm-Message-State: AOAM530Knta6VyWwbmofObf6JII5qEZPlOVu21XOt7xbouuMqTelGPBz
        6CbQk3g1Knv4jN0dbte8Ll/ztzcfqOPsJAeXaRc=
X-Google-Smtp-Source: ABdhPJzacuJptpzsvQJRUnvzBbBzr1u57gJ0wQqQFKPI58LeRRTunUkd1GGEazbj4/xQPLofWtoVqwCs4xjOKh2E+nk=
X-Received: by 2002:a05:6122:1c5:: with SMTP id h5mr1217423vko.2.1644301587245;
 Mon, 07 Feb 2022 22:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20220126114452.692512-1-apatel@ventanamicro.com> <20220126114452.692512-9-apatel@ventanamicro.com>
In-Reply-To: <20220126114452.692512-9-apatel@ventanamicro.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 8 Feb 2022 14:26:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRLcqQ8ZjKwWNmARtaraVW7dD5Hp5=iv+4kHYENvB2gWg@mail.gmail.com>
Message-ID: <CAJF2gTRLcqQ8ZjKwWNmARtaraVW7dD5Hp5=iv+4kHYENvB2gWg@mail.gmail.com>
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
rv32_defconfig would be removed. I think you could delete this part.
https://lore.kernel.org/linux-riscv/20220201150545.1512822-9-guoren@kernel.org/T/#u

I would Cc you in the patch, and you could track the progress.

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
