Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FBC4A30A7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbiA2QgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:36:05 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:44844 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiA2QgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:36:04 -0500
Received: by mail-pj1-f54.google.com with SMTP id nn16-20020a17090b38d000b001b56b2bce31so9389448pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tn8VDDG9d0e9Sp9rvK8OOp7xyu1xxvK9XkYh017etno=;
        b=6RMxlXOy7dNbSKGPnHCS3FfPqAQdsduNunqXZRmfgupgNtaR+3ojqOYx+7QO/tfXSI
         o2aiiVw7s781DZs5pu+0WQKwLxZB0BaGBATa9KQ092H/kgT4uw7hjTszFIyWn9Z6cT9i
         9hsDFfKzDLgPgU7BcwNlPSSmfR+8V3KcTGBYtFLCm/6N+lg9mQjcP+YRvZqtz47Xizzj
         vUrOeOH+0CKRo5ceOdneahpAwOjIuTVg9Y3w7wZVQojzixaI2i9FkuKQkMTFrXYn2Oqj
         H871qbrPkybpk1Egczz1fGXE3Sbo1zrBdzjRtiXqyQXlYmmsRvnV/s9Am6G79SK+M35s
         ZO8Q==
X-Gm-Message-State: AOAM533NGwxpHt+SQiznaIT7SklVDwJ8chlySobHxuvzb0sad678XWho
        ff8TLQRBhTelDY8Dvma85b8IM20igzY+4gDz8Gc=
X-Google-Smtp-Source: ABdhPJzMrDD/M/EHAv2IaWJJxrtH3d8xQFfOV/7/nBm0PoHwYt6UEeFBvYjR9zXhDj6+d9o7kW8BJgbUrxTHUELZ6uQ=
X-Received: by 2002:a17:902:7b95:: with SMTP id w21mr13729553pll.48.1643474163628;
 Sat, 29 Jan 2022 08:36:03 -0800 (PST)
MIME-Version: 1.0
References: <202201280855.Boip1DFz-lkp@intel.com> <CAMuHMdVkdn_X=tEas5DxWz_o9QE2sktnfii=qPJRu1+u+97Fvg@mail.gmail.com>
In-Reply-To: <CAMuHMdVkdn_X=tEas5DxWz_o9QE2sktnfii=qPJRu1+u+97Fvg@mail.gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Sat, 29 Jan 2022 17:35:52 +0100
Message-ID: <CANBLGcyMvgiuc1FhXLvdgsL81O9F617_0JUS4SgH4O4DBmT9vA@mail.gmail.com>
Subject: Re: [esmil:visionfive 36/74] pwm-sifive-ptc.c:undefined reference to `__udivdi3'
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>,
        Chenjieqin <Jessica.Chen@starfivetech.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 at 17:15, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Sat, Jan 29, 2022 at 2:15 AM kernel test robot <lkp@intel.com> wrote:
> > tree:   https://github.com/esmil/linux visionfive
> > head:   31606e93b454de33cd75c74d622f35eee020dc5b
> > commit: d8f87b24049876b29ade8ed4e49f975d32eeec79 [36/74] drivers/pwm: Add SiFive PWM PTC driver
> > config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220128/202201280855.Boip1DFz-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/esmil/linux/commit/d8f87b24049876b29ade8ed4e49f975d32eeec79
> >         git remote add esmil https://github.com/esmil/linux
> >         git fetch --no-tags esmil visionfive
> >         git checkout d8f87b24049876b29ade8ed4e49f975d32eeec79
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    m68k-linux-ld: drivers/pwm/pwm-sifive-ptc.o: in function `sifive_pwm_ptc_apply':
> > >> pwm-sifive-ptc.c:(.text+0x1c2): undefined reference to `__udivdi3'
> >    `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o
>
> +       /* calculate period count */
> +       period_data = state->period / pwm_clk_ns;
>
> 64-by-32 division (pwm_state.period is u64, pwm_clk_ns is uint32_t).
> Please #include <linux/math64.h> and use div_u64():
>
>     period_data = div_u64(period, pwm_clk_ns);

Thanks, I'd only found the raw do_div. This is better.

> +
> +       if (!state->enabled)
> +               /* if is unenable,just set duty_dat to 0 , means low
> level always */
> +               duty_data = 0;
> +       else
> +               /* calculate duty count*/
> +               duty_data = state->duty_cycle / pwm_clk_ns;
>
> Likewise.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
