Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3C9570CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiGKVlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiGKVlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:41:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7067585D70
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657575705; x=1689111705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cWX/ZUAISR+x5BqgIfmM1cUxMRrjQdq2KdLbWcjGPGA=;
  b=juTP4TXS1JaM4/3pvDrMskBYAIXDFKO8HEwP7c+/UPMvGCX2cIOXhWyL
   fbnwsX7nXdvL3jIXGWq6aVWSdI97pPsnYMfqxEK9tadKV8duFUuQtAFH+
   46S+p5eEr9WuE6I26uUeCnkqEDYdtb4Kw/z3Ei0YFYVrD7fYGaTUvJLjm
   9+jhEJULzz2WlcnBPLkY7kz8DFRSoCsyCudEKORjuXnhNv1bYOAZSX0TV
   XMQ2IXADXHHivSPYX/t7j3ZiA4aAyBSiJQennYkEXUicWOdmNHal0Q4FS
   xomsZLaDsROMga2HvIwIajvc5xvFBPVdFCxmctJ48qIm5QcD4KhAJs8He
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310384956"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="310384956"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 14:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="545174753"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2022 14:41:42 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB19x-0001FN-Ut;
        Mon, 11 Jul 2022 21:41:41 +0000
Date:   Tue, 12 Jul 2022 05:41:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_29 25/32] kernel/bpf/trampoline.c:948:9:
 error: call to undeclared function 'ftrace_hash_alloc'; ISO C99 and later do
 not support implicit function declarations
Message-ID: <202207120555.rWXO6yao-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_29
head:   ec522c20e55e48f561146afbb81513e20870ee12
commit: f8f16c805972e534643c5a5d23709766f7af22e4 [25/32] bpf: Add support to attach multi trampolines
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220712/202207120555.rWXO6yao-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project badda4ac3c489a8c8cccdad1f74b9308c350a9e0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=f8f16c805972e534643c5a5d23709766f7af22e4
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_29
        git checkout f8f16c805972e534643c5a5d23709766f7af22e4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/bpf/trampoline.c:948:9: error: call to undeclared function 'ftrace_hash_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
                  ^
>> kernel/bpf/trampoline.c:948:27: error: use of undeclared identifier 'FTRACE_HASH_MAX_BITS'
           hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
                                    ^
>> kernel/bpf/trampoline.c:975:5: error: call to undeclared function 'ftrace_hash_add_entry'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                   ftrace_hash_add_entry(hash, entry);
                                   ^
   kernel/bpf/trampoline.c:985:4: error: call to undeclared function 'ftrace_hash_add_entry'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           ftrace_hash_add_entry(hash, entry);
                           ^
>> kernel/bpf/trampoline.c:989:8: error: call to undeclared function 'set_ftrace_direct'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           err = set_ftrace_direct(hash);
                 ^
>> kernel/bpf/trampoline.c:991:2: error: call to undeclared function 'ftrace_hash_free'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           ftrace_hash_free(hash);
           ^
   6 errors generated.


vim +/ftrace_hash_alloc +948 kernel/bpf/trampoline.c

   941	
   942	static int bpf_tramp_update_set(struct list_head *upd)
   943	{
   944		struct bpf_trampoline *tr;
   945		struct ftrace_hash *hash;
   946		int i, err;
   947	
 > 948		hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
   949		if (!hash)
   950			return -ENOMEM;
   951	
   952		list_for_each_entry(tr, upd, update.list) {
   953			struct ftrace_func_entry *entry;
   954			unsigned long direct;
   955	
   956			switch (tr->update.action) {
   957			case BPF_TRAMP_UPDATE_REG:
   958			case BPF_TRAMP_UPDATE_MODIFY:
   959				direct = (unsigned long) tr->update.im->image;
   960				break;
   961			case BPF_TRAMP_UPDATE_UNREG:
   962				direct = 0;
   963				break;
   964			}
   965	
   966			if (tr->multi.id_multi) {
   967				for (i = 0; i < tr->multi.id_multi->cnt; i++) {
   968					entry = kmalloc(sizeof(*entry), GFP_KERNEL);
   969					if (!entry) {
   970						err = -ENOMEM;
   971						goto out_free;
   972					}
   973					entry->ip = (unsigned long) tr->multi.id_multi->addr[i];
   974					entry->direct = direct;
 > 975					ftrace_hash_add_entry(hash, entry);
   976				}
   977			} else {
   978				entry = kmalloc(sizeof(*entry), GFP_KERNEL);
   979				if (!entry) {
   980					err = -ENOMEM;
   981					goto out_free;
   982				}
   983				entry->ip = (unsigned long) tr->func.addr;
   984				entry->direct = direct;
   985				ftrace_hash_add_entry(hash, entry);
   986			}
   987		}
   988	
 > 989		err = set_ftrace_direct(hash);
   990	out_free:
 > 991		ftrace_hash_free(hash);
   992		return err;
   993	}
   994	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
