Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2354EF6D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353512AbiDAPpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354593AbiDAPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:12:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2E827857D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648824924; x=1680360924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sRq3aNuvvoADqxpwEnycoxwbNQ9AKtJA/e+GBeJ1okI=;
  b=KeDGfBz4lkkUn3IzpcW/cRYvTSItzwRDoItJs0Db+ORQfQLCkYsyfbRy
   OlE/50Xld4/cjvZ1C5QsLcCMQzngfNbqWiRL9MQNzBAAjT3xjj1wei6XH
   z+hFi7P635E5wSbqe3LNbkrpvsJ9fdmjXkrEPuGntsh366AcSHT74utBY
   boTMZIewNZWLpzsi2t1CiCxFl9Td1NJwPTGt3eLTkk1zf6EDVQQ4O9w3l
   sdFRn+msHpUQxQfNHIzuBBOduDVqc0rCwxXQRKf8hk2BuwuoENffyS+GB
   XM60HGGdYO7anwcmuYAYll9JBdkzwUg5cA+SKdZdnEXvBPqsKYEujmBfx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="257733422"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="257733422"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 07:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="522799890"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2022 07:55:14 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naIgE-0001KK-4h;
        Fri, 01 Apr 2022 14:55:14 +0000
Date:   Fri, 1 Apr 2022 22:54:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Francis <alistair.francis@wdc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>
Subject: [ammarfaizi2-block:palmer/linux/riscv-asidlen 1/1]
 arch/riscv/mm/context.c:308:45: error: 'mm_context_t' has no member named
 'id'
Message-ID: <202204012242.MvKAyz37-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-asidlen
head:   bdfae0d4f28854d02d1f78fcb18b41d01ae32832
commit: bdfae0d4f28854d02d1f78fcb18b41d01ae32832 [1/1] riscv: Ensure only ASIDLEN is used for sfence.vma
config: riscv-nommu_k210_defconfig (https://download.01.org/0day-ci/archive/20220401/202204012242.MvKAyz37-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/bdfae0d4f28854d02d1f78fcb18b41d01ae32832
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-asidlen
        git checkout bdfae0d4f28854d02d1f78fcb18b41d01ae32832
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/mm/context.c: In function 'get_mm_asid':
>> arch/riscv/mm/context.c:308:45: error: 'mm_context_t' has no member named 'id'
     308 |         return atomic_long_read(&mm->context.id) & asid_mask;
         |                                             ^
>> arch/riscv/mm/context.c:308:52: error: 'asid_mask' undeclared (first use in this function); did you mean 'pid_task'?
     308 |         return atomic_long_read(&mm->context.id) & asid_mask;
         |                                                    ^~~~~~~~~
         |                                                    pid_task
   arch/riscv/mm/context.c:308:52: note: each undeclared identifier is reported only once for each function it appears in
   arch/riscv/mm/context.c:309:1: error: control reaches end of non-void function [-Werror=return-type]
     309 | }
         | ^
   cc1: some warnings being treated as errors


vim +308 arch/riscv/mm/context.c

   305	
   306	unsigned long get_mm_asid(struct mm_struct *mm)
   307	{
 > 308		return atomic_long_read(&mm->context.id) & asid_mask;
   309	}
   310	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
