Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DB44B6631
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiBOIdj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Feb 2022 03:33:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiBOId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:33:29 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A3C621A;
        Tue, 15 Feb 2022 00:33:19 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id j9so2266619vkj.1;
        Tue, 15 Feb 2022 00:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oR61WoE2PUcAYaftqeV9KOA2/duj5FvLte7fWGKCtuM=;
        b=JbZUl8BSz2gsWG7vZO2wQBaLDJUsVK4njR3CDP5+pzrfj8NiXKvZzfIm0Y35QFnXj4
         EVQ4lsNoqbq93MbLDu+8yBc1w3a22ExU191yaXUUohnOoJWC+AHxSvyg4TQOou9P3hwC
         kINtdFWwCNy+JyyojNJwglxwTKD7OHEAoIIkW6dSOF8uLaTFYMT5nk1fEOVvqSRKSn9T
         2krY9q36yZnC2vED2SlxzVbJDVF7+ffyq61Wes3vTyKQ54JyOQRAMFmkCZMkestp1vom
         eH+TN5po8u6bXVPPgl1Yebeal1gmRQJcE+KWwCej+yewpwCOJKnCT5U37OD4SoOmk7j2
         U0Wg==
X-Gm-Message-State: AOAM5330eOUl9nfYNiJZMsh6fqouRB5cnhEjltZFqjpUXltmxayH15LD
        jZmRbAdE9vqCKtYL4+/4An0wO3gTk7sOMIC5
X-Google-Smtp-Source: ABdhPJy5AeTXv0S+6g0lz0alWqsSYyhe0HwSq+tOfy1jNb82cqVbdPSssVuleAXsLwySy9maOe+/tQ==
X-Received: by 2002:a05:6122:d0b:: with SMTP id az11mr907935vkb.11.1644913998923;
        Tue, 15 Feb 2022 00:33:18 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id t3sm430827vkl.53.2022.02.15.00.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 00:33:18 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id j20so7898598vsg.5;
        Tue, 15 Feb 2022 00:33:18 -0800 (PST)
X-Received: by 2002:a05:6102:440d:: with SMTP id df13mr953197vsb.5.1644913998142;
 Tue, 15 Feb 2022 00:33:18 -0800 (PST)
MIME-Version: 1.0
References: <202202142203.4ofqbic9-lkp@intel.com> <20220214151905.00005a27@Huawei.com>
In-Reply-To: <20220214151905.00005a27@Huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Feb 2022 09:33:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWYHWVroOdqP6+tx_zj+63OG77EcizdnpGsmfto=6SeDw@mail.gmail.com>
Message-ID: <CAMuHMdWYHWVroOdqP6+tx_zj+63OG77EcizdnpGsmfto=6SeDw@mail.gmail.com>
Subject: Re: drivers/iio/adc/xilinx-ams.c:1195:21: error: unused variable 'ams'
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     kernel test robot <lkp@intel.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Manish Narani <manish.narani@xilinx.com>,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan.

On Mon, Feb 14, 2022 at 8:17 PM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Mon, 14 Feb 2022 22:47:14 +0800
> kernel test robot <lkp@intel.com> wrote:
>
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   754e0b0e35608ed5206d6a67a791563c631cec07
> > commit: d5c70627a79455154f5f636096abe6fe57510605 iio: adc: Add Xilinx AMS driver
> > date:   8 weeks ago
> > config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220214/202202142203.4ofqbic9-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5c70627a79455154f5f636096abe6fe57510605
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout d5c70627a79455154f5f636096abe6fe57510605
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/iio/adc/ drivers/net/ethernet/freescale/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
>
> I'm very tempted to say won't fix on this at least not in the IIO code.
>
> The issue I think is the stub for iounmap on sh with no MMU not using the argument because it's

Indeed.

> defined as a while loop rather than as an empty static inline function which is what we'd
> get it it wasn't defined at all (AFAICT).

We would get that only if <asm-generic/io.h> would be included...

> If anyone wants to take this on, my guess is drop
> https://elixir.bootlin.com/linux/latest/source/arch/sh/include/asm/io.h#L274
> and see if everything still works and the warning goes away.

Nope:

    error: implicit declaration of function ‘iounmap’

> +CC linux-sh for inputs.

Thanks, I'll post a fix.

> > All errors (new ones prefixed by >>):
> >
> >    drivers/iio/adc/xilinx-ams.c: In function 'ams_iounmap_ps':
> > >> drivers/iio/adc/xilinx-ams.c:1195:21: error: unused variable 'ams' [-Werror=unused-variable]
> >     1195 |         struct ams *ams = data;
> >          |                     ^~~
> >    drivers/iio/adc/xilinx-ams.c: In function 'ams_iounmap_pl':
> >    drivers/iio/adc/xilinx-ams.c:1202:21: error: unused variable 'ams' [-Werror=unused-variable]
> >     1202 |         struct ams *ams = data;
> >          |                     ^~~
> >    cc1: all warnings being treated as errors

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
