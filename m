Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491E8473B92
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhLNDgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:36:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:61774 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231394AbhLNDgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639452971; x=1670988971;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9X8UG/PSAPJSzARcUocrqkjaC+u7jpUig5cjawHTfbk=;
  b=BORURE/aQaERREie7FnVo92eUYhZ6O2xg+3oiUbHmqTmi8iNMcW8Zyhz
   1C4/LlBXX248rVL3upZSZSvB5CmrQoHqTwicLGO5w7NJFCQiOI8nSK860
   x3WJNkJpbern8aRsX9GnMJU0HOLuWFR0Ht1k43RCEwYtJicQCoeJprSpW
   A7BQbrW86Gjvgc60c6B3/TmHM5YC3fIplkF6IqkQqBQIjSBn/B+3zw+hC
   Jh258ooIV6XM62yJz7ZgeSu9sy+fX2L++ydRni56Z2yC/0EH4mNhLKgHN
   d0fSCSPohReQFOztlKx1WueYmoxDj3aZzgD+ToF9kRGep8NCToFz0lOyR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="218903900"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="218903900"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 19:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="481754784"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Dec 2021 19:36:08 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwybn-0007O9-E3; Tue, 14 Dec 2021 03:36:07 +0000
Date:   Tue, 14 Dec 2021 11:35:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next 27/33] kernel/rcu/tree.c:1180:19: warning:
 variable 'rnp' set but not used
Message-ID: <202112141117.jFtY2VyL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
head:   a4b57ded94e522e2870ae9504f776caa0f615148
commit: ee418df93691657d27f6118d1ff8f681c52f4aa3 [27/33] rcu: Create and use a rcu_rdp_cpu_online()
config: i386-randconfig-s001-20211213 (https://download.01.org/0day-ci/archive/20211214/202112141117.jFtY2VyL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=ee418df93691657d27f6118d1ff8f681c52f4aa3
        git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags paulmck-rcu rcu/next
        git checkout ee418df93691657d27f6118d1ff8f681c52f4aa3
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/rcu/tree.c: In function 'rcu_lockdep_current_cpu_online':
>> kernel/rcu/tree.c:1180:19: warning: variable 'rnp' set but not used [-Wunused-but-set-variable]
    1180 |  struct rcu_node *rnp;
         |                   ^~~


vim +/rnp +1180 kernel/rcu/tree.c

c0d6d01bffdce1 kernel/rcutree.c  Paul E. McKenney 2012-01-23  1163  
c0d6d01bffdce1 kernel/rcutree.c  Paul E. McKenney 2012-01-23  1164  /*
5554788e1d4253 kernel/rcu/tree.c Paul E. McKenney 2018-05-15  1165   * Is the current CPU online as far as RCU is concerned?
2036d94a7b61ca kernel/rcutree.c  Paul E. McKenney 2012-01-30  1166   *
5554788e1d4253 kernel/rcu/tree.c Paul E. McKenney 2018-05-15  1167   * Disable preemption to avoid false positives that could otherwise
5554788e1d4253 kernel/rcu/tree.c Paul E. McKenney 2018-05-15  1168   * happen due to the current CPU number being sampled, this task being
5554788e1d4253 kernel/rcu/tree.c Paul E. McKenney 2018-05-15  1169   * preempted, its old CPU being taken offline, resuming on some other CPU,
49918a54e63c99 kernel/rcu/tree.c Paul E. McKenney 2018-07-07  1170   * then determining that its old CPU is now offline.
c0d6d01bffdce1 kernel/rcutree.c  Paul E. McKenney 2012-01-23  1171   *
5554788e1d4253 kernel/rcu/tree.c Paul E. McKenney 2018-05-15  1172   * Disable checking if in an NMI handler because we cannot safely
5554788e1d4253 kernel/rcu/tree.c Paul E. McKenney 2018-05-15  1173   * report errors from NMI handlers anyway.  In addition, it is OK to use
5554788e1d4253 kernel/rcu/tree.c Paul E. McKenney 2018-05-15  1174   * RCU on an offline processor during initial boot, hence the check for
5554788e1d4253 kernel/rcu/tree.c Paul E. McKenney 2018-05-15  1175   * rcu_scheduler_fully_active.
c0d6d01bffdce1 kernel/rcutree.c  Paul E. McKenney 2012-01-23  1176   */
c0d6d01bffdce1 kernel/rcutree.c  Paul E. McKenney 2012-01-23  1177  bool rcu_lockdep_current_cpu_online(void)
c0d6d01bffdce1 kernel/rcutree.c  Paul E. McKenney 2012-01-23  1178  {
2036d94a7b61ca kernel/rcutree.c  Paul E. McKenney 2012-01-30  1179  	struct rcu_data *rdp;
2036d94a7b61ca kernel/rcutree.c  Paul E. McKenney 2012-01-30 @1180  	struct rcu_node *rnp;
b97d23c51c9fee kernel/rcu/tree.c Paul E. McKenney 2018-07-04  1181  	bool ret = false;
c0d6d01bffdce1 kernel/rcutree.c  Paul E. McKenney 2012-01-23  1182  
5554788e1d4253 kernel/rcu/tree.c Paul E. McKenney 2018-05-15  1183  	if (in_nmi() || !rcu_scheduler_fully_active)
f6f7ee9af7554e kernel/rcu/tree.c Fengguang Wu     2013-10-10  1184  		return true;
ff5c4f5cad3306 kernel/rcu/tree.c Thomas Gleixner  2020-03-13  1185  	preempt_disable_notrace();
da1df50d16171f kernel/rcu/tree.c Paul E. McKenney 2018-07-03  1186  	rdp = this_cpu_ptr(&rcu_data);
2036d94a7b61ca kernel/rcutree.c  Paul E. McKenney 2012-01-30  1187  	rnp = rdp->mynode;
defd1f8a1f4efe kernel/rcu/tree.c David Woodhouse  2021-02-16  1188  	/*
defd1f8a1f4efe kernel/rcu/tree.c David Woodhouse  2021-02-16  1189  	 * Strictly, we care here about the case where the current CPU is
defd1f8a1f4efe kernel/rcu/tree.c David Woodhouse  2021-02-16  1190  	 * in rcu_cpu_starting() and thus has an excuse for rdp->grpmask
defd1f8a1f4efe kernel/rcu/tree.c David Woodhouse  2021-02-16  1191  	 * not being up to date. So arch_spin_is_locked() might have a
defd1f8a1f4efe kernel/rcu/tree.c David Woodhouse  2021-02-16  1192  	 * false positive if it's held by some *other* CPU, but that's
defd1f8a1f4efe kernel/rcu/tree.c David Woodhouse  2021-02-16  1193  	 * OK because that just means a false *negative* on the warning.
defd1f8a1f4efe kernel/rcu/tree.c David Woodhouse  2021-02-16  1194  	 */
ee418df9369165 kernel/rcu/tree.c Paul E. McKenney 2021-12-10  1195  	if (rcu_rdp_cpu_online(rdp) || arch_spin_is_locked(&rcu_state.ofl_lock))
b97d23c51c9fee kernel/rcu/tree.c Paul E. McKenney 2018-07-04  1196  		ret = true;
ff5c4f5cad3306 kernel/rcu/tree.c Thomas Gleixner  2020-03-13  1197  	preempt_enable_notrace();
b97d23c51c9fee kernel/rcu/tree.c Paul E. McKenney 2018-07-04  1198  	return ret;
c0d6d01bffdce1 kernel/rcutree.c  Paul E. McKenney 2012-01-23  1199  }
c0d6d01bffdce1 kernel/rcutree.c  Paul E. McKenney 2012-01-23  1200  EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
c0d6d01bffdce1 kernel/rcutree.c  Paul E. McKenney 2012-01-23  1201  

:::::: The code at line 1180 was first introduced by commit
:::::: 2036d94a7b61ca5032ce90f2bda06afec0fe713e rcu: Rework detection of use of RCU by offline CPUs

:::::: TO: Paul E. McKenney <paul.mckenney@linaro.org>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
