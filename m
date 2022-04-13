Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FEA4FFE2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbiDMSvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiDMSuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:50:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0285D5EBDE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649875713; x=1681411713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vADpo0Y/n9wmDwVhgSNuPyebjkxQp2ZgIereRbZ+S2E=;
  b=PySrNCr7vPEik0cK7+nwUHVa1enNNLjIiwiG8fDj2uFLQzGKFyJhTww+
   KHyUOVWfwUYrSjkzT/qNYe1AxxApyY8N8zvZLkSxqBfLSpa6sF/RfonoG
   LhDmbvahdQ5Q32HH1Eht6ZV7kgX1Df6zcY/OtyW/1Bv1B//HyaqnTOjaB
   IaEw5bVJ2sNVcae2a5A+vV+XfH8Ihc19df358DviPSi1Lp7AVVeKrYEGE
   d41bGUInJrpoMKgbpa5Ue6yunQP1jN2ERvfdbcEvDVKSEssdndN8eiRDi
   nVWdGBdW9Vf3QyKIPK5bx1BQUZr5f6OUGUTwZRZ+voimX7CC0Yt9CeP7R
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="244633665"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="244633665"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725016107"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2022 11:48:31 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nei2Y-0000Wj-NH;
        Wed, 13 Apr 2022 18:48:30 +0000
Date:   Thu, 14 Apr 2022 02:48:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [daniel-thompson:kdb/seq_file 1/5] include/linux/kdb.h:217:33:
 warning: declaration of 'struct seq_operations' will not be visible outside
 of this function
Message-ID: <202204140223.LWUYoH9B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.linaro.org/people/daniel.thompson/linux.git kdb/seq_file
head:   b58798cd87e95bdb8832940ba312ce920de71613
commit: e333b2ce40d76f3250a29a610671861f5ad0689c [1/5] kdb: Add framework to display sequence files
config: arm64-buildonly-randconfig-r003-20220413 (https://download.01.org/0day-ci/archive/20220414/202204140223.LWUYoH9B-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        git remote add daniel-thompson https://git.linaro.org/people/daniel.thompson/linux.git
        git fetch --no-tags daniel-thompson kdb/seq_file
        git checkout e333b2ce40d76f3250a29a610671861f5ad0689c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/printk/printk_safe.c:7:
>> include/linux/kdb.h:217:33: warning: declaration of 'struct seq_operations' will not be visible outside of this function [-Wvisibility]
   kdb_print_seq_file(const struct seq_operations *ops) { return 0; }
                                   ^
   1 warning generated.


vim +217 include/linux/kdb.h

   210	
   211	/* Dynamic kdb shell command registration */
   212	extern int kdb_register(kdbtab_t *cmd);
   213	extern void kdb_unregister(kdbtab_t *cmd);
   214	#else /* ! CONFIG_KGDB_KDB */
   215	static inline __printf(1, 2) int kdb_printf(const char *fmt, ...) { return 0; }
   216	static inline int
 > 217	kdb_print_seq_file(const struct seq_operations *ops) { return 0; }
   218	static inline void kdb_init(int level) {}
   219	static inline int kdb_register(kdbtab_t *cmd) { return 0; }
   220	static inline void kdb_unregister(kdbtab_t *cmd) {}
   221	#endif	/* CONFIG_KGDB_KDB */
   222	enum {
   223		KDB_NOT_INITIALIZED,
   224		KDB_INIT_EARLY,
   225		KDB_INIT_FULL,
   226	};
   227	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
