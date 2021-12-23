Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90A847E930
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 22:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350384AbhLWVsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 16:48:45 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:41609 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbhLWVsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 16:48:43 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MEC8L-1n8S230SqT-00AEav for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021
 22:48:42 +0100
Received: by mail-wm1-f41.google.com with SMTP id o30so1990352wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 13:48:42 -0800 (PST)
X-Gm-Message-State: AOAM531WhokRZFM3GFVYzUTeweR5n5b6aLNXi5F2JeKy+RIeSP/5QGSX
        DdxWP3AYbi3MAAT08zUBpWPyeGTtaUsB/6FCpaU=
X-Google-Smtp-Source: ABdhPJxEYcYHc2s5iCcMqJon0WqW70nGm5f5WDQq7gMOd5Wc3NVcPo41UEwymsv+n/rGicATExGdFZsdKwBJEHEzGmU=
X-Received: by 2002:a7b:c198:: with SMTP id y24mr3011601wmi.1.1640296121769;
 Thu, 23 Dec 2021 13:48:41 -0800 (PST)
MIME-Version: 1.0
References: <YcS4xVWs6bQlQSPC@archlinux-ax161>
In-Reply-To: <YcS4xVWs6bQlQSPC@archlinux-ax161>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Dec 2021 22:48:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1GhoqbcdLHosHNe0QNX3oA5XmE2R-MXfD+eOsJjY5-=Q@mail.gmail.com>
Message-ID: <CAK8P3a1GhoqbcdLHosHNe0QNX3oA5XmE2R-MXfD+eOsJjY5-=Q@mail.gmail.com>
Subject: Re: Issue with booting multi_v5_defconfig kernel with GCC 11
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:r5Ak1ebR5rTlEUEEDSmt0qY3PaS07uuSKx4CFzgjcN8BAO7kkg9
 rrx+K5x4grNfo3XrR7srshiNtoHKi3aL6bdkCwj5e2iXaZiMaNWP3CqFAtaxZWjACZhqXoo
 WQMcHoYpujPDRdIL/uI7yuWIr/dNrcW+abWoWGx6uZAdb1q6YAWYsWTe/msZLD7jlmEMJ1Y
 9rjMUgJeMZRXA04ZraUFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fiEXNFVM780=:7T7YJgTGqvTaUGTzX0d0NI
 yvi8YzPgsxDWO8RNoOBrj9f+rdxGlu6DeN1+1uKNObhdoVXv/rsgy8Jpr5qVy/3ADCINi998C
 IaT6Ylhm2F4jkjOSOM0w/RVqx5D6LxGVFWA2lMi5BWDXbLVyccBYNEASsT8zDO1fn2llj249e
 yO9LBrin+DS5DrVeuLOG+mvi6oSHmsnUKyEYWqYYB06zxMvPsep8FJ2hEipC2ZLUcTxWzdlRq
 aJvXKWwYJnCVGwxVaz72CXqivV9E5yYh+GXuR9H+II5sDEGS7Vk+ySmGOqLs8vJisOWWHTBLx
 uOZnfwOQDB26kxYNxRX99AdQi+zHgkB6MuWo2Ys3THryhLSfZ8jNqHDgetRa1J8dq3KjrJPw4
 hkkAjz8Rs4da5jMctAbl47tmpt/KJxR4reDgSwr2SEORJdWjuJnh49M29SdWqdSIOCDpHmgNn
 2Gkpkb71Wsl+IJUHtfkgTKYoxhXp0SKjHDbVJTMdMaKwxtcggc9xFKPmbWu5EedlFz+XtrsY8
 8UpJ9CcQmveBoDgUHWn+7/4voOGeSd57QW5WEOUumXZZ5N9KRKmL4wGFoQBqZpF/92b5TOAuV
 wytzm+3eioH3NuZbTKU7nyFhVoMzw06N/cPR0rONY7SOwX8mlgX6hnk/OgAWFpe2jyljdK8iO
 ETVezjsDjO8iUGbTZYziw6iR3DyY8j+cq6HT90mZHQmjmoeYCVOUvreze6XxQnuD8300=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 6:58 PM Nathan Chancellor <nathan@kernel.org> wrote:

> da850_evm_config_emac: soc_info: c0dd7288
> da850_evm_config_emac: emac_pdata: 00000000
>
> I don't really see how that is possible, as I can see this member
> assigned in the davinci_soc_info_* variables but maybe there is some
> race during initialization or problem because the QEMU machine is not
> one of these machines?

Right, the problem is that da850_evm_config_emac() gets called
unconditionally for all machines, but davinci_soc_info only gets
populated on davinci machines.

> I think that the GCC commit just makes it so that the rmii_en member is
> read earlier, rather than at the point of use.
>
> Regardless, something like this resolves this panic for me but I have no
> idea if it is proper or not, hence just the report :)
>
> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
> index 428012687a80..7f7f6bae21c2 100644
> --- a/arch/arm/mach-davinci/board-da850-evm.c
> +++ b/arch/arm/mach-davinci/board-da850-evm.c
> @@ -1101,11 +1101,13 @@ static int __init da850_evm_config_emac(void)
>         int ret;
>         u32 val;
>         struct davinci_soc_info *soc_info = &davinci_soc_info;
> -       u8 rmii_en = soc_info->emac_pdata->rmii_en;
> +       u8 rmii_en;
>
>         if (!machine_is_davinci_da850_evm())
>                 return 0;
>
> +       rmii_en = soc_info->emac_pdata->rmii_en;
> +
>         cfg_chip3_base = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
>
>         val = __raw_readl(cfg_chip3_base);
>

This is the correct fix.

Fixes: bae105879f2f ("davinci: DA850/OMAP-L138 EVM: implement
autodetect of RMII PHY")
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
