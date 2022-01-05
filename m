Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351634855AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbiAEPSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:18:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:6784 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241246AbiAEPRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641395868; x=1672931868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1NcRYDLPyMeiPzV/YtB/iU7nC50xaDwNMEdQMJFCW1Q=;
  b=YjRzaCd2QWaszlxWlqyuTyPIt5MJgCtBQEXAnvjiq5B0Zu8gR2zBbPre
   rc3U4v16DJhLKKgzJKYfLPKWI9xNtRVVmcaemv64N2MIxx9VJ3o+OO48p
   9zcK+5knQS1wObaEyoBGKl0K6hAm1qKFMGBffb4moXr/FeZctUoPHOZJf
   XlvqZ57OThq9UHEAgoPFEBHTpsiMXqnQZa7zXPna9CcdbH2Zn5axC9yJf
   09yn8iGLz7LX5r/jmK619AQjxljBknioZbVzWd/xWJ6JPiQTerNysXvmu
   C60DtZqsJD/Ne0dKGRzGEmr9ZQPcI+m/zMXpNJ8p2AZPfvG/Tb8SWDQtx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="223146628"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="223146628"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 07:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="611500727"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jan 2022 07:17:44 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n582q-000Gmo-0B; Wed, 05 Jan 2022 15:17:44 +0000
Date:   Wed, 5 Jan 2022 23:17:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:kprobe/multi 4/14] kernel/kprobes.c:1721:10: error:
 implicit declaration of function 'check_ftrace_multi'
Message-ID: <202201052322.kMqJ0XlX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git kprobe/multi
head:   27d253a29de023f664387fcc049edeeaadf23c8e
commit: fbf6ec1e4f8e6c1fed1e1d14f16595e2dc01902d [4/14] kprobe: Add support to register multiple ftrace kprobes
config: i386-randconfig-r021-20220105 (https://download.01.org/0day-ci/archive/20220105/202201052322.kMqJ0XlX-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=fbf6ec1e4f8e6c1fed1e1d14f16595e2dc01902d
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf kprobe/multi
        git checkout fbf6ec1e4f8e6c1fed1e1d14f16595e2dc01902d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/kprobes.c:23:
   include/linux/kprobes.h:77:21: error: field has incomplete type 'struct ftrace_ops'
                   struct ftrace_ops ops;
                                     ^
   include/linux/ftrace.h:332:8: note: forward declaration of 'struct ftrace_ops'
   struct ftrace_ops;
          ^
>> kernel/kprobes.c:1721:10: error: implicit declaration of function 'check_ftrace_multi' [-Werror,-Wimplicit-function-declaration]
                   return check_ftrace_multi(p);
                          ^
>> kernel/kprobes.c:1916:3: error: implicit declaration of function 'free_ftrace_multi' [-Werror,-Wimplicit-function-declaration]
                   free_ftrace_multi(ap);
                   ^
   kernel/kprobes.c:1916:3: note: did you mean 'kprobe_ftrace_multi'?
   include/linux/kprobes.h:145:20: note: 'kprobe_ftrace_multi' declared here
   static inline bool kprobe_ftrace_multi(struct kprobe *p)
                      ^
   3 errors generated.


vim +/check_ftrace_multi +1721 kernel/kprobes.c

  1713	
  1714	static int check_addr(struct kprobe *p, struct module **probed_mod)
  1715	{
  1716		int ret;
  1717		kprobe_opcode_t *addr;
  1718	
  1719	#ifdef CONFIG_HAVE_KPROBES_MULTI_ON_FTRACE
  1720		if (p->multi.cnt)
> 1721			return check_ftrace_multi(p);
  1722	#endif
  1723	
  1724		/* Adjust probe address from symbol */
  1725		addr = kprobe_addr(p);
  1726		if (IS_ERR(addr))
  1727			return PTR_ERR(addr);
  1728		p->addr = addr;
  1729		p->func_addr = resolve_func_addr(addr);
  1730	
  1731		ret = warn_kprobe_rereg(p);
  1732		if (ret)
  1733			return ret;
  1734		return check_kprobe_address_safe(p, probed_mod);
  1735	}
  1736	
  1737	int register_kprobe(struct kprobe *p)
  1738	{
  1739		struct module *probed_mod = NULL;
  1740		struct kprobe *old_p;
  1741		int ret;
  1742	
  1743		/* User can pass only KPROBE_FLAG_DISABLED to register_kprobe */
  1744		p->flags &= KPROBE_FLAG_DISABLED;
  1745		p->nmissed = 0;
  1746		INIT_LIST_HEAD(&p->list);
  1747	
  1748		ret = check_addr(p, &probed_mod);
  1749		if (ret)
  1750			return ret;
  1751	
  1752		mutex_lock(&kprobe_mutex);
  1753	
  1754		old_p = get_kprobe(p->addr);
  1755		if (old_p) {
  1756			/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
  1757			ret = register_aggr_kprobe(old_p, p);
  1758			goto out;
  1759		}
  1760	
  1761		cpus_read_lock();
  1762		/* Prevent text modification */
  1763		mutex_lock(&text_mutex);
  1764		ret = prepare_kprobe(p);
  1765		mutex_unlock(&text_mutex);
  1766		cpus_read_unlock();
  1767		if (ret)
  1768			goto out;
  1769	
  1770		/*
  1771		 * Multi ftrace kprobes do not have single address,
  1772		 * so they are not stored in the kprobe_table hash.
  1773		 */
  1774		if (kprobe_single(p)) {
  1775			INIT_HLIST_NODE(&p->hlist);
  1776			hlist_add_head_rcu(&p->hlist,
  1777				       &kprobe_table[hash_ptr(p->addr, KPROBE_HASH_BITS)]);
  1778		}
  1779	
  1780		if (!kprobes_all_disarmed && !kprobe_disabled(p)) {
  1781			ret = arm_kprobe(p);
  1782			if (ret) {
  1783				if (kprobe_single(p))
  1784					hlist_del_rcu(&p->hlist);
  1785				synchronize_rcu();
  1786				goto out;
  1787			}
  1788		}
  1789	
  1790		/* Try to optimize kprobe */
  1791		try_to_optimize_kprobe(p);
  1792	out:
  1793		mutex_unlock(&kprobe_mutex);
  1794	
  1795		if (probed_mod)
  1796			module_put(probed_mod);
  1797	
  1798		return ret;
  1799	}
  1800	EXPORT_SYMBOL_GPL(register_kprobe);
  1801	
  1802	/* Check if all probes on the 'ap' are disabled. */
  1803	static bool aggr_kprobe_disabled(struct kprobe *ap)
  1804	{
  1805		struct kprobe *kp;
  1806	
  1807		lockdep_assert_held(&kprobe_mutex);
  1808	
  1809		list_for_each_entry(kp, &ap->list, list)
  1810			if (!kprobe_disabled(kp))
  1811				/*
  1812				 * Since there is an active probe on the list,
  1813				 * we can't disable this 'ap'.
  1814				 */
  1815				return false;
  1816	
  1817		return true;
  1818	}
  1819	
  1820	static struct kprobe *__disable_kprobe(struct kprobe *p)
  1821	{
  1822		struct kprobe *orig_p;
  1823		int ret;
  1824	
  1825		lockdep_assert_held(&kprobe_mutex);
  1826	
  1827		/* Get an original kprobe for return */
  1828		orig_p = __get_valid_kprobe(p);
  1829		if (unlikely(orig_p == NULL))
  1830			return ERR_PTR(-EINVAL);
  1831	
  1832		if (!kprobe_disabled(p)) {
  1833			/* Disable probe if it is a child probe */
  1834			if (p != orig_p)
  1835				p->flags |= KPROBE_FLAG_DISABLED;
  1836	
  1837			/* Try to disarm and disable this/parent probe */
  1838			if (p == orig_p || aggr_kprobe_disabled(orig_p)) {
  1839				/*
  1840				 * If 'kprobes_all_disarmed' is set, 'orig_p'
  1841				 * should have already been disarmed, so
  1842				 * skip unneed disarming process.
  1843				 */
  1844				if (!kprobes_all_disarmed) {
  1845					ret = disarm_kprobe(orig_p, true);
  1846					if (ret) {
  1847						p->flags &= ~KPROBE_FLAG_DISABLED;
  1848						return ERR_PTR(ret);
  1849					}
  1850				}
  1851				orig_p->flags |= KPROBE_FLAG_DISABLED;
  1852			}
  1853		}
  1854	
  1855		return orig_p;
  1856	}
  1857	
  1858	/*
  1859	 * Unregister a kprobe without a scheduler synchronization.
  1860	 */
  1861	static int __unregister_kprobe_top(struct kprobe *p)
  1862	{
  1863		struct kprobe *ap, *list_p;
  1864	
  1865		/* Disable kprobe. This will disarm it if needed. */
  1866		ap = __disable_kprobe(p);
  1867		if (IS_ERR(ap))
  1868			return PTR_ERR(ap);
  1869	
  1870		if (ap == p)
  1871			/*
  1872			 * This probe is an independent(and non-optimized) kprobe
  1873			 * (not an aggrprobe). Remove from the hash list.
  1874			 */
  1875			goto disarmed;
  1876	
  1877		/* Following process expects this probe is an aggrprobe */
  1878		WARN_ON(!kprobe_aggrprobe(ap));
  1879	
  1880		if (list_is_singular(&ap->list) && kprobe_disarmed(ap))
  1881			/*
  1882			 * !disarmed could be happen if the probe is under delayed
  1883			 * unoptimizing.
  1884			 */
  1885			goto disarmed;
  1886		else {
  1887			/* If disabling probe has special handlers, update aggrprobe */
  1888			if (p->post_handler && !kprobe_gone(p)) {
  1889				list_for_each_entry(list_p, &ap->list, list) {
  1890					if ((list_p != p) && (list_p->post_handler))
  1891						goto noclean;
  1892				}
  1893				ap->post_handler = NULL;
  1894			}
  1895	noclean:
  1896			/*
  1897			 * Remove from the aggrprobe: this path will do nothing in
  1898			 * __unregister_kprobe_bottom().
  1899			 */
  1900			list_del_rcu(&p->list);
  1901			if (!kprobe_disabled(ap) && !kprobes_all_disarmed)
  1902				/*
  1903				 * Try to optimize this probe again, because post
  1904				 * handler may have been changed.
  1905				 */
  1906				optimize_kprobe(ap);
  1907		}
  1908		return 0;
  1909	
  1910	disarmed:
  1911		if (kprobe_single(ap))
  1912			hlist_del_rcu(&ap->hlist);
  1913	
  1914	#ifdef CONFIG_HAVE_KPROBES_MULTI_ON_FTRACE
  1915		if (kprobe_ftrace_multi(ap))
> 1916			free_ftrace_multi(ap);
  1917	#endif
  1918		return 0;
  1919	}
  1920	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
