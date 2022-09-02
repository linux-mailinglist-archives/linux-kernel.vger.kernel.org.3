Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296E95AA877
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiIBHC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiIBHCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:02:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB82DBCC36
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91F9E6204B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90988C433D6;
        Fri,  2 Sep 2022 07:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662102165;
        bh=ZrG0/lUHl2HvmtM/ofUKrXPvmZWlaYFtgFovI52B8WY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=0PwWrxQKFJsE8suNuNs2PYfAw3Pqy22MiK055JGSua86/61nZyGwv54LjjyVWWuso
         WkWmQzdAKJYZSM4faK7hl2oBhyw6d1IYRLbhkf7PYc6a+MFPZo17IDk4yOlPhUTrHA
         gLq1hdaOjlAa5MSjGyRHOxlmVDV3cabZ00VFaKAE=
Date:   Fri, 2 Sep 2022 09:02:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [char-misc:char-misc-testing 20/24]
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error:
 'PCI_IRQ_ALL_TYPES' undeclared
Message-ID: <YxGqkvNg0rXDXoew@kroah.com>
References: <202209020641.mPiacQEP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209020641.mPiacQEP-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 06:13:10AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-testing
> head:   51ea3f9e9017b47c15b37a200d8e81e36a169b70
> commit: 3f359bf61b6f65be474fbcdf557cd412f19d0f1d [20/24] misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220902/202209020641.mPiacQEP-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=3f359bf61b6f65be474fbcdf557cd412f19d0f1d
>         git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
>         git fetch --no-tags char-misc char-misc-testing
>         git checkout 3f359bf61b6f65be474fbcdf557cd412f19d0f1d
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/misc/mchp_pci1xxxx/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c: In function 'gp_aux_bus_probe':
> >> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c:87:52: error: 'PCI_IRQ_ALL_TYPES' undeclared (first use in this function)
>       87 |         retval = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>          |                                                    ^~~~~~~~~~~~~~~~~

Odd.

Ah, the driver needs to have a "depends on PCI" for the Kconfig file.

Kumaravel, can you send an add-on patch for this issue with the proper
"Reported-by:" line as asked for above?

thanks,

greg k-h
