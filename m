Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E300B4DA76F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347561AbiCPBos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbiCPBop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:44:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44FF32ED0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647395012; x=1678931012;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TPxPow57q9klc7+u0nfJWcTW00nXF3kKe9TgU1PVSyE=;
  b=d778jwFyeC8CVhxFM1YVhiqijYarZG7UmD8ggxLB0IVATZdoPswlnVEy
   g1t4VkCXZnJ96D3N7BNx1hMDb5ODGnqGh8fIsV+fPGn1WhVvGdR0aAcOu
   +RPRIuWAj4jxmTqwJ9SEyUvP+imEPBxhZRU5qEM+29Tbz0QPBz8ZLlHwD
   vtkGMaEHPPw2PEES2DHIxuvw8t05P4YowE9siQO7GRyvg5Txvw4OiV82r
   PWtY5hGaz8V1L8g9oFmqE5fnj79qyy5taYue8Xq0cJKKZ9RPNiJjFx88L
   aVNwJLAIOI5555KDSERtMfybjGbLXdX096fOtq4lszxbDzfu1MsKucbKQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="237069236"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="237069236"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 18:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="512835479"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Mar 2022 18:43:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUIhG-000BmE-Il; Wed, 16 Mar 2022 01:43:30 +0000
Date:   Wed, 16 Mar 2022 09:42:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 124/2308]
 arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13:
 warning: no previous prototype for 'per_task_common'
Message-ID: <202203160910.Zc3pBtKp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   ef90a8d1de7ff54bfd0fcfe6371c20f544b14d6d
commit: 6495b5a520813aafdd9d4a284fd10cce582fd0cf [124/2308] headers/deps: per_task, arm64, x86: Convert task_struct::thread to a per_task() field
config: arm64-buildonly-randconfig-r005-20220314 (https://download.01.org/0day-ci/archive/20220316/202203160910.Zc3pBtKp-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=6495b5a520813aafdd9d4a284fd10cce582fd0cf
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 6495b5a520813aafdd9d4a284fd10cce582fd0cf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:29:
>> arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
      13 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~
--
   In file included from arch/arm64/kernel/asm-offsets.c:29:
>> arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h:13:13: warning: no previous prototype for 'per_task_common' [-Wmissing-prototypes]
      13 | void __used per_task_common(void)
         |             ^~~~~~~~~~~~~~~


vim +/per_task_common +13 arch/arm64/kernel/../../../kernel/sched/per_task_area_struct_defs.h

ef23e8859af031 Ingo Molnar 2021-09-05  11  
ef23e8859af031 Ingo Molnar 2021-09-05  12  
329a7c8b0e1476 Ingo Molnar 2022-01-04 @13  void __used per_task_common(void)
329a7c8b0e1476 Ingo Molnar 2022-01-04  14  {
329a7c8b0e1476 Ingo Molnar 2022-01-04  15  #include "per_task_area_struct_template.h"
329a7c8b0e1476 Ingo Molnar 2022-01-04  16  }
ef23e8859af031 Ingo Molnar 2021-09-05  17  

:::::: The code at line 13 was first introduced by commit
:::::: 329a7c8b0e147609f9a11b60795e94d40251c76a headers/deps: per_task: Implement single template to define 'struct task_struct_per_task' fields and offsets

:::::: TO: Ingo Molnar <mingo@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
