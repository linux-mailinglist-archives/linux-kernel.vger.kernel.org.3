Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A349B2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355871AbiAYL0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:26:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:52767 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382145AbiAYLY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643109897; x=1674645897;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2DAAwyjGF3VJU1MTs4VLIJXtwINfvdA/C1fdAO95sw4=;
  b=TSb++vYx+KWw4ikdPXq61hotaU/LAS1Ygpq2p+/nrIBl7zSmSc/xLGKz
   FpLhM5gOpDsXfA2ckAKFdRZKA7NRTDc359ZliUSgU1rgM0WStsD6gRiSK
   L+Tf0GsgId93DcnOQTQaNiNq6oeu+aytvVzj1RQPa3lWAjyhUuEHRECR/
   ahrrSmInVOKxGe3IxOY7dcIS3Rby4nwodRsdsUF8zyf5dxSTBHgenSEWz
   ZTKh2NNs9Tc4fJSPXcpdntBGDjU81LqSByPMa7ugdYQsOYMmp8lk0QBAY
   6CMLVGP0JOcnjx32YYHgW6TgkoPfdQb0+6fGXnogfJ2SlktEW8W68EftY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226257036"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="226257036"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 03:24:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="695801754"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Jan 2022 03:24:51 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCJwQ-000JoT-Qk; Tue, 25 Jan 2022 11:24:50 +0000
Date:   Tue, 25 Jan 2022 19:24:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>,
        Tyler Hicks <code@tyhicks.com>,
        Kees Cook <keescook@chromium.org>,
        Jeff Vander Stoep <jeffv@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.4
 3638/9999] kernel/seccomp.c:2041:41: sparse: sparse: incorrect type in
 argument 3 (different address spaces)
Message-ID: <202201251943.TPk8Y7Ob-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.4
head:   3307e1a058380163f1a11c8f7632706168f9fcb1
commit: 5444477e8a4d31f6e6ff720c2d018d06e405bcc1 [3638/9999] UPSTREAM: seccomp: Remove bogus __user annotations
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220125/202201251943.TPk8Y7Ob-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/5444477e8a4d31f6e6ff720c2d018d06e405bcc1
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.4
        git checkout 5444477e8a4d31f6e6ff720c2d018d06e405bcc1
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/seccomp.c:2041:41: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void *buffer @@
   kernel/seccomp.c:2041:41: sparse:     expected void [noderef] <asn:1> *
   kernel/seccomp.c:2041:41: sparse:     got void *buffer
   kernel/seccomp.c:2059:40: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void [noderef] <asn:1> * @@     got void *buffer @@
   kernel/seccomp.c:2059:40: sparse:     expected void [noderef] <asn:1> *
   kernel/seccomp.c:2059:40: sparse:     got void *buffer
>> kernel/seccomp.c:2115:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *buffer @@     got void [noderef] <asn:1> *buffer @@
   kernel/seccomp.c:2115:54: sparse:     expected void *buffer
   kernel/seccomp.c:2115:54: sparse:     got void [noderef] <asn:1> *buffer
   kernel/seccomp.c:2119:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *buffer @@     got void [noderef] <asn:1> *buffer @@
   kernel/seccomp.c:2119:53: sparse:     expected void *buffer
   kernel/seccomp.c:2119:53: sparse:     got void [noderef] <asn:1> *buffer

vim +2041 kernel/seccomp.c

0ddec0fc890020 Tyler Hicks 2017-08-11  2025  
5444477e8a4d31 Jann Horn   2020-11-20  2026  static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
d013db029491b4 Tyler Hicks 2018-05-04  2027  			       size_t *lenp, loff_t *ppos)
0ddec0fc890020 Tyler Hicks 2017-08-11  2028  {
0ddec0fc890020 Tyler Hicks 2017-08-11  2029  	char names[sizeof(seccomp_actions_avail)];
0ddec0fc890020 Tyler Hicks 2017-08-11  2030  	struct ctl_table table;
0ddec0fc890020 Tyler Hicks 2017-08-11  2031  
0ddec0fc890020 Tyler Hicks 2017-08-11  2032  	memset(names, 0, sizeof(names));
0ddec0fc890020 Tyler Hicks 2017-08-11  2033  
0ddec0fc890020 Tyler Hicks 2017-08-11  2034  	if (!seccomp_names_from_actions_logged(names, sizeof(names),
beb44acaf000c9 Tyler Hicks 2018-05-04  2035  					       seccomp_actions_logged, " "))
0ddec0fc890020 Tyler Hicks 2017-08-11  2036  		return -EINVAL;
d013db029491b4 Tyler Hicks 2018-05-04  2037  
d013db029491b4 Tyler Hicks 2018-05-04  2038  	table = *ro_table;
d013db029491b4 Tyler Hicks 2018-05-04  2039  	table.data = names;
d013db029491b4 Tyler Hicks 2018-05-04  2040  	table.maxlen = sizeof(names);
d013db029491b4 Tyler Hicks 2018-05-04 @2041  	return proc_dostring(&table, 0, buffer, lenp, ppos);
0ddec0fc890020 Tyler Hicks 2017-08-11  2042  }
0ddec0fc890020 Tyler Hicks 2017-08-11  2043  
5444477e8a4d31 Jann Horn   2020-11-20  2044  static int write_actions_logged(struct ctl_table *ro_table, void *buffer,
ea6eca778500b0 Tyler Hicks 2018-05-04  2045  				size_t *lenp, loff_t *ppos, u32 *actions_logged)
d013db029491b4 Tyler Hicks 2018-05-04  2046  {
d013db029491b4 Tyler Hicks 2018-05-04  2047  	char names[sizeof(seccomp_actions_avail)];
d013db029491b4 Tyler Hicks 2018-05-04  2048  	struct ctl_table table;
d013db029491b4 Tyler Hicks 2018-05-04  2049  	int ret;
d013db029491b4 Tyler Hicks 2018-05-04  2050  
d013db029491b4 Tyler Hicks 2018-05-04  2051  	if (!capable(CAP_SYS_ADMIN))
d013db029491b4 Tyler Hicks 2018-05-04  2052  		return -EPERM;
d013db029491b4 Tyler Hicks 2018-05-04  2053  
d013db029491b4 Tyler Hicks 2018-05-04  2054  	memset(names, 0, sizeof(names));
d013db029491b4 Tyler Hicks 2018-05-04  2055  
0ddec0fc890020 Tyler Hicks 2017-08-11  2056  	table = *ro_table;
0ddec0fc890020 Tyler Hicks 2017-08-11  2057  	table.data = names;
0ddec0fc890020 Tyler Hicks 2017-08-11  2058  	table.maxlen = sizeof(names);
d013db029491b4 Tyler Hicks 2018-05-04  2059  	ret = proc_dostring(&table, 1, buffer, lenp, ppos);
0ddec0fc890020 Tyler Hicks 2017-08-11  2060  	if (ret)
0ddec0fc890020 Tyler Hicks 2017-08-11  2061  		return ret;
0ddec0fc890020 Tyler Hicks 2017-08-11  2062  
ea6eca778500b0 Tyler Hicks 2018-05-04  2063  	if (!seccomp_actions_logged_from_names(actions_logged, table.data))
0ddec0fc890020 Tyler Hicks 2017-08-11  2064  		return -EINVAL;
0ddec0fc890020 Tyler Hicks 2017-08-11  2065  
ea6eca778500b0 Tyler Hicks 2018-05-04  2066  	if (*actions_logged & SECCOMP_LOG_ALLOW)
0ddec0fc890020 Tyler Hicks 2017-08-11  2067  		return -EINVAL;
0ddec0fc890020 Tyler Hicks 2017-08-11  2068  
ea6eca778500b0 Tyler Hicks 2018-05-04  2069  	seccomp_actions_logged = *actions_logged;
d013db029491b4 Tyler Hicks 2018-05-04  2070  	return 0;
0ddec0fc890020 Tyler Hicks 2017-08-11  2071  }
0ddec0fc890020 Tyler Hicks 2017-08-11  2072  
ea6eca778500b0 Tyler Hicks 2018-05-04  2073  static void audit_actions_logged(u32 actions_logged, u32 old_actions_logged,
ea6eca778500b0 Tyler Hicks 2018-05-04  2074  				 int ret)
ea6eca778500b0 Tyler Hicks 2018-05-04  2075  {
ea6eca778500b0 Tyler Hicks 2018-05-04  2076  	char names[sizeof(seccomp_actions_avail)];
ea6eca778500b0 Tyler Hicks 2018-05-04  2077  	char old_names[sizeof(seccomp_actions_avail)];
ea6eca778500b0 Tyler Hicks 2018-05-04  2078  	const char *new = names;
ea6eca778500b0 Tyler Hicks 2018-05-04  2079  	const char *old = old_names;
ea6eca778500b0 Tyler Hicks 2018-05-04  2080  
ea6eca778500b0 Tyler Hicks 2018-05-04  2081  	if (!audit_enabled)
ea6eca778500b0 Tyler Hicks 2018-05-04  2082  		return;
ea6eca778500b0 Tyler Hicks 2018-05-04  2083  
ea6eca778500b0 Tyler Hicks 2018-05-04  2084  	memset(names, 0, sizeof(names));
ea6eca778500b0 Tyler Hicks 2018-05-04  2085  	memset(old_names, 0, sizeof(old_names));
ea6eca778500b0 Tyler Hicks 2018-05-04  2086  
ea6eca778500b0 Tyler Hicks 2018-05-04  2087  	if (ret)
ea6eca778500b0 Tyler Hicks 2018-05-04  2088  		new = "?";
ea6eca778500b0 Tyler Hicks 2018-05-04  2089  	else if (!actions_logged)
ea6eca778500b0 Tyler Hicks 2018-05-04  2090  		new = "(none)";
ea6eca778500b0 Tyler Hicks 2018-05-04  2091  	else if (!seccomp_names_from_actions_logged(names, sizeof(names),
ea6eca778500b0 Tyler Hicks 2018-05-04  2092  						    actions_logged, ","))
ea6eca778500b0 Tyler Hicks 2018-05-04  2093  		new = "?";
ea6eca778500b0 Tyler Hicks 2018-05-04  2094  
ea6eca778500b0 Tyler Hicks 2018-05-04  2095  	if (!old_actions_logged)
ea6eca778500b0 Tyler Hicks 2018-05-04  2096  		old = "(none)";
ea6eca778500b0 Tyler Hicks 2018-05-04  2097  	else if (!seccomp_names_from_actions_logged(old_names,
ea6eca778500b0 Tyler Hicks 2018-05-04  2098  						    sizeof(old_names),
ea6eca778500b0 Tyler Hicks 2018-05-04  2099  						    old_actions_logged, ","))
ea6eca778500b0 Tyler Hicks 2018-05-04  2100  		old = "?";
ea6eca778500b0 Tyler Hicks 2018-05-04  2101  
ea6eca778500b0 Tyler Hicks 2018-05-04  2102  	return audit_seccomp_actions_logged(new, old, !ret);
ea6eca778500b0 Tyler Hicks 2018-05-04  2103  }
ea6eca778500b0 Tyler Hicks 2018-05-04  2104  
d013db029491b4 Tyler Hicks 2018-05-04  2105  static int seccomp_actions_logged_handler(struct ctl_table *ro_table, int write,
d013db029491b4 Tyler Hicks 2018-05-04  2106  					  void __user *buffer, size_t *lenp,
d013db029491b4 Tyler Hicks 2018-05-04  2107  					  loff_t *ppos)
d013db029491b4 Tyler Hicks 2018-05-04  2108  {
ea6eca778500b0 Tyler Hicks 2018-05-04  2109  	int ret;
ea6eca778500b0 Tyler Hicks 2018-05-04  2110  
ea6eca778500b0 Tyler Hicks 2018-05-04  2111  	if (write) {
ea6eca778500b0 Tyler Hicks 2018-05-04  2112  		u32 actions_logged = 0;
ea6eca778500b0 Tyler Hicks 2018-05-04  2113  		u32 old_actions_logged = seccomp_actions_logged;
ea6eca778500b0 Tyler Hicks 2018-05-04  2114  
ea6eca778500b0 Tyler Hicks 2018-05-04 @2115  		ret = write_actions_logged(ro_table, buffer, lenp, ppos,
ea6eca778500b0 Tyler Hicks 2018-05-04  2116  					   &actions_logged);
ea6eca778500b0 Tyler Hicks 2018-05-04  2117  		audit_actions_logged(actions_logged, old_actions_logged, ret);
ea6eca778500b0 Tyler Hicks 2018-05-04  2118  	} else
ea6eca778500b0 Tyler Hicks 2018-05-04  2119  		ret = read_actions_logged(ro_table, buffer, lenp, ppos);
ea6eca778500b0 Tyler Hicks 2018-05-04  2120  
ea6eca778500b0 Tyler Hicks 2018-05-04  2121  	return ret;
0ddec0fc890020 Tyler Hicks 2017-08-11  2122  }
0ddec0fc890020 Tyler Hicks 2017-08-11  2123  

:::::: The code at line 2041 was first introduced by commit
:::::: d013db029491b49e1459d5a55ecd9ec1be1447ca seccomp: Separate read and write code for actions_logged sysctl

:::::: TO: Tyler Hicks <tyhicks@canonical.com>
:::::: CC: Paul Moore <paul@paul-moore.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
