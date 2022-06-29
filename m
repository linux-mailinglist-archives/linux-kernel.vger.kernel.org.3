Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEFC55F3AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 05:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiF2DCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 23:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiF2DCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:02:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BB4326F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 20:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656471767; x=1688007767;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0++YnCsdzThbYAeNtjJWL49iZVYi+kscJOPR0gF8MTw=;
  b=d0FuJ0h39VDS8j7s+dzNcvIygTixyZ8wNjQjHKBQth+V3+mhnDqvkTwe
   idLSFXj6kiArH8DUPM56BePdceO2rjp/enukVnUnh3eYiGljWsrqKzB8G
   lq57sxNM6/7lwstrUZW4DXlRpYNlEVcCAYTpxo8Xs+76TnvAFVJMRtnL+
   h5LewGeZpFlZGwOnPkQNCC4vsBN0ZE10b3enu6S5nUKsRzxvoCgfboPSn
   X+SK9p7eTnkC0ZsT8LIBlMHlcFYRhnoic7P/yc40iy3iRylwHKQZYR3oR
   H9TgI+uzw+RjwDlKbDob0jqNH4bdIaTSri5i3uAehVDBtc0s4t9xaIzvg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="307394617"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="307394617"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 20:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="658378147"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2022 20:02:45 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6NyX-000Ar6-36;
        Wed, 29 Jun 2022 03:02:45 +0000
Date:   Wed, 29 Jun 2022 11:02:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     kbuild-all@lists.01.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [gfs2:nopid 1/5] fs/gfs2/glock.c:2759:36: error: implicit
 declaration of function 'task_active_pid_ns'
Message-ID: <202206291026.52o1nw9J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git nopid
head:   b1d0ed94e881ca5b5aee15e05f13db75445398f2
commit: 13ba8572506201aa85020970f776597fbcdcda56 [1/5] gfs2: Add glockfd debugfs file
config: csky-randconfig-r025-20220627 (https://download.01.org/0day-ci/archive/20220629/202206291026.52o1nw9J-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?id=13ba8572506201aa85020970f776597fbcdcda56
        git remote add gfs2 https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
        git fetch --no-tags gfs2 nopid
        git checkout 13ba8572506201aa85020970f776597fbcdcda56
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/gfs2/glock.c: In function 'gfs2_glockfd_next_task':
>> fs/gfs2/glock.c:2759:36: error: implicit declaration of function 'task_active_pid_ns' [-Werror=implicit-function-declaration]
    2759 |         struct pid_namespace *ns = task_active_pid_ns(current);
         |                                    ^~~~~~~~~~~~~~~~~~
   fs/gfs2/glock.c:2759:36: warning: initialization of 'struct pid_namespace *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   fs/gfs2/glock.c: In function 'gfs2_glockfd_next_file':
>> fs/gfs2/glock.c:2785:17: error: implicit declaration of function 'fput'; did you mean 'iput'? [-Werror=implicit-function-declaration]
    2785 |                 fput(i->file);
         |                 ^~~~
         |                 iput
   cc1: some warnings being treated as errors


vim +/task_active_pid_ns +2759 fs/gfs2/glock.c

  2756	
  2757	static struct task_struct *gfs2_glockfd_next_task(struct gfs2_glockfd_iter *i)
  2758	{
> 2759		struct pid_namespace *ns = task_active_pid_ns(current);
  2760		struct pid *pid;
  2761	
  2762		if (i->task)
  2763			put_task_struct(i->task);
  2764	
  2765		rcu_read_lock();
  2766	retry:
  2767		i->task = NULL;
  2768		pid = find_ge_pid(i->tgid, ns);
  2769		if (pid) {
  2770			i->tgid = pid_nr_ns(pid, ns);
  2771			i->task = pid_task(pid, PIDTYPE_TGID);
  2772			if (!i->task) {
  2773				i->tgid++;
  2774				goto retry;
  2775			}
  2776			get_task_struct(i->task);
  2777		}
  2778		rcu_read_unlock();
  2779		return i->task;
  2780	}
  2781	
  2782	static struct file *gfs2_glockfd_next_file(struct gfs2_glockfd_iter *i)
  2783	{
  2784		if (i->file) {
> 2785			fput(i->file);
  2786			i->file = NULL;
  2787		}
  2788	
  2789		rcu_read_lock();
  2790		for(;; i->fd++) {
  2791			struct inode *inode;
  2792	
  2793			i->file = task_lookup_next_fd_rcu(i->task, &i->fd);
  2794			if (!i->file) {
  2795				i->fd = 0;
  2796				break;
  2797			}
  2798			inode = file_inode(i->file);
  2799			if (inode->i_sb != i->sb)
  2800				continue;
  2801			if (get_file_rcu(i->file))
  2802				break;
  2803		}
  2804		rcu_read_unlock();
  2805		return i->file;
  2806	}
  2807	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
