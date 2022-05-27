Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89F4535746
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 03:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiE0BQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 21:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiE0BQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 21:16:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F2148317
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 18:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653614211; x=1685150211;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dpCfNs33RiFAmRDbMKxCNIHg+64LaOVLpq1r5kiPKOI=;
  b=FtXaFD7Npe+Wu6PCcoTz9HzViJJ6EfNdCxFGDPNRTyMIfMSPpjus7z3k
   +eQXMj7Hnl3b6APutcGeVc3k1q0pFwkJDrprQv6+X8WZC91XXyqIVZQLs
   cR7hX1fGEQ5M9ydtb3qWGUCzATOiregNMnAoh/NJbaL8tBmJDiAfiCUtF
   6P7IWtw4vtRt56MqU5iBV5TzaluH7iGM0cZZBLTqYUoKbdGcIBQQjuzqp
   DzutJZ+j8/jyfekViO9UxUojQQEO3iLQ4sp2pOYIdZlwzoOyTQ8/31/uy
   IlzehtMxYXYqYUR/V9kdB26Aqw2R8Stam/MkAweTp1vPERc39Vpmm5NbH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274445675"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="274445675"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 18:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="704856721"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 May 2022 18:16:49 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuOau-0004IX-NK;
        Fri, 27 May 2022 01:16:48 +0000
Date:   Fri, 27 May 2022 09:16:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     kbuild-all@lists.01.org, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [rppt:cet/kvm 32/51] <stdin>:1565:2: warning: #warning syscall
 map_shadow_stack not implemented
Message-ID: <202205270929.1teqv28Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git cet/kvm
head:   6c13d37e6c4ff3a7f86c5490b3d0f4f12d0a40da
commit: 987299ad58376fc09a3bc884b55c07c2e5d80245 [32/51] x86/cet/shstk: Introduce map_shadow_stack syscall
config: nios2-randconfig-r001-20220524 (https://download.01.org/0day-ci/archive/20220527/202205270929.1teqv28Y-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=987299ad58376fc09a3bc884b55c07c2e5d80245
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt cet/kvm
        git checkout 987299ad58376fc09a3bc884b55c07c2e5d80245
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 prepare

If you fix the issue, kindly add following tag where applicable
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
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> <stdin>:1565:2: warning: #warning syscall map_shadow_stack not implemented [-Wcpp]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
