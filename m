Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A040546621
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347199AbiFJLzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347183AbiFJLzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:55:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EFD25E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654862140; x=1686398140;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1aFYvO3gKG91AJpe7s7pE6RHbODPsUTIADYEyMjTuHA=;
  b=aPtsX7Z+zl7Ry5e6dwzotX6iXNWI2FPoYzXTr+g8DcrGnISzkWcDisjr
   PjGqaLevagw9S+RDWNJJP+Bb7Bh9HM970aceTzhDU12PWFX0OAM/bqEfD
   AK5WAzgS+sLNtqKnmTWs1wD4k/pWOkCTLfAO5kA7LEL4YtDcOBzCqs/aj
   gl+0uezMdP4xDmXtfy/K/FYdLD75qTDVDFexVZpZK9w+CJCwqdFcY4vCq
   eP3K3Xx3jcOAo2joTFrdGYkDjVl78IYiVZMpV+N3CBcpAqQfnSZSQf9ua
   yEVavamNzQzYtKhjDdf6bmbM9Wt1GrtpdEsby+ALNmTAjF+SlcN3tiSb0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="260725116"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="260725116"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 04:55:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="638101204"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2022 04:55:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzdEo-000Hvh-8Q;
        Fri, 10 Jun 2022 11:55:38 +0000
Date:   Fri, 10 Jun 2022 19:55:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 6/8] arch/x86/kernel/process_64.c:745:5: warning: no
 previous prototype for 'prctl_enable_tagged_addr'
Message-ID: <202206101916.IklgUdbQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   83ba389477b29461f0c926b69deca5eb6f3f5b6a
commit: 91934401d053c31ea7851a9e88fa83b9fa5a7bc4 [6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and ARCH_ENABLE_TAGGED_ADDR
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220610/202206101916.IklgUdbQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=91934401d053c31ea7851a9e88fa83b9fa5a7bc4
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout 91934401d053c31ea7851a9e88fa83b9fa5a7bc4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/process_64.c:745:5: warning: no previous prototype for 'prctl_enable_tagged_addr' [-Wmissing-prototypes]
     745 | int prctl_enable_tagged_addr(unsigned long nr_bits)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/prctl_enable_tagged_addr +745 arch/x86/kernel/process_64.c

   744	
 > 745	int prctl_enable_tagged_addr(unsigned long nr_bits)
   746	{
   747		struct mm_struct *mm = current->mm;
   748	
   749		/* Already enabled? */
   750		if (mm->context.lam_cr3_mask)
   751			return -EBUSY;
   752	
   753		/* LAM has to be enabled before spawning threads */
   754		if (get_nr_threads(current) > 1)
   755			return -EBUSY;
   756	
   757		if (!nr_bits) {
   758			return -EINVAL;
   759		} else if (nr_bits <= 6) {
   760			mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
   761			mm->context.untag_mask =  ~GENMASK(62, 57);
   762		} else {
   763			return -EINVAL;
   764		}
   765	
   766		/* Update CR3 to get LAM active */
   767		switch_mm(current->mm, current->mm, current);
   768		return 0;
   769	}
   770	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
