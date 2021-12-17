Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C6D478967
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhLQLDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhLQLDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:03:34 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E971C061574;
        Fri, 17 Dec 2021 03:03:34 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x15so6427476edv.1;
        Fri, 17 Dec 2021 03:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDoMAsyrmIhOeAjKc2RWkPHbxFIM7lBCTp7TztuEVSM=;
        b=MDJ84xLUZGssdONWgL/SN10UAeKqN7bBEFx3ruzn6B3byC9hOFP3xuCpwvyrpt6IVz
         zOiZiqDwApqetBUdv9a1ylXlirPcfUoaHkKrPvwJU2nLvOYsrwbiIH8SWJU50y3wwMMp
         GDCsT7FHr+13NdQwA9l5damw0NDi7MSGrIjokzpoPeq+gXA3sWxksnXHsiCM3AsCsLpd
         fUTEPj/ziYMrTtabvtfjG9PKcJvSsn42R5lS89FUCW8laTMjuhrh9rlWIVCPTAVOX1fg
         0B52X1ha9xjYwlZQqxLd4/QNzhZfsU8p3ShTib7FzAfj/6upE63bCyOdD+NmLLBbCNYm
         yBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDoMAsyrmIhOeAjKc2RWkPHbxFIM7lBCTp7TztuEVSM=;
        b=ctuIVxDMMFNh2SHLOh2Z9bRymA310BCbzaMAuHJnEGc1jwYk/TV2ZiHzNAMdVKEDzW
         awlsCBYRvK6zK0pWqX/1pnpU4ZNBvACFVYfhADH/HSwN+nB2O4fVdhSI3t+4m8SuZrpk
         8sO9Zrnj5YjYFaAJGl1zILzdMjkw8pMQbKqdAJLMc0vHslcrxcNexHEt9K10EJ1BfHhA
         4vrRSqWzJlmr/6v6fIVyO0n75SChdPj6bGNt7zVbDSzHczH3O3RNC/58M3hhUXsgoPEd
         7LUDQogcPZ7a5wWjPfAmb7GgqwEUTudGFLkvUEq+aC9ZwRdscmtzEwHfcCPE5Cx0Ay6F
         o71g==
X-Gm-Message-State: AOAM530RZOX2WT7EMQi5jFYCCmiARUmfKOr/TjKx91FCufLfA9+Uytue
        6i/5QyjY1a7hbp5gb3igtvQ335xQu4UpG64oKSg=
X-Google-Smtp-Source: ABdhPJyAJvENyGKzfsDhCwjGvbjVkd+Q0jA2QYceLQE6nq1Jktig1JBhZE+VrImWjWMGjOoN5o5JjCf3Ip+ALI540JU=
X-Received: by 2002:a17:907:76d4:: with SMTP id kf20mr2141413ejc.44.1639739013073;
 Fri, 17 Dec 2021 03:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20211217172931.01c24d4b@canb.auug.org.au>
In-Reply-To: <20211217172931.01c24d4b@canb.auug.org.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Dec 2021 13:02:05 +0200
Message-ID: <CAHp75Vd9O=A9_N=KLDV2mJ2haFybNqnSL2AdByf4Pc6zjjD94w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pinctrl tree with the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Huan Feng <huan.feng@starfivetech.com>,
        Kiran Kumar S <kiran.kumar1.s@intel.com>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:29 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the pinctrl tree got conflicts in:
>
>   drivers/pinctrl/Kconfig
>   drivers/pinctrl/Makefile
>
> between commit:
>
>   ec648f6b7686 ("pinctrl: starfive: Add pinctrl driver for StarFive SoCs")
>
> from the arm-soc tree and commits:
>
>   12422af8194d ("pinctrl: Add Intel Thunder Bay pinctrl driver")
>   b124c8bd50c7 ("pinctrl: Sort Kconfig and Makefile entries alphabetically")
>
> from the pinctrl tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks!
To me it seems like a correct fix.

> diff --cc drivers/pinctrl/Kconfig
> index 0d5b61e4c21e,c27c9ee89f0e..000000000000
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> diff --cc drivers/pinctrl/Makefile
> index f5bdd6b209a6,6be6c3fc6663..000000000000
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@@ -30,26 -39,16 +39,17 @@@ obj-$(CONFIG_PINCTRL_OXNAS)        += pinctrl-
>   obj-$(CONFIG_PINCTRL_PALMAS)  += pinctrl-palmas.o
>   obj-$(CONFIG_PINCTRL_PIC32)   += pinctrl-pic32.o
>   obj-$(CONFIG_PINCTRL_PISTACHIO)       += pinctrl-pistachio.o
> + obj-$(CONFIG_PINCTRL_RK805)   += pinctrl-rk805.o
>   obj-$(CONFIG_PINCTRL_ROCKCHIP)        += pinctrl-rockchip.o
>   obj-$(CONFIG_PINCTRL_SINGLE)  += pinctrl-single.o
> - obj-$(CONFIG_PINCTRL_SX150X)  += pinctrl-sx150x.o
> - obj-$(CONFIG_ARCH_TEGRA)      += tegra/
> - obj-$(CONFIG_PINCTRL_XWAY)    += pinctrl-xway.o
> - obj-$(CONFIG_PINCTRL_LANTIQ)  += pinctrl-lantiq.o
> - obj-$(CONFIG_PINCTRL_LPC18XX) += pinctrl-lpc18xx.o
> - obj-$(CONFIG_PINCTRL_TB10X)   += pinctrl-tb10x.o
> + obj-$(CONFIG_PINCTRL_STMFX)   += pinctrl-stmfx.o
>   obj-$(CONFIG_PINCTRL_ST)      += pinctrl-st.o
>  +obj-$(CONFIG_PINCTRL_STARFIVE)        += pinctrl-starfive.o
> - obj-$(CONFIG_PINCTRL_STMFX)   += pinctrl-stmfx.o
> - obj-$(CONFIG_PINCTRL_ZYNQ)    += pinctrl-zynq.o
> + obj-$(CONFIG_PINCTRL_SX150X)  += pinctrl-sx150x.o
> + obj-$(CONFIG_PINCTRL_TB10X)   += pinctrl-tb10x.o
> + obj-$(CONFIG_PINCTRL_THUNDERBAY) += pinctrl-thunderbay.o
>   obj-$(CONFIG_PINCTRL_ZYNQMP)  += pinctrl-zynqmp.o
> - obj-$(CONFIG_PINCTRL_INGENIC) += pinctrl-ingenic.o
> - obj-$(CONFIG_PINCTRL_RK805)   += pinctrl-rk805.o
> - obj-$(CONFIG_PINCTRL_OCELOT)  += pinctrl-ocelot.o
> - obj-$(CONFIG_PINCTRL_MICROCHIP_SGPIO) += pinctrl-microchip-sgpio.o
> - obj-$(CONFIG_PINCTRL_EQUILIBRIUM)   += pinctrl-equilibrium.o
> - obj-$(CONFIG_PINCTRL_K210)    += pinctrl-k210.o
> - obj-$(CONFIG_PINCTRL_KEEMBAY) += pinctrl-keembay.o
> + obj-$(CONFIG_PINCTRL_ZYNQ)    += pinctrl-zynq.o
>
>   obj-y                         += actions/
>   obj-$(CONFIG_ARCH_ASPEED)     += aspeed/



-- 
With Best Regards,
Andy Shevchenko
