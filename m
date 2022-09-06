Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21EA5ADEA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 06:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiIFEkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 00:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiIFEkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 00:40:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E195EDF1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 21:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662439211; x=1693975211;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i6pviLp47wGKYv2ksbQeKhlS6DOKuqKfVvzrpAUU+F4=;
  b=cYvSeIbc9k93KJjQUAHyqtY24F2WomMJeVB4h0kyL/GHbA9OaUl6BERd
   9cR+mnMtcQOW8707CJYooeytDG7EM5AF9Tq1XSDJ1sjykCVqxpgkcmUbH
   Y3S52KiKQOZgnMkUB/XzQbhIN1AbYDeJoNyW4uvkReVk10rGO4E/CDw3r
   oywql1YcCGeoVUzQOJ4gMwvHulKE5msIoZ+hYagg5lYDdo9oQvw1oTyct
   KhK7NMQz7lRE7ofqAYoE18q+uhAOwftoElVX0ovkhX6TPujfIWMBUWUBc
   KLe1sqlCluV9vr9XJgObISHHRZ49GstyyBuzOoVf+nM82wN9Pb4+v9acX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="297813450"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="297813450"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 21:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="682258984"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2022 21:40:09 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVQNc-0004o5-2L;
        Tue, 06 Sep 2022 04:40:08 +0000
Date:   Tue, 6 Sep 2022 12:39:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: arch/powerpc/platforms/85xx/mpc85xx_cds.c:161:3: warning:
 unannotated fall-through between switch labels
Message-ID: <202209061224.KxORRGVg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   53e99dcff61e1523ec1c3628b2d564ba15d32eb7
commit: dee2b702bcf067d7b6b62c18bdd060ff0810a800 kconfig: Add support for -Wimplicit-fallthrough
date:   10 months ago
config: powerpc-randconfig-r004-20220906 (https://download.01.org/0day-ci/archive/20220906/202209061224.KxORRGVg-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/85xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/powerpc/platforms/85xx/mpc85xx_cds.c:161:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                   default:
                   ^
   arch/powerpc/platforms/85xx/mpc85xx_cds.c:161:3: note: insert 'break;' to avoid fall-through
                   default:
                   ^
                   break; 
   arch/powerpc/platforms/85xx/mpc85xx_cds.c:184:6: warning: no previous prototype for function 'mpc85xx_cds_fixup_bus' [-Wmissing-prototypes]
   void mpc85xx_cds_fixup_bus(struct pci_bus *bus)
        ^
   arch/powerpc/platforms/85xx/mpc85xx_cds.c:184:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void mpc85xx_cds_fixup_bus(struct pci_bus *bus)
   ^
   static 
   2 warnings generated.


vim +161 arch/powerpc/platforms/85xx/mpc85xx_cds.c

7120438e5d82f4 Andrey Smirnov 2016-07-28  125  
7120438e5d82f4 Andrey Smirnov 2016-07-28  126  
749e80810d26c8 Roy Zang       2007-06-01  127  static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
591f0a4287d0de Andy Fleming   2006-04-02  128  {
591f0a4287d0de Andy Fleming   2006-04-02  129  	u_char c;
749e80810d26c8 Roy Zang       2007-06-01  130  	if (dev->vendor == PCI_VENDOR_ID_VIA) {
749e80810d26c8 Roy Zang       2007-06-01  131  		switch (dev->device) {
749e80810d26c8 Roy Zang       2007-06-01  132  		case PCI_DEVICE_ID_VIA_82C586_1:
591f0a4287d0de Andy Fleming   2006-04-02  133  			/*
591f0a4287d0de Andy Fleming   2006-04-02  134  			 * U-Boot does not set the enable bits
591f0a4287d0de Andy Fleming   2006-04-02  135  			 * for the IDE device. Force them on here.
591f0a4287d0de Andy Fleming   2006-04-02  136  			 */
591f0a4287d0de Andy Fleming   2006-04-02  137  			pci_read_config_byte(dev, 0x40, &c);
591f0a4287d0de Andy Fleming   2006-04-02  138  			c |= 0x03; /* IDE: Chip Enable Bits */
591f0a4287d0de Andy Fleming   2006-04-02  139  			pci_write_config_byte(dev, 0x40, c);
591f0a4287d0de Andy Fleming   2006-04-02  140  
591f0a4287d0de Andy Fleming   2006-04-02  141  			/*
591f0a4287d0de Andy Fleming   2006-04-02  142  			 * Since only primary interface works, force the
591f0a4287d0de Andy Fleming   2006-04-02  143  			 * IDE function to standard primary IDE interrupt
591f0a4287d0de Andy Fleming   2006-04-02  144  			 * w/ 8259 offset
591f0a4287d0de Andy Fleming   2006-04-02  145  			 */
591f0a4287d0de Andy Fleming   2006-04-02  146  			dev->irq = 14;
591f0a4287d0de Andy Fleming   2006-04-02  147  			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
749e80810d26c8 Roy Zang       2007-06-01  148  			break;
591f0a4287d0de Andy Fleming   2006-04-02  149  		/*
591f0a4287d0de Andy Fleming   2006-04-02  150  		 * Force legacy USB interrupt routing
591f0a4287d0de Andy Fleming   2006-04-02  151  		 */
749e80810d26c8 Roy Zang       2007-06-01  152  		case PCI_DEVICE_ID_VIA_82C586_2:
749e80810d26c8 Roy Zang       2007-06-01  153  		/* There are two USB controllers.
749e80810d26c8 Roy Zang       2007-06-01  154  		 * Identify them by functon number
749e80810d26c8 Roy Zang       2007-06-01  155  		 */
8d7bc8f9d1c23f Randy Vinson   2007-07-19  156  			if (PCI_FUNC(dev->devfn) == 3)
749e80810d26c8 Roy Zang       2007-06-01  157  				dev->irq = 11;
749e80810d26c8 Roy Zang       2007-06-01  158  			else
591f0a4287d0de Andy Fleming   2006-04-02  159  				dev->irq = 10;
749e80810d26c8 Roy Zang       2007-06-01  160  			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
749e80810d26c8 Roy Zang       2007-06-01 @161  		default:
749e80810d26c8 Roy Zang       2007-06-01  162  			break;
591f0a4287d0de Andy Fleming   2006-04-02  163  		}
591f0a4287d0de Andy Fleming   2006-04-02  164  	}
591f0a4287d0de Andy Fleming   2006-04-02  165  }
ddd64159eb0d09 Andy Fleming   2006-08-17  166  

:::::: The code at line 161 was first introduced by commit
:::::: 749e80810d26c8d522b089718f22bb92d7834a37 [POWERPC] Remove redundant pci_read_irq_line() function for 85xx platform

:::::: TO: Roy Zang <tie-fei.zang@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
