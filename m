Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4454D6F3E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiCLNjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCLNjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:39:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF47427FD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 05:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647092311; x=1678628311;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CA2Kl1BDk/XN5RAWF8A33we03D0765U+/ccBOJYnqSc=;
  b=Po+dHTDXBK712XaMyST+OtS1gLOxLUgZEjLN7dPw8p6VaJ7ciZaErRxV
   JesOd1sMfssNsuj1tw5oJFgw+qK2wpYdalBaorml0QozzZnIXVdguMy1x
   XpGiwyuK81es1fS/BaPzvZ71+0yr+yTRlHBcRzpZBBA1XdyEXk4mOsMXO
   OyOZyZaP6u6ZckrW4izscEqAyQwaQev35Q3hLgXqn6D5x8NnrC6OsYHQH
   xk78ndLKsJTP+2lQS4tymuJ+WAB6wciZjofktNEG8JKIM5U6dSjba1t1w
   1tzbMYpw8Qg7noC+z+QtcMPg+Jy7layyg3PtI2EEB1/hogsoDQpXfad9y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255978555"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255978555"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 05:38:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="539375672"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 12 Mar 2022 05:38:29 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nT1wy-0007uU-SA; Sat, 12 Mar 2022 13:38:28 +0000
Date:   Sat, 12 Mar 2022 21:37:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/proton-pack.c:783:14: sparse: sparse: symbol
 'spectre_bhb_patch_fw_mitigation_enabled' was not declared. Should it be
 static?
Message-ID: <202203122137.UnefPg5u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68453767131a5deec1e8f9ac92a9042f929e585d
commit: ba2689234be92024e5635d30fe744f4853ad97db arm64: entry: Add vectors that have the bhb mitigation sequences
date:   3 weeks ago
config: arm64-randconfig-s032-20220311 (https://download.01.org/0day-ci/archive/20220312/202203122137.UnefPg5u-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba2689234be92024e5635d30fe744f4853ad97db
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ba2689234be92024e5635d30fe744f4853ad97db
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm64/kernel/proton-pack.c:783:14: sparse: sparse: symbol 'spectre_bhb_patch_fw_mitigation_enabled' was not declared. Should it be static?

vim +/spectre_bhb_patch_fw_mitigation_enabled +783 arch/arm64/kernel/proton-pack.c

   773	
   774	static int ssbd_prctl_get(struct task_struct *task)
   775	{
   776		switch (spectre_v4_state) {
   777		case SPECTRE_UNAFFECTED:
   778			return PR_SPEC_NOT_AFFECTED;
   779		case SPECTRE_MITIGATED:
   780			if (spectre_v4_mitigations_on())
   781				return PR_SPEC_NOT_AFFECTED;
   782	
 > 783			if (spectre_v4_mitigations_dynamic())
   784				break;
   785	
   786			/* Mitigations are disabled, so we're vulnerable. */
   787			fallthrough;
   788		case SPECTRE_VULNERABLE:
   789			fallthrough;
   790		default:
   791			return PR_SPEC_ENABLE;
   792		}
   793	
   794		/* Check the mitigation state for this task */
   795		if (task_spec_ssb_force_disable(task))
   796			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
   797	
   798		if (task_spec_ssb_noexec(task))
   799			return PR_SPEC_PRCTL | PR_SPEC_DISABLE_NOEXEC;
   800	
   801		if (task_spec_ssb_disable(task))
   802			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
   803	
   804		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
   805	}
   806	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
