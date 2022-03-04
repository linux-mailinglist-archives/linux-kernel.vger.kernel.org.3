Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0F4CCC4A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 04:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiCDD3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 22:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiCDD33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 22:29:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A667485F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 19:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646364522; x=1677900522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qhqM0wTLtPPZL2LBIfN1EQS8DLyl5brGVgQ13YNGIIA=;
  b=Ukm9Wn5kVgtviI8dm9eJTjTT50fz9zScetCDpARBLbLl3r3/QrH75UbZ
   v+X+zIkmdCrECxutwyfW3zo3eBImTwhW5uAF4U2v42F2ItwgjlxiS/CE9
   +jDRdYR4K3rQmf5xra/7xoj1p5u2593ewwCVskid/sr1hW4TT59F4gpk9
   v2jobxqWJ5UZk+Flsv7qrZ0Oayz3hc8orFgVzdEXT0xkVHhtDUJvejQrv
   8JCE9r9+byz/fM7SAImbAj/gHGV6Q9EwfjC+GLuay0ofEy5Fz4zHtWZNC
   I8fT1W9j2hxN6oFlEr2GnB8h18NxCTKWN1JU6paDuni37g9elw5Oz7oe6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="317108689"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="317108689"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 19:28:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="508847819"
Received: from lkp-server01.sh.intel.com (HELO ccb16ba0ecc3) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2022 19:28:39 -0800
Received: from kbuild by ccb16ba0ecc3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPycR-0001EM-2W; Fri, 04 Mar 2022 03:28:39 +0000
Date:   Fri, 4 Mar 2022 11:28:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/deprecated/android-4.14-p-release
 137/6167] security/commoncap.c:75:5: sparse: sparse: symbol '__cap_capable'
 was not declared. Should it be static?
Message-ID: <202203041153.II8SFndk-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/deprecated/android-4.14-p-release
head:   0ca5d5ac9152d01b3494fb2efb5390319eb9904a
commit: 2b02b4ab89b9cba5aec936046d8538962c5142fc [137/6167] ANDROID: net: paranoid: commoncap: Begin to warn users of implicit PARANOID_NETWORK capability grants
config: i386-randconfig-s001-20211101 (https://download.01.org/0day-ci/archive/20220304/202203041153.II8SFndk-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/2b02b4ab89b9cba5aec936046d8538962c5142fc
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/deprecated/android-4.14-p-release
        git checkout 2b02b4ab89b9cba5aec936046d8538962c5142fc
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> security/commoncap.c:75:5: sparse: sparse: symbol '__cap_capable' was not declared. Should it be static?
   security/commoncap.c:474:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] magic @@     got int @@
   security/commoncap.c:474:31: sparse:     expected restricted __le32 [usertype] magic
   security/commoncap.c:474:31: sparse:     got int
   security/commoncap.c:475:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] nsmagic @@     got unsigned int [usertype] @@
   security/commoncap.c:475:33: sparse:     expected restricted __le32 [usertype] nsmagic
   security/commoncap.c:475:33: sparse:     got unsigned int [usertype]
   security/commoncap.c:476:29: sparse: sparse: restricted __le32 degrades to integer
   security/commoncap.c:477:39: sparse: sparse: invalid assignment: |=
   security/commoncap.c:477:39: sparse:    left side has type restricted __le32
   security/commoncap.c:477:39: sparse:    right side has type int
   security/commoncap.c:479:42: sparse: sparse: cast from restricted __le32
   security/commoncap.c:1226:41: sparse: sparse: dubious: !x | y
   security/commoncap.c:1307:27: sparse: sparse: symbol 'capability_hooks' was not declared. Should it be static?
   security/commoncap.c:75:5: warning: no previous declaration for '__cap_capable' [-Wmissing-declarations]
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
