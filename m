Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57975AEF4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiIFPr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiIFPrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:47:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4CC6E81;
        Tue,  6 Sep 2022 07:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96BAC61566;
        Tue,  6 Sep 2022 14:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A296C433D6;
        Tue,  6 Sep 2022 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662476235;
        bh=R18WFnNy3TwZN3ByMr1YJcCSh/76hXZOmWVfX7DNusQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eaLkIX0QbKGPlAQf1xCrPXpzXXN2fUJadh5o1s5l8SBRQou7LTp2MwwIg7CNHlRlf
         ZeFuau2ADeD7JyiSaT7B1rsaPb4VO+7s7ZlzNU4q+gRriEJQ5YUT+ZlOYus4lVmTEp
         +lpor9XXqe6JMuQlvX6rPgw24P6OpoOWd0EYupTlncinSrPmGIcj2Es+bVcfSdcGUG
         +IhG1B5uvhS4F8SOLF5+WKqLBgv51x13yoeupzpjeeALa3ltNH+H3JuZio6QOz0zVb
         6Z3SH3Xr//GF1IUykQ4quBjnklfh0cMdFYTh02nSXxjHtCKFdGVsBoMbk20lQo0lcn
         cGbowpCahLhjw==
Date:   Tue, 6 Sep 2022 07:57:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Li Yang <leoyang.li@nxp.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: drivers/usb/gadget/udc/fsl_qe_udc.c:624:4: warning: unannotated
 fall-through between switch labels
Message-ID: <YxdfyJVLtEaSEoEe@dev-arch.thelio-3990X>
References: <202209040524.gGNP6kqx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209040524.gGNP6kqx-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-usb and some maintainers

On Sun, Sep 04, 2022 at 05:21:53AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   42cf58c272ee1dae902e8cc1166c246589abd1d8
> commit: dee2b702bcf067d7b6b62c18bdd060ff0810a800 kconfig: Add support for -Wimplicit-fallthrough
> date:   10 months ago
> config: powerpc-randconfig-r001-20220904 (https://download.01.org/0day-ci/archive/20220904/202209040524.gGNP6kqx-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dee2b702bcf067d7b6b62c18bdd060ff0810a800
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout dee2b702bcf067d7b6b62c18bdd060ff0810a800
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/nohash/ arch/powerpc/perf/ arch/powerpc/platforms/85xx/ arch/powerpc/sysdev/ drivers/usb/gadget/udc/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):

<snip irrelevant warnings>

> >> drivers/usb/gadget/udc/fsl_qe_udc.c:624:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>                            default:
>                            ^
>    drivers/usb/gadget/udc/fsl_qe_udc.c:624:4: note: insert '__attribute__((fallthrough));' to silence this warning
>                            default:
>                            ^
>                            __attribute__((fallthrough)); 
>    drivers/usb/gadget/udc/fsl_qe_udc.c:624:4: note: insert 'break;' to avoid fall-through
>                            default:
>                            ^
>                            break; 
>    drivers/usb/gadget/udc/fsl_qe_udc.c:654:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
>                    default:
>                    ^
>    drivers/usb/gadget/udc/fsl_qe_udc.c:654:3: note: insert 'break;' to avoid fall-through
>                    default:
>                    ^
>                    break; 

This seems like a legitimate issue or at least one that needs
clarification...

>    drivers/usb/gadget/udc/fsl_qe_udc.c:1023:19: warning: variable 'pframe' set but not used [-Wunused-but-set-variable]
>            struct qe_frame *pframe;
>                             ^
>    drivers/usb/gadget/udc/fsl_qe_udc.c:1698:6: warning: variable 'reval' set but not used [-Wunused-but-set-variable]
>            int reval;
>                ^
>    drivers/usb/gadget/udc/fsl_qe_udc.c:50:19: warning: unused variable 'driver_desc' [-Wunused-const-variable]
>    static const char driver_desc[] = DRIVER_DESC;
>                      ^
>    11 warnings generated.
> 
> 
> vim +624 drivers/usb/gadget/udc/fsl_qe_udc.c
> 
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  519  
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  520  static int qe_ep_init(struct qe_udc *udc,
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  521  		      unsigned char pipe_num,
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  522  		      const struct usb_endpoint_descriptor *desc)
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  523  {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  524  	struct qe_ep *ep = &udc->eps[pipe_num];
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  525  	unsigned long flags;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  526  	int reval = 0;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  527  	u16 max = 0;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  528  
> 29cc88979a8818 drivers/usb/gadget/fsl_qe_udc.c     Kuninori Morimoto   2011-08-23  529  	max = usb_endpoint_maxp(desc);
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  530  
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  531  	/* check the max package size validate for this endpoint */
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  532  	/* Refer to USB2.0 spec table 9-13,
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  533  	*/
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  534  	if (pipe_num != 0) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  535  		switch (desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  536  		case USB_ENDPOINT_XFER_BULK:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  537  			if (strstr(ep->ep.name, "-iso")
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  538  					|| strstr(ep->ep.name, "-int"))
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  539  				goto en_done;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  540  			switch (udc->gadget.speed) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  541  			case USB_SPEED_HIGH:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  542  			if ((max == 128) || (max == 256) || (max == 512))
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  543  				break;
> f91e5d097f1207 drivers/usb/gadget/udc/fsl_qe_udc.c Randy Dunlap        2021-04-27  544  			fallthrough;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  545  			default:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  546  				switch (max) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  547  				case 4:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  548  				case 8:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  549  				case 16:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  550  				case 32:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  551  				case 64:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  552  					break;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  553  				default:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  554  				case USB_SPEED_LOW:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  555  					goto en_done;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  556  				}
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  557  			}
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  558  			break;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  559  		case USB_ENDPOINT_XFER_INT:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  560  			if (strstr(ep->ep.name, "-iso"))	/* bulk is ok */
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  561  				goto en_done;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  562  			switch (udc->gadget.speed) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  563  			case USB_SPEED_HIGH:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  564  				if (max <= 1024)
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  565  					break;
> f91e5d097f1207 drivers/usb/gadget/udc/fsl_qe_udc.c Randy Dunlap        2021-04-27  566  				fallthrough;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  567  			case USB_SPEED_FULL:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  568  				if (max <= 64)
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  569  					break;
> f91e5d097f1207 drivers/usb/gadget/udc/fsl_qe_udc.c Randy Dunlap        2021-04-27  570  				fallthrough;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  571  			default:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  572  				if (max <= 8)
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  573  					break;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  574  				goto en_done;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  575  			}
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  576  			break;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  577  		case USB_ENDPOINT_XFER_ISOC:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  578  			if (strstr(ep->ep.name, "-bulk")
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  579  				|| strstr(ep->ep.name, "-int"))
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  580  				goto en_done;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  581  			switch (udc->gadget.speed) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  582  			case USB_SPEED_HIGH:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  583  				if (max <= 1024)
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  584  					break;
> f91e5d097f1207 drivers/usb/gadget/udc/fsl_qe_udc.c Randy Dunlap        2021-04-27  585  				fallthrough;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  586  			case USB_SPEED_FULL:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  587  				if (max <= 1023)
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  588  					break;
> 14158aa4510439 drivers/usb/gadget/udc/fsl_qe_udc.c Gustavo A. R. Silva 2021-07-14  589  				fallthrough;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  590  			default:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  591  				goto en_done;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  592  			}
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  593  			break;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  594  		case USB_ENDPOINT_XFER_CONTROL:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  595  			if (strstr(ep->ep.name, "-iso")
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  596  				|| strstr(ep->ep.name, "-int"))
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  597  				goto en_done;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  598  			switch (udc->gadget.speed) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  599  			case USB_SPEED_HIGH:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  600  			case USB_SPEED_FULL:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  601  				switch (max) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  602  				case 1:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  603  				case 2:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  604  				case 4:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  605  				case 8:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  606  				case 16:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  607  				case 32:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  608  				case 64:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  609  					break;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  610  				default:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  611  					goto en_done;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  612  				}
> f91e5d097f1207 drivers/usb/gadget/udc/fsl_qe_udc.c Randy Dunlap        2021-04-27  613  				fallthrough;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  614  			case USB_SPEED_LOW:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  615  				switch (max) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  616  				case 1:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  617  				case 2:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  618  				case 4:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  619  				case 8:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  620  					break;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  621  				default:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  622  					goto en_done;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  623  				}
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02 @624  			default:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  625  				goto en_done;

As far as I can tell, a 'goto en_done' is always taken. Either we hit a
default case somewhere and 'goto en_done' or the inner switch statements
will break if the value is one of the ones listed then we fallthrough to
the default case regardless, if I am reading this right? Is this
intentional or a bug?

Cheers,
Nathan

> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  626  			}
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  627  			break;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  628  
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  629  		default:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  630  			goto en_done;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  631  		}
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  632  	} /* if ep0*/
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  633  
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  634  	spin_lock_irqsave(&udc->lock, flags);
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  635  
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  636  	/* initialize ep structure */
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  637  	ep->ep.maxpacket = max;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  638  	ep->tm = (u8)(desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK);
> ec39e2aeeff290 drivers/usb/gadget/fsl_qe_udc.c     Ido Shayevitz       2012-03-12  639  	ep->ep.desc = desc;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  640  	ep->stopped = 0;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  641  	ep->init = 1;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  642  
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  643  	if (pipe_num == 0) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  644  		ep->dir = USB_DIR_BOTH;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  645  		udc->ep0_dir = USB_DIR_OUT;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  646  		udc->ep0_state = WAIT_FOR_SETUP;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  647  	} else	{
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  648  		switch (desc->bEndpointAddress & USB_ENDPOINT_DIR_MASK) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  649  		case USB_DIR_OUT:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  650  			ep->dir = USB_DIR_OUT;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  651  			break;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  652  		case USB_DIR_IN:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  653  			ep->dir = USB_DIR_IN;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  654  		default:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  655  			break;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  656  		}
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  657  	}
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  658  
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  659  	/* hardware special operation */
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  660  	qe_ep_bd_init(udc, pipe_num);
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  661  	if ((ep->tm == USBP_TM_CTL) || (ep->dir == USB_DIR_OUT)) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  662  		reval = qe_ep_rxbd_update(ep);
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  663  		if (reval)
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  664  			goto en_done1;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  665  	}
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  666  
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  667  	if ((ep->tm == USBP_TM_CTL) || (ep->dir == USB_DIR_IN)) {
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  668  		ep->txframe = kmalloc(sizeof(*ep->txframe), GFP_ATOMIC);
> d9116ca87e8dfe drivers/usb/gadget/udc/fsl_qe_udc.c Wolfram Sang        2016-08-25  669  		if (!ep->txframe)
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  670  			goto en_done2;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  671  		qe_frame_init(ep->txframe);
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  672  	}
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  673  
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  674  	qe_ep_register_init(udc, pipe_num);
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  675  
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  676  	/* Now HW will be NAKing transfers to that EP,
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  677  	 * until a buffer is queued to it. */
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  678  	spin_unlock_irqrestore(&udc->lock, flags);
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  679  
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  680  	return 0;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  681  en_done2:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  682  	kfree(ep->rxbuffer);
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  683  	kfree(ep->rxframe);
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  684  en_done1:
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  685  	spin_unlock_irqrestore(&udc->lock, flags);
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  686  en_done:
> cd40c4c45eaedc drivers/usb/gadget/fsl_qe_udc.c     Anton Vorontsov     2008-11-08  687  	dev_err(udc->dev, "failed to initialize %s\n", ep->ep.name);
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  688  	return -ENODEV;
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  689  }
> 3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  690  
> 
> :::::: The code at line 624 was first introduced by commit
> :::::: 3948f0e0c999a6201e9898bb8fbe3c6cc1199276 usb: add Freescale QE/CPM USB peripheral controller driver
> 
> :::::: TO: Li Yang <leoli@freescale.com>
> :::::: CC: Greg Kroah-Hartman <gregkh@suse.de>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
