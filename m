Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68DB49FCED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349613AbiA1Pfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:35:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:9194 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbiA1Pfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643384137; x=1674920137;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bnTglTlA+P76GoyxIGtpOs7sZ8czQvccrOs6J2bQFNs=;
  b=c9LmqPTE9K2ms0A5CBw5rOtACf/ry8WjgcxrmNf8u19LfR3Qa2OqRPxx
   1Z9YfqbKS1kPMk8bg319nyLxbosqENcbJEsgPinPe6FjpkV7T/Hf5UQ88
   NcYoqiGdxl8x8YhLHvNdDCGfY9ZFAwZlbhTuVpFyMznw7UsFf6bjtFKlv
   8fy6Pf2edbUpzvyqAPhbTkvzfa2fczBRC7UrkizoH3A7I0zT0MDdMgK8s
   Hwy/8gvs6SGaSqGLuJa1fj2+NX96hNE+sh2fsngYxD9U6cRL5xwusKWcC
   59+t7O0KQjM/cUqqlJprYEs66eci1XGUseiKCF8LM0W4MgAzlzdE6nSDl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227810779"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="227810779"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 07:35:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="598237628"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2022 07:35:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDTHj-000O2G-9i; Fri, 28 Jan 2022 15:35:35 +0000
Date:   Fri, 28 Jan 2022 23:35:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/dvm/rx.c:918:22: error: member
 reference type 'struct iwl_wipan_noa_data' is not a pointer; did you mean to
 use '.'?
Message-ID: <202201282320.hBOR8EK6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220128-173237/cgel-zte-gmail-com/dvm-use-struct_size-over-open-coded-arithmetic/20220128-160349
head:   77680691120f395e319c3d051219912dd305048a
commit: 77680691120f395e319c3d051219912dd305048a iwlwifi: dvm: use struct_size over open coded arithmetic
date:   6 hours ago
config: riscv-buildonly-randconfig-r005-20220124 (https://download.01.org/0day-ci/archive/20220128/202201282320.hBOR8EK6-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/77680691120f395e319c3d051219912dd305048a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220128-173237/cgel-zte-gmail-com/dvm-use-struct_size-over-open-coded-arithmetic/20220128-160349
        git checkout 77680691120f395e319c3d051219912dd305048a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/wireless/intel/iwlwifi/dvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/wireless/intel/iwlwifi/dvm/rx.c:918:22: error: member reference type 'struct iwl_wipan_noa_data' is not a pointer; did you mean to use '.'?
                   new_data = kmalloc(struct_size(*new_data, data, len), GFP_ATOMIC);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:194:18: note: expanded from macro 'struct_size'
                       sizeof(*(p)->member) + __must_be_array((p)->member),\
                               ~~~^
>> drivers/net/wireless/intel/iwlwifi/dvm/rx.c:918:22: error: indirection requires pointer operand ('u8[]' (aka 'unsigned char[]') invalid)
                   new_data = kmalloc(struct_size(*new_data, data, len), GFP_ATOMIC);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:194:14: note: expanded from macro 'struct_size'
                       sizeof(*(p)->member) + __must_be_array((p)->member),\
                              ^~~~~~~~~~~~
>> drivers/net/wireless/intel/iwlwifi/dvm/rx.c:918:22: error: member reference type 'struct iwl_wipan_noa_data' is not a pointer; did you mean to use '.'?
                   new_data = kmalloc(struct_size(*new_data, data, len), GFP_ATOMIC);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:194:49: note: expanded from macro 'struct_size'
                       sizeof(*(p)->member) + __must_be_array((p)->member),\
                                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~
   include/linux/compiler.h:258:59: note: expanded from macro '__must_be_array'
   #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/compiler_types.h:287:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:16:62: note: expanded from macro 'BUILD_BUG_ON_ZERO'
   #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                                ^
>> drivers/net/wireless/intel/iwlwifi/dvm/rx.c:918:22: error: member reference type 'struct iwl_wipan_noa_data' is not a pointer; did you mean to use '.'?
                   new_data = kmalloc(struct_size(*new_data, data, len), GFP_ATOMIC);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:194:49: note: expanded from macro 'struct_size'
                       sizeof(*(p)->member) + __must_be_array((p)->member),\
                                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~
   include/linux/compiler.h:258:65: note: expanded from macro '__must_be_array'
   #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   include/linux/compiler_types.h:287:74: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                            ^
   include/linux/build_bug.h:16:62: note: expanded from macro 'BUILD_BUG_ON_ZERO'
   #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                                ^
>> drivers/net/wireless/intel/iwlwifi/dvm/rx.c:918:22: error: indirection requires pointer operand ('struct iwl_wipan_noa_data' invalid)
                   new_data = kmalloc(struct_size(*new_data, data, len), GFP_ATOMIC);
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:195:14: note: expanded from macro 'struct_size'
                       sizeof(*(p)))
                              ^~~~
   5 errors generated.


vim +918 drivers/net/wireless/intel/iwlwifi/dvm/rx.c

   897	
   898	static void iwlagn_rx_noa_notification(struct iwl_priv *priv,
   899					       struct iwl_rx_cmd_buffer *rxb)
   900	{
   901		struct iwl_wipan_noa_data *new_data, *old_data;
   902		struct iwl_rx_packet *pkt = rxb_addr(rxb);
   903		struct iwl_wipan_noa_notification *noa_notif = (void *)pkt->data;
   904	
   905		/* no condition -- we're in softirq */
   906		old_data = rcu_dereference_protected(priv->noa_data, true);
   907	
   908		if (noa_notif->noa_active) {
   909			u32 len = le16_to_cpu(noa_notif->noa_attribute.length);
   910			u32 copylen = len;
   911	
   912			/* EID, len, OUI, subtype */
   913			len += 1 + 1 + 3 + 1;
   914			/* P2P id, P2P length */
   915			len += 1 + 2;
   916			copylen += 1 + 2;
   917	
 > 918			new_data = kmalloc(struct_size(*new_data, data, len), GFP_ATOMIC);
   919			if (new_data) {
   920				new_data->length = len;
   921				new_data->data[0] = WLAN_EID_VENDOR_SPECIFIC;
   922				new_data->data[1] = len - 2; /* not counting EID, len */
   923				new_data->data[2] = (WLAN_OUI_WFA >> 16) & 0xff;
   924				new_data->data[3] = (WLAN_OUI_WFA >> 8) & 0xff;
   925				new_data->data[4] = (WLAN_OUI_WFA >> 0) & 0xff;
   926				new_data->data[5] = WLAN_OUI_TYPE_WFA_P2P;
   927				memcpy(&new_data->data[6], &noa_notif->noa_attribute,
   928				       copylen);
   929			}
   930		} else
   931			new_data = NULL;
   932	
   933		rcu_assign_pointer(priv->noa_data, new_data);
   934	
   935		if (old_data)
   936			kfree_rcu(old_data, rcu_head);
   937	}
   938	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
