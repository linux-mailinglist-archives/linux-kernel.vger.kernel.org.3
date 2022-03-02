Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A254CB362
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 01:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiCBX4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiCBXz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:55:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A413110E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646265314; x=1677801314;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RYhnBVg37Hvg/itaelH1cM2fBftR4o5ezh8YvKEbl2U=;
  b=MHEgnyq38bHckbwLq3SQ6wGoWziGZDmGaEuc21jLamq23VBgedrl0Tkw
   eoAjtbquDdggNY679/zqXNVposQxHPD711qfbtaiiTk+MdX0x1KvddzuP
   E+yv6/I6Tibhri5TLlToD+kdLcZ7K170Rt8iycCKo+sRGVcr2QCxXF0mr
   9yhS61YVVh4i6rkLzA3yXi7LFGRPrQB8gGWDMZHOvEQ7AZPPnOIeAY6Ln
   LMJSyK7riajONWCb7eH4e7wYcZxY1wXgKSZTGs929XYZMBTOt1zxLBiHp
   YIdzEYB7QK7EaMEbUuIuMFpBKTKU/vdiPyodEC9HPlf/TSwxHF9UXb5XP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233496797"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="233496797"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:33:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="594181259"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2022 15:33:00 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPYSp-000250-MT; Wed, 02 Mar 2022 23:32:59 +0000
Date:   Thu, 3 Mar 2022 07:32:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/deprecated/android-4.9-p-release
 3994/9999] security/commoncap.c:75:5: warning: no previous declaration for
 '__cap_capable'
Message-ID: <202203030705.8QZOBwpb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/deprecated/android-4.9-p-release
head:   74f5cdd2ad41ea660f18bcaf7ce3d8d3e8e88428
commit: 0268f76e4b39897c7b9ecf5fae695dbbc7bb7426 [3994/9999] ANDROID: commoncap: Begin to warn users of implicit PARANOID_NETWORK capability grants
config: i386-randconfig-r034-20211122 (https://download.01.org/0day-ci/archive/20220303/202203030705.8QZOBwpb-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/0268f76e4b39897c7b9ecf5fae695dbbc7bb7426
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/deprecated/android-4.9-p-release
        git checkout 0268f76e4b39897c7b9ecf5fae695dbbc7bb7426
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/audit.h:26:0,
                    from security/commoncap.c:11:
   include/linux/sched.h:1260:1: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
    const struct sched_group_energy * const(*sched_domain_energy_f)(int cpu);
    ^~~~~
>> security/commoncap.c:75:5: warning: no previous declaration for '__cap_capable' [-Wmissing-declarations]
    int __cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
        ^~~~~~~~~~~~~
   In file included from include/linux/capability.h:15:0,
                    from security/commoncap.c:10:
   security/commoncap.c: In function 'cap_prctl_drop':
   include/uapi/linux/capability.h:355:27: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
                              ^
   security/commoncap.c:903:7: note: in expansion of macro 'cap_valid'
     if (!cap_valid(cap))
          ^~~~~~~~~
   security/commoncap.c: In function 'cap_task_prctl':
   include/uapi/linux/capability.h:355:27: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
                              ^
   security/commoncap.c:933:8: note: in expansion of macro 'cap_valid'
      if (!cap_valid(arg2))
           ^~~~~~~~~
   include/uapi/linux/capability.h:355:27: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
    #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
                              ^
   security/commoncap.c:1017:10: note: in expansion of macro 'cap_valid'
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
    89			/* Have we tried all of the parent namespaces? */
    90			if (ns == &init_user_ns)
    91				return -EPERM;
    92	
    93			/* 
    94			 * The owner of the user namespace in the parent of the
    95			 * user namespace has all caps.
    96			 */
    97			if ((ns->parent == cred->user_ns) && uid_eq(ns->owner, cred->euid))
    98				return 0;
    99	
   100			/*
   101			 * If you have a capability in a parent user ns, then you have
   102			 * it over all children user namespaces as well.
   103			 */
   104			ns = ns->parent;
   105		}
   106	
   107		/* We never get here */
   108	}
   109	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
