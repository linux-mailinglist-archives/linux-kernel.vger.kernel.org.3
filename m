Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8714FFB6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiDMQix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiDMQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:38:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70D15EDCF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649867789; x=1681403789;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bV+s9ry0Q7ddESHyRku86nQtMR9t/0ZO18c14izb35w=;
  b=TD0hYdHXr6yjqj2ToyVce3/LiF3Z5JXkX/QcfAEksAz3LezfdHkIgKa4
   y33VYk7tz1eTnp8RD6bQ/llVczLbK/ZzwwC6vyIN1/1jp9B5XCEglX2nk
   rXrNAJSZyHWB2FbLNXokGc9JEG3jcrPxPHB8Pt06hveCdd6HE+f1urZ9T
   8KRoShVG7CTbo9MaKEAQmlB05fLHJq3l3CaH2RnhwUOfTxO7Ov11d7PBc
   42Z/0spVwU+YNq4tT+3qR0cnkANpUJbDcbEygwzIdDXN7yCu+2cSLnQm4
   3zz/A3yE5ZddMpujxuMkpJgat7PbVVQkwxvCwzImVjJ2eEescm5bWBV1o
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262155643"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262155643"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="645235351"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2022 09:36:28 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nefyl-0000SS-Lo;
        Wed, 13 Apr 2022 16:36:27 +0000
Date:   Thu, 14 Apr 2022 00:35:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [daniel-thompson:kdb/seq_file 1/3] include/linux/kdb.h:217:33:
 warning: 'struct seq_operations' declared inside parameter list will not be
 visible outside of this definition or declaration
Message-ID: <202204140058.LCY9tRmR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.linaro.org/people/daniel.thompson/linux.git kdb/seq_file
head:   2c8f993b3c1bdefc7bf84c5d63dbe69d15897b20
commit: e333b2ce40d76f3250a29a610671861f5ad0689c [1/3] kdb: Add framework to display sequence files
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220414/202204140058.LCY9tRmR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        git remote add daniel-thompson https://git.linaro.org/people/daniel.thompson/linux.git
        git fetch --no-tags daniel-thompson kdb/seq_file
        git checkout e333b2ce40d76f3250a29a610671861f5ad0689c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash kernel/printk/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/printk/printk_safe.c:7:
>> include/linux/kdb.h:217:33: warning: 'struct seq_operations' declared inside parameter list will not be visible outside of this definition or declaration
     217 | kdb_print_seq_file(const struct seq_operations *ops) { return 0; }
         |                                 ^~~~~~~~~~~~~~


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
