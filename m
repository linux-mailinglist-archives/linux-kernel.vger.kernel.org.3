Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA646598C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345582AbiHRTcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiHRTcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:32:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7A0CD516
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660851126; x=1692387126;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ek5IqYX+bKNFUtYq9X05isuDAUFHxFw32/iXVOIytRs=;
  b=gf+spBrP2R84+hEk0tO0pjJ4uKogJU3PqCW3CjoVzU9jAOP1ZyRsCZyZ
   QZfx3XCvIlRitI+3evH/rx4XYVOLnioN9fnW4CwWZYa9OR/SvZAL3FtP0
   NTPpsOKXkduo3pWp6d1HzK9iDXTdZiS/JwzTgZqdSnmsvWBWM0VaVWMzp
   68cQpT7nJH4pRqRyJnT6R78aywOs432pwiOUas+I4kxjI+/5xXQWbjF9p
   9a22u3rPSpB90LXUsw+EsCtGESpirA8zqWqJLcR4T7rP49+cjsOZ1hAHO
   B01De4iMA9CD+bCU5kIurFc31Ox7802hD5aw6fEVGHuNyHNIoJubilhuF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="354591029"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="354591029"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 12:32:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="558665972"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2022 12:32:04 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOlFM-0000TB-0b;
        Thu, 18 Aug 2022 19:32:04 +0000
Date:   Fri, 19 Aug 2022 03:31:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrea Mayer <andrea.mayer@uniroma2.it>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: net/ipv6/seg6_local.c:43:8: warning: Excessive padding in 'struct
 seg6_action_desc' (8 padding bytes, where 0 is optimal). Optimal fields
 order: attrs, optattrs, input, slwt_ops, action, static_headroom, consider
 reordering the fields or adding explicit p...
Message-ID: <202208190350.HZ1vBJzy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   573ae4f13f630d6660008f1974c0a8a29c30e18a
commit: cfdf64a03406351a9d6c1fe568a141a9a85d4710 seg6: add callbacks for customizing the creation/destruction of a behavior
date:   1 year, 8 months ago
config: riscv-randconfig-c006-20220815 (https://download.01.org/0day-ci/archive/20220819/202208190350.HZ1vBJzy-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cfdf64a03406351a9d6c1fe568a141a9a85d4710
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cfdf64a03406351a9d6c1fe568a141a9a85d4710
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

clang-analyzer warnings: (new ones prefixed by >>)
                       ^~~~~
   drivers/memstick/core/ms_block.c:1762:2: note: Taking false branch
           dbg("Parallel mode supported: %d", !!(msb->caps & MEMSTICK_CAP_PAR4));
           ^
   drivers/memstick/core/ms_block.h:284:27: note: expanded from macro 'dbg'
   #define dbg(format, ...)                __dbg(1, format, ## __VA_ARGS__)
                                           ^
   drivers/memstick/core/ms_block.h:279:3: note: expanded from macro '__dbg'
                   if (debug >= level) \
                   ^
   drivers/memstick/core/ms_block.c:1762:2: note: Loop condition is false.  Exiting loop
           dbg("Parallel mode supported: %d", !!(msb->caps & MEMSTICK_CAP_PAR4));
           ^
   drivers/memstick/core/ms_block.h:284:27: note: expanded from macro 'dbg'
   #define dbg(format, ...)                __dbg(1, format, ## __VA_ARGS__)
                                           ^
   drivers/memstick/core/ms_block.h:278:2: note: expanded from macro '__dbg'
           do { \
           ^
   drivers/memstick/core/ms_block.c:1763:2: note: 'debug' is < 1
           dbg("Read only: %d", msb->read_only);
           ^
   drivers/memstick/core/ms_block.h:284:27: note: expanded from macro 'dbg'
   #define dbg(format, ...)                __dbg(1, format, ## __VA_ARGS__)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/memstick/core/ms_block.h:279:7: note: expanded from macro '__dbg'
                   if (debug >= level) \
                       ^~~~~
   drivers/memstick/core/ms_block.c:1763:2: note: Taking false branch
           dbg("Read only: %d", msb->read_only);
           ^
   drivers/memstick/core/ms_block.h:284:27: note: expanded from macro 'dbg'
   #define dbg(format, ...)                __dbg(1, format, ## __VA_ARGS__)
                                           ^
   drivers/memstick/core/ms_block.h:279:3: note: expanded from macro '__dbg'
                   if (debug >= level) \
                   ^
   drivers/memstick/core/ms_block.c:1763:2: note: Loop condition is false.  Exiting loop
           dbg("Read only: %d", msb->read_only);
           ^
   drivers/memstick/core/ms_block.h:284:27: note: expanded from macro 'dbg'
   #define dbg(format, ...)                __dbg(1, format, ## __VA_ARGS__)
                                           ^
   drivers/memstick/core/ms_block.h:278:2: note: expanded from macro '__dbg'
           do { \
           ^
   drivers/memstick/core/ms_block.c:1772:6: note: 'error' is 0
           if (error)
               ^~~~~
   drivers/memstick/core/ms_block.c:1772:2: note: Taking false branch
           if (error)
           ^
   drivers/memstick/core/ms_block.c:1775:10: note: Calling 'msb_ftl_initialize'
           error = msb_ftl_initialize(msb);
                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/memstick/core/ms_block.c:1332:6: note: Assuming field 'ftl_initialized' is false
           if (msb->ftl_initialized)
               ^~~~~~~~~~~~~~~~~~~~
   drivers/memstick/core/ms_block.c:1332:2: note: Taking false branch
           if (msb->ftl_initialized)
           ^
   drivers/memstick/core/ms_block.c:1344:6: note: Assuming field 'used_blocks_bitmap' is null
           if (!msb->used_blocks_bitmap || !msb->lba_to_pba_table ||
               ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/memstick/core/ms_block.c:1344:31: note: Left side of '||' is true
           if (!msb->used_blocks_bitmap || !msb->lba_to_pba_table ||
                                        ^
   drivers/memstick/core/ms_block.c:1347:3: note: Memory is released
                   kfree(msb->lba_to_pba_table);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/memstick/core/ms_block.c:1775:10: note: Returning; memory was released
           error = msb_ftl_initialize(msb);
                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/memstick/core/ms_block.c:1776:6: note: 'error' is -12
           if (error)
               ^~~~~
   drivers/memstick/core/ms_block.c:1776:2: note: Taking true branch
           if (error)
           ^
   drivers/memstick/core/ms_block.c:2180:7: note: Returning; memory was released
           rc = msb_init_card(card);
                ^~~~~~~~~~~~~~~~~~~
   drivers/memstick/core/ms_block.c:2181:6: note: 'rc' is -12
           if (rc)
               ^~
   drivers/memstick/core/ms_block.c:2181:2: note: Taking true branch
           if (rc)
           ^
   drivers/memstick/core/ms_block.c:2182:3: note: Control jumps to line 2192
                   goto out_free;
                   ^
   drivers/memstick/core/ms_block.c:2193:2: note: Calling 'msb_data_clear'
           msb_data_clear(msb);
           ^~~~~~~~~~~~~~~~~~~
   drivers/memstick/core/ms_block.c:1957:2: note: Attempt to free released memory
           kfree(msb->lba_to_pba_table);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 8 warnings (8 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
>> net/ipv6/seg6_local.c:43:8: warning: Excessive padding in 'struct seg6_action_desc' (8 padding bytes, where 0 is optimal). Optimal fields order: attrs, optattrs, input, slwt_ops, action, static_headroom, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct seg6_action_desc {
   ~~~~~~~^~~~~~~~~~~~~~~~~~
   net/ipv6/seg6_local.c:43:8: note: Excessive padding in 'struct seg6_action_desc' (8 padding bytes, where 0 is optimal). Optimal fields order: attrs, optattrs, input, slwt_ops, action, static_headroom, consider reordering the fields or adding explicit padding members
   struct seg6_action_desc {
   ~~~~~~~^~~~~~~~~~~~~~~~~~
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   17 warnings generated.
   Suppressed 17 warnings (16 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   16 warnings generated.
   Suppressed 16 warnings (16 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   19 warnings generated.
   net/ipv6/ip6_vti.c:194:2: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcpy(t->parms.name, dev->name);
           ^~~~~~
   net/ipv6/ip6_vti.c:194:2: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
           strcpy(t->parms.name, dev->name);
           ^~~~~~
   net/ipv6/ip6_vti.c:849:4: warning: Value stored to 'err' is never read [clang-analyzer-deadcode.DeadStores]
                           err = vti6_update(t, &p1, false);
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/ipv6/ip6_vti.c:849:4: note: Value stored to 'err' is never read
                           err = vti6_update(t, &p1, false);
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/ipv6/ip6_vti.c:1166:2: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcpy(t->parms.name, ip6n->fb_tnl_dev->name);
           ^~~~~~
   net/ipv6/ip6_vti.c:1166:2: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
           strcpy(t->parms.name, ip6n->fb_tnl_dev->name);
           ^~~~~~
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
   17 warnings generated.
   net/atm/common.c:238:2: warning: Assigned value is garbage or undefined [clang-analyzer-core.uninitialized.Assign]
           skb_queue_walk_safe(&queue, skb, tmp) {
           ^
   include/linux/skbuff.h:3459:33: note: expanded from macro 'skb_queue_walk_safe'
                   for (skb = (queue)->next, tmp = skb->next;                      \
                                                 ^ ~~~~~~~~~
   net/atm/common.c:231:2: note: Calling '__skb_queue_head_init'
           __skb_queue_head_init(&queue);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/atm/common.c:231:2: note: Returning from '__skb_queue_head_init'
           __skb_queue_head_init(&queue);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/atm/common.c:234:2: note: Loop condition is false.  Exiting loop
           spin_lock_irqsave(&rq->lock, flags);
           ^
   include/linux/spinlock.h:384:2: note: expanded from macro 'spin_lock_irqsave'
           raw_spin_lock_irqsave(spinlock_check(lock), flags);     \
           ^
   include/linux/spinlock.h:250:2: note: expanded from macro 'raw_spin_lock_irqsave'
           do {                                            \
           ^
   net/atm/common.c:234:2: note: Loop condition is false.  Exiting loop
           spin_lock_irqsave(&rq->lock, flags);
           ^
   include/linux/spinlock.h:382:43: note: expanded from macro 'spin_lock_irqsave'
   #define spin_lock_irqsave(lock, flags)                          \
                                                                   ^
   net/atm/common.c:235:2: note: Calling 'skb_queue_splice_init'
           skb_queue_splice_init(rq, &queue);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/skbuff.h:1957:6: note: Assuming the condition is false
           if (!skb_queue_empty(list)) {
               ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/skbuff.h:1957:2: note: Taking false branch
           if (!skb_queue_empty(list)) {
           ^
   net/atm/common.c:235:2: note: Returning from 'skb_queue_splice_init'
           skb_queue_splice_init(rq, &queue);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/atm/common.c:238:2: note: Assigned value is garbage or undefined
           skb_queue_walk_safe(&queue, skb, tmp) {
           ^
   include/linux/skbuff.h:3459:33: note: expanded from macro 'skb_queue_walk_safe'
                   for (skb = (queue)->next, tmp = skb->next;                      \

vim +43 net/ipv6/seg6_local.c

cfdf64a03406351 Andrea Mayer 2020-12-02  42  
d1df6fd8a1d22d3 David Lebrun 2017-08-05 @43  struct seg6_action_desc {
d1df6fd8a1d22d3 David Lebrun 2017-08-05  44  	int action;
d1df6fd8a1d22d3 David Lebrun 2017-08-05  45  	unsigned long attrs;
0a3021f1d4e553d Andrea Mayer 2020-12-02  46  
0a3021f1d4e553d Andrea Mayer 2020-12-02  47  	/* The optattrs field is used for specifying all the optional
0a3021f1d4e553d Andrea Mayer 2020-12-02  48  	 * attributes supported by a specific behavior.
0a3021f1d4e553d Andrea Mayer 2020-12-02  49  	 * It means that if one of these attributes is not provided in the
0a3021f1d4e553d Andrea Mayer 2020-12-02  50  	 * netlink message during the behavior creation, no errors will be
0a3021f1d4e553d Andrea Mayer 2020-12-02  51  	 * returned to the userspace.
0a3021f1d4e553d Andrea Mayer 2020-12-02  52  	 *
0a3021f1d4e553d Andrea Mayer 2020-12-02  53  	 * Each attribute can be only of two types (mutually exclusive):
0a3021f1d4e553d Andrea Mayer 2020-12-02  54  	 * 1) required or 2) optional.
0a3021f1d4e553d Andrea Mayer 2020-12-02  55  	 * Every user MUST obey to this rule! If you set an attribute as
0a3021f1d4e553d Andrea Mayer 2020-12-02  56  	 * required the same attribute CANNOT be set as optional and vice
0a3021f1d4e553d Andrea Mayer 2020-12-02  57  	 * versa.
0a3021f1d4e553d Andrea Mayer 2020-12-02  58  	 */
0a3021f1d4e553d Andrea Mayer 2020-12-02  59  	unsigned long optattrs;
0a3021f1d4e553d Andrea Mayer 2020-12-02  60  
d1df6fd8a1d22d3 David Lebrun 2017-08-05  61  	int (*input)(struct sk_buff *skb, struct seg6_local_lwt *slwt);
d1df6fd8a1d22d3 David Lebrun 2017-08-05  62  	int static_headroom;
cfdf64a03406351 Andrea Mayer 2020-12-02  63  
cfdf64a03406351 Andrea Mayer 2020-12-02  64  	struct seg6_local_lwtunnel_ops slwt_ops;
d1df6fd8a1d22d3 David Lebrun 2017-08-05  65  };
d1df6fd8a1d22d3 David Lebrun 2017-08-05  66  

:::::: The code at line 43 was first introduced by commit
:::::: d1df6fd8a1d22d37cffa0075ab8ad423ce656777 ipv6: sr: define core operations for seg6local lightweight tunnel

:::::: TO: David Lebrun <david.lebrun@uclouvain.be>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
