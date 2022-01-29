Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F314A3076
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351978AbiA2QP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:15:56 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:33440 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbiA2QPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:15:50 -0500
Received: by mail-ua1-f42.google.com with SMTP id u6so9479394uaq.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fViSxtqGswQQcDKgDoujfoDQRcc1fcJ5TVFc8e30+Ic=;
        b=oHgQ2Zi/qaqye1Y80YjcscP4z6Zoc3xx3hmjmzW6x4JNVccl/mkUJrnPCwx5m5C7S7
         ajIA1JfKt3CjKXYLSWXMFvVwbHmo7q3B95mcRKA9rOxZYSsEv8Jzn7TrpWqo4ijscSCt
         kJYwu9cZeVR5NZndmznMjs12L72JvZ3epY5vbvydZbG32k0BX5maVB/exLgICwmW1dC8
         pZDkuRS4/uhIEaqup7NzpKJ47sHOqMjdDXX1obrINRZUusVGVJfHxsP7FpjOUN+mXUJd
         i9n0dYXMuhVkpxLtP8yLp7iJfXj3KhBCWkEmPui0xvMS4Ga4cohd/BOygukpiToC6bOE
         Y75g==
X-Gm-Message-State: AOAM530Oq+WcWh8JznSOM9MdMGGhlQs28QJQmlanWNiCZjO81XAZRENi
        U3Pra/PAJyAWDwIGisHTbXc2afqPGmGyTA==
X-Google-Smtp-Source: ABdhPJwbIEgUDjSqMHK4eQ7aCV51DJT2iKHSB+HNX7NeQqt1tEAXy3YkV+bS/P7X/dc3cX+OjMl5Lw==
X-Received: by 2002:ab0:1631:: with SMTP id k46mr5686212uae.24.1643472947841;
        Sat, 29 Jan 2022 08:15:47 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id j37sm2500233vka.45.2022.01.29.08.15.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 08:15:47 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id o15so5715821vki.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 08:15:47 -0800 (PST)
X-Received: by 2002:a05:6122:c8f:: with SMTP id ba15mr5900645vkb.39.1643472946991;
 Sat, 29 Jan 2022 08:15:46 -0800 (PST)
MIME-Version: 1.0
References: <202201280855.Boip1DFz-lkp@intel.com>
In-Reply-To: <202201280855.Boip1DFz-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 29 Jan 2022 17:15:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVkdn_X=tEas5DxWz_o9QE2sktnfii=qPJRu1+u+97Fvg@mail.gmail.com>
Message-ID: <CAMuHMdVkdn_X=tEas5DxWz_o9QE2sktnfii=qPJRu1+u+97Fvg@mail.gmail.com>
Subject: Re: [esmil:visionfive 36/74] pwm-sifive-ptc.c:undefined reference to `__udivdi3'
To:     kernel test robot <lkp@intel.com>
Cc:     Chenjieqin <Jessica.Chen@starfivetech.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 2:15 AM kernel test robot <lkp@intel.com> wrote:
> tree:   https://github.com/esmil/linux visionfive
> head:   31606e93b454de33cd75c74d622f35eee020dc5b
> commit: d8f87b24049876b29ade8ed4e49f975d32eeec79 [36/74] drivers/pwm: Add SiFive PWM PTC driver
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220128/202201280855.Boip1DFz-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/esmil/linux/commit/d8f87b24049876b29ade8ed4e49f975d32eeec79
>         git remote add esmil https://github.com/esmil/linux
>         git fetch --no-tags esmil visionfive
>         git checkout d8f87b24049876b29ade8ed4e49f975d32eeec79
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    m68k-linux-ld: drivers/pwm/pwm-sifive-ptc.o: in function `sifive_pwm_ptc_apply':
> >> pwm-sifive-ptc.c:(.text+0x1c2): undefined reference to `__udivdi3'
>    `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

+       /* calculate period count */
+       period_data = state->period / pwm_clk_ns;

64-by-32 division (pwm_state.period is u64, pwm_clk_ns is uint32_t).
Please #include <linux/math64.h> and use div_u64():

    period_data = div_u64(period, pwm_clk_ns);

+
+       if (!state->enabled)
+               /* if is unenable,just set duty_dat to 0 , means low
level always */
+               duty_data = 0;
+       else
+               /* calculate duty count*/
+               duty_data = state->duty_cycle / pwm_clk_ns;

Likewise.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
