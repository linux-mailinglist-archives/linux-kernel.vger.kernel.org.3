Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5E34EFF6B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353573AbiDBHem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348987AbiDBHeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:34:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51304174EA8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648884766; x=1680420766;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UHUuiLANLlCn54nkSZ4+ujgIsYKlEPvIrG2HeqCnNoM=;
  b=k6lT4u4+8Ty/hyM4JJqw2p7Io/1i2ms19UtMqGqq4AGr8ZDbB/wpHArj
   gASRZlJ0b585Y3sg6b68Il+RVzNag8ejZX2MYkaG/BWQP07RL+h5M0Jfk
   Uo2+BlNQMkjdiCuAGJvg/p1X2OGOzsk85LnNs39LlaK3x/PTooXUwBcGJ
   0XFqm2KIYvoMf8ocpBk2vVm4upPROB3Xid3BuPXL3jzG22VdpcviFvjUW
   7ItBFqjlB4WeHFXVBvjBvaPju5YadHMpt7jCwFBfYCO01FNS81Tdhxl3X
   jxX03DdYB3pRXwKSTQv0V83Xs6cSFnWDV48xu6DNfM/mH7MwSqhTQsHai
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259113219"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="259113219"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 00:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="521898682"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Apr 2022 00:32:44 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naYFX-00021a-Qq;
        Sat, 02 Apr 2022 07:32:43 +0000
Date:   Sat, 2 Apr 2022 15:31:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [broonie-ci:tmp 1/1] init/main.c:1641:2: error: TEST
Message-ID: <202204021556.nxlZnplP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git tmp
head:   43b72ebc853c105427885ca515416f58459c0a5d
commit: 43b72ebc853c105427885ca515416f58459c0a5d [1/1] Test build failures
config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220402/202204021556.nxlZnplP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=43b72ebc853c105427885ca515416f58459c0a5d
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci tmp
        git checkout 43b72ebc853c105427885ca515416f58459c0a5d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   init/main.c:781:20: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init __weak mem_encrypt_init(void) { }
                      ^
   init/main.c:781:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak mem_encrypt_init(void) { }
   ^
   static 
>> init/main.c:1641:2: error: TEST
   #error TEST
    ^
   1 warning and 1 error generated.


vim +1641 init/main.c

  1640	
> 1641	#error TEST

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
