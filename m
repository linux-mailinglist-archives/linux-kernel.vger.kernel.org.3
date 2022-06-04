Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E028853D64A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiFDJqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 05:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiFDJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:46:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E8D1B7B9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654335990; x=1685871990;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y7eqfJtcCCLym+4+Tc+iYhf6VTHEGMjAlT46WjxakCI=;
  b=PZR11Pj3mlzie2vFOb431qrFXOoBZrCYDoamgkFsX60BrUec+ql6Kpwq
   8oiD/0lNcMzzorephEg9PqXLzU/WFo96m0ijt+Av1b+qHzNLQHVRK2Lxr
   //9iACAVJixMQEZdwtezmQZpATAQpTsZ2V+0wLz8N5MdDyNE5D227duWs
   7Dp3G+Mb08UVqb68wtbrvb3HgLeG/mlsPgE2LyxsJhdYqPvtneUNbSAYN
   JE8+uQVnhHSoNmpR8j8YAt1D8+hOdTwxw10YgPFgucfTvqgh1/Zh9i78L
   B2tH6/V5zJ7xt1STigAotXdjDrHiolYataYaMieVGnJhBOw4QTTcixZ8X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="275218158"
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="275218158"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 02:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,277,1647327600"; 
   d="scan'208";a="634891332"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2022 02:46:29 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxQMW-000Abk-AW;
        Sat, 04 Jun 2022 09:46:28 +0000
Date:   Sat, 4 Jun 2022 17:46:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        James Morris <jamorris@linux.microsoft.com>
Subject: security/landlock/syscalls.c:150:1: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202206041737.hvLpbdsq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: 265885daf3e5082eb9f6e2a23bdbf9ba4456a21b landlock: Add syscall implementations
date:   1 year, 1 month ago
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220604/202206041737.hvLpbdsq-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=265885daf3e5082eb9f6e2a23bdbf9ba4456a21b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 265885daf3e5082eb9f6e2a23bdbf9ba4456a21b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash drivers/s390/scsi/ kernel/ security/landlock/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> security/landlock/syscalls.c:150:1: sparse: sparse: Using plain integer as NULL pointer
>> security/landlock/syscalls.c:150:1: sparse: sparse: Using plain integer as NULL pointer
   security/landlock/syscalls.c:295:1: sparse: sparse: Using plain integer as NULL pointer
   security/landlock/syscalls.c:295:1: sparse: sparse: Using plain integer as NULL pointer

vim +150 security/landlock/syscalls.c

   130	
   131	/**
   132	 * sys_landlock_create_ruleset - Create a new ruleset
   133	 *
   134	 * @attr: Pointer to a &struct landlock_ruleset_attr identifying the scope of
   135	 *        the new ruleset.
   136	 * @size: Size of the pointed &struct landlock_ruleset_attr (needed for
   137	 *        backward and forward compatibility).
   138	 * @flags: Must be 0.
   139	 *
   140	 * This system call enables to create a new Landlock ruleset, and returns the
   141	 * related file descriptor on success.
   142	 *
   143	 * Possible returned errors are:
   144	 *
   145	 * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
   146	 * - EINVAL: @flags is not 0, or unknown access, or too small @size;
   147	 * - E2BIG or EFAULT: @attr or @size inconsistencies;
   148	 * - ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
   149	 */
 > 150	SYSCALL_DEFINE3(landlock_create_ruleset,
   151			const struct landlock_ruleset_attr __user *const, attr,
   152			const size_t, size, const __u32, flags)
   153	{
   154		struct landlock_ruleset_attr ruleset_attr;
   155		struct landlock_ruleset *ruleset;
   156		int err, ruleset_fd;
   157	
   158		/* Build-time checks. */
   159		build_check_abi();
   160	
   161		if (!landlock_initialized)
   162			return -EOPNOTSUPP;
   163	
   164		/* No flag for now. */
   165		if (flags)
   166			return -EINVAL;
   167	
   168		/* Copies raw user space buffer. */
   169		err = copy_min_struct_from_user(&ruleset_attr, sizeof(ruleset_attr),
   170				offsetofend(typeof(ruleset_attr), handled_access_fs),
   171				attr, size);
   172		if (err)
   173			return err;
   174	
   175		/* Checks content (and 32-bits cast). */
   176		if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=
   177				LANDLOCK_MASK_ACCESS_FS)
   178			return -EINVAL;
   179	
   180		/* Checks arguments and transforms to kernel struct. */
   181		ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs);
   182		if (IS_ERR(ruleset))
   183			return PTR_ERR(ruleset);
   184	
   185		/* Creates anonymous FD referring to the ruleset. */
   186		ruleset_fd = anon_inode_getfd("landlock-ruleset", &ruleset_fops,
   187				ruleset, O_RDWR | O_CLOEXEC);
   188		if (ruleset_fd < 0)
   189			landlock_put_ruleset(ruleset);
   190		return ruleset_fd;
   191	}
   192	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
