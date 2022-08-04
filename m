Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF9C58A1FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbiHDUht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiHDUhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:37:43 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3052D1C4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659645457; x=1691181457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bqa3OlGACgieIlhMiTXOcDALao/nEaAOXh2tKobFp3A=;
  b=XppdFAmYdEZHW6QFaKuWhVcAGy4Za0VQ3xwEI9PiIEpdyJlVlURtqrIP
   TX/Q1uxte81ZtCxrSdiA5jk4Ves/JTF6R2lBp9gO2Q0D/A8XfKyBOdMBM
   pdFPP0kzo3z+DB5cXlc/SgGx598oYwqK5Z+oGMl2fwgtdRrISmQSAvB3Y
   ARMnIbtBUqjOcLInOpNF2ho3xl/Oq6s+jyeBPnakLIUrQkxn/ajIia5Hl
   kBFwAI0P9fjQ5CmWzlDXgAMuKASyfvuKTBpfCwuyP4yzAvlPsKGm2YSaD
   U2SqcccKRJhjCc+k8M+io87q0uE9UKtqULIU1iJiz6dRmpEPQpZPnL+18
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="276959988"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="276959988"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 13:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579223066"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Aug 2022 13:37:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJhb4-000Ipr-1d;
        Thu, 04 Aug 2022 20:37:34 +0000
Date:   Fri, 5 Aug 2022 04:37:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi 11/18] kernel/bpf/trampoline.c:259:6:
 error: call to undeclared function 'key_in_multi_trampoline'; ISO C99 and
 later do not support implicit function declarations
Message-ID: <202208050431.OUd5V0rj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi
head:   3f77a2c51293ea19f1ce6a9b06b9fa394beecd13
commit: fb3e0f80af089fc89a36ad479f7adfc4dd3aa9fb [11/18] bpf: Add support to attach program to multiple trampolines
config: riscv-randconfig-r042-20220804 (https://download.01.org/0day-ci/archive/20220805/202208050431.OUd5V0rj-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=fb3e0f80af089fc89a36ad479f7adfc4dd3aa9fb
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi
        git checkout fb3e0f80af089fc89a36ad479f7adfc4dd3aa9fb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/bpf/trampoline.c:259:6: error: call to undeclared function 'key_in_multi_trampoline'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (key_in_multi_trampoline(key))
               ^
>> kernel/bpf/trampoline.c:1056:13: error: static declaration of 'key_in_multi_trampoline' follows non-static declaration
   static bool key_in_multi_trampoline(u64 key)
               ^
   kernel/bpf/trampoline.c:259:6: note: previous implicit declaration is here
           if (key_in_multi_trampoline(key))
               ^
   kernel/bpf/trampoline.c:1099:9: warning: variable 'rollback_cnt' set but not used [-Wunused-but-set-variable]
           int i, rollback_cnt = 0, err = -EINVAL;
                  ^
   kernel/bpf/trampoline.c:1100:16: warning: variable 'ip' set but not used [-Wunused-but-set-variable]
           unsigned long ip, image_new, image_old;
                         ^
   2 warnings and 2 errors generated.


vim +/key_in_multi_trampoline +259 kernel/bpf/trampoline.c

   252	
   253	static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
   254	{
   255		struct bpf_trampoline *tr = NULL;
   256		struct hlist_head *head;
   257	
   258		mutex_lock(&trampoline_mutex);
 > 259		if (key_in_multi_trampoline(key))
   260			goto out;
   261		tr = __bpf_trampoline_lookup(key);
   262		if (tr) {
   263			refcount_inc(&tr->refcnt);
   264			goto out;
   265		}
   266		tr = bpf_trampoline_alloc();
   267		if (!tr)
   268			goto out;
   269		tr->key = key;
   270		head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
   271		hlist_add_head(&tr->hlist, head);
   272	out:
   273		mutex_unlock(&trampoline_mutex);
   274		return tr;
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
