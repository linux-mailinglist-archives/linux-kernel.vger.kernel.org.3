Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977AB4B669A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiBOIxZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Feb 2022 03:53:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBOIxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:53:24 -0500
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB31113AE0;
        Tue, 15 Feb 2022 00:53:14 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id g21so9113768vsp.6;
        Tue, 15 Feb 2022 00:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q1Y32bFnV0z6s8wKFyvVq+8Pc0+YZ2m9QE+RjlAqL5Q=;
        b=ctnr9E90JBq/cYX3xON8GfHtqVU6nPm39DTEPo4rPLk8MdGpCFu4e8Iee7aF+Cj5XS
         GpvKB7V3zaX6ml/EyMP6KgRmvdnQ8DMiAzrUdUx93gB84cQ7myqwWCCjp2OZkQsisXWJ
         pr5Er6fyuN7zuS2Ho3olGRk0sDLtNaObZrsTLtdyG24sPDejMJ3XzdOvmPZuf/WQQS8I
         wi1PZZs789xZa3p5M+eP9gv/MO0iWhkLtC5yP8WT+3n7bB4NOnw4f4B9PyQtP+MDZrep
         grmx+Tt9xTZD1hU6uhyPkqJAXvxtBV1NY8p+chOFbWQaWzFY8u1A4pmKZN1uJft5AwzY
         lclA==
X-Gm-Message-State: AOAM530R6uer0Lyj31kZOD6R/mSAfTmjmaj7i5wyAwXQ1uYRslTjxc2v
        wZ+xx64uXav2+MizhlfrxplCPbJVhSXbJn2R
X-Google-Smtp-Source: ABdhPJyEmLquwoqosW7UUF/FbbEblNRNQP82tFipva5yMt6IUx49LpDA11heQ82vRy1PHRPOy+IBoA==
X-Received: by 2002:a05:6102:38cc:: with SMTP id k12mr1020867vst.31.1644915193861;
        Tue, 15 Feb 2022 00:53:13 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id w2sm668793vkw.40.2022.02.15.00.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 00:53:13 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id g20so9638470vsb.9;
        Tue, 15 Feb 2022 00:53:13 -0800 (PST)
X-Received: by 2002:a05:6102:440d:: with SMTP id df13mr971256vsb.5.1644915193078;
 Tue, 15 Feb 2022 00:53:13 -0800 (PST)
MIME-Version: 1.0
References: <202202142203.4ofqbic9-lkp@intel.com> <20220214151905.00005a27@Huawei.com>
 <CAMuHMdWYHWVroOdqP6+tx_zj+63OG77EcizdnpGsmfto=6SeDw@mail.gmail.com>
In-Reply-To: <CAMuHMdWYHWVroOdqP6+tx_zj+63OG77EcizdnpGsmfto=6SeDw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Feb 2022 09:53:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVNQ=Y9uSS=9GSgu35gHLfsdVTNgxyyu2U5XKqPZYZs3A@mail.gmail.com>
Message-ID: <CAMuHMdVNQ=Y9uSS=9GSgu35gHLfsdVTNgxyyu2U5XKqPZYZs3A@mail.gmail.com>
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

On Tue, Feb 15, 2022 at 9:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Feb 14, 2022 at 8:17 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Mon, 14 Feb 2022 22:47:14 +0800
> > kernel test robot <lkp@intel.com> wrote:
> >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   754e0b0e35608ed5206d6a67a791563c631cec07
> > > commit: d5c70627a79455154f5f636096abe6fe57510605 iio: adc: Add Xilinx AMS driver
> > > date:   8 weeks ago
> > > config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220214/202202142203.4ofqbic9-lkp@intel.com/config)
> > > compiler: sh4-linux-gcc (GCC) 11.2.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5c70627a79455154f5f636096abe6fe57510605
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout d5c70627a79455154f5f636096abe6fe57510605
> > >         # save the config file to linux build tree
> > >         mkdir build_dir
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/iio/adc/ drivers/net/ethernet/freescale/
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> >
> > I'm very tempted to say won't fix on this at least not in the IIO code.
> >
> > The issue I think is the stub for iounmap on sh with no MMU not using the argument because it's
>
> Indeed.
>
> > defined as a while loop rather than as an empty static inline function which is what we'd
> > get it it wasn't defined at all (AFAICT).
>
> We would get that only if <asm-generic/io.h> would be included...
>
> > If anyone wants to take this on, my guess is drop
> > https://elixir.bootlin.com/linux/latest/source/arch/sh/include/asm/io.h#L274
> > and see if everything still works and the warning goes away.
>
> Nope:
>
>     error: implicit declaration of function ‘iounmap’
>
> > +CC linux-sh for inputs.
>
> Thanks, I'll post a fix.

https://lore.kernel.org/r/4ed0a7a0d3fa912a5b44c451884818f2c138ef42.1644914600.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
