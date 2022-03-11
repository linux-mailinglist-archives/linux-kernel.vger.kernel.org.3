Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB44D5D07
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347204AbiCKIHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiCKIH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:07:27 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7111B6E05
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:06:24 -0800 (PST)
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1My3Mv-1oM5eD3qLH-00zYJR for <linux-kernel@vger.kernel.org>; Fri, 11 Mar
 2022 09:06:22 +0100
Received: by mail-wm1-f53.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso5509857wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:06:22 -0800 (PST)
X-Gm-Message-State: AOAM5310TF+G4M7OM00PY2EJ32ECAOoPAbLio8j13ThtW+Skz0S17Gv7
        9hFvkMz1RX7Bqu5WnQinYbuztXlVkyBli77FF7g=
X-Google-Smtp-Source: ABdhPJy17LqDTAxjPGrIpJ7hGQWebaXhx8FEgzAQaMgcnDW0cuC+n1tELJsffidaq8vu0XVBaNn4fqCx/0TgBM77wbE=
X-Received: by 2002:a1c:4e15:0:b0:387:3661:e857 with SMTP id
 g21-20020a1c4e15000000b003873661e857mr14436323wmh.94.1646985982435; Fri, 11
 Mar 2022 00:06:22 -0800 (PST)
MIME-Version: 1.0
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 11 Mar 2022 09:06:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2YeENkriOpXk_a6uvOC0T1Ys2gLm_AZJL_HLmez24KQw@mail.gmail.com>
Message-ID: <CAK8P3a2YeENkriOpXk_a6uvOC0T1Ys2gLm_AZJL_HLmez24KQw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] arch: arm: mach-hpe: Introduce the HPE GXP architecture
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qdcpI9WEjLKeIGB6mDZLdCRyYo8yHJzcY1bK1yrfmH3TCGfaTF4
 PMwjOWsaaNcT+FiqNcHh67ZKAywzD6s8Tf7fuU9ZW/VE0QozurEObBbLX3gkcEYPQTZUbin
 PD4sSFR/wVsKbGJb7Hsfbqa0EXcoIKhmWkmxh7SSW5LIya43o7e7qP8lYdpbwN4K7G++bCk
 eXRPw+mdGZ0TaVHISG0yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+63tD2KNLus=:Q9y9m4bKvLdW2uXoCRos0i
 zZlde72WDOMM3Di7SY9mQ+U5lnx7FAaiCkq0qx2r3Zy5YAeVAwfowBSin4C7SYruSAnKrgPsg
 Zr9T3IPHkk+M3dJdh1+uEvXzZuZEoQX4w96X8kGXR7YLWEMkymhzM7HCO7sNToE4l+caF8QyH
 eFbnrNk/KdGDuF1Q9LMlJiAIaH35fiJGPsZvA5yntKZ01A3YHJZ6cGiZtUhuP/UgXEynpHJ1O
 NMQso3owEHgFAUv/Ab0rtuM6MvHRn9bZwccwIRbv1TXpKsM3C6mpYIL7y5O57LGYPJ5kSK2PU
 dmQ9h7j2rJAnbD208WehY+rRgt2fuBL9h2LHTULFfLe2Oh5Tt1NktNQ8BHkwHv4VRq0nejasB
 hPvN88WTyQFRbMD7hPlQz2kCeo9U1MWARy5umWcssmXSsQBi0V5SM4siOHKrPmcbe7B3KsEFq
 kdTzXbITKK75Sm5F9Jh/pHAgntdkoAIsGa5GLqOTV/WDqRfzxPZfcPPwC8OwhL8URBMYq5PEb
 U3WJBY0Y6JwWOl99Qr2saWWlHapf+DWrQ5yHP8lVaEoWURQlvKAH9lf8fj5n5frdxAReZ4yOh
 0os/3KOq2lHka2zUd5j9f945yn99Tb+I4Qv027VoVrTqEUEZ7aFwJY7aX6hRLhLahKvtRDF11
 +vFGkDPA0RsX06n3bkkMqXYpoaUhJikZnuQajdszadB1dg3IFD4JhtAyJd53OVsKZMNA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 8:52 PM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> The GXP is the HPE BMC SoC that is used in the majority
> of HPE Generation 10 servers. Traditionally the asic will
> last multiple generations of server before being replaced.
> In gxp.c we reset the EHCI controller early to boot the asic.
>
> Info about SoC:
>
> HPE GXP is the name of the HPE Soc. This SoC is used to implement
> many BMC features at HPE. It supports ARMv7 architecture based on
> the Cortex A9 core. It is capable of using an AXI bus to which
> a memory controller is attached. It has multiple SPI interfaces
> to connect boot flash and BIOS flash. It uses a 10/100/1000 MAC
> for network connectivity. It has multiple i2c engines to drive
> connectivity with a host infrastructure. The initial patches
> enable the watchdog and timer enabling the host to be able to
> boot.
>
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

Please add me to Cc for the entire series when resending.


> +config ARCH_HPE_GXP
> +       bool "HPE GXP SoC"
> +       select ARM_VIC
> +       select PINCTRL
> +       select IRQ_DOMAIN
> +       select GENERIC_IRQ_CHIP
> +       select MULTI_IRQ_HANDLER
> +       select SPARSE_IRQ
> +       select CLKSRC_MMIO
> +       depends on ARCH_MULTI_V7

By convention, the 'depends on' usually comes first here.

Please drop the 'select' statements for things that are already selected
by ARCH_MULTIPLATFORM or ARCH_MULTI_V7.


> +
> +#define IOP_REGS_PHYS_BASE 0xc0000000
> +#define IOP_REGS_VIRT_BASE 0xf0000000
> +#define IOP_REGS_SIZE (240*SZ_1M)
> +#define RESET_CMD 0x00080002
> +
> +static struct map_desc gxp_io_desc[] __initdata = {
> +       {
> +               .virtual        = (unsigned long)IOP_REGS_VIRT_BASE,
> +               .pfn            = __phys_to_pfn(IOP_REGS_PHYS_BASE),
> +               .length         = IOP_REGS_SIZE,
> +               .type           = MT_DEVICE,
> +       },
> +};

It looks like this is only used for the pxf_restart() function below.
In this case, you should get rid of the static mapping entirely and
use an ioremap() in the gxp_dt_init() function instead, ideally getting
the address from an appropriate device node rather than hardcoding
it here.

If there are other drivers using the static mapping, either explain
here why this is required, or try to change them to dynamic mappings as well.

> +static void __init gxp_dt_init(void)
> +{
> +       void __iomem *gxp_init_regs;
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, NULL, "hpe,gxp-cpu-init");
> +       gxp_init_regs = of_iomap(np, 0);
> +
> +       /*it is necessary for our SOC to reset ECHI through this*/
> +       /* register due to a hardware limitation*/
> +       __raw_writel(RESET_CMD,
> +               (gxp_init_regs));

My feeling is still that this should be done in the platform specific EHCI
driver front-end. I think I commented on this before but don't remember
getting an explanation why you can't have it there.

> +static void gxp_restart(enum reboot_mode mode, const char *cmd)
> +{
> +       __raw_writel(1, (void __iomem *) IOP_REGS_VIRT_BASE);
> +}

With both of these, you should use writel() instead of __raw_write().
Using the __raw accessors breaks big-endian kernels (which you
probably don't need, but shouldn't break for no reason anyway), and
lacks serialization and atomicity of the access.

A better place for the restart logic may be a separate driver in
drivers/power/reset/, at least if this otherwise ends up being the only
platform specific code you need.

          Arnd
