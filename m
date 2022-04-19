Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9EC5061C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbiDSBp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240811AbiDSBpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:45:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C31827B0E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650332593; x=1681868593;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=khBNnzuB+/3JZumgTZaDVpsLBrDQyn0KmbZTfUCR/8Q=;
  b=dPGbny38A8bEuDhER7yQrbzM+1Gi2TNMqZtFwBIkUk56DAPBaCHvBqPx
   P8Fc5LysKSVzB4qP+kq4oM5LeFSbDu1F/12lz5G4yKS4u6plgGV0xtrMA
   qEYGSlNL9yOCNSB/TmDe6vfwFcciqhe23uP8WqV3DfqsjsuqrlW7Su5tx
   P5mYN7U0J5+TCc6U/aYEmI/jLuxW8ojtg9spJCDnrqUK2Oh7v5MH5C4af
   yW4nsLcvjyrGRDq4SkUvfXAJrJ48Oa8QM4UCZDGloGiV+sAQT6GiyDye5
   cl55S1R+WVhQDhxvZD0/oJj3OxioYYetEqDu3JiJyOVSRO4Y5JyIeFLmK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="324091878"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="324091878"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 18:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="726866606"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Apr 2022 18:43:11 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngcta-0005Aq-9p;
        Tue, 19 Apr 2022 01:43:10 +0000
Date:   Tue, 19 Apr 2022 09:42:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2137/2356]
 drivers/net/ethernet/marvell/prestera/prestera_router.c:58:45: warning:
 declaration of 'struct fib_entry_notifier_info' will not be visible outside
 of this function
Message-ID: <202204190943.X9eY78sK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: a543fd04d10eb15cb62b4163c8495b88fee40856 [2137/2356] headers/deps: net: Optimize <net/ip_fib.h> dependencies, remove <net/ip_fib_api.h> inclusion
config: i386-randconfig-a016-20220418 (https://download.01.org/0day-ci/archive/20220419/202204190943.X9eY78sK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=a543fd04d10eb15cb62b4163c8495b88fee40856
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout a543fd04d10eb15cb62b4163c8495b88fee40856
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/bluetooth/ drivers/misc/ drivers/net/bonding/ drivers/net/ethernet/marvell/prestera/ drivers/net/ethernet/microchip/lan966x/ drivers/net/netdevsim/ drivers/net/phy/ drivers/power/supply/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/prestera/prestera_router.c:58:45: warning: declaration of 'struct fib_entry_notifier_info' will not be visible outside of this function [-Wvisibility]
   prestera_util_fen_info2fib_cache_key(struct fib_entry_notifier_info *fen_info,
                                               ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:62:41: error: incomplete definition of type 'struct fib_entry_notifier_info'
           key->addr.u.ipv4 = cpu_to_be32(fen_info->dst);
                                          ~~~~~~~~^
   include/linux/byteorder/generic.h:94:21: note: expanded from macro 'cpu_to_be32'
   #define cpu_to_be32 __cpu_to_be32
                       ^
   include/uapi/linux/byteorder/little_endian.h:40:53: note: expanded from macro '__cpu_to_be32'
   #define __cpu_to_be32(x) ((__force __be32)__swab32((x)))
                                                       ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:58:45: note: forward declaration of 'struct fib_entry_notifier_info'
   prestera_util_fen_info2fib_cache_key(struct fib_entry_notifier_info *fen_info,
                                               ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:63:28: error: incomplete definition of type 'struct fib_entry_notifier_info'
           key->prefix_len = fen_info->dst_len;
                             ~~~~~~~~^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:58:45: note: forward declaration of 'struct fib_entry_notifier_info'
   prestera_util_fen_info2fib_cache_key(struct fib_entry_notifier_info *fen_info,
                                               ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:64:28: error: incomplete definition of type 'struct fib_entry_notifier_info'
           key->kern_tb_id = fen_info->tb_id;
                             ~~~~~~~~^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:58:45: note: forward declaration of 'struct fib_entry_notifier_info'
   prestera_util_fen_info2fib_cache_key(struct fib_entry_notifier_info *fen_info,
                                               ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:83:2: error: implicit declaration of function 'fib_info_put' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           fib_info_put(fib_cache->fi);
           ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:83:2: note: did you mean 'fib_rule_put'?
   include/net/fib_rules.h:110:20: note: 'fib_rule_put' declared here
   static inline void fib_rule_put(struct fib_rule *rule)
                      ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:106:2: error: implicit declaration of function 'fib_info_hold' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           fib_info_hold(fi);
           ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:120:2: error: implicit declaration of function 'fib_info_put' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           fib_info_put(fi);
           ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:131:21: error: variable has incomplete type 'struct fib_rt_info'
           struct fib_rt_info fri;
                              ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:131:9: note: forward declaration of 'struct fib_rt_info'
           struct fib_rt_info fri;
                  ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:147:2: error: implicit declaration of function 'fib_alias_hw_flags_set' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           fib_alias_hw_flags_set(&init_net, &fri);
           ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:281:17: warning: declaration of 'struct fib_entry_notifier_info' will not be visible outside of this function [-Wvisibility]
                          struct fib_entry_notifier_info *fen_info)
                                 ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:288:39: error: incompatible pointer types passing 'struct fib_entry_notifier_info *' to parameter of type 'struct fib_entry_notifier_info *' [-Werror,-Wincompatible-pointer-types]
           prestera_util_fen_info2fib_cache_key(fen_info, &fc_key);
                                                ^~~~~~~~
   drivers/net/ethernet/marvell/prestera/prestera_router.c:58:70: note: passing argument to parameter 'fen_info' here
   prestera_util_fen_info2fib_cache_key(struct fib_entry_notifier_info *fen_info,
                                                                        ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:312:19: error: incomplete definition of type 'struct fib_entry_notifier_info'
                                                              fen_info->fi,
                                                              ~~~~~~~~^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:281:17: note: forward declaration of 'struct fib_entry_notifier_info'
                          struct fib_entry_notifier_info *fen_info)
                                 ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:313:19: error: incomplete definition of type 'struct fib_entry_notifier_info'
                                                              fen_info->tos,
                                                              ~~~~~~~~^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:281:17: note: forward declaration of 'struct fib_entry_notifier_info'
                          struct fib_entry_notifier_info *fen_info)
                                 ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:314:19: error: incomplete definition of type 'struct fib_entry_notifier_info'
                                                              fen_info->type);
                                                              ~~~~~~~~^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:281:17: note: forward declaration of 'struct fib_entry_notifier_info'
                          struct fib_entry_notifier_info *fen_info)
                                 ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:461:33: error: field has incomplete type 'struct fib_entry_notifier_info'
           struct fib_entry_notifier_info fen_info;
                                          ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:461:9: note: forward declaration of 'struct fib_entry_notifier_info'
           struct fib_entry_notifier_info fen_info;
                  ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:496:2: error: implicit declaration of function 'fib_info_put' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           fib_info_put(fib_work->fen_info.fi);
           ^
   drivers/net/ethernet/marvell/prestera/prestera_router.c:518:14: error: incomplete definition of type 'struct fib_entry_notifier_info'
                   fen_info = container_of(info, struct fib_entry_notifier_info,
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/container_of.h:19:47: note: expanded from macro 'container_of'
           static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:293:74: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                            ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'


vim +58 drivers/net/ethernet/marvell/prestera/prestera_router.c

15fa9e8c5ffbe0 Yevhen Orlov 2021-12-27  56  
4394fbcb78cfe1 Yevhen Orlov 2022-02-16  57  static void
4394fbcb78cfe1 Yevhen Orlov 2022-02-16 @58  prestera_util_fen_info2fib_cache_key(struct fib_entry_notifier_info *fen_info,
4394fbcb78cfe1 Yevhen Orlov 2022-02-16  59  				     struct prestera_kern_fib_cache_key *key)
4394fbcb78cfe1 Yevhen Orlov 2022-02-16  60  {
4394fbcb78cfe1 Yevhen Orlov 2022-02-16  61  	memset(key, 0, sizeof(*key));
4394fbcb78cfe1 Yevhen Orlov 2022-02-16  62  	key->addr.u.ipv4 = cpu_to_be32(fen_info->dst);
4394fbcb78cfe1 Yevhen Orlov 2022-02-16  63  	key->prefix_len = fen_info->dst_len;
4394fbcb78cfe1 Yevhen Orlov 2022-02-16  64  	key->kern_tb_id = fen_info->tb_id;
4394fbcb78cfe1 Yevhen Orlov 2022-02-16  65  }
4394fbcb78cfe1 Yevhen Orlov 2022-02-16  66  

:::::: The code at line 58 was first introduced by commit
:::::: 4394fbcb78cfe190988d2c1beaaaccc97dcf8c5f net: marvell: prestera: handle fib notifications

:::::: TO: Yevhen Orlov <yevhen.orlov@plvision.eu>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
