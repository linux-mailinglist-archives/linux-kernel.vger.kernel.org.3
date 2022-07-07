Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF6F56AA2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiGGSCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiGGSCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:02:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B7B2656F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:02:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA93562099
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 18:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A574EC3411E;
        Thu,  7 Jul 2022 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657216930;
        bh=HDoiUoInW6aRDDHHBzIKcn6qHHceeqkyq+CtmISyeXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFNRNmus3psaglVsXhnp50XE0PLeedFGauo1lxlwehQS+G6/mNCfKqLJAjuzYaUhm
         EI+zP/PyEYWmd8XZ0aJ8awxttRUg0EmcFh0qXk4VN+Q0gYRqCGSt/Y6pQlhv9reMi8
         JmbFNT++r3TVVkL4uA2Sm5K4oltpHe7qs7wNNroA=
Date:   Thu, 7 Jul 2022 20:02:07 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [linux-stable-rc:linux-4.19.y 1539/3265]
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:15: error: implicit
 declaration of function 'read_poll_timeout'
Message-ID: <YscfnyyLd5Oxd/3p@kroah.com>
References: <202207061830.78pJNuwN-lkp@intel.com>
 <701e5ff60f921cb80bbc76e0fe0119b93c9bb431.camel@calian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <701e5ff60f921cb80bbc76e0fe0119b93c9bb431.camel@calian.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:42:48PM +0000, Robert Hancock wrote:
> On Wed, 2022-07-06 at 18:43 +0800, kernel test robot wrote:
> > Hi Robert,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:  
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git__;!!IOGos0k!nK_4HG5DiIjhDaFvtB2c4HTsoQMg8UHEBJDv6stlGIMButbUtJc42wGH5qXaVC5JIkAwZas4Ne1iIw$
> >   linux-4.19.y
> > head:   b9f174a70c6f609b6132c3a65883b16d552984b8
> > commit: 8b8ad8a7ac24905937c3975b54c4594b93b66ebb [1539/3265] net:
> > axienet: Wait for PhyRstCmplt after core reset
> > config: microblaze-randconfig-r003-20220704
> > (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/
> > 20220706/202207061830.78pJNuwN-lkp@intel.com/config__;!!IOGos0k!nK_4H
> > G5DiIjhDaFvtB2c4HTsoQMg8UHEBJDv6stlGIMButbUtJc42wGH5qXaVC5JIkAwZatUAT
> > tDaQ$ )
> > compiler: microblaze-linux-gcc (GCC) 11.3.0
> > reproduce (this is a W=1 build):
> >         wget
> > https://urldefense.com/v3/__https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross__;!!IOGos0k!nK_4HG5DiIjhDaFvtB2c4HTsoQMg8UHEBJDv6stlGIMButbUtJc42wGH5qXaVC5JIkAwZautG4jkgg$
> >   -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         #
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=8b8ad8a7ac24905937c3975b54c4594b93b66ebb__;!!IOGos0k!nK_4HG5DiIjhDaFvtB2c4HTsoQMg8UHEBJDv6stlGIMButbUtJc42wGH5qXaVC5JIkAwZas8R9M_sA$
> >  
> >         git remote add linux-stable-rc
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git__;!!IOGos0k!nK_4HG5DiIjhDaFvtB2c4HTsoQMg8UHEBJDv6stlGIMButbUtJc42wGH5qXaVC5JIkAwZas4Ne1iIw$
> >  
> >         git fetch --no-tags linux-stable-rc linux-4.19.y
> >         git checkout 8b8ad8a7ac24905937c3975b54c4594b93b66ebb
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0
> > make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash
> > drivers/net/ethernet/xilinx/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    drivers/net/ethernet/xilinx/xilinx_axienet_main.c: In function
> > 'axienet_dma_bd_init':
> >    drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:9: error:
> > 'ret' undeclared (first use in this function); did you mean 'net'?
> >      283 |         ret = read_poll_timeout(axienet_ior, value,
> >          |         ^~~
> >          |         net
> >    drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:9: note:
> > each undeclared identifier is reported only once for each function it
> > appears in
> > > > drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:15: error:
> > > > implicit declaration of function 'read_poll_timeout' [-
> > > > Werror=implicit-function-declaration]
> >      283 |         ret = read_poll_timeout(axienet_ior, value,
> >          |               ^~~~~~~~~~~~~~~~~
> >    drivers/net/ethernet/xilinx/xilinx_axienet_main.c:283:46: error:
> > 'value' undeclared (first use in this function)
> >      283 |         ret = read_poll_timeout(axienet_ior, value,
> >          |                                              ^~~~~
> >    cc1: some warnings being treated as errors
> > 
> 
> This seems like maybe a bad backport of the listed patch to the 4.19
> stable release?

If so, can you provide a fix for this?

thanks,

greg k-h
