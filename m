Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C928256435A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 02:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiGCAB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 20:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGCABZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 20:01:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C31EB4AD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 17:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656806483; x=1688342483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hpjHhvhq73GuDmTdo45BViQT/U+1yBagJoORAR5IZg8=;
  b=nJGVagoFySx3AzmsKYonkiKgTZkrvbmQ1zRi0em053PjyeUNBR70XMlL
   YkQJuSIGV4UsJQo2vW/clqoMnccu383ig6ZNU1qHiIA34U2Hbvq42rKM4
   cllRht6NbLrlPfRZFyFyIMX5qoo10LbCWO4vqh1y0MxIKLaeJbyW+ugqY
   go26QVEjHfZkyXos2Eq7BX8Dv61MRJFOTNcQ/dngrAmNukAP6vKhlwaTW
   Y/W2Ji6j7GH/WGJE8YOPRchwlJp1bUIvOTqhicCNYOWNqE46H1/jYPDdg
   O6ty3lbKEFyDaROfxDVWLTPn8Sn0rSNVjp5oZylCajXBn638WKYtTTW1x
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="283990931"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="283990931"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 17:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="719007139"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Jul 2022 17:01:21 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7n3A-000Frd-JC;
        Sun, 03 Jul 2022 00:01:20 +0000
Date:   Sun, 3 Jul 2022 08:01:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/gpio/gpio-virtio.c:23:8: warning: Excessive padding in
 'struct virtio_gpio_line' (58 padding bytes, where 26 is optimal). Optimal
 fields order: res, rxlen, lock, completion, req, consider reordering the
 fields or adding explicit padding members [c...
Message-ID: <202207030712.4FJHaNfk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69cb6c6556ad89620547318439d6be8bb1629a5a
commit: 3a29355a22c0275fe864100794fee58a73175d93 gpio: Add virtio-gpio driver
date:   10 months ago
config: arm-randconfig-c002-20220629 (https://download.01.org/0day-ci/archive/20220703/202207030712.4FJHaNfk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a9119143a2d1f4d0d0bc1fe0d819e5351b4e0deb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3a29355a22c0275fe864100794fee58a73175d93
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3a29355a22c0275fe864100794fee58a73175d93
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
                   ^
   include/linux/minmax.h:28:26: note: expanded from macro '__cmp'
   #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                            ^
   crypto/skcipher.c:354:10: note: Assuming '__UNIQUE_ID___x333' is >= '__UNIQUE_ID___y334'
           bsize = min(walk->stride, max(n, walk->blocksize));
                   ^
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:38:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:33:3: note: expanded from macro '__cmp_once'
                   __cmp(unique_x, unique_y, op); })
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:28:26: note: expanded from macro '__cmp'
   #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                            ^~~~~~~~~~
   crypto/skcipher.c:354:10: note: '?' condition is false
           bsize = min(walk->stride, max(n, walk->blocksize));
                   ^
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^
   include/linux/minmax.h:38:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                   ^
   include/linux/minmax.h:33:3: note: expanded from macro '__cmp_once'
                   __cmp(unique_x, unique_y, op); })
                   ^
   include/linux/minmax.h:28:26: note: expanded from macro '__cmp'
   #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                            ^
   crypto/skcipher.c:358:15: note: Assuming 'n' is < 'bsize'
           if (unlikely(n < bsize)) {
                        ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   crypto/skcipher.c:358:2: note: Taking true branch
           if (unlikely(n < bsize)) {
           ^
   crypto/skcipher.c:359:22: note: Field 'total' is < field 'blocksize'
                   if (unlikely(walk->total < walk->blocksize))
                                      ^
   crypto/skcipher.c:359:3: note: Taking true branch
                   if (unlikely(walk->total < walk->blocksize))
                   ^
   crypto/skcipher.c:360:11: note: Calling 'skcipher_walk_done'
                           return skcipher_walk_done(walk, -EINVAL);
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   crypto/skcipher.c:110:6: note: Assuming 'n' is not equal to 0
           if (!n)
               ^~
   crypto/skcipher.c:110:2: note: Taking false branch
           if (!n)
           ^
   crypto/skcipher.c:113:2: note: Taking false branch
           if (likely(err >= 0)) {
           ^
   crypto/skcipher.c:118:13: note: Assuming the condition is false
           if (likely(!(walk->flags & (SKCIPHER_WALK_PHYS |
                      ^
   include/linux/compiler.h:77:40: note: expanded from macro 'likely'
   # define likely(x)      __builtin_expect(!!(x), 1)
                                               ^
   crypto/skcipher.c:118:2: note: Taking false branch
           if (likely(!(walk->flags & (SKCIPHER_WALK_PHYS |
           ^
   crypto/skcipher.c:124:13: note: Assuming the condition is false
           } else if (walk->flags & SKCIPHER_WALK_DIFF) {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   crypto/skcipher.c:124:9: note: Taking false branch
           } else if (walk->flags & SKCIPHER_WALK_DIFF) {
                  ^
   crypto/skcipher.c:127:13: note: Assuming the condition is true
           } else if (walk->flags & SKCIPHER_WALK_COPY) {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   crypto/skcipher.c:127:9: note: Taking true branch
           } else if (walk->flags & SKCIPHER_WALK_COPY) {
                  ^
   crypto/skcipher.c:128:3: note: Calling 'skcipher_map_dst'
                   skcipher_map_dst(walk);
                   ^~~~~~~~~~~~~~~~~~~~~~
   crypto/skcipher.c:67:1: note: Returning without writing to 'walk->page'
   }
   ^
   crypto/skcipher.c:128:3: note: Returning from 'skcipher_map_dst'
                   skcipher_map_dst(walk);
                   ^~~~~~~~~~~~~~~~~~~~~~
   crypto/skcipher.c:129:3: note: Null pointer passed as 2nd argument to memory copy function
                   memcpy(walk->dst.virt.addr, walk->page, n);
                   ^                           ~~~~~~~~~~
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
>> drivers/gpio/gpio-virtio.c:23:8: warning: Excessive padding in 'struct virtio_gpio_line' (58 padding bytes, where 26 is optimal). Optimal fields order: res, rxlen, lock, completion, req, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct virtio_gpio_line {
   ~~~~~~~^~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-virtio.c:23:8: note: Excessive padding in 'struct virtio_gpio_line' (58 padding bytes, where 26 is optimal). Optimal fields order: res, rxlen, lock, completion, req, consider reordering the fields or adding explicit padding members
   struct virtio_gpio_line {
   ~~~~~~~^~~~~~~~~~~~~~~~~~
   1 warning generated.
   drivers/pwm/core.c:818:13: warning: Access to field 'name' results in a dereference of a null pointer (loaded from variable 'np') [clang-analyzer-core.NullDereference]
                           con_id = np->name;
                                    ^
   drivers/pwm/core.c:1150:6: note: Assuming the condition is true
           if (is_of_node(fwnode))
               ^~~~~~~~~~~~~~~~~~
   drivers/pwm/core.c:1150:2: note: Taking true branch
           if (is_of_node(fwnode))
           ^
   drivers/pwm/core.c:1151:25: note: Assuming the condition is false
                   pwm = of_pwm_get(dev, to_of_node(fwnode), con_id);
                                         ^
   include/linux/of.h:164:3: note: expanded from macro 'to_of_node'
                   is_of_node(__to_of_node_fwnode) ?                       \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pwm/core.c:1151:25: note: '?' condition is false
                   pwm = of_pwm_get(dev, to_of_node(fwnode), con_id);
                                         ^
   include/linux/of.h:164:3: note: expanded from macro 'to_of_node'
                   is_of_node(__to_of_node_fwnode) ?                       \
                   ^
   drivers/pwm/core.c:1151:25: note: Passing null pointer value via 2nd parameter 'np'
                   pwm = of_pwm_get(dev, to_of_node(fwnode), con_id);
                                         ^
   include/linux/of.h:161:2: note: expanded from macro 'to_of_node'
           ({                                                              \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pwm/core.c:1151:9: note: Calling 'of_pwm_get'
                   pwm = of_pwm_get(dev, to_of_node(fwnode), con_id);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pwm/core.c:775:6: note: Assuming 'con_id' is null
           if (con_id) {
               ^~~~~~
   drivers/pwm/core.c:775:2: note: Taking false branch
           if (con_id) {
           ^
   drivers/pwm/core.c:783:6: note: Assuming 'err' is 0
           if (err) {
               ^~~
   drivers/pwm/core.c:783:2: note: Taking false branch
           if (err) {
           ^
   drivers/pwm/core.c:788:25: note: Assuming '__of_fwnode_handle_node' is null
           pc = fwnode_to_pwmchip(of_fwnode_handle(args.np));
                                  ^
   include/linux/of.h:174:3: note: expanded from macro 'of_fwnode_handle'
                   __of_fwnode_handle_node ?                               \
                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/pwm/core.c:788:25: note: '?' condition is false
           pc = fwnode_to_pwmchip(of_fwnode_handle(args.np));
                                  ^
   include/linux/of.h:174:3: note: expanded from macro 'of_fwnode_handle'
                   __of_fwnode_handle_node ?                               \
                   ^
   drivers/pwm/core.c:789:2: note: Taking false branch
           if (IS_ERR(pc)) {
           ^
   drivers/pwm/core.c:798:2: note: Taking false branch
           if (IS_ERR(pwm))
           ^
   drivers/pwm/core.c:802:2: note: Taking false branch
           if (IS_ERR(dl)) {
           ^
   drivers/pwm/core.c:814:7: note: 'con_id' is null
           if (!con_id) {
                ^~~~~~
   drivers/pwm/core.c:814:2: note: Taking true branch
           if (!con_id) {
           ^
   drivers/pwm/core.c:817:7: note: 'err' is < 0
                   if (err < 0)
                       ^~~
   drivers/pwm/core.c:817:3: note: Taking true branch
                   if (err < 0)
                   ^
   drivers/pwm/core.c:818:13: note: Access to field 'name' results in a dereference of a null pointer (loaded from variable 'np')
                           con_id = np->name;
                                    ^~
   1 warning generated.
   lib/crypto/chacha20poly1305-selftest.c:9027:7: warning: Value stored to 'total_len' is never read [clang-analyzer-deadcode.DeadStores]
           for (total_len = POLY1305_DIGEST_SIZE; IS_ENABLED(DEBUG_CHACHA20POLY1305_SLOW_CHUNK_TEST)
                ^
   lib/crypto/chacha20poly1305-selftest.c:9027:7: note: Value stored to 'total_len' is never read
   6 warnings generated.
   drivers/video/fbdev/udlfb.c:370:6: warning: Value stored to 'identical' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           int identical = width;
               ^~~~~~~~~   ~~~~~
   drivers/video/fbdev/udlfb.c:370:6: note: Value stored to 'identical' during its initialization is never read
           int identical = width;
               ^~~~~~~~~   ~~~~~
   drivers/video/fbdev/udlfb.c:564:3: warning: Value stored to 'back_start' is never read [clang-analyzer-deadcode.DeadStores]
                   back_start += offset;
                   ^             ~~~~~~
   drivers/video/fbdev/udlfb.c:564:3: note: Value stored to 'back_start' is never read

vim +23 drivers/gpio/gpio-virtio.c

    22	
  > 23	struct virtio_gpio_line {
    24		struct mutex lock; /* Protects line operation */
    25		struct completion completion;
    26		struct virtio_gpio_request req ____cacheline_aligned;
    27		struct virtio_gpio_response res ____cacheline_aligned;
    28		unsigned int rxlen;
    29	};
    30	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
