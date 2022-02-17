Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DC74B98BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiBQGFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:05:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiBQGFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:05:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32452295FC2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645077905; x=1676613905;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zygUgPf43rBuaeOOUEfw172EFYT3eiqn7l95DhRFbO4=;
  b=FWFmccdHjHaftRt71C6Y8QrK/m8U9a449NMAeX5Z9N3L4keWXkp4ugAs
   bh53Po/bskd9+kSdLovvqZfBUDiiEtiX9CtsPWiaQXqCMd2ZQR36uuVHR
   Tor9c27BmtsBYtqNLUGChCapTMMZQY1ef22ODSGv3cjoAGI4jvtTeN86O
   uW2+q00cCgHjlCpsq23tY24CQV1gg+obkxRyKuoqSjYJoOLvba10KDd2u
   EDwIxtE7Wihh3+ayhwD2dFQpaOJLEBKFFtvt/G+I3bgygpimkh/0N4ZQg
   Hc3RP0wg4dEAQv9+qx7FJxQMqoljiA0hQqxj1TOyTm4JeDMKqGCR1ja98
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="275390114"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="275390114"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 22:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="636912964"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Feb 2022 22:05:03 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKZuY-000BW0-BG; Thu, 17 Feb 2022 06:05:02 +0000
Date:   Thu, 17 Feb 2022 14:04:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     kbuild-all@lists.01.org, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [rppt:cet/kvm 32/49] <stdin>:1565:2: warning: #warning syscall
 map_shadow_stack not implemented
Message-ID: <202202171454.SfEDJ0Yv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git cet/kvm
head:   e2f9808bd7530f44cd5d95332036bb660b66b8db
commit: 987299ad58376fc09a3bc884b55c07c2e5d80245 [32/49] x86/cet/shstk: Introduce map_shadow_stack syscall
config: sh-randconfig-m031-20220217 (https://download.01.org/0day-ci/archive/20220217/202202171454.SfEDJ0Yv-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=987299ad58376fc09a3bc884b55c07c2e5d80245
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt cet/kvm
        git checkout 987299ad58376fc09a3bc884b55c07c2e5d80245
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> <stdin>:1565:2: warning: #warning syscall map_shadow_stack not implemented [-Wcpp]
--
   <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> <stdin>:1565:2: warning: #warning syscall map_shadow_stack not implemented [-Wcpp]
--
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> <stdin>:1565:2: warning: #warning syscall map_shadow_stack not implemented [-Wcpp]

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
