Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F96A4D206A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348465AbiCHSty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiCHStw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:49:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB14524091
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:48:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5655561631
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95849C340EB;
        Tue,  8 Mar 2022 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646765334;
        bh=9YYaSE0zcLHmYP1okJbTk/+q25CpFwv+Xzod0rR53VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W524Fqz2+RGBYMMoURiLl6IRv2CrOwdOLG2B6WCuUOEufaIGTG0aSIgLcMKG6u1YJ
         UnfBZRtxAK9zJ3mJ5Ie9NdijI6Cu0sInrHzfV+WxDKYW/2Lrx2VeoUVFgBoQJLP4+t
         hHK4YXGDftYhsWUpCMgMTVV/kCD9ux4NPzUEEfGJDMBy9mW79j44oQ69YbxJkV6yxu
         TPLF6ylRir54x0LmJnQUe8gcs7lzbvXL405W0Nd7WlVqW/g6KILBaCZQYzny+aT5qt
         +T0zdo4YjSfG8HBY7TswSkEYhmqV6R+u7DuM/Sqj5GyfjoClJS1eeDPVqBwUwQ6PvU
         idTcXNgm78sVw==
Received: by pali.im (Postfix)
        id 5977A1655; Tue,  8 Mar 2022 19:48:51 +0100 (CET)
Date:   Tue, 8 Mar 2022 19:48:51 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: pcie.c:undefined reference to `pci_remap_iospace'
Message-ID: <20220308184851.jmw2xvrapy5wzwof@pali>
References: <202203090147.24cUL0De-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203090147.24cUL0De-lkp@intel.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2022 02:03:03 kernel test robot wrote:
> Hi Pali,
> 
> FYI, the error/warning still remains.

See: https://lore.kernel.org/linux-mm/20220113134938.3tx7iiukphvazvsq@pali/

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ea4424be16887a37735d6550cfd0611528dbe5d9
> commit: 6198461ef509356e7f0fe5b04e88009aa698a065 arm: ioremap: Replace pci_ioremap_io() usage by pci_remap_iospace()
> date:   3 months ago
> config: arm-randconfig-r033-20220308 (https://download.01.org/0day-ci/archive/20220309/202203090147.24cUL0De-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6198461ef509356e7f0fe5b04e88009aa698a065
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6198461ef509356e7f0fe5b04e88009aa698a065
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: arch/arm/mach-dove/pcie.o: in function `dove_pcie_setup':
> >> pcie.c:(.init.text+0xd4): undefined reference to `pci_remap_iospace'
>    arm-linux-gnueabi-ld: drivers/pci/pci.o: in function `devm_pci_remap_iospace':
>    (.text+0x1372): undefined reference to `pci_remap_iospace'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
