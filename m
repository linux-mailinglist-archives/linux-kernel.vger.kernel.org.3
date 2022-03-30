Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D094EC69B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346899AbiC3OfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346893AbiC3Oe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:34:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB241633
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648650791; x=1680186791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pH8MCjX6TgaYkZK9C3rAQKysjdwFETF6IZxfRb5mEb0=;
  b=FRrlEj6jXq3uncmd+1rfnFcmcQsPwuv4up7W/N0V60YrHSuHEmu577FO
   vBuafpgHOWotTMsXNT3LQnP0GTJbce584DZMkLiErNcIkO1jV/G3k+uUV
   frEJLyUNddwG+Sze+dJYdal37u5Q/UZkiJFTTHzTPL3A4bCTbbqvs32mS
   YcqXLlazpq/YkjE+lkFlTxX4kv3Ecn7vFRMlStwrgrfve629QYhP8vPP8
   +o8RYRGh/jE3dfo8gcsLaUR5wfjOvN+aK8LIxNC6vl5F7zwa7QH6hYArA
   Sp4PesiFfpW/Gy6v3wfNkeo8Wk00qk6/+7zVPh7TdesacNieKHZLAo/Pl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="258387515"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="258387515"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:33:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="546883498"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Mar 2022 07:33:09 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZZNk-00004w-JB;
        Wed, 30 Mar 2022 14:33:08 +0000
Date:   Wed, 30 Mar 2022 22:32:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: arch/sparc/kernel/process_64.c:677:5: error: no previous prototype
 for 'arch_dup_task_struct'
Message-ID: <202203302224.qSPZdQcq-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d888c83fcec75194a8a48ccd283953bdba7b2550
commit: 74a04967482faa7144b93dae3b2e913870dd421c sparc64: Add support for ADI (Application Data Integrity)
date:   4 years ago
config: sparc64-randconfig-r004-20220330 (https://download.01.org/0day-ci/archive/20220330/202203302224.qSPZdQcq-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=74a04967482faa7144b93dae3b2e913870dd421c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 74a04967482faa7144b93dae3b2e913870dd421c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash M=arch/sparc/kernel

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/sparc/kernel/process_64.c:677:5: error: no previous prototype for 'arch_dup_task_struct' [-Werror=missing-prototypes]
     677 | int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
         |     ^~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/sparc/kernel/adi_64.c:125:21: error: no previous prototype for 'find_tag_store' [-Werror=missing-prototypes]
     125 | tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
         |                     ^~~~~~~~~~~~~~
   arch/sparc/kernel/adi_64.c:157:21: error: no previous prototype for 'alloc_tag_store' [-Werror=missing-prototypes]
     157 | tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
         |                     ^~~~~~~~~~~~~~~
   arch/sparc/kernel/adi_64.c:300:6: error: no previous prototype for 'del_tag_store' [-Werror=missing-prototypes]
     300 | void del_tag_store(tag_storage_desc_t *tag_desc, struct mm_struct *mm)
         |      ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/arch_dup_task_struct +677 arch/sparc/kernel/process_64.c

   672	
   673	/* TIF_MCDPER in thread info flags for current task is updated lazily upon
   674	 * a context switch. Update this flag in current task's thread flags
   675	 * before dup so the dup'd task will inherit the current TIF_MCDPER flag.
   676	 */
 > 677	int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
   678	{
   679		if (adi_capable()) {
   680			register unsigned long tmp_mcdper;
   681	
   682			__asm__ __volatile__(
   683				".word 0x83438000\n\t"	/* rd  %mcdper, %g1 */
   684				"mov %%g1, %0\n\t"
   685				: "=r" (tmp_mcdper)
   686				:
   687				: "g1");
   688			if (tmp_mcdper)
   689				set_thread_flag(TIF_MCDPER);
   690			else
   691				clear_thread_flag(TIF_MCDPER);
   692		}
   693	
   694		*dst = *src;
   695		return 0;
   696	}
   697	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
