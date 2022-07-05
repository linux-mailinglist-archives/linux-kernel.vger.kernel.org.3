Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08705567A95
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 01:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiGEXNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 19:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiGEXND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 19:13:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF03513F41
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062782; x=1688598782;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+Orqa29JFYx4xWz8H8R17jgvkeNypedLEaIok3+c0GU=;
  b=Dk4J3QL7DUBrOIpBD8dpXchwNH1OvXyzB2f+YlLH/gDAsye4doZohjIu
   D6uA2AdqA325b9fY6NPF10yPlUuk6dQr36se4LgL9a4IP+J+/Ems/FJi8
   Es4AIZmo7lOMQs3wfllK3hK2E9dgqIrqTr4zjvYZdHh5U3FrltoiN3e/S
   tYHWA6LJ2lc/Ga5MUKjmYUnD5DhTVM6BDAZJJXsufPYwLBp5rSllBLIsH
   0lO4pUTqmyzZoHjJG7DKSlAMgxH/EBvrU3nrtGOkuE9XLuzfYNBg8vJFk
   0CeT79D7oF4/EHPLBlidduoeUdIJFgL+wxLvPgzx0vodPgPLNsjRtmKLk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="369882710"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="369882710"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="543147953"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jul 2022 16:13:01 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8rj2-000JhN-Jd;
        Tue, 05 Jul 2022 23:13:00 +0000
Date:   Wed, 6 Jul 2022 07:12:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_22 21/21] kernel/bpf/trampoline.c:916:15:
 error: implicit declaration of function 'set_ftrace_direct'; did you mean
 'modify_ftrace_direct'?
Message-ID: <202207060701.G7zn7gft-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_22
head:   1d891c46bb689a24985cea58f4eddb053d6b1331
commit: 1d891c46bb689a24985cea58f4eddb053d6b1331 [21/21] bpf: Add support to attach multi trampolines
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220706/202207060701.G7zn7gft-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=1d891c46bb689a24985cea58f4eddb053d6b1331
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_22
        git checkout 1d891c46bb689a24985cea58f4eddb053d6b1331
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/trampoline.c: In function 'bpf_tramp_update_set':
>> kernel/bpf/trampoline.c:916:15: error: implicit declaration of function 'set_ftrace_direct'; did you mean 'modify_ftrace_direct'? [-Werror=implicit-function-declaration]
     916 |         err = set_ftrace_direct(hash);
         |               ^~~~~~~~~~~~~~~~~
         |               modify_ftrace_direct
   cc1: some warnings being treated as errors


vim +916 kernel/bpf/trampoline.c

   868	
   869	static int bpf_tramp_update_set(struct list_head *upd)
   870	{
   871		struct bpf_trampoline *tr;
   872		struct ftrace_hash *hash;
   873		int i, err;
   874	
   875		hash = ftrace_hash_alloc(FTRACE_HASH_MAX_BITS);
   876		if (!hash)
   877			return -ENOMEM;
   878	
   879		list_for_each_entry(tr, upd, update.list) {
   880			struct ftrace_func_entry *entry;
   881			unsigned long direct;
   882	
   883			switch (tr->update.action) {
   884			case BPF_TRAMP_UPDATE_REG:
   885			case BPF_TRAMP_UPDATE_MODIFY:
   886				direct = (unsigned long) tr->update.im->image;
   887				break;
   888			case BPF_TRAMP_UPDATE_UNREG:
   889				direct = 0;
   890				continue;
   891			}
   892	
   893			if (tr->multi.id_multi) {
   894				for (i = 0; i < tr->multi.id_multi->cnt; i++) {
   895					entry = kmalloc(sizeof(*entry), GFP_KERNEL);
   896					if (!entry) {
   897						err = -ENOMEM;
   898						goto out_free;
   899					}
   900					entry->ip = (unsigned long) tr->multi.id_multi->addr[i];
   901					entry->direct = direct;
   902					ftrace_hash_add_entry(hash, entry);
   903				}
   904			} else {
   905				entry = kmalloc(sizeof(*entry), GFP_KERNEL);
   906				if (!entry) {
   907					err = -ENOMEM;
   908					goto out_free;
   909				}
   910				entry->ip = (unsigned long) tr->func.addr;
   911				entry->direct = direct;
   912				ftrace_hash_add_entry(hash, entry);
   913			}
   914		}
   915	
 > 916		err = set_ftrace_direct(hash);
   917	out_free:
   918		ftrace_hash_free(hash);
   919		return err;
   920	}
   921	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
