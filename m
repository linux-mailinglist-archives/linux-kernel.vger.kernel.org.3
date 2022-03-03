Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC744CB5CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 05:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiCCEEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 23:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCCEEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 23:04:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF020163D6A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 20:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646280225; x=1677816225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kz3LVF49hdsquqqC4+deZnBpfx1+hI0OpJ2X/TjO3ts=;
  b=krlA5I0LI/TvIpoq0Yus8dg6I+OlFFIvLYEywleTCcqIJy7A2+0tsdS2
   tR++FHnlmM50ozlmO3mSv89UamK6cEC1ebkws3bTU/YJBpbZa471Es3kl
   jN0bq6pI0KpcnyKs4UHO0AiWe1xhDg8tNJ7V8tUFcamJb8VNbqlHrFh4v
   7sa02hNRNe5xMi+xJmcJ2iuDXB+LvHMXDPNixgY2FvJDPOIs/hzcm/Uj1
   kbUQVmZ8Ex70YsK07RCFZogOBLJR9Fi5+w2qbOmhnXsg77akivPOalM+t
   Hh3YzcL9sgxlHPD7KkjFt8cTaoVWgroHBBYvL4CUHNKnmYisp9n/IIl55
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253300964"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253300964"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 20:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="641957990"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2022 20:03:44 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPcgp-00008X-Da; Thu, 03 Mar 2022 04:03:43 +0000
Date:   Thu, 3 Mar 2022 12:03:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-q-release
 2605/9999] kernel/trace/ftrace.c:6567:6: warning: no previous declaration
 for 'ftrace_graph_return_stub'
Message-ID: <202203031139.31glDHLy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-q-release
head:   10b2283595d8504436650acaacae25859eb24bdc
commit: 03002d0374dd37a1969c6c3aa5e16ffe9844af24 [2605/9999] ANDROID: ftrace: fix function type mismatches
config: i386-randconfig-r024-20211019 (https://download.01.org/0day-ci/archive/20220303/202203031139.31glDHLy-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/03002d0374dd37a1969c6c3aa5e16ffe9844af24
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-q-release
        git checkout 03002d0374dd37a1969c6c3aa5e16ffe9844af24
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/ftrace.c:2727:13: warning: no previous declaration for 'arch_ftrace_trampoline_free' [-Wmissing-declarations]
    void __weak arch_ftrace_trampoline_free(struct ftrace_ops *ops)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:3488:1: warning: no previous declaration for 'arch_ftrace_trampoline_func' [-Wmissing-declarations]
    arch_ftrace_trampoline_func(struct ftrace_ops *ops, struct dyn_ftrace *rec)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:3726:15: warning: no previous declaration for 'arch_ftrace_match_adjust' [-Wmissing-declarations]
    char * __weak arch_ftrace_match_adjust(char *str, const char *search)
                  ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: In function 'process_mod_list':
   kernel/trace/ftrace.c:4008:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     int ret;
         ^~~
   kernel/trace/ftrace.c: In function 'ftrace_regex_release':
   kernel/trace/ftrace.c:5040:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     int ret;
         ^~~
   kernel/trace/ftrace.c: At top level:
   kernel/trace/ftrace.c:5949:13: warning: no previous declaration for 'arch_ftrace_update_trampoline' [-Wmissing-declarations]
    void __weak arch_ftrace_update_trampoline(struct ftrace_ops *ops)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:6567:6: warning: no previous declaration for 'ftrace_graph_return_stub' [-Wmissing-declarations]
    void ftrace_graph_return_stub(struct ftrace_graph_ret *trace)
         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:6571:5: warning: no previous declaration for 'ftrace_graph_entry_stub' [-Wmissing-declarations]
    int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
        ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:1093:27: warning: 'ftrace_swapper_pid' defined but not used [-Wunused-const-variable=]
    static struct pid * const ftrace_swapper_pid = &init_struct_pid;
                              ^~~~~~~~~~~~~~~~~~


vim +/ftrace_graph_return_stub +6567 kernel/trace/ftrace.c

  6566	
> 6567	void ftrace_graph_return_stub(struct ftrace_graph_ret *trace)
  6568	{
  6569	}
  6570	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
