Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C349A596647
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 02:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiHQAVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 20:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbiHQAVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 20:21:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D098383BC3;
        Tue, 16 Aug 2022 17:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660695668; x=1692231668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rhDzVNNnGdfyKK32OyvW12ap4FYyQ2w7NdRL3cQTteU=;
  b=lDmJl1eOZTZbS0uA4uv1N5Ov1nRrxYzBzsi/aKUdhz+IhjTIVNrX953O
   /mHcs9q9ICWXVF3pRt+xarBsFqF+h1IeIVMz28CX/4IsU9EecEps+D5gY
   VvfUfGtTFviXnFPxjCILsIOru7IuIo9mhnWU/zeeKa98DvgOX9UB6S6el
   s3/PXk2SoF4E+FQaKaDNMDS9ubEXnUANk4wcuyDU0qsInjnloG3DjSGNT
   kAjIrLIJy4RlsSQOVC+lOL3d69NTigCHB2ikVRpXY+LxFR9zHHgdfz2+4
   xnBE+ShGAlNB/xrBW4CejTLDkJqE2lT+ur8QhmrTjtVriyfUfL6eogyf8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="318363763"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="318363763"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 17:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="710345674"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2022 17:21:05 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO6nw-0000N2-1z;
        Wed, 17 Aug 2022 00:21:04 +0000
Date:   Wed, 17 Aug 2022 08:20:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Szuying Chen <chensiying21@gmail.com>, gregkh@linuxfoundation.org,
        mario.limonciello@amd.com, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v4] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <202208170830.DW4YZvZF-lkp@intel.com>
References: <20220816105502.9059-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816105502.9059-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Szuying,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc1 next-20220816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Szuying-Chen/thunderbolt-thunderbolt-add-vendor-s-NVM-formats/20220816-193757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: s390-buildonly-randconfig-r004-20220815 (https://download.01.org/0day-ci/archive/20220817/202208170830.DW4YZvZF-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/16b15f1135451c01b616a6a2bacf2f54a1082a08
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Szuying-Chen/thunderbolt-thunderbolt-add-vendor-s-NVM-formats/20220816-193757
        git checkout 16b15f1135451c01b616a6a2bacf2f54a1082a08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/thunderbolt/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/thunderbolt/nvm.c:14:
   In file included from drivers/thunderbolt/tb.h:13:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/thunderbolt/nvm.c:14:
   In file included from drivers/thunderbolt/tb.h:13:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/thunderbolt/nvm.c:14:
   In file included from drivers/thunderbolt/tb.h:13:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   drivers/thunderbolt/nvm.c:107:3: error: expected expression
                   const u8 *buf = sw->nvm->buf;
                   ^
>> drivers/thunderbolt/nvm.c:109:8: error: use of undeclared identifier 'buf'
                   if (!buf) {
                        ^
   drivers/thunderbolt/nvm.c:118:38: error: use of undeclared identifier 'buf'
                   ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
                                                      ^
   12 warnings and 3 errors generated.


vim +/buf +109 drivers/thunderbolt/nvm.c

    61	
    62	static int asmedia_nvm_validate(struct tb_switch *sw, unsigned int mode)
    63	{
    64		struct tb_nvm *nvm;
    65		u32 val;
    66		u32 nvm_size;
    67		int ret = 0;
    68		unsigned int image_size;
    69	
    70		switch (mode) {
    71		case NVM_UPGRADE:
    72			if (sw->no_nvm_upgrade)
    73				sw->no_nvm_upgrade = false;
    74	
    75			break;
    76	
    77		case NVM_ADD:
    78			nvm = tb_nvm_alloc(&sw->dev);
    79			if (IS_ERR(nvm)) {
    80				ret = PTR_ERR(nvm);
    81				break;
    82			}
    83	
    84			ret = usb4_switch_nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
    85			if (ret)
    86				break;
    87	
    88			nvm->nvm_asm.major = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
    89			ret = usb4_switch_nvm_read(sw, ASMEDIA_NVM_DATE, &val, sizeof(val));
    90			if (ret)
    91				break;
    92	
    93			nvm->nvm_asm.minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
    94			nvm_size = SZ_512K;
    95			ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
    96			if (ret)
    97				break;
    98	
    99			ret = tb_nvm_add_non_active(nvm, NVM_MAX_SIZE, tb_switch_nvm_write);
   100			if (ret)
   101				break;
   102	
   103			sw->nvm = nvm;
   104			break;
   105	
   106		case NVM_WRITE:
   107			const u8 *buf = sw->nvm->buf;
   108	
 > 109			if (!buf) {
   110				ret = -EINVAL;
   111				break;
   112			}
   113			image_size = sw->nvm->buf_data_size;
   114			if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE) {
   115				ret = -EINVAL;
   116				break;
   117			}
   118			ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
   119			if (!ret)
   120				sw->nvm->flushed = true;
   121	
   122			break;
   123	
   124		default:
   125			break;
   126		}
   127	
   128		if ((mode == NVM_ADD) && (ret != 0))
   129			tb_nvm_free(sw->nvm);
   130	
   131		return ret;
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
