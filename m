Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45204CAE7B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbiCBTS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbiCBTSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:18:18 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0D25E8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646248653; x=1677784653;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gPj7MvWo8UszOjBjUPqRuH9Y8l5KgFcyHPQGUBxuQzo=;
  b=d8PZks5KOw4kJB1EnmXT602zPmZb/TgyTJeZRJ9phnJT3kMlHRA4bdi2
   4NZQH3NYJPL45TItsYYJtflAe8ml6IrWpVsCG1kkRilm3y0Y8O+HjcA1B
   L9U951WotTAxYMxkRw9bGqYTSpZ24h8ep8I6WoBXT34597UCkWAZcOJEP
   2nElnbfJWAxUIBsHlnH5pfUx4a8yE5wasKLbx7hXd3NPFzevKy/42TJiS
   VEa0IXiUvWmhFq+oDfk5+Nu/KY8/3c5X9BboUkz/Z2ztOuQWgh70nwa3Y
   Ga5WPxmwjpX2PJbOzr2AINsilPdhJKZdhTJs5lr9AYV6+4AWrsHxyjVmh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="314205402"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="314205402"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 11:17:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="609314140"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2022 11:17:31 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPUTb-0001nq-3w; Wed, 02 Mar 2022 19:17:31 +0000
Date:   Thu, 3 Mar 2022 03:16:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/deprecated/android-4.14-p-release
 137/6167] security/commoncap.c:75:5: warning: no previous declaration for
 '__cap_capable'
Message-ID: <202203030333.1rYTj1jB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/deprecated/android-4.14-p-release
head:   0ca5d5ac9152d01b3494fb2efb5390319eb9904a
commit: 2b02b4ab89b9cba5aec936046d8538962c5142fc [137/6167] ANDROID: net: paranoid: commoncap: Begin to warn users of implicit PARANOID_NETWORK capability grants
config: arm-zeus_defconfig (https://download.01.org/0day-ci/archive/20220303/202203030333.1rYTj1jB-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2b02b4ab89b9cba5aec936046d8538962c5142fc
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/deprecated/android-4.14-p-release
        git checkout 2b02b4ab89b9cba5aec936046d8538962c5142fc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> security/commoncap.c:75:5: warning: no previous declaration for '__cap_capable' [-Wmissing-declarations]
    int __cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
        ^~~~~~~~~~~~~
   In file included from include/linux/capability.h:16:0,
                    from security/commoncap.c:10:
   security/commoncap.c: In function 'cap_prctl_drop':
   include/uapi/linux/capability.h:372:27: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
                              ^
   security/commoncap.c:1112:7: note: in expansion of macro 'cap_valid'
     if (!cap_valid(cap))
          ^~~~~~~~~
   security/commoncap.c: In function 'cap_task_prctl':
   include/uapi/linux/capability.h:372:27: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
                              ^
   security/commoncap.c:1142:8: note: in expansion of macro 'cap_valid'
      if (!cap_valid(arg2))
           ^~~~~~~~~
   include/uapi/linux/capability.h:372:27: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
                              ^
   security/commoncap.c:1226:10: note: in expansion of macro 'cap_valid'
      if (((!cap_valid(arg3)) | arg4 | arg5))
             ^~~~~~~~~


vim +/__cap_capable +75 security/commoncap.c

    59	
    60	/**
    61	 * __cap_capable - Determine whether a task has a particular effective capability
    62	 * @cred: The credentials to use
    63	 * @ns:  The user namespace in which we need the capability
    64	 * @cap: The capability to check for
    65	 * @audit: Whether to write an audit message or not
    66	 *
    67	 * Determine whether the nominated task has the specified capability amongst
    68	 * its effective set, returning 0 if it does, -ve if it does not.
    69	 *
    70	 * NOTE WELL: cap_has_capability() cannot be used like the kernel's capable()
    71	 * and has_capability() functions.  That is, it has the reverse semantics:
    72	 * cap_has_capability() returns 0 when a task has a capability, but the
    73	 * kernel's capable() and has_capability() returns 1 for this case.
    74	 */
  > 75	int __cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
    76			int cap, int audit)
    77	{
    78		struct user_namespace *ns = targ_ns;
    79	
    80		/* See if cred has the capability in the target user namespace
    81		 * by examining the target user namespace and all of the target
    82		 * user namespace's parents.
    83		 */
    84		for (;;) {
    85			/* Do we have the necessary capabilities? */
    86			if (ns == cred->user_ns)
    87				return cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;
    88	
    89			/*
    90			 * If we're already at a lower level than we're looking for,
    91			 * we're done searching.
    92			 */
    93			if (ns->level <= cred->user_ns->level)
    94				return -EPERM;
    95	
    96			/* 
    97			 * The owner of the user namespace in the parent of the
    98			 * user namespace has all caps.
    99			 */
   100			if ((ns->parent == cred->user_ns) && uid_eq(ns->owner, cred->euid))
   101				return 0;
   102	
   103			/*
   104			 * If you have a capability in a parent user ns, then you have
   105			 * it over all children user namespaces as well.
   106			 */
   107			ns = ns->parent;
   108		}
   109	
   110		/* We never get here */
   111	}
   112	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
