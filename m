Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB2E527499
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 01:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiENXCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 19:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiENXCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 19:02:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11EB15816
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652569368; x=1684105368;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T3p1KnqVs7ah+VrSrQ9KL2iGoxuTB3OTQRT04B7eq+U=;
  b=Le052CeiIF8jdygxHd2vCIL/HnWEZWob7XHpf0z9DyLXJ4AUN0liMoeH
   NgnXvfstqtGKYB/b1EgChIwDt0djSSmzL7qQR1GrAFmQaQ/nitNPV0cVM
   Yldf20tzCyFHsGE2RdcLc5JyVXeiNsUaL7qwd+qVxF7xMacv1sSa53/4H
   j8OXBj7b4RxjW1dFUeBy0Yk+BLufSY8pfj1viu0cgtpIs2VZZ1jNwAih9
   pdwmaIdR2cqy/fVlC0dEox/9Ve8cL13nl0fgcXUc/yDsdnGP+tGJbkbbO
   apcm3K7VtJILPvVg6vkU31FgoZJtklFZ8wIChAE3jzyriupKEqJGirupH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="250469057"
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="250469057"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 16:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="604298766"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 May 2022 16:02:47 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nq0mc-00015x-3Y;
        Sat, 14 May 2022 23:02:46 +0000
Date:   Sun, 15 May 2022 07:01:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-5.18-kprobes 43/46]
 arch/xtensa/kernel/patching.c:41:16: warning: no previous prototype for
 'xtensa_patch_text'
Message-ID: <202205150645.bh32cVqn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-5.18-kprobes
head:   8d9b04fec534d588aeb00d6003276eebf2eb73e0
commit: 74da1e3bad8529ecb3c103033fda53ea2a40e5e1 [43/46] xtensa: extract instruction patching from jump label code
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220515/202205150645.bh32cVqn-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/74da1e3bad8529ecb3c103033fda53ea2a40e5e1
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-5.18-kprobes
        git checkout 74da1e3bad8529ecb3c103033fda53ea2a40e5e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/xtensa/kernel/patching.c:41:16: warning: no previous prototype for 'xtensa_patch_text' [-Wmissing-prototypes]
      41 | void __kprobes xtensa_patch_text(unsigned long addr, const void *data,
         |                ^~~~~~~~~~~~~~~~~


vim +/xtensa_patch_text +41 arch/xtensa/kernel/patching.c

    40	
  > 41	void __kprobes xtensa_patch_text(unsigned long addr, const void *data,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
