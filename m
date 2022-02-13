Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54B24B3DC0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 22:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbiBMVcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 16:32:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiBMVcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 16:32:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8D553B56
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 13:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644787931; x=1676323931;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QJe42j1eVHfw+uB6W+m6p/pUfNhMlNJgk0DGfZzQEoI=;
  b=KwWnKHAFRqj0jxYA3R8BfdPSLWa6T7V2Gv9oiBjKBC4sXk9NKc22+VcT
   40Mmpb0Rw1Sn9RI7x6xTlZ3tUKXtm5nW5ZvAJkPefbTtcMwxnEjvImJIF
   /5RqvZSJ4lQI4hngiCIC01am9sQ/uIFGUWFp2IL4wKtAvFOp5BHa9BdSj
   pbjLmEqsqpWfaU+xgxW2EeaC1vW8aTwY1dM5La5FFz+XV0RA3FUQABrRe
   Ig23cDWDeNGQpcaFNCMfXVOyH0TwA2rt0rRhOz4zxQVqBvZP1tPtvo9kP
   ybhP2cJzYm/lWAUd088t7hG9sRR+q3wuBgSIkTqXax2wZsC2beLMamELS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="233525383"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="233525383"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 13:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="542930097"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Feb 2022 13:32:09 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJMTY-0007s5-Vh; Sun, 13 Feb 2022 21:32:08 +0000
Date:   Mon, 14 Feb 2022 05:31:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-02 5/11] kernel/bpf/pifomap.c:197:6: warning: no
 previous prototype for function 'pifo_set_bit'
Message-ID: <202202140517.jN2jJhHH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-02
head:   26dde94b299bc277f7a99a99ba64b4363964e833
commit: 34cc5abfbae0dfcb6967c54cb80f7595bc9c5c37 [5/11] Add a PIFO map type for queueing packets
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220214/202202140517.jN2jJhHH-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=34cc5abfbae0dfcb6967c54cb80f7595bc9c5c37
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-02
        git checkout 34cc5abfbae0dfcb6967c54cb80f7595bc9c5c37
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/pifomap.c:197:6: warning: no previous prototype for function 'pifo_set_bit' [-Wmissing-prototypes]
   void pifo_set_bit(struct bpf_pifo_queue *queue, u32 rank)
        ^
   kernel/bpf/pifomap.c:197:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void pifo_set_bit(struct bpf_pifo_queue *queue, u32 rank)
   ^
   static 
>> kernel/bpf/pifomap.c:208:6: warning: no previous prototype for function 'pifo_clear_bit' [-Wmissing-prototypes]
   void pifo_clear_bit(struct bpf_pifo_queue *queue, u32 rank)
        ^
   kernel/bpf/pifomap.c:208:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void pifo_clear_bit(struct bpf_pifo_queue *queue, u32 rank)
   ^
   static 
   2 warnings generated.


vim +/pifo_set_bit +197 kernel/bpf/pifomap.c

   196	
 > 197	void pifo_set_bit(struct bpf_pifo_queue *queue, u32 rank)
   198	{
   199		u32 i;
   200	
   201		for (i = queue->levels; i > 0; i--) {
   202			unsigned long *bitmap = queue->lvl_bitmap[i-1];
   203			set_bit(rank, bitmap);
   204			rank /= BITS_PER_TYPE(long);
   205		}
   206	}
   207	
 > 208	void pifo_clear_bit(struct bpf_pifo_queue *queue, u32 rank)
   209	{
   210		u32 i;
   211	
   212		for (i = queue->levels; i > 0; i--) {
   213			unsigned long *bitmap = queue->lvl_bitmap[i-1];
   214			clear_bit(rank, bitmap);
   215			rank /= BITS_PER_TYPE(long);
   216	
   217			// another bit is set in this word, don't clear bit in higher
   218			// level
   219			if (*(bitmap + rank))
   220				break;
   221		}
   222	}
   223	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
