Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008BF4D628A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348942AbiCKNoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbiCKNoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:44:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD19D18E432
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647006189; x=1678542189;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1WLciB+5XZNIRAFHKD3kF9c7MeIlHZUQ5tWcGCfeQD0=;
  b=jkp0YcvDpwvWItk3N8yuF1qb9enGtX182GbC0vG9oXGPW5WsTF1ZT7Ei
   lrgvHl/40Y13qNOva6BljE8kUogJgsjqiUWAEjimzhOu7ExWpp81e0FWq
   bbxOOXnHl3SCATjZL3d0UlkT1A5AQroWW/NfmjlLXf3YJoZP5p+wkr9y4
   MfYV2uBCwVi8kUh5DrsRIYM8hhY5qqYTgOwFeDMCYCt7gx0C4Lz2tj2kE
   oTIxuIsKPaTsIDmuQGc6zH/je/iObUG9qM+MH6+mJEfITGCFc9ayRFm1T
   2Lwf2AiqesNrMC07E7nLaH0mpwCRQ1i4/nOmAeQ8xkgnI03GeLCf+55DO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="342000714"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="342000714"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 05:43:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="644934835"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2022 05:43:07 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSfXu-0006UW-9F; Fri, 11 Mar 2022 13:43:06 +0000
Date:   Fri, 11 Mar 2022 21:42:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/dma/iop-adma.c:170:5: error: implicit declaration of
 function 'list_for_each_entry_from_inside' is invalid in C99
Message-ID: <202203112154.lWEn6Enk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220311-151720/Xiaomeng-Tong/list_for_each_entry-make-iterator-invisiable-outside-the-loop/20220301-160113
head:   54ae283053c127aac4b946dffa0f31f9885dbb77
commit: 54ae283053c127aac4b946dffa0f31f9885dbb77 drivers/dma: remove iterator use outside the loop
date:   6 hours ago
config: arm64-randconfig-r014-20220310 (https://download.01.org/0day-ci/archive/20220311/202203112154.lWEn6Enk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/54ae283053c127aac4b946dffa0f31f9885dbb77
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220311-151720/Xiaomeng-Tong/list_for_each_entry-make-iterator-invisiable-outside-the-loop/20220301-160113
        git checkout 54ae283053c127aac4b946dffa0f31f9885dbb77
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/dma/iop-adma.c:170:5: error: implicit declaration of function 'list_for_each_entry_from_inside' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                                   list_for_each_entry_from_inside(grp_iter, grp_start,
                                   ^
>> drivers/dma/iop-adma.c:171:35: error: expected ';' after expression
                                           &iop_chan->chain, chain_node) {
                                                                        ^
                                                                        ;
>> drivers/dma/iop-adma.c:170:37: error: use of undeclared identifier 'grp_iter'
                                   list_for_each_entry_from_inside(grp_iter, grp_start,
                                                                   ^
>> drivers/dma/iop-adma.c:171:24: error: use of undeclared identifier 'chain_node'
                                           &iop_chan->chain, chain_node) {
                                                             ^
   drivers/dma/iop-adma.c:173:35: error: use of undeclared identifier 'grp_iter'; did you mean 'dup_iter'?
                                               iop_desc_get_zero_result(grp_iter);
                                                                        ^~~~~~~~
                                                                        dup_iter
   include/linux/uio.h:242:13: note: 'dup_iter' declared here
   const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
               ^
   drivers/dma/iop-adma.c:175:10: error: use of undeclared identifier 'grp_iter'; did you mean 'grp_start'?
                                               grp_iter->idx, zero_sum_result);
                                               ^~~~~~~~
                                               grp_start
   include/linux/printk.h:574:26: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
                                   ^
   include/linux/dynamic_debug.h:163:22: note: expanded from macro 'dynamic_pr_debug'
                              pr_fmt(fmt), ##__VA_ARGS__)
                                             ^
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^
   drivers/dma/iop-adma.c:106:44: note: 'grp_start' declared here
           struct iop_adma_desc_slot *iter, *_iter, *grp_start = NULL;
                                                     ^
>> drivers/dma/iop-adma.c:187:4: error: implicit declaration of function 'list_for_each_entry_safe_from_inside' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           list_for_each_entry_safe_from_inside(grp_iter, _grp_iter,
                           ^
   drivers/dma/iop-adma.c:188:45: error: expected ';' after expression
                                   grp_start, &iop_chan->chain, chain_node) {
                                                                           ^
                                                                           ;
   drivers/dma/iop-adma.c:187:41: error: use of undeclared identifier 'grp_iter'
                           list_for_each_entry_safe_from_inside(grp_iter, _grp_iter,
                                                                ^
>> drivers/dma/iop-adma.c:187:51: error: use of undeclared identifier '_grp_iter'
                           list_for_each_entry_safe_from_inside(grp_iter, _grp_iter,
                                                                          ^
   drivers/dma/iop-adma.c:188:34: error: use of undeclared identifier 'chain_node'
                                   grp_start, &iop_chan->chain, chain_node) {
                                                                ^
   drivers/dma/iop-adma.c:190:6: error: use of undeclared identifier 'grp_iter'; did you mean 'dup_iter'?
                                           grp_iter, iop_chan, cookie);
                                           ^~~~~~~~
                                           dup_iter
   include/linux/uio.h:242:13: note: 'dup_iter' declared here
   const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
               ^
   drivers/dma/iop-adma.c:193:40: error: use of undeclared identifier 'grp_iter'; did you mean 'dup_iter'?
                                   end_of_chain = iop_adma_clean_slot(grp_iter,
                                                                      ^~~~~~~~
                                                                      dup_iter
   include/linux/uio.h:242:13: note: 'dup_iter' declared here
   const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
               ^
   13 errors generated.


vim +/list_for_each_entry_from_inside +170 drivers/dma/iop-adma.c

   103	
   104	static void __iop_adma_slot_cleanup(struct iop_adma_chan *iop_chan)
   105	{
 > 106		struct iop_adma_desc_slot *iter, *_iter, *grp_start = NULL;
   107		dma_cookie_t cookie = 0;
   108		u32 current_desc = iop_chan_get_current_descriptor(iop_chan);
   109		int busy = iop_chan_is_busy(iop_chan);
   110		int seen_current = 0, slot_cnt = 0, slots_per_op = 0;
   111	
   112		dev_dbg(iop_chan->device->common.dev, "%s\n", __func__);
   113		/* free completed slots from the chain starting with
   114		 * the oldest descriptor
   115		 */
   116		list_for_each_entry_safe(iter, _iter, &iop_chan->chain,
   117						chain_node) {
   118			pr_debug("\tcookie: %d slot: %d busy: %d "
   119				"this_desc: %pad next_desc: %#llx ack: %d\n",
   120				iter->async_tx.cookie, iter->idx, busy,
   121				&iter->async_tx.phys, (u64)iop_desc_get_next_desc(iter),
   122				async_tx_test_ack(&iter->async_tx));
   123			prefetch(_iter);
   124			prefetch(&_iter->async_tx);
   125	
   126			/* do not advance past the current descriptor loaded into the
   127			 * hardware channel, subsequent descriptors are either in
   128			 * process or have not been submitted
   129			 */
   130			if (seen_current)
   131				break;
   132	
   133			/* stop the search if we reach the current descriptor and the
   134			 * channel is busy, or if it appears that the current descriptor
   135			 * needs to be re-read (i.e. has been appended to)
   136			 */
   137			if (iter->async_tx.phys == current_desc) {
   138				BUG_ON(seen_current++);
   139				if (busy || iop_desc_get_next_desc(iter))
   140					break;
   141			}
   142	
   143			/* detect the start of a group transaction */
   144			if (!slot_cnt && !slots_per_op) {
   145				slot_cnt = iter->slot_cnt;
   146				slots_per_op = iter->slots_per_op;
   147				if (slot_cnt <= slots_per_op) {
   148					slot_cnt = 0;
   149					slots_per_op = 0;
   150				}
   151			}
   152	
   153			if (slot_cnt) {
   154				pr_debug("\tgroup++\n");
   155				if (!grp_start)
   156					grp_start = iter;
   157				slot_cnt -= slots_per_op;
   158			}
   159	
   160			/* all the members of a group are complete */
   161			if (slots_per_op != 0 && slot_cnt == 0) {
   162				int end_of_chain = 0;
   163				pr_debug("\tgroup end\n");
   164	
   165				/* collect the total results */
   166				if (grp_start->xor_check_result) {
   167					u32 zero_sum_result = 0;
   168					slot_cnt = grp_start->slot_cnt;
   169	
 > 170					list_for_each_entry_from_inside(grp_iter, grp_start,
 > 171						&iop_chan->chain, chain_node) {
   172						zero_sum_result |=
   173						    iop_desc_get_zero_result(grp_iter);
   174						pr_debug("\titer%d result: %d\n",
   175						    grp_iter->idx, zero_sum_result);
   176						slot_cnt -= slots_per_op;
   177						if (slot_cnt == 0)
   178							break;
   179					}
   180					pr_debug("\tgrp_start->xor_check_result: %p\n",
   181						grp_start->xor_check_result);
   182					*grp_start->xor_check_result = zero_sum_result;
   183				}
   184	
   185				/* clean up the group */
   186				slot_cnt = grp_start->slot_cnt;
 > 187				list_for_each_entry_safe_from_inside(grp_iter, _grp_iter,
 > 188					grp_start, &iop_chan->chain, chain_node) {
   189					cookie = iop_adma_run_tx_complete_actions(
   190						grp_iter, iop_chan, cookie);
   191	
   192					slot_cnt -= slots_per_op;
   193					end_of_chain = iop_adma_clean_slot(grp_iter,
   194						iop_chan);
   195	
   196					if (slot_cnt == 0 || end_of_chain)
   197						break;
   198				}
   199	
   200				/* the group should be complete at this point */
   201				BUG_ON(slot_cnt);
   202	
   203				slots_per_op = 0;
   204				grp_start = NULL;
   205				if (end_of_chain)
   206					break;
   207				else
   208					continue;
   209			} else if (slots_per_op) /* wait for group completion */
   210				continue;
   211	
   212			/* write back zero sum results (single descriptor case) */
   213			if (iter->xor_check_result && iter->async_tx.cookie)
   214				*iter->xor_check_result =
   215					iop_desc_get_zero_result(iter);
   216	
   217			cookie = iop_adma_run_tx_complete_actions(
   218						iter, iop_chan, cookie);
   219	
   220			if (iop_adma_clean_slot(iter, iop_chan))
   221				break;
   222		}
   223	
   224		if (cookie > 0) {
   225			iop_chan->common.completed_cookie = cookie;
   226			pr_debug("\tcompleted cookie %d\n", cookie);
   227		}
   228	}
   229	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
