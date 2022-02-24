Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFD34C21D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiBXCug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiBXCua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:50:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966A1166E14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 18:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645671001; x=1677207001;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FouP27on1rIZsc+WeEjVArGu53XGah9tgEmvJYeMwfA=;
  b=NVvbnWSQJTHyKZ7ZsQpjyrBCMslAK/sPT537nIl+49U+LgHHGF+DPpQ7
   daEAIPDTViSa2NeuE+eZh6v2uf21cwfRyU9f6fDFxWL6H6fBMET5tGI5l
   TtHWih9RvVpCzZ2o0jEffPJMzadV7//hz4SqWjqwBxidoSK9WYxDxQCvt
   kKNlKcfxZz8Hrqkr1dxR61UZATS1gGbyJwgunyJQpcfHV21rUtEDo/5CP
   2M9VxgM5QPyJZokYogWiH/7jpYg6qAEppgt3VQUvl0VN0LdcqjL+hpdb1
   hSyPu3H4CNfFCf2M/CfIwNhrkfIIPr+PobG9aygXLrstibX+MNPfl70Yw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232757134"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="232757134"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="508696083"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Feb 2022 18:49:59 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN4Cd-000297-7c; Thu, 24 Feb 2022 02:49:59 +0000
Date:   Thu, 24 Feb 2022 10:49:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 22/42] kernel/bpf/trampoline.c:154:26:
 warning: passing argument 1 of 'ftrace_location' makes integer from pointer
 without a cast
Message-ID: <202202241056.xqhnicOb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   27b6438f414b6a37b60dcd90c8980397586d49db
commit: 28a2850ec958722056cb6679cf68567905223971 [22/42] x86/bpf: Add ENDBR instructions to prologue and trampoline
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220224/202202241056.xqhnicOb-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=28a2850ec958722056cb6679cf68567905223971
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 28a2850ec958722056cb6679cf68567905223971
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/bpf/trampoline.c: In function 'register_fentry':
>> kernel/bpf/trampoline.c:154:26: warning: passing argument 1 of 'ftrace_location' makes integer from pointer without a cast [-Wint-conversion]
     154 |  faddr = ftrace_location(ip);
         |                          ^~
         |                          |
         |                          void *
   In file included from kernel/bpf/trampoline.c:6:
   include/linux/ftrace.h:792:59: note: expected 'long unsigned int' but argument is of type 'void *'
     792 | static inline unsigned long ftrace_location(unsigned long ip)
         |                                             ~~~~~~~~~~~~~~^~


vim +/ftrace_location +154 kernel/bpf/trampoline.c

   146	
   147	/* first time registering */
   148	static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
   149	{
   150		void *ip = tr->func.addr;
   151		unsigned long faddr;
   152		int ret;
   153	
 > 154		faddr = ftrace_location(ip);
   155		if (faddr)
   156			tr->func.ftrace_managed = true;
   157	
   158		if (bpf_trampoline_module_get(tr))
   159			return -ENOENT;
   160	
   161		if (tr->func.ftrace_managed)
   162			ret = register_ftrace_direct((long)ip, (long)new_addr);
   163		else
   164			ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
   165	
   166		if (ret)
   167			bpf_trampoline_module_put(tr);
   168		return ret;
   169	}
   170	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
