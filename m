Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1656A5B0D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiIGTcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIGTca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:32:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FABBD4EC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662579149; x=1694115149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Bbr27ZZsqeXv7M+kbngATqDVVDUO8d+b6Aa8czXF0Vs=;
  b=FmZCGB7N56M1DvIOy2YxItJTIyp+OYJk4079hPxzGtyJ5IjXNyZb8fBg
   MNr1sjt+EuwuOw8UgT2d6y+LjnsoYYRC7Zy8/XjXcXENOoVRD0ap0MybD
   423Az9OotRQ28IYz4ujplenKXnDvA/CG5kw+11J9Rxij26cesgSwA2Nsj
   wnN5X5CTC/ssMh9vdIgzotuRZ23ZxeyRvqG3yAufVMusm8CBFhss9P5R5
   a6Vjojm2yIkIFvCXtl6bfHZEPDY7iogEL/0M+p88NL1nUHsU5O8Nej+31
   Nthp57iD1T6eCrTkuat3nVJXcq3SCJau616v/U7CQp4VeGao9PHodXHe9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="358712057"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="358712057"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="591850374"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Sep 2022 12:32:27 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW0mg-0006tZ-1q;
        Wed, 07 Sep 2022 19:32:26 +0000
Date:   Thu, 8 Sep 2022 03:32:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:sched/psi 11/11] kernel/cgroup/cgroup.c:3819:4: error:
 implicit declaration of function 'cgroup_file_show' is invalid in C99
Message-ID: <202209080327.r83nfBI5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/psi
head:   d79e9c758a62dfe7e3472dbf99400c2774ba51f2
commit: d79e9c758a62dfe7e3472dbf99400c2774ba51f2 [11/11] sched/psi: Per-cgroup PSI accounting disable/re-enable interface
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220908/202209080327.r83nfBI5-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=d79e9c758a62dfe7e3472dbf99400c2774ba51f2
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/psi
        git checkout d79e9c758a62dfe7e3472dbf99400c2774ba51f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/cgroup/cgroup.c:3819:4: error: implicit declaration of function 'cgroup_file_show' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                           cgroup_file_show(&cgrp->psi_files[i], enable);
                           ^
   kernel/cgroup/cgroup.c:3819:4: note: did you mean 'cgroup_type_show'?
   kernel/cgroup/cgroup.c:3511:12: note: 'cgroup_type_show' declared here
   static int cgroup_type_show(struct seq_file *seq, void *v)
              ^
   1 error generated.


vim +/cgroup_file_show +3819 kernel/cgroup/cgroup.c

  3792	
  3793	static ssize_t cgroup_pressure_write(struct kernfs_open_file *of,
  3794					     char *buf, size_t nbytes,
  3795					     loff_t off)
  3796	{
  3797		ssize_t ret;
  3798		int enable;
  3799		struct cgroup *cgrp;
  3800		struct psi_group *psi;
  3801	
  3802		ret = kstrtoint(strstrip(buf), 0, &enable);
  3803		if (ret)
  3804			return ret;
  3805	
  3806		if (enable < 0 || enable > 1)
  3807			return -ERANGE;
  3808	
  3809		cgrp = cgroup_kn_lock_live(of->kn, false);
  3810		if (!cgrp)
  3811			return -ENOENT;
  3812	
  3813		psi = cgroup_psi(cgrp);
  3814		if (psi->enabled != enable) {
  3815			int i;
  3816	
  3817			/* show or hide {cpu,memory,io,irq}.pressure files */
  3818			for (i = 0; i < NR_PSI_RESOURCES; i++)
> 3819				cgroup_file_show(&cgrp->psi_files[i], enable);
  3820	
  3821			psi->enabled = enable;
  3822			if (enable)
  3823				psi_cgroup_restart(psi);
  3824		}
  3825	
  3826		cgroup_kn_unlock(of->kn);
  3827	
  3828		return nbytes;
  3829	}
  3830	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
