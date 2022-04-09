Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588964FA9EC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbiDIRZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiDIRZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:25:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6F71F9A3A;
        Sat,  9 Apr 2022 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649524998; x=1681060998;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HnVPrHU25YgzofhVDItkDJ/R4tqkfZF/RlH1wW8Vtj0=;
  b=PeDFDElOUcfCZkeMrXNWt8IWgBj1wPaQA6L+BqfcAytjseAft4CdE/b2
   S4ghBSc5KXzlv894SOn1NsBmTWwXAdkylLUaXcoNhiFt6AfcFVEOIQiMp
   5hBLLIPQSZKGz7Uwc8GSPSPZ5rwIjaFUtFqx/0PQuenk2bESfGAQx9qKz
   X2nDdmb79ZJmyfjkELO7q19Tb+eLmusKKJ65lbgYeN8VOujUsrLW45Yt7
   lzDPHXBE+qApl73WvH4SE8qnck/7rVHwimXlOOIE8hJYcfXzxJaHCcFQd
   qDaxXoTFJEQbdfyGo7z105aBw5I2MX6wph+t1CokH+ugwbqn7CnS2qLPT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="260679153"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="260679153"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 10:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; 
   d="scan'208";a="622226937"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2022 10:23:16 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndEns-0000FL-6C;
        Sat, 09 Apr 2022 17:23:16 +0000
Date:   Sun, 10 Apr 2022 01:22:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:1175:34:
 warning: unused variable 'c8sectpfe_match'
Message-ID: <202204100134.zt0li8uQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1b45d8ccb9839b48e5884664470e54520e17f4c
commit: e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2 media: platform: place stm32/ and sti/ under st/ dir
date:   3 weeks ago
config: s390-randconfig-r016-20220409 (https://download.01.org/0day-ci/archive/20220410/202204100134.zt0li8uQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9fdd25848a79892eaacc5414d5aef18555b79919)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e7b8153e2a4f0c9c8d1450aa7328d54ea64fe8b2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/media/platform/st/sti/c8sectpfe/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:16:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:16:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:16:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:1175:34: warning: unused variable 'c8sectpfe_match' [-Wunused-const-variable]
   static const struct of_device_id c8sectpfe_match[] = {
                                    ^
   13 warnings generated.


vim +/c8sectpfe_match +1175 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c

c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1174  
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30 @1175  static const struct of_device_id c8sectpfe_match[] = {
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1176  	{ .compatible = "st,stih407-c8sectpfe" },
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1177  	{ /* sentinel */ },
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1178  };
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1179  MODULE_DEVICE_TABLE(of, c8sectpfe_match);
c5f5d0f99794cf drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c Peter Griffin 2015-07-30  1180  

:::::: The code at line 1175 was first introduced by commit
:::::: c5f5d0f99794cfb675ecacfe37a1b33b352b9752 [media] c8sectpfe: STiH407/10 Linux DVB demux support

:::::: TO: Peter Griffin <peter.griffin@linaro.org>
:::::: CC: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
