Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B8C5866A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiHAI71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiHAI7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:59:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E293D2AC71
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659344364; x=1690880364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WLSob6WZRijo1r4X/QWSTUIvozlCXPaoJf/ZsfYxpKY=;
  b=LXjEXE9BB4zFEbVbA2X9YZMta+EuxYv/tDCLag+DumoIbXtclw/BFkrq
   KLAEkhsibeuXPyFs2zZ4XArKXOTOlN4t3hELrR3NPDfdSpgMbzWen08V9
   cnoLLK+iYzXs7w66WCD0nqzn8kEj+kWM9gad9g1A40EPWxo9YcSV+jKKf
   iRU8vsOk7cg2dO04zuDLdAHvq6NxQ+VENpGK6XjglgYE9SgtgjPMwt21Y
   4rt85DqIEDl6nB18hAS1iyB1lqhGZ97m+p47Yh7bPHimFD9tt+7IzKnPt
   XGRST+SERwQIKAW2UB4TXSeuqpMkieK6zlC9rpDXJTrkG7Zolef1qxp/L
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="350806562"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="350806562"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 01:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="630159734"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2022 01:59:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIRGk-000Eyh-27;
        Mon, 01 Aug 2022 08:59:22 +0000
Date:   Mon, 1 Aug 2022 16:58:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-5.19.y-rt-rebase 16/55] kernel/softirq.c:640:1:
 sparse: sparse: symbol '__pcpu_scope_timersd' was not declared. Should it be
 static?
Message-ID: <202208011628.5yMVdsg8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-5.19.y-rt-rebase
head:   4730816e7a6aab17945765fc82d47cdc9a05b8fa
commit: 492b6c0790cc99809397f2daca10299efb6ed354 [16/55] rcutorture: Also force sched priority to timersd on boosting test.
config: microblaze-randconfig-s041-20220731 (https://download.01.org/0day-ci/archive/20220801/202208011628.5yMVdsg8-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=492b6c0790cc99809397f2daca10299efb6ed354
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-5.19.y-rt-rebase
        git checkout 492b6c0790cc99809397f2daca10299efb6ed354
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/softirq.c:640:1: sparse: sparse: symbol '__pcpu_scope_timersd' was not declared. Should it be static?

vim +/__pcpu_scope_timersd +640 kernel/softirq.c

   639	
 > 640	DEFINE_PER_CPU(struct task_struct *, timersd);
   641	static DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
   642	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
