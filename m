Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7CA4EB90F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbiC3Dua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbiC3Du0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:50:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13A410FD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648612121; x=1680148121;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tmChXMwz///A7QXHFK++/gQahDLQFhWJS+iOrjHlvbE=;
  b=iOZTk7IbNkSaIimhhfKpgVuQ5ThbfSd6Nr0U0AlSZyCJWkl3OzBMR1rM
   2/rAVy47bOobkBQR1au464q59Zhc6o6GDVDlD9ZnXpHp/mzFL5vBM7tgv
   rm+SxibxNbFMqNPscyoaaZfXb7k3eOHKp5/I6v1r4w31EFBgzPjL2kcdW
   I8XOHLNyamEa4/GAGRnGrH8WHZHO9punhYqUJJvsv1VH5QiWdqwv7DUyZ
   VbcyIMVsMvps7vJlX5VKVcTjxafpz2ejnVXELj1GZO+B9XOeV1xddYMwd
   b/jSEErtYLtW/O5xWj473Ju6fj0u/isKUYOBkvsvbGKvINg9PFr7mYzre
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259410256"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="259410256"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 20:48:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="565226972"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2022 20:48:39 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZPK3-0000xr-7e; Wed, 30 Mar 2022 03:48:39 +0000
Date:   Wed, 30 Mar 2022 11:48:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Xiao <xiaowei66@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof:sysctl-next 18/18] kernel/sysctl.c:1767:36: error: 'C_A_D'
 undeclared here (not in a function)
Message-ID: <202203301144.4U0W3gWI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-next
head:   84053cc7ef2f2f86caeea6a8c0944b2f0b3f33ca
commit: 84053cc7ef2f2f86caeea6a8c0944b2f0b3f33ca [18/18] ftrace: move sysctl_ftrace_enabled to ftrace.c
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220330/202203301144.4U0W3gWI-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=84053cc7ef2f2f86caeea6a8c0944b2f0b3f33ca
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof sysctl-next
        git checkout 84053cc7ef2f2f86caeea6a8c0944b2f0b3f33ca
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/sysctl.c:1767:36: error: 'C_A_D' undeclared here (not in a function)
    1767 |                 .data           = &C_A_D,
         |                                    ^~~~~


vim +/C_A_D +1767 kernel/sysctl.c

  1651	
  1652	static struct ctl_table kern_table[] = {
  1653	#ifdef CONFIG_NUMA_BALANCING
  1654		{
  1655			.procname	= "numa_balancing",
  1656			.data		= NULL, /* filled in by handler */
  1657			.maxlen		= sizeof(unsigned int),
  1658			.mode		= 0644,
  1659			.proc_handler	= sysctl_numa_balancing,
  1660			.extra1		= SYSCTL_ZERO,
  1661			.extra2		= SYSCTL_FOUR,
  1662		},
  1663	#endif /* CONFIG_NUMA_BALANCING */
  1664	#ifdef CONFIG_SCHED_AUTOGROUP
  1665		{
  1666			.procname	= "sched_autogroup_enabled",
  1667			.data		= &sysctl_sched_autogroup_enabled,
  1668			.maxlen		= sizeof(unsigned int),
  1669			.mode		= 0644,
  1670			.proc_handler	= proc_dointvec_minmax,
  1671			.extra1		= SYSCTL_ZERO,
  1672			.extra2		= SYSCTL_ONE,
  1673		},
  1674	#endif
  1675		{
  1676			.procname	= "panic",
  1677			.data		= &panic_timeout,
  1678			.maxlen		= sizeof(int),
  1679			.mode		= 0644,
  1680			.proc_handler	= proc_dointvec,
  1681		},
  1682	#ifdef CONFIG_PROC_SYSCTL
  1683		{
  1684			.procname	= "tainted",
  1685			.maxlen 	= sizeof(long),
  1686			.mode		= 0644,
  1687			.proc_handler	= proc_taint,
  1688		},
  1689		{
  1690			.procname	= "sysctl_writes_strict",
  1691			.data		= &sysctl_writes_strict,
  1692			.maxlen		= sizeof(int),
  1693			.mode		= 0644,
  1694			.proc_handler	= proc_dointvec_minmax,
  1695			.extra1		= SYSCTL_NEG_ONE,
  1696			.extra2		= SYSCTL_ONE,
  1697		},
  1698	#endif
  1699	#ifdef CONFIG_LATENCYTOP
  1700		{
  1701			.procname	= "latencytop",
  1702			.data		= &latencytop_enabled,
  1703			.maxlen		= sizeof(int),
  1704			.mode		= 0644,
  1705			.proc_handler	= sysctl_latencytop,
  1706		},
  1707	#endif
  1708		{
  1709			.procname	= "print-fatal-signals",
  1710			.data		= &print_fatal_signals,
  1711			.maxlen		= sizeof(int),
  1712			.mode		= 0644,
  1713			.proc_handler	= proc_dointvec,
  1714		},
  1715	#ifdef CONFIG_SPARC
  1716		{
  1717			.procname	= "reboot-cmd",
  1718			.data		= reboot_command,
  1719			.maxlen		= 256,
  1720			.mode		= 0644,
  1721			.proc_handler	= proc_dostring,
  1722		},
  1723		{
  1724			.procname	= "stop-a",
  1725			.data		= &stop_a_enabled,
  1726			.maxlen		= sizeof (int),
  1727			.mode		= 0644,
  1728			.proc_handler	= proc_dointvec,
  1729		},
  1730		{
  1731			.procname	= "scons-poweroff",
  1732			.data		= &scons_pwroff,
  1733			.maxlen		= sizeof (int),
  1734			.mode		= 0644,
  1735			.proc_handler	= proc_dointvec,
  1736		},
  1737	#endif
  1738	#ifdef CONFIG_SPARC64
  1739		{
  1740			.procname	= "tsb-ratio",
  1741			.data		= &sysctl_tsb_ratio,
  1742			.maxlen		= sizeof (int),
  1743			.mode		= 0644,
  1744			.proc_handler	= proc_dointvec,
  1745		},
  1746	#endif
  1747	#ifdef CONFIG_PARISC
  1748		{
  1749			.procname	= "soft-power",
  1750			.data		= &pwrsw_enabled,
  1751			.maxlen		= sizeof (int),
  1752			.mode		= 0644,
  1753			.proc_handler	= proc_dointvec,
  1754		},
  1755	#endif
  1756	#ifdef CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW
  1757		{
  1758			.procname	= "unaligned-trap",
  1759			.data		= &unaligned_enabled,
  1760			.maxlen		= sizeof (int),
  1761			.mode		= 0644,
  1762			.proc_handler	= proc_dointvec,
  1763		},
  1764	#endif
  1765		{
  1766			.procname	= "ctrl-alt-del",
> 1767			.data		= &C_A_D,
  1768			.maxlen		= sizeof(int),
  1769			.mode		= 0644,
  1770			.proc_handler	= proc_dointvec,
  1771		},
  1772	#ifdef CONFIG_STACK_TRACER
  1773		{
  1774			.procname	= "stack_tracer_enabled",
  1775			.data		= &stack_tracer_enabled,
  1776			.maxlen		= sizeof(int),
  1777			.mode		= 0644,
  1778			.proc_handler	= stack_trace_sysctl,
  1779		},
  1780	#endif
  1781	#ifdef CONFIG_TRACING
  1782		{
  1783			.procname	= "ftrace_dump_on_oops",
  1784			.data		= &ftrace_dump_on_oops,
  1785			.maxlen		= sizeof(int),
  1786			.mode		= 0644,
  1787			.proc_handler	= proc_dointvec,
  1788		},
  1789		{
  1790			.procname	= "traceoff_on_warning",
  1791			.data		= &__disable_trace_on_warning,
  1792			.maxlen		= sizeof(__disable_trace_on_warning),
  1793			.mode		= 0644,
  1794			.proc_handler	= proc_dointvec,
  1795		},
  1796		{
  1797			.procname	= "tracepoint_printk",
  1798			.data		= &tracepoint_printk,
  1799			.maxlen		= sizeof(tracepoint_printk),
  1800			.mode		= 0644,
  1801			.proc_handler	= tracepoint_printk_sysctl,
  1802		},
  1803	#endif
  1804	#ifdef CONFIG_KEXEC_CORE
  1805		{
  1806			.procname	= "kexec_load_disabled",
  1807			.data		= &kexec_load_disabled,
  1808			.maxlen		= sizeof(int),
  1809			.mode		= 0644,
  1810			/* only handle a transition from default "0" to "1" */
  1811			.proc_handler	= proc_dointvec_minmax,
  1812			.extra1		= SYSCTL_ONE,
  1813			.extra2		= SYSCTL_ONE,
  1814		},
  1815	#endif
  1816	#ifdef CONFIG_MODULES
  1817		{
  1818			.procname	= "modprobe",
  1819			.data		= &modprobe_path,
  1820			.maxlen		= KMOD_PATH_LEN,
  1821			.mode		= 0644,
  1822			.proc_handler	= proc_dostring,
  1823		},
  1824		{
  1825			.procname	= "modules_disabled",
  1826			.data		= &modules_disabled,
  1827			.maxlen		= sizeof(int),
  1828			.mode		= 0644,
  1829			/* only handle a transition from default "0" to "1" */
  1830			.proc_handler	= proc_dointvec_minmax,
  1831			.extra1		= SYSCTL_ONE,
  1832			.extra2		= SYSCTL_ONE,
  1833		},
  1834	#endif
  1835	#ifdef CONFIG_UEVENT_HELPER
  1836		{
  1837			.procname	= "hotplug",
  1838			.data		= &uevent_helper,
  1839			.maxlen		= UEVENT_HELPER_PATH_LEN,
  1840			.mode		= 0644,
  1841			.proc_handler	= proc_dostring,
  1842		},
  1843	#endif
  1844	#ifdef CONFIG_MAGIC_SYSRQ
  1845		{
  1846			.procname	= "sysrq",
  1847			.data		= NULL,
  1848			.maxlen		= sizeof (int),
  1849			.mode		= 0644,
  1850			.proc_handler	= sysrq_sysctl_handler,
  1851		},
  1852	#endif
  1853	#ifdef CONFIG_PROC_SYSCTL
  1854		{
  1855			.procname	= "cad_pid",
  1856			.data		= NULL,
  1857			.maxlen		= sizeof (int),
  1858			.mode		= 0600,
  1859			.proc_handler	= proc_do_cad_pid,
  1860		},
  1861	#endif
  1862		{
  1863			.procname	= "threads-max",
  1864			.data		= NULL,
  1865			.maxlen		= sizeof(int),
  1866			.mode		= 0644,
  1867			.proc_handler	= sysctl_max_threads,
  1868		},
  1869		{
  1870			.procname	= "usermodehelper",
  1871			.mode		= 0555,
  1872			.child		= usermodehelper_table,
  1873		},
  1874		{
  1875			.procname	= "overflowuid",
  1876			.data		= &overflowuid,
  1877			.maxlen		= sizeof(int),
  1878			.mode		= 0644,
  1879			.proc_handler	= proc_dointvec_minmax,
  1880			.extra1		= SYSCTL_ZERO,
  1881			.extra2		= SYSCTL_MAXOLDUID,
  1882		},
  1883		{
  1884			.procname	= "overflowgid",
  1885			.data		= &overflowgid,
  1886			.maxlen		= sizeof(int),
  1887			.mode		= 0644,
  1888			.proc_handler	= proc_dointvec_minmax,
  1889			.extra1		= SYSCTL_ZERO,
  1890			.extra2		= SYSCTL_MAXOLDUID,
  1891		},
  1892	#ifdef CONFIG_S390
  1893		{
  1894			.procname	= "userprocess_debug",
  1895			.data		= &show_unhandled_signals,
  1896			.maxlen		= sizeof(int),
  1897			.mode		= 0644,
  1898			.proc_handler	= proc_dointvec,
  1899		},
  1900	#endif
  1901		{
  1902			.procname	= "pid_max",
  1903			.data		= &pid_max,
  1904			.maxlen		= sizeof (int),
  1905			.mode		= 0644,
  1906			.proc_handler	= proc_dointvec_minmax,
  1907			.extra1		= &pid_max_min,
  1908			.extra2		= &pid_max_max,
  1909		},
  1910		{
  1911			.procname	= "panic_on_oops",
  1912			.data		= &panic_on_oops,
  1913			.maxlen		= sizeof(int),
  1914			.mode		= 0644,
  1915			.proc_handler	= proc_dointvec,
  1916		},
  1917		{
  1918			.procname	= "panic_print",
  1919			.data		= &panic_print,
  1920			.maxlen		= sizeof(unsigned long),
  1921			.mode		= 0644,
  1922			.proc_handler	= proc_doulongvec_minmax,
  1923		},
  1924		{
  1925			.procname	= "ngroups_max",
  1926			.data		= (void *)&ngroups_max,
  1927			.maxlen		= sizeof (int),
  1928			.mode		= 0444,
  1929			.proc_handler	= proc_dointvec,
  1930		},
  1931		{
  1932			.procname	= "cap_last_cap",
  1933			.data		= (void *)&cap_last_cap,
  1934			.maxlen		= sizeof(int),
  1935			.mode		= 0444,
  1936			.proc_handler	= proc_dointvec,
  1937		},
  1938	#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
  1939		{
  1940			.procname       = "unknown_nmi_panic",
  1941			.data           = &unknown_nmi_panic,
  1942			.maxlen         = sizeof (int),
  1943			.mode           = 0644,
  1944			.proc_handler   = proc_dointvec,
  1945		},
  1946	#endif
  1947	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
