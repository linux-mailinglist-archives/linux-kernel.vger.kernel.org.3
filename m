Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7145853478B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbiEZAix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344494AbiEZAit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:38:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C4412A86
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:38:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FBDA61699
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E87C385B8;
        Thu, 26 May 2022 00:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653525527;
        bh=mcqnCN2YBvUwzyeX7k9K0peIxzEFPkn3xDeteHBJrdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N81Te+SF1DaTNUMLBN4mZrqMfFtVaNu04yzxkWAlTPTkjjB2gjrpRj4YiUOUG2C9s
         wVOIhua2ME2fPtnqKDcwdZRp7/toRuiOBEgYWx4yfRor4GbFQhNwSsgZ2baz26jZ0/
         KqNpbrO/hogCJiuGrST8myIByIeIz52S387T66zjv/KgCiLaCXWTxnbPwLpWDr0PEs
         zOehz4xfU646b/yq2Q47pM3yfoprinh8TG5y/4ArXluhF2hfpv8nmOrvBtVvQ7bLWC
         8nf1S1iLaIkPcmLl9wWRXx6wgzMUAbQXC2kLwWp9fb7IkzLsIxXKJFXd9ee9tf44w0
         XaYPLwyZb1QjQ==
Date:   Wed, 25 May 2022 17:38:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer
 type 'enum imx_dma_type' from 'const void *'
Message-ID: <Yo7MFbwDyT+1lzcr@dev-arch.thelio-3990X>
References: <202205021042.xPjJ6Z4J-lkp@intel.com>
 <CAOMZO5Dg8_vDbW0vau4YFspZZ-RS=in8xEavkyYvBAQB41xTWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dg8_vDbW0vau4YFspZZ-RS=in8xEavkyYvBAQB41xTWA@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 09:14:30PM -0300, Fabio Estevam wrote:
> On Sun, May 1, 2022 at 11:13 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Fabio,
> >
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   672c0c5173427e6b3e2a9bbb7be51ceeec78093a
> > commit: 0ab785c894e618587e83bb67e8a8e96649868ad1 dmaengine: imx-dma: Remove unused .id_table
> > date:   1 year, 5 months ago
> > config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220502/202205021042.xPjJ6Z4J-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 09325d36061e42b495d1f4c7e933e260eac260ed)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0ab785c894e618587e83bb67e8a8e96649868ad1
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 0ab785c894e618587e83bb67e8a8e96649868ad1
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/dma/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/dma/imx-dma.c:1048:20: warning: cast to smaller integer type 'enum imx_dma_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> >            imxdma->devtype = (enum imx_dma_type)of_device_get_match_data(&pdev->dev);
> >                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    1 warning generated.
> 
> Does anyone know how to fix this clang warning?

Either an intermediate cast to uintptr_t or unsigned long or replacing
the enum cast with one of those should work. See commits:

2602dc10f9d9 ("memory: renesas-rpc-if: Silence clang warning")
10462b3558d4 ("can: mcp251x: mcp251x_can_probe(): silence clang warning")
83415669d8d8 ("can: hi311x: hi3110_can_probe(): silence clang warning")
be5aeee30e45 ("scsi: fcoe: Suppress a compiler warning")

Cheers,
Nathan
