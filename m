Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59F54D2CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiCIKRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCIKRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:17:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D678216AA74
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646820967; x=1678356967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XLi2cuUcCXMT6Cda6jf5NSgLIoMub3A2l45neUnRa+8=;
  b=J7RX761W7nqprtd5zC47/2wfAaiqtBi0zfd3tds/Mm6jAsfbFfZzmOrZ
   DOMXqHpnzqxxS3aNMP2lYD8gJoQdCqn1TavWPu+hr6QRF/6I1o0bhpRq5
   Xcwi8FWEgP2OFKTNHZtiZNjU5tTDKvSAqLE4gM6RSZPAIXLJt+ZZz7ZVV
   Ob6vLGEh7wvSwaBTp9+JDXwQMFdXE+CnyHPWKPQhpmRT6zFbrETp3clPJ
   S42BsPeEN8kMzEEG/4vRqwyOIM3D2+DxuXcGPNw8C/hnKpVM/MkX2Gcxk
   z3gwxlf6vhYbinq6M7TLd2h8k6TQhBFhXCC6srJgVUlZdiAay90s0FkNE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253770803"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="253770803"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 02:16:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="495790144"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2022 02:16:03 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRtMQ-00034V-Nc; Wed, 09 Mar 2022 10:16:02 +0000
Date:   Wed, 9 Mar 2022 18:15:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        James Morris <jamorris@linux.microsoft.com>
Subject: security/landlock/syscalls.c:150:1: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202203091814.0wqSqdu3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: 265885daf3e5082eb9f6e2a23bdbf9ba4456a21b landlock: Add syscall implementations
date:   11 months ago
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20220309/202203091814.0wqSqdu3-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=265885daf3e5082eb9f6e2a23bdbf9ba4456a21b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 265885daf3e5082eb9f6e2a23bdbf9ba4456a21b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
