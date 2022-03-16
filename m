Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1298D4DAFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355671AbiCPMgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiCPMgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:36:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FDD32062
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647434136; x=1678970136;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AdBDmD/5MlIfA1oxTlGLJlOo2ySS0jnVT+2d8CiU1CY=;
  b=NgpNxynqi5VthaTmAFHv5e5kdQbmwvqUmr3apQPa5m9UHzofOch6mMH1
   S0NrAjVK5GDkZY1bJgPHvMb7kqrztLX+5XFTkc6iY86lf7sVmp5rrBzfW
   xtfHb44lcPhTj0im7bPHb7YIMZuraLTpI/ftLZJjjvdfZBzpvXN5FpUyD
   VbTFrDySat3hwMt4ZSnADHRdorHOCF0b63Ltj9MejhHy1fgsByZDYMJIB
   Dm8KxCKnLk0Uc/eXTzOBzOkdyre6Hzjc3MUs6MDA8LB+RVtBZS+A8yTfS
   et0gELdUvD9/Ps1NBw98Ufy8294iAJvwXHAUhTCDuu7Dxh0Ov2qrhNYsI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256522378"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256522378"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:35:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="540893402"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2022 05:35:34 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUSsI-000CPJ-2j; Wed, 16 Mar 2022 12:35:34 +0000
Date:   Wed, 16 Mar 2022 20:34:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1471/2335]
 ./usr/include/asm-generic/bpf_perf_event.h:4:10: fatal error:
 uapi/linux/ptrace.h: No such file or directory
Message-ID: <202203162045.LpmFsb8S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 0e8c59e6be9eaf6f92b82fd96d34ad3b7998c03b [1471/2335] headers/deps: bpf: Use <uapi/linux/ptrace.h> in <uapi/asm-generic/bpf_perf_event.h>
config: i386-randconfig-a006-20220314 (https://download.01.org/0day-ci/archive/20220316/202203162045.LpmFsb8S-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=0e8c59e6be9eaf6f92b82fd96d34ad3b7998c03b
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 0e8c59e6be9eaf6f92b82fd96d34ad3b7998c03b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/asm/bpf_perf_event.h:1,
                    from <command-line>:32:
>> ./usr/include/asm-generic/bpf_perf_event.h:4:10: fatal error: uapi/linux/ptrace.h: No such file or directory
       4 | #include <uapi/linux/ptrace.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
