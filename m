Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7F74EDA1E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiCaNCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiCaNCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:02:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFCC1A6373
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648731613; x=1680267613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NrbE2Fu6qin+cBpDb/9/JkXlaserqB+2eKhtL+f1T/4=;
  b=EDR7wI10O2apTDSt8mj3YXg5S3D9iUvEI4AY/2mFkcl1axGp4PfqddVb
   l3xuDGdbeEf7VqDPVu6Raz7I1x5AGi8ahXgHyjeZU0vXdx57MvF5dO6BG
   dCnhY0KFt8z/oyeIrwu1ZOwFBoLPaZW7qhm5IEkrOE1TwEngZpu2j+49A
   9PdrUgEQNId+H+PqiqW2psrElklCjKdkzryk00U25IXOJ2mHOcaqARBI1
   dRg9e3TlWEpShDqEf2e7Vql5nI9FMuNoENa6WRv15M4szGq7HnV7AjhSd
   MxLy6OIPkT6l0Sj4EFONLk1FIN21BKwCeFzdiEylGmCqZW3KTGFwMT5te
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="284749543"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="284749543"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 06:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="522335459"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2022 06:00:10 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZuPK-0000Gm-5P;
        Thu, 31 Mar 2022 13:00:10 +0000
Date:   Thu, 31 Mar 2022 20:59:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 29/122] arch/arm64/kernel/stacktrace.c:289:13:
 error: implicit declaration of function 'task_scs' is invalid in C99
Message-ID: <202203312049.zLjHyetm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   074b4ea9811e2c47ae1ecada177629c19fa56d59
commit: 8cdc580c5ca2ffecb0db4f84a99167ef763a21cc [29/122] arm64: implement stack_trace_save_shadow
config: arm64-randconfig-r012-20220331 (https://download.01.org/0day-ci/archive/20220331/202203312049.zLjHyetm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 881350a92d821d4f8e4fa648443ed1d17e251188)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/hnaz/linux-mm/commit/8cdc580c5ca2ffecb0db4f84a99167ef763a21cc
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout 8cdc580c5ca2ffecb0db4f84a99167ef763a21cc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> arch/arm64/kernel/stacktrace.c:289:13: error: implicit declaration of function 'task_scs' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           scs_base = task_scs(current);
                      ^
>> arch/arm64/kernel/stacktrace.c:289:11: warning: incompatible integer to pointer conversion assigning to 'unsigned long *' from 'int' [-Wint-conversion]
           scs_base = task_scs(current);
                    ^ ~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/task_scs +289 arch/arm64/kernel/stacktrace.c

   260	
   261	noinline notrace int arch_stack_walk_shadow(unsigned long *store,
   262						    unsigned int size,
   263						    unsigned int skipnr)
   264	{
   265		unsigned long *scs_top, *scs_base, *scs_next;
   266		unsigned int len = 0, part;
   267	
   268		preempt_disable();
   269	
   270		/* Get the SCS pointer. */
   271		asm volatile("mov %0, x18" : "=&r" (scs_top));
   272	
   273		/* The top SCS slot is empty. */
   274		scs_top -= 1;
   275	
   276		/* Handle SDEI and hardirq frames. */
   277		for (part = 0; part < ARRAY_SIZE(scs_parts); part++) {
   278			scs_next = *this_cpu_ptr(scs_parts[part].saved);
   279			if (scs_next) {
   280				scs_base = *this_cpu_ptr(scs_parts[part].base);
   281				if (walk_shadow_stack_part(scs_top, scs_base, store,
   282							   size, &skipnr, &len))
   283					goto out;
   284				scs_top = scs_next;
   285			}
   286		}
   287	
   288		/* Handle task and softirq frames. */
 > 289		scs_base = task_scs(current);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
