Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419C14E1F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 04:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbiCUDzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 23:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiCUDzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 23:55:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28235CF0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 20:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647834820; x=1679370820;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SsmXh+TUr8SlUAiEUnETJ7m9O7B3Y14OPX6mgzP+iMs=;
  b=OSUaEajaMx8+bWxV8BnKrWFktwx74rXDaLvaOQZs0z8C3L0b4xvF3u52
   3BLLHFqOWKVXu/3eJxYi8HDrSjKV5KEqhD0ItehaVGwrltQg5TLcq3REA
   RcwKQnoLYe17RLCUDABC9A07ShR8Tdwd3Ree1G2PQGriuH7N0ocWsudIg
   hckTy0MkCqpvqCBhWbOqViV8ySBSJ87dYt0xrEgYR+VR0U3CWdWww0mEw
   hFulZPNPTrFRoE14scS7pesfWWClv5rO4Q1pEUtHLe4FiILs3kqtgVwp9
   FOjVtq4skH7UIDJq+Vj2SqOTIhx3mDoLJqAm/fIrPUnDYnCnJADYoAXPr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="244934857"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="244934857"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 20:53:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="518269315"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2022 20:53:38 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nW96v-000HSQ-J2; Mon, 21 Mar 2022 03:53:37 +0000
Date:   Mon, 21 Mar 2022 11:53:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/perf-wip 17/17] cc1: error: bad
 value ('alderlake') for '-march=' switch
Message-ID: <202203211136.zyGiUsJS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/perf-wip
head:   9f86e73b1575cedbbce029cc1dc45e8fe6f5a586
commit: 9f86e73b1575cedbbce029cc1dc45e8fe6f5a586 [17/17] x86: add modern Intel and AMD CPUs
config: x86_64-randconfig-r025-20220321 (https://download.01.org/0day-ci/archive/20220321/202203211136.zyGiUsJS-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/9f86e73b1575cedbbce029cc1dc45e8fe6f5a586
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/perf-wip
        git checkout 9f86e73b1575cedbbce029cc1dc45e8fe6f5a586
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> cc1: error: bad value ('alderlake') for '-march=' switch
   cc1: note: valid arguments to '-march=' switch are: nocona core2 nehalem corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 cannonlake icelake-client icelake-server cascadelake tigerlake bonnell atom silvermont slm goldmont goldmont-plus tremont knl knm x86-64 eden-x2 nano nano-1000 nano-2000 nano-3000 nano-x2 eden-x4 nano-x4 k8 k8-sse3 opteron opteron-sse3 athlon64 athlon64-sse3 athlon-fx amdfam10 barcelona bdver1 bdver2 bdver3 bdver4 znver1 znver2 btver1 btver2 native; did you mean 'tigerlake'?
   make[2]: *** [scripts/Makefile.build:288: scripts/mod/empty.o] Error 1
>> cc1: error: bad value ('alderlake') for '-march=' switch
   cc1: note: valid arguments to '-march=' switch are: nocona core2 nehalem corei7 westmere sandybridge corei7-avx ivybridge core-avx-i haswell core-avx2 broadwell skylake skylake-avx512 cannonlake icelake-client icelake-server cascadelake tigerlake bonnell atom silvermont slm goldmont goldmont-plus tremont knl knm x86-64 eden-x2 nano nano-1000 nano-2000 nano-3000 nano-x2 eden-x4 nano-x4 k8 k8-sse3 opteron opteron-sse3 athlon64 athlon64-sse3 athlon-fx amdfam10 barcelona bdver1 bdver2 bdver3 bdver4 znver1 znver2 btver1 btver2 native; did you mean 'tigerlake'?
   make[2]: *** [scripts/Makefile.build:121: scripts/mod/devicetable-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1190: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
