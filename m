Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB0347834B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 03:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhLQCmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 21:42:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:55539 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhLQCmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639708962; x=1671244962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CSbl0+RPrs7o5cCRB3i4ahUHL/2Yzz/T3+j9xH6WCvo=;
  b=cWgOn0UbqV7DnCmD4WRZLn8ufRcr3AYh84q5y0GopUHYhtA3N5e/tCZw
   0HMOxw/2zw6IN1uf7SY7diJl5J9yJxnRYNf7TP6ugUHbu3tll/sa3cs5w
   2VledaH9nkrayaz+Kt/DZSCMsb79cZGBAFUgs3QXQSWHFK+8a4He8hDEk
   iVa7dBlDtNinSRl5ims9kEnc2amPbGWumwHHxgXmdUdfgZnu82j9AoYUT
   0lzm8bjBZpaHbAekpsYD/SC/vHzuDyH+B6R9N9lPPcqJ3AjQV9nrAHrQp
   lRW0O76qS67TrfsS+vDepZJ2kFWm5UWPSmh11UHg4/ydb8/ADLmai1dTd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="239886336"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="239886336"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 18:42:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="506592531"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2021 18:42:37 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my3Cc-00047u-0U; Fri, 17 Dec 2021 02:42:34 +0000
Date:   Fri, 17 Dec 2021 10:41:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [t-kristo-pm:usi-5.16-v5-bpf 16/19] drivers/hid/hid-bpf.c:696:36:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202112171058.s47VBRgI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-v5-bpf
head:   82a2c7cbd9682f2664179cd7e01647e46272c316
commit: 8ffc42bfd37f05ffa2c284b71a6c3bb5021fac8f [16/19] HID: bpf: add support for new workqueue triggering BPF call
config: arm64-randconfig-s031-20211216 (https://download.01.org/0day-ci/archive/20211217/202112171058.s47VBRgI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/t-kristo/linux-pm/commit/8ffc42bfd37f05ffa2c284b71a6c3bb5021fac8f
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-v5-bpf
        git checkout 8ffc42bfd37f05ffa2c284b71a6c3bb5021fac8f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hid/ drivers/pinctrl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/hid/hid-bpf.c:38:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:38:21: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:38:21: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:48:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:48:9: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:48:9: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:68:20: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:68:20: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:68:20: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:68:20: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:68:20: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:68:20: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:83:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:83:59: sparse:     expected struct bpf_prog_array **array
   drivers/hid/hid-bpf.c:83:59: sparse:     got struct bpf_prog_array [noderef] __rcu **
   drivers/hid/hid-bpf.c:85:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:85:59: sparse:     expected struct bpf_prog_array **array
   drivers/hid/hid-bpf.c:85:59: sparse:     got struct bpf_prog_array [noderef] __rcu **
   drivers/hid/hid-bpf.c:87:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog **target @@     got struct bpf_prog [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:87:52: sparse:     expected struct bpf_prog **target
   drivers/hid/hid-bpf.c:87:52: sparse:     got struct bpf_prog [noderef] __rcu **
   drivers/hid/hid-bpf.c:93:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog **target @@     got struct bpf_prog [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:93:53: sparse:     expected struct bpf_prog **target
   drivers/hid/hid-bpf.c:93:53: sparse:     got struct bpf_prog [noderef] __rcu **
   drivers/hid/hid-bpf.c:111:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:111:21: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:111:21: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:121:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:121:9: sparse:    struct bpf_prog_array [noderef] __rcu *
   drivers/hid/hid-bpf.c:121:9: sparse:    struct bpf_prog_array *
   drivers/hid/hid-bpf.c:140:20: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:140:20: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:140:20: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:140:20: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:140:20: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:140:20: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:156:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:156:59: sparse:     expected struct bpf_prog_array **array
   drivers/hid/hid-bpf.c:156:59: sparse:     got struct bpf_prog_array [noderef] __rcu **
   drivers/hid/hid-bpf.c:158:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct bpf_prog_array **array @@     got struct bpf_prog_array [noderef] __rcu ** @@
   drivers/hid/hid-bpf.c:158:59: sparse:     expected struct bpf_prog_array **array
   drivers/hid/hid-bpf.c:158:59: sparse:     got struct bpf_prog_array [noderef] __rcu **
   drivers/hid/hid-bpf.c:160:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:160:26: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:160:26: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:169:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/hid/hid-bpf.c:169:26: sparse:    struct bpf_prog *
   drivers/hid/hid-bpf.c:169:26: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/hid/hid-bpf.c:228:27: sparse: sparse: symbol 'hid_prog_ops' was not declared. Should it be static?
   drivers/hid/hid-bpf.c:243:23: sparse: sparse: symbol 'hid_bpf_add_report' was not declared. Should it be static?
   drivers/hid/hid-bpf.c:271:6: sparse: sparse: symbol 'hid_bpf_free_reports' was not declared. Should it be static?
   drivers/hid/hid-bpf.c:649:31: sparse: sparse: symbol 'hid_verifier_ops' was not declared. Should it be static?
>> drivers/hid/hid-bpf.c:696:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bpf_prog const *prog @@     got struct bpf_prog [noderef] __rcu *work_prog @@
   drivers/hid/hid-bpf.c:857:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bpf_prog const *prog @@     got struct bpf_prog [noderef] __rcu *rdesc_fixup_prog @@
   drivers/hid/hid-bpf.c:909:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bpf_prog *prog @@     got struct bpf_prog [noderef] __rcu *rdesc_fixup_prog @@

vim +696 drivers/hid/hid-bpf.c

   688	
   689	static void hid_bpf_work(struct work_struct *work)
   690	{
   691		struct hid_bpf_ctx *ctx =
   692			container_of(work, struct hid_bpf_ctx, work.work);
   693	
   694		migrate_disable();
   695	
 > 696		bpf_prog_run(ctx->hdev->bpf.work_prog, ctx);
   697	
   698		migrate_enable();
   699	}
   700	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
