Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819C45AAAA4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiIBIwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiIBIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:52:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE4977541
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:52:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35760B82A20
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68487C433C1;
        Fri,  2 Sep 2022 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662108722;
        bh=KotLMig5z7tT9Gwnx+UUjdt0ZwNA6Lb0o+zz/CQnB1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vV/zgjjCC0eA451u6LxPpHtT/i61Xqg8yXrI5WW4014zKg3Y6Mq8ob7uDxgiNTCM3
         XV+6l7p/s9vHWqQlGu43+9DG1zchkwspUVpWTisdxtHJtxiOGZ+0OpwmV8S47HvuXl
         JRTqMVJuqR2tZ5bukbvj6CEob+4UflLZc+jsy/DU=
Date:   Fri, 2 Sep 2022 10:51:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc:char-misc-testing 20/24]
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
 'PCI_IRQ_ALL_TYPES' undeclared
Message-ID: <YxHEL6SscClLdkss@kroah.com>
References: <202209020641.mPiacQEP-lkp@intel.com>
 <YxGqkvNg0rXDXoew@kroah.com>
 <BN8PR11MB3668E0B249AB3CFCE15A4D3BE97A9@BN8PR11MB3668.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR11MB3668E0B249AB3CFCE15A4D3BE97A9@BN8PR11MB3668.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 08:30:22AM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> 
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Friday, September 2, 2022 12:33 PM
> > To: kernel test robot <lkp@intel.com>; Kumaravel Thiagarajan - I21417
> > <Kumaravel.Thiagarajan@microchip.com>; kbuild-all@lists.01.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [char-misc:char-misc-testing 20/24]
> > drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
> > 'PCI_IRQ_ALL_TYPES' undeclared
> > 
> > 
> > On Fri, Sep 02, 2022 at 06:13:10AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> > misc.git char-misc-testing
> > > head:   51ea3f9e9017b47c15b37a200d8e81e36a169b70
> > > commit: 3f359bf61b6f65be474fbcdf557cd412f19d0f1d [20/24] misc:
> > microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-
> > function endpoint of pci1xxxx device.
> > > config: sh-allmodconfig
> > > (https://download.01.org/0day-
> > ci/archive/20220902/202209020641.mPiacQE
> > > P-lkp@intel.com/config)
> > > compiler: sh4-linux-gcc (GCC) 12.1.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-
> > tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-
> > misc.git/commit/?id=3f359bf61b6f65be474fbcdf557cd412f19d0f1d
> > >         git remote add char-misc
> > https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> > >         git fetch --no-tags char-misc char-misc-testing
> > >         git checkout 3f359bf61b6f65be474fbcdf557cd412f19d0f1d
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> > > make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash
> > > drivers/misc/mchp_pci1xxxx/
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All error/warnings (new ones prefixed by >>):
> > >
> > >    drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c: In function
> > 'gp_aux_bus_probe':
> > > >> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
> > > >> 'PCI_IRQ_ALL_TYPES' undeclared (first use in this function)
> > >       87 |         retval = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> > >          |                                                    ^~~~~~~~~~~~~~~~~
> > 
> > Odd.
> > 
> > Ah, the driver needs to have a "depends on PCI" for the Kconfig file.
> > 
> > Kumaravel, can you send an add-on patch for this issue with the proper
> > "Reported-by:" line as asked for above?
> Greg, for the add-on patch, can I modify only the KConfig file which you can apply to
> commit id: 3f359bf61b6f65be474fbcdf557cd412f19d0f1d of char-misc-testing?

Yes, I can merge them together.

thanks,

greg k-h
