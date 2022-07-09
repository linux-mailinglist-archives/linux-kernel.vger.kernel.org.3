Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4930956C95C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGIMUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 08:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 08:20:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC9E205D9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657369244; x=1688905244;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6TccN//6JSbICF5i25NIMGonOEIsuoLLf0GoDWUYcjE=;
  b=njxhfAFEv6xDlvF4/uD6BMapfEgKFoGI6p72cias9Zxe5VQYbgv2lZe4
   GjZaM4ZAiU3gkwj+8gQMMjqm//5cvVoiPNOGOLOljda3DuYWScWdtIUKM
   H0JROugoL2f7dcSgc/eeN4FXjBnu5qgttKoOhWA7HiAUMMS9K2AR0Kfm1
   DKksz1cjjNq5+t5Wg1Hiw9L5HBmjxde+chS1PlXMKlu++glossyxxT6nq
   x5jGz50Fud/2J3BHMsX8Y+aLp9XpKU7hI+r7XGafBRCHW0couRp6bNT81
   QADSfcVvBFjI3EqlmhM+GAd2P95ipg6BQvRP5n7oTNy/ID5D73YMPtDu7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="348415925"
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="348415925"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 05:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="921282352"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2022 05:20:41 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA9Rx-000Ojg-4b;
        Sat, 09 Jul 2022 12:20:41 +0000
Date:   Sat, 9 Jul 2022 20:20:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: drivers/iio/adc/ad7476.c:39:8: warning: Excessive padding in 'struct
 ad7476_state' (72 padding bytes, where 8 is optimal). Optimal fields order:
 data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering
 the fields or adding explicit paddi...
Message-ID: <202207092005.Rutj9g0E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5524c2a1fc4002a52e16236659e779767617a4f
commit: 396f7234856956eb29f009da6e5d846f29f87ebd iio: core: move @chrdev from struct iio_dev to struct iio_dev_opaque
date:   1 year, 2 months ago
config: arm-randconfig-c002-20220702 (https://download.01.org/0day-ci/archive/20220709/202207092005.Rutj9g0E-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=396f7234856956eb29f009da6e5d846f29f87ebd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 396f7234856956eb29f009da6e5d846f29f87ebd
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
                          ^~~~~~~~~~~~~~~~
   net/core/filter.c:2813:3: note: Loop condition is false. Execution continues on line 2827
                   while (i != msg->sg.end) {
                   ^
   net/core/filter.c:2829:2: note: Calling '__clear_bit'
           __clear_bit(new, &msg->sg.copy);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bitops/non-atomic.h:26:23: note: The result of the left shift is undefined because the right operand is negative
           unsigned long mask = BIT_MASK(nr);
                                ^
   include/linux/bits.h:10:30: note: expanded from macro 'BIT_MASK'
   #define BIT_MASK(nr)            (UL(1) << ((nr) % BITS_PER_LONG))
                                          ^  ~~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:1736:2: warning: Null pointer passed as 1st argument to memory set function [clang-analyzer-unix.cstring.NullArg]
           memset(to, 0, len);
           ^      ~~
   net/core/filter.c:1725:15: note: Assuming 'offset' is <= 65535
           if (unlikely(offset > 0xffff))
                        ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   net/core/filter.c:1725:2: note: Taking false branch
           if (unlikely(offset > 0xffff))
           ^
   net/core/filter.c:1729:15: note: Assuming 'ptr' is null
           if (unlikely(!ptr))
                        ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   net/core/filter.c:1729:2: note: Taking true branch
           if (unlikely(!ptr))
           ^
   net/core/filter.c:1730:3: note: Control jumps to line 1736
                   goto err_clear;
                   ^
   net/core/filter.c:1736:2: note: Null pointer passed as 1st argument to memory set function
           memset(to, 0, len);
           ^      ~~
   net/core/filter.c:1770:2: warning: Null pointer passed as 1st argument to memory set function [clang-analyzer-unix.cstring.NullArg]
           memset(to, 0, len);
           ^      ~~
   net/core/filter.c:1756:15: note: Assuming 'offset' is <= 65535
           if (unlikely(offset > 0xffff))
                        ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   net/core/filter.c:1756:2: note: Taking false branch
           if (unlikely(offset > 0xffff))
           ^
   net/core/filter.c:1759:15: note: Assuming field 'skb' is non-null
           if (unlikely(!ctx->skb))
                        ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   net/core/filter.c:1759:2: note: Taking false branch
           if (unlikely(!ctx->skb))
           ^
   net/core/filter.c:1763:15: note: Assuming 'ptr' is null
           if (unlikely(!ptr))
                        ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   net/core/filter.c:1763:2: note: Taking true branch
           if (unlikely(!ptr))
           ^
   net/core/filter.c:1764:3: note: Control jumps to line 1770
                   goto err_clear;
                   ^
   net/core/filter.c:1770:2: note: Null pointer passed as 1st argument to memory set function
           memset(to, 0, len);
           ^      ~~
   net/core/filter.c:5136:15: warning: Value stored to 'sk' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct sock *sk = bpf_sock->sk;
                        ^~   ~~~~~~~~~~~~
   net/core/filter.c:5136:15: note: Value stored to 'sk' during its initialization is never read
           struct sock *sk = bpf_sock->sk;
                        ^~   ~~~~~~~~~~~~
   net/core/filter.c:5137:6: warning: Value stored to 'val' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
               ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/filter.c:5137:6: note: Value stored to 'val' during its initialization is never read
           int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
               ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 17 warnings (17 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   drivers/iio/adc/ad7298.c:40:8: warning: Excessive padding in 'struct ad7298_state' (72 padding bytes, where 8 is optimal). Optimal fields order: rx_buf, spi, reg, ext_ref, ring_msg, scan_single_msg, scan_single_xfer, ring_xfer, tx_buf, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7298_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/adc/ad7298.c:40:8: note: Excessive padding in 'struct ad7298_state' (72 padding bytes, where 8 is optimal). Optimal fields order: rx_buf, spi, reg, ext_ref, ring_msg, scan_single_msg, scan_single_xfer, ring_xfer, tx_buf, consider reordering the fields or adding explicit padding members
   struct ad7298_state {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
>> drivers/iio/adc/ad7476.c:39:8: warning: Excessive padding in 'struct ad7476_state' (72 padding bytes, where 8 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7476_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/adc/ad7476.c:39:8: note: Excessive padding in 'struct ad7476_state' (72 padding bytes, where 8 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members
   struct ad7476_state {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   18 warnings generated.
   Suppressed 18 warnings (18 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   net/netlink/genetlink.c:1471:24: warning: Access to field 'genl_sock' results in a dereference of a null pointer (loaded from variable 'prev') [clang-analyzer-core.NullDereference]
           err = nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
                                 ^
   net/netlink/genetlink.c:1429:8: note: Calling 'genl_register_family'
           err = genl_register_family(&genl_ctrl);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netlink/genetlink.c:398:6: note: 'err' is 0
           if (err)
               ^~~
   net/netlink/genetlink.c:398:2: note: Taking false branch
           if (err)
           ^
   net/netlink/genetlink.c:403:6: note: Assuming the condition is false
           if (genl_family_find_byname(family->name)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netlink/genetlink.c:403:2: note: Taking false branch
           if (genl_family_find_byname(family->name)) {
           ^
   net/netlink/genetlink.c:415:2: note: Taking true branch
           if (family == &genl_ctrl) {
           ^
   net/netlink/genetlink.c:426:6: note: Assuming field 'id' is >= 0
           if (family->id < 0) {
               ^~~~~~~~~~~~~~
   net/netlink/genetlink.c:426:2: note: Taking false branch
           if (family->id < 0) {
           ^
   net/netlink/genetlink.c:432:6: note: Assuming 'err' is 0
           if (err)
               ^~~
   net/netlink/genetlink.c:432:2: note: Taking false branch
           if (err)
           ^
   net/netlink/genetlink.c:438:2: note: Calling 'genl_ctrl_event'
           genl_ctrl_event(CTRL_CMD_NEWFAMILY, family, NULL, 0);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netlink/genetlink.c:1079:6: note: Assuming field 'genl_sock' is non-null
           if (!init_net.genl_sock)
               ^~~~~~~~~~~~~~~~~~~
   net/netlink/genetlink.c:1079:2: note: Taking false branch
           if (!init_net.genl_sock)
           ^
   net/netlink/genetlink.c:1082:2: note: Control jumps to 'case CTRL_CMD_NEWFAMILY:'  at line 1083
           switch (event) {
           ^
   net/netlink/genetlink.c:1085:3: note: Taking false branch
                   WARN_ON(grp);
                   ^
   include/asm-generic/bug.h:120:2: note: expanded from macro 'WARN_ON'
           if (unlikely(__ret_warn_on))                                    \
           ^
   net/netlink/genetlink.c:1087:3: note:  Execution continues on line 1097
                   break;
                   ^
   net/netlink/genetlink.c:1097:2: note: Taking false branch
           if (IS_ERR(msg))
           ^
   net/netlink/genetlink.c:1100:6: note: Assuming field 'netnsok' is not equal to 0
           if (!family->netnsok) {
               ^~~~~~~~~~~~~~~~
   net/netlink/genetlink.c:1100:2: note: Taking false branch
           if (!family->netnsok) {
           ^
   net/netlink/genetlink.c:1105:3: note: Calling 'genlmsg_multicast_allns'
                   genlmsg_multicast_allns(&genl_ctrl, msg, 0,
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netlink/genetlink.c:1486:19: note: Assuming 'group' is < field 'n_mcgrps'
           if (WARN_ON_ONCE(group >= family->n_mcgrps))
                            ^
   include/asm-generic/bug.h:145:27: note: expanded from macro 'WARN_ON_ONCE'
           int __ret_warn_once = !!(condition);                    \
                                    ^~~~~~~~~
   net/netlink/genetlink.c:1486:6: note: '__ret_warn_once' is 0
           if (WARN_ON_ONCE(group >= family->n_mcgrps))
               ^
   include/asm-generic/bug.h:147:15: note: expanded from macro 'WARN_ON_ONCE'
           if (unlikely(__ret_warn_once && !__warned)) {           \
                        ^~~~~~~~~~~~~~~
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   net/netlink/genetlink.c:1486:6: note: Left side of '&&' is false
           if (WARN_ON_ONCE(group >= family->n_mcgrps))
--
               ^~~~~~~~
   net/core/dev.c:6121:2: note: Taking true branch
           if (grow > 0)
           ^
   net/core/dev.c:6122:3: note: Calling 'gro_pull_from_frag0'
                   gro_pull_from_frag0(skb, grow);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:5992:9: note: Assuming the condition is false
           BUG_ON(skb->end - skb->tail < grow);
                  ^
   include/asm-generic/bug.h:63:45: note: expanded from macro 'BUG_ON'
   #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                               ^~~~~~~~~
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   net/core/dev.c:5992:2: note: Taking false branch
           BUG_ON(skb->end - skb->tail < grow);
           ^
   include/asm-generic/bug.h:63:32: note: expanded from macro 'BUG_ON'
   #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                  ^
   net/core/dev.c:5992:2: note: Loop condition is false.  Exiting loop
           BUG_ON(skb->end - skb->tail < grow);
           ^
   include/asm-generic/bug.h:63:27: note: expanded from macro 'BUG_ON'
   #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                             ^
   net/core/dev.c:5994:2: note: Null pointer passed as 2nd argument to memory copy function
           memcpy(skb_tail_pointer(skb), NAPI_GRO_CB(skb)->frag0, grow);
           ^
   net/core/dev.c:7751:19: warning: Access to field 'lower_level' results in a dereference of a null pointer (loaded from variable 'dev') [clang-analyzer-core.NullDereference]
           dev->lower_level = __netdev_lower_depth(dev) + 1;
                            ^
   net/core/dev.c:8210:33: note: Passing value via 2nd parameter 'upper_dev'
           __netdev_upper_dev_unlink(dev, upper_dev, &priv);
                                          ^~~~~~~~~
   net/core/dev.c:8210:2: note: Calling '__netdev_upper_dev_unlink'
           __netdev_upper_dev_unlink(dev, upper_dev, &priv);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:8174:2: note: Assuming the condition is false
           ASSERT_RTNL();
           ^
   include/linux/rtnetlink.h:110:12: note: expanded from macro 'ASSERT_RTNL'
           WARN_ONCE(!rtnl_is_locked(), \
                     ^~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:157:27: note: expanded from macro 'WARN_ONCE'
           int __ret_warn_once = !!(condition);                    \
                                    ^~~~~~~~~
   net/core/dev.c:8174:2: note: '__ret_warn_once' is 0
           ASSERT_RTNL();
           ^
   include/linux/rtnetlink.h:110:2: note: expanded from macro 'ASSERT_RTNL'
           WARN_ONCE(!rtnl_is_locked(), \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:159:15: note: expanded from macro 'WARN_ONCE'
           if (unlikely(__ret_warn_once && !__warned)) {           \
                        ^~~~~~~~~~~~~~~
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   net/core/dev.c:8174:2: note: Left side of '&&' is false
           ASSERT_RTNL();
           ^
   include/linux/rtnetlink.h:110:2: note: expanded from macro 'ASSERT_RTNL'
           WARN_ONCE(!rtnl_is_locked(), \
           ^
   include/asm-generic/bug.h:159:31: note: expanded from macro 'WARN_ONCE'
           if (unlikely(__ret_warn_once && !__warned)) {           \
                                        ^
   net/core/dev.c:8174:2: note: Taking false branch
           ASSERT_RTNL();
           ^
   include/linux/rtnetlink.h:110:2: note: expanded from macro 'ASSERT_RTNL'
           WARN_ONCE(!rtnl_is_locked(), \
           ^
   include/asm-generic/bug.h:159:2: note: expanded from macro 'WARN_ONCE'
           if (unlikely(__ret_warn_once && !__warned)) {           \
           ^
   net/core/dev.c:8176:28: note: Assuming pointer value is null
           changeupper_info.master = netdev_master_upper_dev_get(dev) == upper_dev;
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:8189:30: note: Passing null pointer value via 1st parameter 'dev'
           __netdev_update_lower_level(upper_dev, priv);
                                       ^~~~~~~~~
   net/core/dev.c:8189:2: note: Calling '__netdev_update_lower_level'
           __netdev_update_lower_level(upper_dev, priv);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:7751:19: note: Access to field 'lower_level' results in a dereference of a null pointer (loaded from variable 'dev')
           dev->lower_level = __netdev_lower_depth(dev) + 1;
           ~~~              ^
   net/core/dev.c:10820:2: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcpy(dev->name, name);
           ^~~~~~
   net/core/dev.c:10820:2: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
           strcpy(dev->name, name);
           ^~~~~~
   Suppressed 18 warnings (16 in non-user code, 2 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
>> drivers/iio/adc/ad7476.c:39:8: warning: Excessive padding in 'struct ad7476_state' (72 padding bytes, where 8 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct ad7476_state {
   ~~~~~~~^~~~~~~~~~~~~~
   drivers/iio/adc/ad7476.c:39:8: note: Excessive padding in 'struct ad7476_state' (72 padding bytes, where 8 is optimal). Optimal fields order: data, spi, chip_info, ref_reg, convst_gpio, msg, xfer, consider reordering the fields or adding explicit padding members
   struct ad7476_state {
   ~~~~~~~^~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   18 warnings generated.
   net/decnet/af_decnet.c:1765:4: warning: Value stored to 'rv' is never read [clang-analyzer-deadcode.DeadStores]
                           rv = -EFAULT;
                           ^    ~~~~~~~
   net/decnet/af_decnet.c:1765:4: note: Value stored to 'rv' is never read
                           rv = -EFAULT;
                           ^    ~~~~~~~
   net/decnet/af_decnet.c:1962:2: warning: Value stored to 'mss' is never read [clang-analyzer-deadcode.DeadStores]
           mss = scp->segsize_rem;
           ^     ~~~~~~~~~~~~~~~~
   net/decnet/af_decnet.c:1962:2: note: Value stored to 'mss' is never read
           mss = scp->segsize_rem;
           ^     ~~~~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   net/decnet/dn_nsp_in.c:763:3: warning: Value stored to 'ptr' is never read [clang-analyzer-deadcode.DeadStores]
                   ptr += 2;
                   ^      ~
   net/decnet/dn_nsp_in.c:763:3: note: Value stored to 'ptr' is never read
                   ptr += 2;
                   ^      ~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   19 warnings generated.
   net/decnet/dn_route.c:827:20: warning: Value stored to 'cb' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct dn_skb_cb *cb = DN_SKB_CB(skb);
                             ^~
   net/decnet/dn_route.c:827:20: note: Value stored to 'cb' during its initialization is never read
           struct dn_skb_cb *cb = DN_SKB_CB(skb);
                             ^~
   net/decnet/dn_route.c:839:20: warning: Value stored to 'cb' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct dn_skb_cb *cb = DN_SKB_CB(skb);
                             ^~
   net/decnet/dn_route.c:839:20: note: Value stored to 'cb' during its initialization is never read
           struct dn_skb_cb *cb = DN_SKB_CB(skb);
                             ^~
   net/decnet/dn_route.c:890:39: warning: Access to field 'mtu' results in a dereference of a null pointer (loaded from field 'dev') [clang-analyzer-core.NullDereference]
           if (dst_metric(&rt->dst, RTAX_MTU) > rt->dst.dev->mtu)
                                                ^
   net/decnet/dn_route.c:1652:2: note: Taking false branch
           if (!net_eq(net, &init_net))
           ^
   net/decnet/dn_route.c:1657:6: note: Assuming 'err' is >= 0
           if (err < 0)
               ^~~~~~~
   net/decnet/dn_route.c:1657:2: note: Taking false branch
           if (err < 0)
           ^
   net/decnet/dn_route.c:1664:6: note: Assuming 'skb' is not equal to NULL
           if (skb == NULL)
               ^~~~~~~~~~~
   net/decnet/dn_route.c:1664:2: note: Taking false branch
           if (skb == NULL)
           ^
   net/decnet/dn_route.c:1669:6: note: Assuming the condition is true
           if (tb[RTA_SRC])
               ^~~~~~~~~~~
   net/decnet/dn_route.c:1669:2: note: Taking true branch
           if (tb[RTA_SRC])
           ^
   net/decnet/dn_route.c:1672:6: note: Assuming the condition is false
           if (tb[RTA_DST])
               ^~~~~~~~~~~
   net/decnet/dn_route.c:1672:2: note: Taking false branch
           if (tb[RTA_DST])
           ^
   net/decnet/dn_route.c:1675:6: note: Assuming the condition is true
           if (tb[RTA_IIF])

vim +39 drivers/iio/adc/ad7476.c

7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  38  
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10 @39  struct ad7476_state {
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  40  	struct spi_device		*spi;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  41  	const struct ad7476_chip_info	*chip_info;
7bf50a968a1cd0 drivers/iio/adc/ad7476.c         Jonathan Cameron   2021-04-25  42  	struct regulator		*ref_reg;
af37e4703d00ce drivers/iio/adc/ad7476.c         Dragos Bogdan      2020-03-11  43  	struct gpio_desc		*convst_gpio;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  44  	struct spi_transfer		xfer;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  45  	struct spi_message		msg;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  46  	/*
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  47  	 * DMA (thus cache coherency maintenance) requires the
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  48  	 * transfer buffers to live in their own cache lines.
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  49  	 * Make the buffer large enough for one 16 bit sample and one 64 bit
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  50  	 * aligned 64 bit timestamp.
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  51  	 */
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  52  	unsigned char data[ALIGN(2, sizeof(s64)) + sizeof(s64)]
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  53  			____cacheline_aligned;
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  54  };
7a28fe3c93d6cd drivers/staging/iio/adc/ad7476.c Lars-Peter Clausen 2012-09-10  55  

:::::: The code at line 39 was first introduced by commit
:::::: 7a28fe3c93d6cd920c84678a1bf45af8b4248577 staging:iio:ad7476: Squash driver into a single file.

:::::: TO: Lars-Peter Clausen <lars@metafoo.de>
:::::: CC: Jonathan Cameron <jic23@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
