Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D20A58BA74
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 11:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiHGJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiHGJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 05:40:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C6162F0;
        Sun,  7 Aug 2022 02:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659865241; x=1691401241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ImgjE4x9iGWz4Eh3hMhl6NN5VLUdjlgb6XpSKzzuwuA=;
  b=DTigo1pU81HcaITWTU3TZOWUTyqXd4hD3G7wiD5NuwINspJuQH6FZT79
   KW4UwsdxRTImC8oa9u7nq6in4kEFzP4dGmH5rx5uynfVsSu7gAOK1NnP/
   iakUxHkzP9GOwk8kZ7KgIHVL1NwjoTO2os/dXKwH95NJ1rRwbUbkr8NM4
   SI/pSnF+i/Fv1w504jlN4Of2+h28emjJ1JQxzHqHhCHGgVmKZLjuWsWO6
   sx9XoQH2gQslModVRpPwCS0jafJCPgbxrBa7YoN/Cl1F++eO4u3FsGQGE
   cv62R/S4hHhzAPPxGYAW7ouBzipWxXTFdraamrjA9RCdDg3SsigQcM5E/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="290433512"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="290433512"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 02:40:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="636962364"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Aug 2022 02:40:29 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKclo-000LCh-25;
        Sun, 07 Aug 2022 09:40:28 +0000
Date:   Sun, 7 Aug 2022 17:40:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Szuying Chen <chensiying21@gmail.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Yd_Tseng@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Message-ID: <202208071758.wZC5VHIZ-lkp@intel.com>
References: <20220805092224.2536-1-Chloe_Chen@asmedia.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805092224.2536-1-Chloe_Chen@asmedia.com.tw>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Szuying,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Szuying-Chen/thunderbolt-thunderbolt-add-vendor-s-NVM-formats/20220805-172732
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b2a88c212e652e94f1e4b635910972ac57ba4e97
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220807/202208071758.wZC5VHIZ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cc64350d27db3b30e5ceef2b5d6a3c48b9a4d989
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Szuying-Chen/thunderbolt-thunderbolt-add-vendor-s-NVM-formats/20220805-172732
        git checkout cc64350d27db3b30e5ceef2b5d6a3c48b9a4d989
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/thunderbolt/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/thunderbolt/nvm.c:75:3: error: expected expression
                   struct tb_nvm *nvm;
                   ^
   drivers/thunderbolt/nvm.c:79:3: error: use of undeclared identifier 'nvm'
                   nvm = tb_nvm_alloc(&sw->dev);
                   ^
   drivers/thunderbolt/nvm.c:80:14: error: use of undeclared identifier 'nvm'
                   if (IS_ERR(nvm)) {
                              ^
   drivers/thunderbolt/nvm.c:81:18: error: use of undeclared identifier 'nvm'
                           ret = PTR_ERR(nvm);
                                         ^
   drivers/thunderbolt/nvm.c:89:3: error: use of undeclared identifier 'nvm'
                   nvm->vendor.date = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
                   ^
   drivers/thunderbolt/nvm.c:94:3: error: use of undeclared identifier 'nvm'
                   nvm->vendor.customerID = (((u8)val) << 0x8 | ((u8)(val >> 0x8)));
                   ^
   drivers/thunderbolt/nvm.c:95:3: error: use of undeclared identifier 'nvm'
                   nvm->vendor.version = (u8)(val >> 0x10);
                   ^
   drivers/thunderbolt/nvm.c:97:27: error: use of undeclared identifier 'nvm'
                   ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
                                           ^
   drivers/thunderbolt/nvm.c:101:31: error: use of undeclared identifier 'nvm'
                   ret = tb_nvm_add_non_active(nvm, NVM_MAX_SIZE, tb_switch_nvm_write);
                                               ^
   drivers/thunderbolt/nvm.c:105:13: error: use of undeclared identifier 'nvm'
                   sw->nvm = nvm;
                             ^
   drivers/thunderbolt/nvm.c:109:3: error: expected expression
                   unsigned int image_size;
                   ^
   drivers/thunderbolt/nvm.c:116:3: error: use of undeclared identifier 'image_size'
                   image_size = sw->nvm->buf_data_size;
                   ^
   drivers/thunderbolt/nvm.c:117:7: error: use of undeclared identifier 'image_size'; did you mean 'page_size'?
                   if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE) {
                       ^~~~~~~~~~
                       page_size
   include/linux/mm.h:927:29: note: 'page_size' declared here
   static inline unsigned long page_size(struct page *page)
                               ^
   drivers/thunderbolt/nvm.c:117:36: error: use of undeclared identifier 'image_size'; did you mean 'page_size'?
                   if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE) {
                                                    ^~~~~~~~~~
                                                    page_size
   include/linux/mm.h:927:29: note: 'page_size' declared here
   static inline unsigned long page_size(struct page *page)
                               ^
   drivers/thunderbolt/nvm.c:121:43: error: use of undeclared identifier 'image_size'; did you mean 'page_size'?
                   ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
                                                           ^~~~~~~~~~
                                                           page_size
   include/linux/mm.h:927:29: note: 'page_size' declared here
   static inline unsigned long page_size(struct page *page)
                               ^
>> drivers/thunderbolt/nvm.c:76:7: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                   u32 val;
                       ^
   1 warning and 15 errors generated.


vim +76 drivers/thunderbolt/nvm.c

    62	
    63	static int tb_nvm_vendor_apply(struct tb_switch *sw, unsigned int handle)
    64	{
    65		int ret = 0;
    66	
    67		switch (handle) {
    68		case 0:
    69			if (sw->no_nvm_upgrade)
    70				sw->no_nvm_upgrade = false;
    71	
    72			break;
    73	
    74		case 1:
    75			struct tb_nvm *nvm;
  > 76			u32 val;
    77			u32 nvm_size;
    78	
    79			nvm = tb_nvm_alloc(&sw->dev);
    80			if (IS_ERR(nvm)) {
    81				ret = PTR_ERR(nvm);
    82				break;
    83			}
    84	
    85			ret = usb4_switch_nvm_read(sw, NVM_Date, &val, sizeof(val));
    86			if (ret)
    87				break;
    88	
    89			nvm->vendor.date = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
    90			ret = usb4_switch_nvm_read(sw, NVM_CUSTOMER_ID, &val, sizeof(val));
    91			if (ret)
    92				break;
    93	
    94			nvm->vendor.customerID = (((u8)val) << 0x8 | ((u8)(val >> 0x8)));
    95			nvm->vendor.version = (u8)(val >> 0x10);
    96			nvm_size = SZ_512K;
    97			ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
    98			if (ret)
    99				break;
   100	
   101			ret = tb_nvm_add_non_active(nvm, NVM_MAX_SIZE, tb_switch_nvm_write);
   102			if (ret)
   103				break;
   104	
   105			sw->nvm = nvm;
   106			break;
   107	
   108		case 2:
   109			unsigned int image_size;
   110			const u8 *buf = sw->nvm->buf;
   111	
   112			if (!buf) {
   113				ret = -EINVAL;
   114				break;
   115			}
   116			image_size = sw->nvm->buf_data_size;
   117			if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE) {
   118				ret = -EINVAL;
   119				break;
   120			}
   121			ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
   122			if (!ret)
   123				sw->nvm->flushed = true;
   124	
   125			break;
   126	
   127		default:
   128			break;
   129		}
   130	
   131		if ((handle == 1) && (ret != 0))
   132			tb_nvm_free(sw->nvm);
   133	
   134		return ret;
   135	}
   136	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
