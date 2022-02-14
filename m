Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120CE4B3EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 01:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbiBNA4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 19:56:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiBNA4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 19:56:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBAA522E0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644800183; x=1676336183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tM6quFDWh1DffEf5fGn7mC4OV/Rs8yLeC5XqZpHkVlA=;
  b=VRJfo8t2TzcXp8Gyf1/pcAI6zA+7fS8eJCvL9yFd3XHXIB2QiTAuTcuw
   Dj7o8GeAKfw+xTlDPzmhO9xyM+J70NNhvLrT9KzSnecWAXM8w89ndFvLb
   fiGnNqwuJNQpjWBOaMpGkkkHTfb8jMzfVaUz/XWXE2WXvyfyB6pDIk+IH
   +xLi1iuAQQFrTAB95TKW/ilK1BnYl5cRyME9mepBgZISQz2IYpcfsDNi4
   xxxiW9blAz+wtkNF/eV1Y4ThL9yzBv7PB8q6x9sNOWEI9vK0FyixPYn30
   wgBs8LQ/jbkt8AL8UxWeXn/Nw0wmECJ4gbM0Bo2qLpBeT02mRjHcC+CBZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="248818256"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="248818256"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 16:56:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="527759431"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Feb 2022 16:56:22 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJPfB-00083B-Eg; Mon, 14 Feb 2022 00:56:21 +0000
Date:   Mon, 14 Feb 2022 08:55:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [arnd-playground:set_fs 6/11] arch/arc/kernel/process.c:63:15:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <202202140815.nUkV6yfz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git set_fs
head:   2a0bc55bf1de54742196464620860bbc46592f11
commit: e7e49ac844a31b9eebb95e85b0e20696aa646280 [6/11] uaccess: generalize access_ok()
config: arc-randconfig-s031-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140815.nUkV6yfz-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=e7e49ac844a31b9eebb95e85b0e20696aa646280
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground set_fs
        git checkout e7e49ac844a31b9eebb95e85b0e20696aa646280
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash arch/arc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arc/kernel/process.c:63:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got int *uaddr @@
   arch/arc/kernel/process.c:63:15: sparse:     expected void const [noderef] __user *ptr
   arch/arc/kernel/process.c:63:15: sparse:     got int *uaddr
   arch/arc/kernel/process.c:70:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *uaddr @@
   arch/arc/kernel/process.c:70:15: sparse:     expected void const volatile [noderef] __user *ptr
   arch/arc/kernel/process.c:70:15: sparse:     got int *uaddr
   arch/arc/kernel/process.c:77:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *uaddr @@
   arch/arc/kernel/process.c:77:15: sparse:     expected void const volatile [noderef] __user *ptr
   arch/arc/kernel/process.c:77:15: sparse:     got int *uaddr

vim +63 arch/arc/kernel/process.c

bf90e1eab682dc Vineet Gupta      2013-01-18   45  
91e040a79df73d Vineet Gupta      2016-10-20   46  SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
91e040a79df73d Vineet Gupta      2016-10-20   47  {
e6e335bf3a400b Vineet Gupta      2016-11-07   48  	struct pt_regs *regs = current_pt_regs();
e8708786d4fe21 Peter Zijlstra    2018-06-19   49  	u32 uval;
e8708786d4fe21 Peter Zijlstra    2018-06-19   50  	int ret;
91e040a79df73d Vineet Gupta      2016-10-20   51  
91e040a79df73d Vineet Gupta      2016-10-20   52  	/*
f79f7a2d96769d Bhaskar Chowdhury 2021-03-22   53  	 * This is only for old cores lacking LLOCK/SCOND, which by definition
91e040a79df73d Vineet Gupta      2016-10-20   54  	 * can't possibly be SMP. Thus doesn't need to be SMP safe.
91e040a79df73d Vineet Gupta      2016-10-20   55  	 * And this also helps reduce the overhead for serializing in
91e040a79df73d Vineet Gupta      2016-10-20   56  	 * the UP case
91e040a79df73d Vineet Gupta      2016-10-20   57  	 */
91e040a79df73d Vineet Gupta      2016-10-20   58  	WARN_ON_ONCE(IS_ENABLED(CONFIG_SMP));
91e040a79df73d Vineet Gupta      2016-10-20   59  
f79f7a2d96769d Bhaskar Chowdhury 2021-03-22   60  	/* Z indicates to userspace if operation succeeded */
e6e335bf3a400b Vineet Gupta      2016-11-07   61  	regs->status32 &= ~STATUS_Z_MASK;
e6e335bf3a400b Vineet Gupta      2016-11-07   62  
96d4f267e40f95 Linus Torvalds    2019-01-03  @63  	ret = access_ok(uaddr, sizeof(*uaddr));
e8708786d4fe21 Peter Zijlstra    2018-06-19   64  	if (!ret)
e8708786d4fe21 Peter Zijlstra    2018-06-19   65  		 goto fail;
91e040a79df73d Vineet Gupta      2016-10-20   66  
e8708786d4fe21 Peter Zijlstra    2018-06-19   67  again:
91e040a79df73d Vineet Gupta      2016-10-20   68  	preempt_disable();
91e040a79df73d Vineet Gupta      2016-10-20   69  
e8708786d4fe21 Peter Zijlstra    2018-06-19   70  	ret = __get_user(uval, uaddr);
e8708786d4fe21 Peter Zijlstra    2018-06-19   71  	if (ret)
e8708786d4fe21 Peter Zijlstra    2018-06-19   72  		 goto fault;
e8708786d4fe21 Peter Zijlstra    2018-06-19   73  
e8708786d4fe21 Peter Zijlstra    2018-06-19   74  	if (uval != expected)
e8708786d4fe21 Peter Zijlstra    2018-06-19   75  		 goto out;
e8708786d4fe21 Peter Zijlstra    2018-06-19   76  
e8708786d4fe21 Peter Zijlstra    2018-06-19   77  	ret = __put_user(new, uaddr);
e8708786d4fe21 Peter Zijlstra    2018-06-19   78  	if (ret)
e8708786d4fe21 Peter Zijlstra    2018-06-19   79  		 goto fault;
91e040a79df73d Vineet Gupta      2016-10-20   80  
e6e335bf3a400b Vineet Gupta      2016-11-07   81  	regs->status32 |= STATUS_Z_MASK;
91e040a79df73d Vineet Gupta      2016-10-20   82  
e8708786d4fe21 Peter Zijlstra    2018-06-19   83  out:
91e040a79df73d Vineet Gupta      2016-10-20   84  	preempt_enable();
e6e335bf3a400b Vineet Gupta      2016-11-07   85  	return uval;
e8708786d4fe21 Peter Zijlstra    2018-06-19   86  
e8708786d4fe21 Peter Zijlstra    2018-06-19   87  fault:
e8708786d4fe21 Peter Zijlstra    2018-06-19   88  	preempt_enable();
e8708786d4fe21 Peter Zijlstra    2018-06-19   89  
e8708786d4fe21 Peter Zijlstra    2018-06-19   90  	if (unlikely(ret != -EFAULT))
e8708786d4fe21 Peter Zijlstra    2018-06-19   91  		 goto fail;
e8708786d4fe21 Peter Zijlstra    2018-06-19   92  
d8ed45c5dcd455 Michel Lespinasse 2020-06-08   93  	mmap_read_lock(current->mm);
64019a2e467a28 Peter Xu          2020-08-11   94  	ret = fixup_user_fault(current->mm, (unsigned long) uaddr,
e8708786d4fe21 Peter Zijlstra    2018-06-19   95  			       FAULT_FLAG_WRITE, NULL);
d8ed45c5dcd455 Michel Lespinasse 2020-06-08   96  	mmap_read_unlock(current->mm);
e8708786d4fe21 Peter Zijlstra    2018-06-19   97  
e8708786d4fe21 Peter Zijlstra    2018-06-19   98  	if (likely(!ret))
e8708786d4fe21 Peter Zijlstra    2018-06-19   99  		 goto again;
e8708786d4fe21 Peter Zijlstra    2018-06-19  100  
e8708786d4fe21 Peter Zijlstra    2018-06-19  101  fail:
3cf5d076fb4d48 Eric W. Biederman 2019-05-23  102  	force_sig(SIGSEGV);
e8708786d4fe21 Peter Zijlstra    2018-06-19  103  	return ret;
91e040a79df73d Vineet Gupta      2016-10-20  104  }
91e040a79df73d Vineet Gupta      2016-10-20  105  

:::::: The code at line 63 was first introduced by commit
:::::: 96d4f267e40f9509e8a66e2b39e8b95655617693 Remove 'type' argument from access_ok() function

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
