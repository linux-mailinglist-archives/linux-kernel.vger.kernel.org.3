Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF2D5757D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbiGNWv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGNWvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:51:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4543B71BD3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657839113; x=1689375113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2mAhU/3PSX4TmtzMFMZggBgnyJiS6ojDvLtmZRDRDVY=;
  b=LWNVx/6P5k7KALuh8XITN2TEuZpKqjTZHsm3yFtlQ2O0i+Y7Wj1nA/T8
   U0rwhxHDVDS0f0HJwCSVUrwbRTFkGqPeQyFwwfexHCRPpwRKlIQeUWArf
   UZJ+6X5L+k9k8+Gxsp6dyxmQ3+rWjdSnjvPNNCcv51sk6GKRnO5mKwv0r
   vkVegruKiZmgEeCSyVOZOyX4FiRYz+9JAAxeP4bZsNwYmFLUeXHRjgRHd
   0e4mC8xaL6ORoOr6fvsDCHLkJ5LOXJPmp2n2EKKj7iPtC4uhbnRTgKps8
   Cgyx8EPwIOPKkj4BxJ+z+4tz73OJ1AOQz8vq2kWrj3E7p6nGg+c94sF1C
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="347325439"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="347325439"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 15:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="571282082"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 15:51:49 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC7gT-0001FF-9o;
        Thu, 14 Jul 2022 22:51:49 +0000
Date:   Fri, 15 Jul 2022 06:51:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: arch/x86/kernel/cpu/bugs.c:776:12: sparse: sparse: symbol
 'retbleed_strings' was not declared. Should it be static?
Message-ID: <202207150647.oLujDthN-lkp@intel.com>
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
head:   db886979683a8360ced9b24ab1125ad0c4d2cf76
commit: 7fbf47c7ce50b38a64576b150e7011ae73d54669 x86/bugs: Add AMD retbleed= boot parameter
date:   3 weeks ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220715/202207150647.oLujDthN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7fbf47c7ce50b38a64576b150e7011ae73d54669
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7fbf47c7ce50b38a64576b150e7011ae73d54669
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/bugs.c:776:12: sparse: sparse: symbol 'retbleed_strings' was not declared. Should it be static?

vim +/retbleed_strings +776 arch/x86/kernel/cpu/bugs.c

   774	
   775	static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 > 776		SPECTRE_V2_NONE;
   777	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
