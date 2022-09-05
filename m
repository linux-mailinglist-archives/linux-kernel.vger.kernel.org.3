Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DC35ACD24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiIEHwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbiIEHvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:51:43 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F52145987
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:51:33 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id a22so5620082qtw.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mBdQmRWDY8ne5gcCWgnGXajv2wyTqqdjxhtd10+W++I=;
        b=S2/GlHbGzoSFNj/2wSFFP3CXlweDwcN2bOfcUi7WcJqMTjKzD1ZZptS+Vh/v/NSFLw
         v52DgGxkbaN42SwtAKGU957hmoD370XR7AvD+YPv5M3jL4VhlTh35JTre5Hux1c6XcoO
         in/tMppeK33ZYWCHdoJd+fIogOu2MXbfCl+sEzfWscjhS2yEwE6cifjBl19jPit1k70v
         jn9iCTzSPHsxE2FrEEA0hvb9KcGAFyHTdh+tVuKlvvXaGhJNItbXbBVzOscGk4b4gYIg
         xOwFxW4Eho8r4qNibF8EfCvQhZ21XXBIODJXl7LvRaY+6b5tJ0GVmLjIHNXK/O3/sQF7
         j5cg==
X-Gm-Message-State: ACgBeo1ZVAjooWKSUdy+irtemoLggDv/VjZIKueMt4lXKQzj9hxn9lbv
        HZSZyUVP7QS6NgSY5KLRb3JTYQHl+87esg==
X-Google-Smtp-Source: AA6agR6s2zNoI2IgySttHHm5oHvYkXbk2dYW9UFdWVQFlF7U/dY7565ZllfomYnHtoQYm51zRXVEog==
X-Received: by 2002:ac8:5755:0:b0:343:560d:f4e1 with SMTP id 21-20020ac85755000000b00343560df4e1mr37690062qtx.630.1662364291602;
        Mon, 05 Sep 2022 00:51:31 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id q2-20020a05620a0d8200b006b555509398sm8096332qkl.136.2022.09.05.00.51.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 00:51:31 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3450a7358baso35090037b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:51:31 -0700 (PDT)
X-Received: by 2002:a81:1691:0:b0:345:17df:4fc6 with SMTP id
 139-20020a811691000000b0034517df4fc6mr6428879yww.502.1662364290829; Mon, 05
 Sep 2022 00:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <202209031414.Y8YCEjmI-lkp@intel.com> <YxL9qpQ2YcvC4sjh@kroah.com> <BN8PR11MB3668BC26BC1B17B09A888271E97D9@BN8PR11MB3668.namprd11.prod.outlook.com>
In-Reply-To: <BN8PR11MB3668BC26BC1B17B09A888271E97D9@BN8PR11MB3668.namprd11.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Sep 2022 09:51:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV6oTkv-UACsAjp5t4o4GpPz_YqhdjDdfD4tQsvcjGuBA@mail.gmail.com>
Message-ID: <CAMuHMdV6oTkv-UACsAjp5t4o4GpPz_YqhdjDdfD4tQsvcjGuBA@mail.gmail.com>
Subject: Re: [char-misc:char-misc-testing 20/24] kismet: WARNING: unmet direct
 dependencies detected for GPIOLIB_IRQCHIP when selected by GP_PCI1XXXX
To:     Kumaravel Thiagarajan <Kumaravel.Thiagarajan@microchip.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        kbuild test robot <lkp@intel.com>, paul@pgazz.com,
        fazilyildiran@gmail.com, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kumaravel,

On Sat, Sep 3, 2022 at 12:29 PM <Kumaravel.Thiagarajan@microchip.com> wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Saturday, September 3, 2022 12:40 PM
> > To: kernel test robot <lkp@intel.com>; Kumaravel Thiagarajan - I21417
> > <Kumaravel.Thiagarajan@microchip.com>; Paul Gazzillo <paul@pgazz.com>;
> > Necip Fazil Yildiran <fazilyildiran@gmail.com>; kbuild-all@lists.01.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [char-misc:char-misc-testing 20/24] kismet: WARNING: unmet
> > direct dependencies detected for GPIOLIB_IRQCHIP when selected by
> > GP_PCI1XXXX
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> >
> > On Sat, Sep 03, 2022 at 02:12:13PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> > misc.git char-misc-testing
> > > head:   4ec7ac90ff399b7d9af81cc8afd430a22786c61b
> > > commit: 393fc2f5948fd340d016a9557eea6e1ac2f6c60c [20/24] misc:
> > microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-
> > function endpoint of pci1xxxx device.
> > > config: x86_64-kismet-CONFIG_GPIOLIB_IRQCHIP-CONFIG_GP_PCI1XXXX-
> > 0-0
> > > (https://download.01.org/0day-
> > ci/archive/20220903/202209031414.Y8YCEjm
> > > I-lkp@intel.com/config)
> > > reproduce:
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> > misc.git/commit/?id=393fc2f5948fd340d016a9557eea6e1ac2f6c60c
> > >         git remote add char-misc
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> > >         git fetch --no-tags char-misc char-misc-testing
> > >         git checkout 393fc2f5948fd340d016a9557eea6e1ac2f6c60c
> > >         # 1. reproduce by kismet
> > >            # install kmax per
> > https://github.com/paulgazz/kmax/blob/master/README.md
> > >            kismet --linux-ksrc=linux --selectees CONFIG_GPIOLIB_IRQCHIP --
> > selectors CONFIG_GP_PCI1XXXX -a=x86_64
> > >         # 2. reproduce by make
> > >            # save the config file to linux source tree
> > >            cd linux
> > >            make ARCH=x86_64 olddefconfig
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > kismet warnings: (new ones prefixed by >>)
> > > >> kismet: WARNING: unmet direct dependencies detected for
> > > >> GPIOLIB_IRQCHIP when selected by GP_PCI1XXXX
> > >
> > >    WARNING: unmet direct dependencies detected for GPIOLIB_IRQCHIP
> > >      Depends on [n]: GPIOLIB [=n]
> > >      Selected by [y]:
> > >      - GP_PCI1XXXX [=y] && PCI [=y]
> >
> > Ick, I missed this before in review.  Kumaravel, any chance you can make this
> > a "depends" issue instead of a select one?
>
> Greg, can I select both GPIOLIB & GPIOLIB_IRQCHIP like below?
>
> config GP_PCI1XXXX
>        tristate "Microchip PCI1XXXX PCIe to GPIO Expander + OTP/EEPROM manager"
>        depends on PCI
>        select GPIOLIB
>        select GPIOLIB_IRQCHIP
>        help
>          PCI1XXXX is a PCIe GEN 3 switch with one of the endpoints having
>          multiple functions and one of the functions is a GPIO controller
>          which also has registers to interface with the OTP and EEPROM.
>          Select yes, no or module here to include or exclude the driver
>          for the GPIO function.
>
> or replace "select GPIOLIB_IRQCHIP" with "depends on GPIOLIB_IRQCHIP" like you mentioned?
>
> Please advise.

I think you want to use

    depends on GPIOLIB
    select GPIOLIB_IRQCHIP

The former is a visible symbol, under full user control.
The latter is an invisible symbol, to be selected by drivers that need it.
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
