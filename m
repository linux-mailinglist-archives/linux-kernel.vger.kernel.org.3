Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91114E1B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 12:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244700AbiCTLae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 07:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiCTLac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 07:30:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFB82AE10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647775748; x=1679311748;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dBq0OSMa9X004PJvexP6BCkyqeRPN1aSAJ0JYfwwMJk=;
  b=kAUNvX/jHo2z76WYQMVQu1FQ78kki5ptMO7SYrKBMtsHXur3hFWb07Go
   mrjSpEKvL8WuBlSzbLExoZ34jleGdQK/8NAyepy3JbpZSJUmgs2wMghSJ
   ftm11WXe80ujYS8QvWtg/QzFXMebOVJWZHOED18tmvEa3TrKNojpnPYc6
   rK9u1u+ufyhTdPYm5TZr185sn0Ri+wS1EIHJkXyKBUkl4I9X+xpewpBP9
   udZQ8fk7VgZM7Q3OBxObIzsC3hSn4EJIAb4XUMI9k7xzs0AJFivfmg+Rh
   vEaLg1AphrPQZr3u27nHc5IFJY/lN9pCYHCZ7AtwJXaMHGjBclISBam/D
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="239542986"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="239542986"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 04:29:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="518081222"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2022 04:29:06 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVtk9-000Grw-RW; Sun, 20 Mar 2022 11:29:05 +0000
Date:   Sun, 20 Mar 2022 19:28:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 317/317]
 drivers/scsi/ufs/ufshcd-crypto.c:24:30: error: 'struct ufs_hba' has no
 member named 'crypto_cfg_register'
Message-ID: <202203201943.V8TSsqLr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   905917fe701f16ad2d895c3fef85ca92efd86a06
commit: 905917fe701f16ad2d895c3fef85ca92efd86a06 [317/317] scsi: ufs: Split struct ufs_hba
config: arm-randconfig-r021-20220320 (https://download.01.org/0day-ci/archive/20220320/202203201943.V8TSsqLr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/905917fe701f16ad2d895c3fef85ca92efd86a06
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche ufs-for-next
        git checkout 905917fe701f16ad2d895c3fef85ca92efd86a06
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/scsi/ufs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/scsi/ufs/ufshcd-crypto.c: In function 'ufshcd_program_key':
>> drivers/scsi/ufs/ufshcd-crypto.c:24:30: error: 'struct ufs_hba' has no member named 'crypto_cfg_register'
      24 |         u32 slot_offset = hba->crypto_cfg_register + slot * sizeof(*cfg);
         |                              ^~
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from drivers/scsi/ufs/ufshcd.h:15,
                    from drivers/scsi/ufs/ufshcd-crypto.c:6:
   drivers/scsi/ufs/ufshcd-crypto.c: In function 'ufshcd_crypto_keyslot_program':
>> include/linux/container_of.h:19:54: error: 'struct ufs_hba' has no member named 'crypto_profile'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/scsi/ufs/ufshcd-crypto.c:56:17: note: in expansion of macro 'container_of'
      56 |                 container_of(profile, struct ufs_hba, crypto_profile);
         |                 ^~~~~~~~~~~~
>> include/linux/compiler_types.h:287:27: error: expression in static assertion is not an integer
     287 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/scsi/ufs/ufshcd-crypto.c:56:17: note: in expansion of macro 'container_of'
      56 |                 container_of(profile, struct ufs_hba, crypto_profile);
         |                 ^~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/compiler_types.h:140:41: error: 'struct ufs_hba' has no member named 'crypto_profile'
     140 | #define __compiler_offsetof(a, b)       __builtin_offsetof(a, b)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:33: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:22:28: note: in expansion of macro 'offsetof'
      22 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   drivers/scsi/ufs/ufshcd-crypto.c:56:17: note: in expansion of macro 'container_of'
      56 |                 container_of(profile, struct ufs_hba, crypto_profile);
         |                 ^~~~~~~~~~~~
>> drivers/scsi/ufs/ufshcd-crypto.c:57:59: error: 'struct ufs_hba' has no member named 'crypto_cap_array'
      57 |         const union ufs_crypto_cap_entry *ccap_array = hba->crypto_cap_array;
         |                                                           ^~
>> drivers/scsi/ufs/ufshcd-crypto.c:67:30: error: 'struct ufs_hba' has no member named 'crypto_capabilities'; did you mean 'capabilities'?
      67 |         for (i = 0; i < hba->crypto_capabilities.num_crypto_cap; i++) {
         |                              ^~~~~~~~~~~~~~~~~~~
         |                              capabilities
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from drivers/scsi/ufs/ufshcd.h:15,
                    from drivers/scsi/ufs/ufshcd-crypto.c:6:
   drivers/scsi/ufs/ufshcd-crypto.c: In function 'ufshcd_crypto_keyslot_evict':
>> include/linux/container_of.h:19:54: error: 'struct ufs_hba' has no member named 'crypto_profile'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                                      ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/scsi/ufs/ufshcd-crypto.c:114:17: note: in expansion of macro 'container_of'
     114 |                 container_of(profile, struct ufs_hba, crypto_profile);
         |                 ^~~~~~~~~~~~
>> include/linux/compiler_types.h:287:27: error: expression in static assertion is not an integer
     287 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/scsi/ufs/ufshcd-crypto.c:114:17: note: in expansion of macro 'container_of'
     114 |                 container_of(profile, struct ufs_hba, crypto_profile);
         |                 ^~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/compiler_types.h:140:41: error: 'struct ufs_hba' has no member named 'crypto_profile'
     140 | #define __compiler_offsetof(a, b)       __builtin_offsetof(a, b)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:33: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:22:28: note: in expansion of macro 'offsetof'
      22 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   drivers/scsi/ufs/ufshcd-crypto.c:114:17: note: in expansion of macro 'container_of'
     114 |                 container_of(profile, struct ufs_hba, crypto_profile);
         |                 ^~~~~~~~~~~~
   drivers/scsi/ufs/ufshcd-crypto.c: In function 'ufshcd_crypto_enable':
>> drivers/scsi/ufs/ufshcd-crypto.c:125:43: error: 'struct ufs_hba' has no member named 'crypto_profile'
     125 |         blk_crypto_reprogram_all_keys(&hba->crypto_profile);
         |                                           ^~
   drivers/scsi/ufs/ufshcd-crypto.c: In function 'ufshcd_hba_init_crypto_capabilities':
   drivers/scsi/ufs/ufshcd-crypto.c:171:14: error: 'struct ufs_hba' has no member named 'crypto_capabilities'; did you mean 'capabilities'?
     171 |         hba->crypto_capabilities.reg_val =
         |              ^~~~~~~~~~~~~~~~~~~
         |              capabilities
   drivers/scsi/ufs/ufshcd-crypto.c:173:12: error: 'struct ufs_hba' has no member named 'crypto_cfg_register'
     173 |         hba->crypto_cfg_register =
         |            ^~
   drivers/scsi/ufs/ufshcd-crypto.c:174:27: error: 'struct ufs_hba' has no member named 'crypto_capabilities'; did you mean 'capabilities'?
     174 |                 (u32)hba->crypto_capabilities.config_array_ptr * 0x100;
         |                           ^~~~~~~~~~~~~~~~~~~
         |                           capabilities
   drivers/scsi/ufs/ufshcd-crypto.c:175:12: error: 'struct ufs_hba' has no member named 'crypto_cap_array'
     175 |         hba->crypto_cap_array =
         |            ^~
   drivers/scsi/ufs/ufshcd-crypto.c:176:45: error: 'struct ufs_hba' has no member named 'crypto_capabilities'; did you mean 'capabilities'?
     176 |                 devm_kcalloc(hba->dev, hba->crypto_capabilities.num_crypto_cap,
         |                                             ^~~~~~~~~~~~~~~~~~~
         |                                             capabilities
   drivers/scsi/ufs/ufshcd-crypto.c:177:40: error: 'struct ufs_hba' has no member named 'crypto_cap_array'
     177 |                              sizeof(hba->crypto_cap_array[0]), GFP_KERNEL);
         |                                        ^~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from drivers/scsi/ufs/ufshcd.h:15,
                    from drivers/scsi/ufs/ufshcd-crypto.c:6:
   drivers/scsi/ufs/ufshcd-crypto.c:178:17: error: 'struct ufs_hba' has no member named 'crypto_cap_array'
     178 |         if (!hba->crypto_cap_array) {
         |                 ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/scsi/ufs/ufshcd-crypto.c:178:9: note: in expansion of macro 'if'
     178 |         if (!hba->crypto_cap_array) {
         |         ^~
   drivers/scsi/ufs/ufshcd-crypto.c:178:17: error: 'struct ufs_hba' has no member named 'crypto_cap_array'
     178 |         if (!hba->crypto_cap_array) {
         |                 ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/scsi/ufs/ufshcd-crypto.c:178:9: note: in expansion of macro 'if'
     178 |         if (!hba->crypto_cap_array) {
         |         ^~
   drivers/scsi/ufs/ufshcd-crypto.c:178:17: error: 'struct ufs_hba' has no member named 'crypto_cap_array'
     178 |         if (!hba->crypto_cap_array) {
         |                 ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/scsi/ufs/ufshcd-crypto.c:178:9: note: in expansion of macro 'if'
     178 |         if (!hba->crypto_cap_array) {
         |         ^~
   drivers/scsi/ufs/ufshcd-crypto.c:185:39: error: 'struct ufs_hba' has no member named 'crypto_profile'
     185 |                         hba->dev, &hba->crypto_profile,
         |                                       ^~
   drivers/scsi/ufs/ufshcd-crypto.c:186:30: error: 'struct ufs_hba' has no member named 'crypto_capabilities'; did you mean 'capabilities'?
     186 |                         hba->crypto_capabilities.config_count + 1);
         |                              ^~~~~~~~~~~~~~~~~~~
         |                              capabilities
   drivers/scsi/ufs/ufshcd-crypto.c:190:12: error: 'struct ufs_hba' has no member named 'crypto_profile'
     190 |         hba->crypto_profile.ll_ops = ufshcd_crypto_ops;
         |            ^~
   drivers/scsi/ufs/ufshcd-crypto.c:192:12: error: 'struct ufs_hba' has no member named 'crypto_profile'
     192 |         hba->crypto_profile.max_dun_bytes_supported = 8;
         |            ^~
   drivers/scsi/ufs/ufshcd-crypto.c:193:12: error: 'struct ufs_hba' has no member named 'crypto_profile'
     193 |         hba->crypto_profile.dev = hba->dev;
         |            ^~
   drivers/scsi/ufs/ufshcd-crypto.c:199:42: error: 'struct ufs_hba' has no member named 'crypto_capabilities'; did you mean 'capabilities'?
     199 |         for (cap_idx = 0; cap_idx < hba->crypto_capabilities.num_crypto_cap;
         |                                          ^~~~~~~~~~~~~~~~~~~
         |                                          capabilities
   drivers/scsi/ufs/ufshcd-crypto.c:201:20: error: 'struct ufs_hba' has no member named 'crypto_cap_array'
     201 |                 hba->crypto_cap_array[cap_idx].reg_val =
         |                    ^~
   drivers/scsi/ufs/ufshcd-crypto.c:206:52: error: 'struct ufs_hba' has no member named 'crypto_cap_array'
     206 |                                                 hba->crypto_cap_array[cap_idx]);
         |                                                    ^~
   drivers/scsi/ufs/ufshcd-crypto.c:208:28: error: 'struct ufs_hba' has no member named 'crypto_profile'
     208 |                         hba->crypto_profile.modes_supported[blk_mode_num] |=
         |                            ^~
   drivers/scsi/ufs/ufshcd-crypto.c:209:36: error: 'struct ufs_hba' has no member named 'crypto_cap_array'
     209 |                                 hba->crypto_cap_array[cap_idx].sdus_mask * 512;
         |                                    ^~
   drivers/scsi/ufs/ufshcd-crypto.c: In function 'ufshcd_init_crypto':
   drivers/scsi/ufs/ufshcd-crypto.c:232:36: error: 'struct ufs_hba' has no member named 'crypto_capabilities'; did you mean 'capabilities'?
     232 |         for (slot = 0; slot < hba->crypto_capabilities.config_count + 1; slot++)
         |                                    ^~~~~~~~~~~~~~~~~~~
         |                                    capabilities
   drivers/scsi/ufs/ufshcd-crypto.c: In function 'ufshcd_crypto_register':
   drivers/scsi/ufs/ufshcd-crypto.c:239:41: error: 'struct ufs_hba' has no member named 'crypto_profile'
     239 |                 blk_crypto_register(&hba->crypto_profile, q);


vim +24 drivers/scsi/ufs/ufshcd-crypto.c

70297a8ac7a7a4 Satya Tangirala 2020-07-06   19  
1bc726e26ef317 Eric Biggers    2020-07-10   20  static int ufshcd_program_key(struct ufs_hba *hba,
1bc726e26ef317 Eric Biggers    2020-07-10   21  			      const union ufs_crypto_cfg_entry *cfg, int slot)
70297a8ac7a7a4 Satya Tangirala 2020-07-06   22  {
70297a8ac7a7a4 Satya Tangirala 2020-07-06   23  	int i;
70297a8ac7a7a4 Satya Tangirala 2020-07-06  @24  	u32 slot_offset = hba->crypto_cfg_register + slot * sizeof(*cfg);
1bc726e26ef317 Eric Biggers    2020-07-10   25  	int err = 0;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   26  
70297a8ac7a7a4 Satya Tangirala 2020-07-06   27  	ufshcd_hold(hba, false);
1bc726e26ef317 Eric Biggers    2020-07-10   28  
1bc726e26ef317 Eric Biggers    2020-07-10   29  	if (hba->vops && hba->vops->program_key) {
1bc726e26ef317 Eric Biggers    2020-07-10   30  		err = hba->vops->program_key(hba, cfg, slot);
1bc726e26ef317 Eric Biggers    2020-07-10   31  		goto out;
1bc726e26ef317 Eric Biggers    2020-07-10   32  	}
1bc726e26ef317 Eric Biggers    2020-07-10   33  
70297a8ac7a7a4 Satya Tangirala 2020-07-06   34  	/* Ensure that CFGE is cleared before programming the key */
70297a8ac7a7a4 Satya Tangirala 2020-07-06   35  	ufshcd_writel(hba, 0, slot_offset + 16 * sizeof(cfg->reg_val[0]));
70297a8ac7a7a4 Satya Tangirala 2020-07-06   36  	for (i = 0; i < 16; i++) {
70297a8ac7a7a4 Satya Tangirala 2020-07-06   37  		ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[i]),
70297a8ac7a7a4 Satya Tangirala 2020-07-06   38  			      slot_offset + i * sizeof(cfg->reg_val[0]));
70297a8ac7a7a4 Satya Tangirala 2020-07-06   39  	}
70297a8ac7a7a4 Satya Tangirala 2020-07-06   40  	/* Write dword 17 */
70297a8ac7a7a4 Satya Tangirala 2020-07-06   41  	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[17]),
70297a8ac7a7a4 Satya Tangirala 2020-07-06   42  		      slot_offset + 17 * sizeof(cfg->reg_val[0]));
70297a8ac7a7a4 Satya Tangirala 2020-07-06   43  	/* Dword 16 must be written last */
70297a8ac7a7a4 Satya Tangirala 2020-07-06   44  	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[16]),
70297a8ac7a7a4 Satya Tangirala 2020-07-06   45  		      slot_offset + 16 * sizeof(cfg->reg_val[0]));
1bc726e26ef317 Eric Biggers    2020-07-10   46  out:
70297a8ac7a7a4 Satya Tangirala 2020-07-06   47  	ufshcd_release(hba);
1bc726e26ef317 Eric Biggers    2020-07-10   48  	return err;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   49  }
70297a8ac7a7a4 Satya Tangirala 2020-07-06   50  
cb77cb5abe1f4f Eric Biggers    2021-10-18   51  static int ufshcd_crypto_keyslot_program(struct blk_crypto_profile *profile,
70297a8ac7a7a4 Satya Tangirala 2020-07-06   52  					 const struct blk_crypto_key *key,
70297a8ac7a7a4 Satya Tangirala 2020-07-06   53  					 unsigned int slot)
70297a8ac7a7a4 Satya Tangirala 2020-07-06   54  {
cb77cb5abe1f4f Eric Biggers    2021-10-18   55  	struct ufs_hba *hba =
cb77cb5abe1f4f Eric Biggers    2021-10-18   56  		container_of(profile, struct ufs_hba, crypto_profile);
70297a8ac7a7a4 Satya Tangirala 2020-07-06  @57  	const union ufs_crypto_cap_entry *ccap_array = hba->crypto_cap_array;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   58  	const struct ufs_crypto_alg_entry *alg =
70297a8ac7a7a4 Satya Tangirala 2020-07-06   59  			&ufs_crypto_algs[key->crypto_cfg.crypto_mode];
70297a8ac7a7a4 Satya Tangirala 2020-07-06   60  	u8 data_unit_mask = key->crypto_cfg.data_unit_size / 512;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   61  	int i;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   62  	int cap_idx = -1;
6500251e590657 Pujin Shi       2020-10-02   63  	union ufs_crypto_cfg_entry cfg = {};
1bc726e26ef317 Eric Biggers    2020-07-10   64  	int err;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   65  
70297a8ac7a7a4 Satya Tangirala 2020-07-06   66  	BUILD_BUG_ON(UFS_CRYPTO_KEY_SIZE_INVALID != 0);
70297a8ac7a7a4 Satya Tangirala 2020-07-06  @67  	for (i = 0; i < hba->crypto_capabilities.num_crypto_cap; i++) {
70297a8ac7a7a4 Satya Tangirala 2020-07-06   68  		if (ccap_array[i].algorithm_id == alg->ufs_alg &&
70297a8ac7a7a4 Satya Tangirala 2020-07-06   69  		    ccap_array[i].key_size == alg->ufs_key_size &&
70297a8ac7a7a4 Satya Tangirala 2020-07-06   70  		    (ccap_array[i].sdus_mask & data_unit_mask)) {
70297a8ac7a7a4 Satya Tangirala 2020-07-06   71  			cap_idx = i;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   72  			break;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   73  		}
70297a8ac7a7a4 Satya Tangirala 2020-07-06   74  	}
70297a8ac7a7a4 Satya Tangirala 2020-07-06   75  
70297a8ac7a7a4 Satya Tangirala 2020-07-06   76  	if (WARN_ON(cap_idx < 0))
70297a8ac7a7a4 Satya Tangirala 2020-07-06   77  		return -EOPNOTSUPP;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   78  
70297a8ac7a7a4 Satya Tangirala 2020-07-06   79  	cfg.data_unit_size = data_unit_mask;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   80  	cfg.crypto_cap_idx = cap_idx;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   81  	cfg.config_enable = UFS_CRYPTO_CONFIGURATION_ENABLE;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   82  
70297a8ac7a7a4 Satya Tangirala 2020-07-06   83  	if (ccap_array[cap_idx].algorithm_id == UFS_CRYPTO_ALG_AES_XTS) {
70297a8ac7a7a4 Satya Tangirala 2020-07-06   84  		/* In XTS mode, the blk_crypto_key's size is already doubled */
70297a8ac7a7a4 Satya Tangirala 2020-07-06   85  		memcpy(cfg.crypto_key, key->raw, key->size/2);
70297a8ac7a7a4 Satya Tangirala 2020-07-06   86  		memcpy(cfg.crypto_key + UFS_CRYPTO_KEY_MAX_SIZE/2,
70297a8ac7a7a4 Satya Tangirala 2020-07-06   87  		       key->raw + key->size/2, key->size/2);
70297a8ac7a7a4 Satya Tangirala 2020-07-06   88  	} else {
70297a8ac7a7a4 Satya Tangirala 2020-07-06   89  		memcpy(cfg.crypto_key, key->raw, key->size);
70297a8ac7a7a4 Satya Tangirala 2020-07-06   90  	}
70297a8ac7a7a4 Satya Tangirala 2020-07-06   91  
1bc726e26ef317 Eric Biggers    2020-07-10   92  	err = ufshcd_program_key(hba, &cfg, slot);
70297a8ac7a7a4 Satya Tangirala 2020-07-06   93  
70297a8ac7a7a4 Satya Tangirala 2020-07-06   94  	memzero_explicit(&cfg, sizeof(cfg));
1bc726e26ef317 Eric Biggers    2020-07-10   95  	return err;
70297a8ac7a7a4 Satya Tangirala 2020-07-06   96  }
70297a8ac7a7a4 Satya Tangirala 2020-07-06   97  
1bc726e26ef317 Eric Biggers    2020-07-10   98  static int ufshcd_clear_keyslot(struct ufs_hba *hba, int slot)
70297a8ac7a7a4 Satya Tangirala 2020-07-06   99  {
70297a8ac7a7a4 Satya Tangirala 2020-07-06  100  	/*
70297a8ac7a7a4 Satya Tangirala 2020-07-06  101  	 * Clear the crypto cfg on the device. Clearing CFGE
70297a8ac7a7a4 Satya Tangirala 2020-07-06  102  	 * might not be sufficient, so just clear the entire cfg.
70297a8ac7a7a4 Satya Tangirala 2020-07-06  103  	 */
6500251e590657 Pujin Shi       2020-10-02  104  	union ufs_crypto_cfg_entry cfg = {};
70297a8ac7a7a4 Satya Tangirala 2020-07-06  105  
1bc726e26ef317 Eric Biggers    2020-07-10  106  	return ufshcd_program_key(hba, &cfg, slot);
70297a8ac7a7a4 Satya Tangirala 2020-07-06  107  }
70297a8ac7a7a4 Satya Tangirala 2020-07-06  108  
cb77cb5abe1f4f Eric Biggers    2021-10-18  109  static int ufshcd_crypto_keyslot_evict(struct blk_crypto_profile *profile,
70297a8ac7a7a4 Satya Tangirala 2020-07-06  110  				       const struct blk_crypto_key *key,
70297a8ac7a7a4 Satya Tangirala 2020-07-06  111  				       unsigned int slot)
70297a8ac7a7a4 Satya Tangirala 2020-07-06  112  {
cb77cb5abe1f4f Eric Biggers    2021-10-18  113  	struct ufs_hba *hba =
cb77cb5abe1f4f Eric Biggers    2021-10-18  114  		container_of(profile, struct ufs_hba, crypto_profile);
70297a8ac7a7a4 Satya Tangirala 2020-07-06  115  
1bc726e26ef317 Eric Biggers    2020-07-10  116  	return ufshcd_clear_keyslot(hba, slot);
70297a8ac7a7a4 Satya Tangirala 2020-07-06  117  }
70297a8ac7a7a4 Satya Tangirala 2020-07-06  118  
70297a8ac7a7a4 Satya Tangirala 2020-07-06  119  bool ufshcd_crypto_enable(struct ufs_hba *hba)
70297a8ac7a7a4 Satya Tangirala 2020-07-06  120  {
70297a8ac7a7a4 Satya Tangirala 2020-07-06  121  	if (!(hba->caps & UFSHCD_CAP_CRYPTO))
70297a8ac7a7a4 Satya Tangirala 2020-07-06  122  		return false;
70297a8ac7a7a4 Satya Tangirala 2020-07-06  123  
70297a8ac7a7a4 Satya Tangirala 2020-07-06  124  	/* Reset might clear all keys, so reprogram all the keys. */
cb77cb5abe1f4f Eric Biggers    2021-10-18 @125  	blk_crypto_reprogram_all_keys(&hba->crypto_profile);
70297a8ac7a7a4 Satya Tangirala 2020-07-06  126  	return true;
70297a8ac7a7a4 Satya Tangirala 2020-07-06  127  }
70297a8ac7a7a4 Satya Tangirala 2020-07-06  128  

:::::: The code at line 24 was first introduced by commit
:::::: 70297a8ac7a7a4a3284c2eb20fefefbe72dab338 scsi: ufs: UFS crypto API

:::::: TO: Satya Tangirala <satyat@google.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
