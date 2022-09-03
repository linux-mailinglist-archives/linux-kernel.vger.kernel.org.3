Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82D05AC170
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 23:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiICVWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 17:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiICVWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 17:22:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7923CFC1
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662240132; x=1693776132;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QaiF2l7DngsGbjNRw0hIS+JCJD2uY7wTJ0JtOgdl3IQ=;
  b=EYOLEw7aytJ56OGrm+XjnSQ9i2Vg0KQai7zkF0xRGPXlesl7j1guLDvd
   Toxo6VFzNcqqx3lkYkiuHWBcNl7sZRx1l7OQEwk2NigHH1z84z0nk1qUz
   1NN2UI0QFdd7wZXNj5DetIFMDq/pvvQNwu1s1NaZeRGqx0fRTbbdIRIQi
   IiSW53zAAFrRUmi8RncWdSPE7IiSf9M6BfyMcvgBEjGXhrDZTLGeAfwVq
   /tfsRN+SMsC/P9nVOHhBBVPBfCTQQKwJIT0AR2DVd1eJCCq3vKZiL4LQR
   GdZE1gAQWaUWEca1Obe+2z35ejn2dhQ7lFzOJfqYTLczUIaYAoD3+0KYT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="283179393"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="283179393"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 14:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="646480311"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Sep 2022 14:22:09 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUaae-0002Dd-2z;
        Sat, 03 Sep 2022 21:22:08 +0000
Date:   Sun, 4 Sep 2022 05:21:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/usb/gadget/udc/fsl_qe_udc.c:624:4: warning: unannotated
 fall-through between switch labels
Message-ID: <202209040524.gGNP6kqx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42cf58c272ee1dae902e8cc1166c246589abd1d8
commit: dee2b702bcf067d7b6b62c18bdd060ff0810a800 kconfig: Add support for -Wimplicit-fallthrough
date:   10 months ago
config: powerpc-randconfig-r001-20220904 (https://download.01.org/0day-ci/archive/20220904/202209040524.gGNP6kqx-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dee2b702bcf067d7b6b62c18bdd060ff0810a800
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dee2b702bcf067d7b6b62c18bdd060ff0810a800
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/mm/nohash/ arch/powerpc/perf/ arch/powerpc/platforms/85xx/ arch/powerpc/sysdev/ drivers/usb/gadget/udc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   __do_insb
   ^
   arch/powerpc/include/asm/io.h:556:56: note: expanded from macro '__do_insb'
   #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/usb/gadget/udc/fsl_qe_udc.c:27:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:12:1: note: expanded from here
   __do_insw
   ^
   arch/powerpc/include/asm/io.h:557:56: note: expanded from macro '__do_insw'
   #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/usb/gadget/udc/fsl_qe_udc.c:27:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:14:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:558:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/usb/gadget/udc/fsl_qe_udc.c:27:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:16:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:559:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/usb/gadget/udc/fsl_qe_udc.c:27:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:18:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:560:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/usb/gadget/udc/fsl_qe_udc.c:27:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:619:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:20:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:561:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> drivers/usb/gadget/udc/fsl_qe_udc.c:624:4: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                           default:
                           ^
   drivers/usb/gadget/udc/fsl_qe_udc.c:624:4: note: insert '__attribute__((fallthrough));' to silence this warning
                           default:
                           ^
                           __attribute__((fallthrough)); 
   drivers/usb/gadget/udc/fsl_qe_udc.c:624:4: note: insert 'break;' to avoid fall-through
                           default:
                           ^
                           break; 
   drivers/usb/gadget/udc/fsl_qe_udc.c:654:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                   default:
                   ^
   drivers/usb/gadget/udc/fsl_qe_udc.c:654:3: note: insert 'break;' to avoid fall-through
                   default:
                   ^
                   break; 
   drivers/usb/gadget/udc/fsl_qe_udc.c:1023:19: warning: variable 'pframe' set but not used [-Wunused-but-set-variable]
           struct qe_frame *pframe;
                            ^
   drivers/usb/gadget/udc/fsl_qe_udc.c:1698:6: warning: variable 'reval' set but not used [-Wunused-but-set-variable]
           int reval;
               ^
   drivers/usb/gadget/udc/fsl_qe_udc.c:50:19: warning: unused variable 'driver_desc' [-Wunused-const-variable]
   static const char driver_desc[] = DRIVER_DESC;
                     ^
   11 warnings generated.


vim +624 drivers/usb/gadget/udc/fsl_qe_udc.c

3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  519  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  520  static int qe_ep_init(struct qe_udc *udc,
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  521  		      unsigned char pipe_num,
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  522  		      const struct usb_endpoint_descriptor *desc)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  523  {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  524  	struct qe_ep *ep = &udc->eps[pipe_num];
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  525  	unsigned long flags;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  526  	int reval = 0;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  527  	u16 max = 0;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  528  
29cc88979a8818 drivers/usb/gadget/fsl_qe_udc.c     Kuninori Morimoto   2011-08-23  529  	max = usb_endpoint_maxp(desc);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  530  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  531  	/* check the max package size validate for this endpoint */
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  532  	/* Refer to USB2.0 spec table 9-13,
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  533  	*/
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  534  	if (pipe_num != 0) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  535  		switch (desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  536  		case USB_ENDPOINT_XFER_BULK:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  537  			if (strstr(ep->ep.name, "-iso")
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  538  					|| strstr(ep->ep.name, "-int"))
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  539  				goto en_done;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  540  			switch (udc->gadget.speed) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  541  			case USB_SPEED_HIGH:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  542  			if ((max == 128) || (max == 256) || (max == 512))
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  543  				break;
f91e5d097f1207 drivers/usb/gadget/udc/fsl_qe_udc.c Randy Dunlap        2021-04-27  544  			fallthrough;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  545  			default:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  546  				switch (max) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  547  				case 4:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  548  				case 8:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  549  				case 16:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  550  				case 32:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  551  				case 64:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  552  					break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  553  				default:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  554  				case USB_SPEED_LOW:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  555  					goto en_done;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  556  				}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  557  			}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  558  			break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  559  		case USB_ENDPOINT_XFER_INT:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  560  			if (strstr(ep->ep.name, "-iso"))	/* bulk is ok */
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  561  				goto en_done;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  562  			switch (udc->gadget.speed) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  563  			case USB_SPEED_HIGH:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  564  				if (max <= 1024)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  565  					break;
f91e5d097f1207 drivers/usb/gadget/udc/fsl_qe_udc.c Randy Dunlap        2021-04-27  566  				fallthrough;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  567  			case USB_SPEED_FULL:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  568  				if (max <= 64)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  569  					break;
f91e5d097f1207 drivers/usb/gadget/udc/fsl_qe_udc.c Randy Dunlap        2021-04-27  570  				fallthrough;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  571  			default:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  572  				if (max <= 8)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  573  					break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  574  				goto en_done;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  575  			}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  576  			break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  577  		case USB_ENDPOINT_XFER_ISOC:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  578  			if (strstr(ep->ep.name, "-bulk")
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  579  				|| strstr(ep->ep.name, "-int"))
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  580  				goto en_done;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  581  			switch (udc->gadget.speed) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  582  			case USB_SPEED_HIGH:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  583  				if (max <= 1024)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  584  					break;
f91e5d097f1207 drivers/usb/gadget/udc/fsl_qe_udc.c Randy Dunlap        2021-04-27  585  				fallthrough;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  586  			case USB_SPEED_FULL:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  587  				if (max <= 1023)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  588  					break;
14158aa4510439 drivers/usb/gadget/udc/fsl_qe_udc.c Gustavo A. R. Silva 2021-07-14  589  				fallthrough;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  590  			default:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  591  				goto en_done;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  592  			}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  593  			break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  594  		case USB_ENDPOINT_XFER_CONTROL:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  595  			if (strstr(ep->ep.name, "-iso")
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  596  				|| strstr(ep->ep.name, "-int"))
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  597  				goto en_done;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  598  			switch (udc->gadget.speed) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  599  			case USB_SPEED_HIGH:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  600  			case USB_SPEED_FULL:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  601  				switch (max) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  602  				case 1:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  603  				case 2:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  604  				case 4:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  605  				case 8:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  606  				case 16:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  607  				case 32:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  608  				case 64:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  609  					break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  610  				default:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  611  					goto en_done;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  612  				}
f91e5d097f1207 drivers/usb/gadget/udc/fsl_qe_udc.c Randy Dunlap        2021-04-27  613  				fallthrough;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  614  			case USB_SPEED_LOW:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  615  				switch (max) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  616  				case 1:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  617  				case 2:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  618  				case 4:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  619  				case 8:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  620  					break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  621  				default:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  622  					goto en_done;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  623  				}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02 @624  			default:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  625  				goto en_done;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  626  			}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  627  			break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  628  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  629  		default:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  630  			goto en_done;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  631  		}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  632  	} /* if ep0*/
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  633  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  634  	spin_lock_irqsave(&udc->lock, flags);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  635  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  636  	/* initialize ep structure */
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  637  	ep->ep.maxpacket = max;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  638  	ep->tm = (u8)(desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK);
ec39e2aeeff290 drivers/usb/gadget/fsl_qe_udc.c     Ido Shayevitz       2012-03-12  639  	ep->ep.desc = desc;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  640  	ep->stopped = 0;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  641  	ep->init = 1;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  642  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  643  	if (pipe_num == 0) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  644  		ep->dir = USB_DIR_BOTH;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  645  		udc->ep0_dir = USB_DIR_OUT;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  646  		udc->ep0_state = WAIT_FOR_SETUP;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  647  	} else	{
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  648  		switch (desc->bEndpointAddress & USB_ENDPOINT_DIR_MASK) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  649  		case USB_DIR_OUT:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  650  			ep->dir = USB_DIR_OUT;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  651  			break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  652  		case USB_DIR_IN:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  653  			ep->dir = USB_DIR_IN;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  654  		default:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  655  			break;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  656  		}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  657  	}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  658  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  659  	/* hardware special operation */
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  660  	qe_ep_bd_init(udc, pipe_num);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  661  	if ((ep->tm == USBP_TM_CTL) || (ep->dir == USB_DIR_OUT)) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  662  		reval = qe_ep_rxbd_update(ep);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  663  		if (reval)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  664  			goto en_done1;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  665  	}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  666  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  667  	if ((ep->tm == USBP_TM_CTL) || (ep->dir == USB_DIR_IN)) {
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  668  		ep->txframe = kmalloc(sizeof(*ep->txframe), GFP_ATOMIC);
d9116ca87e8dfe drivers/usb/gadget/udc/fsl_qe_udc.c Wolfram Sang        2016-08-25  669  		if (!ep->txframe)
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  670  			goto en_done2;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  671  		qe_frame_init(ep->txframe);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  672  	}
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  673  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  674  	qe_ep_register_init(udc, pipe_num);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  675  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  676  	/* Now HW will be NAKing transfers to that EP,
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  677  	 * until a buffer is queued to it. */
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  678  	spin_unlock_irqrestore(&udc->lock, flags);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  679  
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  680  	return 0;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  681  en_done2:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  682  	kfree(ep->rxbuffer);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  683  	kfree(ep->rxframe);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  684  en_done1:
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  685  	spin_unlock_irqrestore(&udc->lock, flags);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  686  en_done:
cd40c4c45eaedc drivers/usb/gadget/fsl_qe_udc.c     Anton Vorontsov     2008-11-08  687  	dev_err(udc->dev, "failed to initialize %s\n", ep->ep.name);
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  688  	return -ENODEV;
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  689  }
3948f0e0c999a6 drivers/usb/gadget/fsl_qe_udc.c     Li Yang             2008-09-02  690  

:::::: The code at line 624 was first introduced by commit
:::::: 3948f0e0c999a6201e9898bb8fbe3c6cc1199276 usb: add Freescale QE/CPM USB peripheral controller driver

:::::: TO: Li Yang <leoli@freescale.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
