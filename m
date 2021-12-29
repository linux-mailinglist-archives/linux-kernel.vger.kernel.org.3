Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170AE48102E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 06:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhL2Fqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 00:46:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:58759 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234367AbhL2Fqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 00:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640756809; x=1672292809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BzpfcYpGQ7Fy2FRD7W1rbRF21I0SyxFzQnTKksrCJDY=;
  b=k4fZWIUzLCL6e04BDbcPrkGLQBY8wHgF1WK9Nkvz5ZK7VhBi0pj9m4Pc
   t4Ot/jmpC29hxBR6sQb9Ew4LnBqqwshrxYOeLMFbB+G/hAtQhe7srikv3
   b3b3V1c29jGYIcFujLi7BeC6eDPoK4B5c/MQhYUCddqRA+YuFIAHVQZHH
   Um35Ad/FerQ9R5xUNaogT6+13i45u4TPiQ3mhX9cRQ92OQ7e1pLTkf8Ow
   G1/13cmiijp8Zyh5Z1l/BmM6nIeLzBrtJC1gtIN13fsZMXoQQ6DhuORy8
   dtXne4InbqE5Y80id8ECwmhqnlZB3/GTRS88mViXtfU0iJ1QHOQ+9orB+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="240252432"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="240252432"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 21:46:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="470223998"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Dec 2021 21:46:47 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2RnS-0008aC-Q7; Wed, 29 Dec 2021 05:46:46 +0000
Date:   Wed, 29 Dec 2021 13:46:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:kprobe/multi 4/13] kernel/kprobes.c:1757:9: error: no
 member named 'multi' in 'struct kprobe'
Message-ID: <202112291313.NBZhynh0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git kprobe/multi
head:   774280c9bc95e4e50cda3cd09324bd03fec50b52
commit: b20ae58e76fd39a4b63168d1b8b97db3a45c5680 [4/13] kprobe: Add support to register multiple ftrace kprobes
config: riscv-buildonly-randconfig-r006-20211228 (https://download.01.org/0day-ci/archive/20211229/202112291313.NBZhynh0-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7171af744543433ac75b232eb7dfdaef7efd4d7a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=b20ae58e76fd39a4b63168d1b8b97db3a45c5680
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf kprobe/multi
        git checkout b20ae58e76fd39a4b63168d1b8b97db3a45c5680
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/kprobes.c:1757:9: error: no member named 'multi' in 'struct kprobe'
           if (p->multi.cnt)
               ~  ^
   kernel/kprobes.c:1989:12: warning: no previous prototype for function 'kprobe_exceptions_notify' [-Wmissing-prototypes]
   int __weak kprobe_exceptions_notify(struct notifier_block *self,
              ^
   kernel/kprobes.c:1989:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __weak kprobe_exceptions_notify(struct notifier_block *self,
   ^
   static 
   1 warning and 1 error generated.


vim +1757 kernel/kprobes.c

  1745	
  1746	int register_kprobe(struct kprobe *p)
  1747	{
  1748		struct module *probed_mod = NULL;
  1749		struct kprobe *old_p;
  1750		int ret;
  1751	
  1752		/* User can pass only KPROBE_FLAG_DISABLED to register_kprobe */
  1753		p->flags &= KPROBE_FLAG_DISABLED;
  1754		p->nmissed = 0;
  1755		INIT_LIST_HEAD(&p->list);
  1756	
> 1757		if (p->multi.cnt)
  1758			ret = check_ftrace_multi(p);
  1759		else
  1760			ret = check_addr(p, &probed_mod);
  1761		if (ret)
  1762			return ret;
  1763	
  1764		mutex_lock(&kprobe_mutex);
  1765	
  1766		old_p = get_kprobe(p->addr);
  1767		if (old_p) {
  1768			/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
  1769			ret = register_aggr_kprobe(old_p, p);
  1770			goto out;
  1771		}
  1772	
  1773		cpus_read_lock();
  1774		/* Prevent text modification */
  1775		mutex_lock(&text_mutex);
  1776		ret = prepare_kprobe(p);
  1777		mutex_unlock(&text_mutex);
  1778		cpus_read_unlock();
  1779		if (ret)
  1780			goto out;
  1781	
  1782		/*
  1783		 * Multi ftrace kprobes do not have single address,
  1784		 * so they are not stored in the kprobe_table hash.
  1785		 */
  1786		if (kprobe_single(p)) {
  1787			INIT_HLIST_NODE(&p->hlist);
  1788			hlist_add_head_rcu(&p->hlist,
  1789				       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
  1790		}
  1791	
  1792		if (!kprobes_all_disarmed && !kprobe_disabled(p)) {
  1793			ret = arm_kprobe(p);
  1794			if (ret) {
  1795				if (kprobe_single(p))
  1796					hlist_del_rcu(&p->hlist);
  1797				synchronize_rcu();
  1798				goto out;
  1799			}
  1800		}
  1801	
  1802		/* Try to optimize kprobe */
  1803		try_to_optimize_kprobe(p);
  1804	out:
  1805		mutex_unlock(&kprobe_mutex);
  1806	
  1807		if (probed_mod)
  1808			module_put(probed_mod);
  1809	
  1810		return ret;
  1811	}
  1812	EXPORT_SYMBOL_GPL(register_kprobe);
  1813	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
