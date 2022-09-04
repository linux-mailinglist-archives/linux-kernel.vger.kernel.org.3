Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B55AC34E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 09:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiIDHsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 03:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiIDHr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 03:47:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3459945054
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 00:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B10CB60685
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 07:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DECC433D6;
        Sun,  4 Sep 2022 07:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662277677;
        bh=oxdo6MtDY84aE3uMxN3N24PzVVYS4LOR0JIMYaYd+cU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbhT4RA9mQmsypgSk9fsLX+4f/3N0fZf7Ut/1cjlC11tI8xGEmrQKfo80K18WgBXE
         m7YyUjPjar+Gj6m7hPOaL5qSZh4Mm7DUq1AUocSWvsas5osL5Cf42z/SLNsFyGc0o4
         +DDDQ8mqvwkWymNJaBUXgN1m7fxeuhgSJyRpBstY=
Date:   Sun, 4 Sep 2022 09:47:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     lkp@intel.com, paul@pgazz.com, fazilyildiran@gmail.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [char-misc:char-misc-testing 20/24] kismet: WARNING: unmet
 direct dependencies detected for GPIOLIB_IRQCHIP when selected by
 GP_PCI1XXXX
Message-ID: <YxRYKh3vX4hoOjB6@kroah.com>
References: <202209031414.Y8YCEjmI-lkp@intel.com>
 <YxL9qpQ2YcvC4sjh@kroah.com>
 <BN8PR11MB3668BC26BC1B17B09A888271E97D9@BN8PR11MB3668.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR11MB3668BC26BC1B17B09A888271E97D9@BN8PR11MB3668.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 10:21:31AM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
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

I do not know, try them both out and see what happens.

> I am not able to experiment with these options as my Linux development machine is not accessible
> due to some maintenance activities in office during the weekend.

No worries, doing it this week is fine.

thanks,

greg k-h
