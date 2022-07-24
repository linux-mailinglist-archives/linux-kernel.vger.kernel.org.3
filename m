Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E8B57F24F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 02:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbiGXAy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 20:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239065AbiGXAyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 20:54:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CBF15711
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 17:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658624057; x=1690160057;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M9y+vG5BDZkxT/eGc/C5jum/3bvTJ3A34mAKeoZ6CGQ=;
  b=X5YL69kiNw7XbSXhYZdesEfSLALUhCaOQ6U749ev8sUlVs+R5SOdszfv
   AFYWlyaBFWIdTK4/6jAwvW/J6sAG2xu8BiL7fkicUVYBEfRCANmOmI7fC
   xfLR1hcx6KkVXUIuj1ftAIJO0j8g17AfU+kTtqFxNGJS4aehehVGW9L8J
   P6ZtUTL5AHa8kEJABJSWpsDhiypn2Gse/4B+cCUDvm3xMomwv8MiX6Bvq
   oPKhuFS/R3v1XcqtIpIbwyjZL2BGHH+XgNbdPSafGHSaUW7wC0KwJEJSg
   GMJzQKTWMbu7w/EcYmTecgyIpNIfBckwp6rZKoynKhfvpqxke9sTMHee5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="287516763"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="287516763"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 17:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="626995775"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Jul 2022 17:54:15 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFPss-0003JZ-2N;
        Sun, 24 Jul 2022 00:54:14 +0000
Date:   Sun, 24 Jul 2022 08:53:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/13] drivers/acpi/apei/erst-dbg.c:73:22: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202207240823.vYaPrLLL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   8f1ad76e5cd0e91e574027038c51ace7789f8401
commit: badfa95b53ee2d7247e30f8ba0d418d162f6523d [5/13] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220724/202207240823.vYaPrLLL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=badfa95b53ee2d7247e30f8ba0d418d162f6523d
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout badfa95b53ee2d7247e30f8ba0d418d162f6523d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/apei/erst-dbg.c:73:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/acpi/apei/erst-dbg.c:73:22: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/acpi/apei/erst-dbg.c:73:22: sparse:     got unsigned int *
--
>> fs/orangefs/devorangefs-req.c:605:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/orangefs/devorangefs-req.c:605:26: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/orangefs/devorangefs-req.c:605:26: sparse:     got signed int *
   fs/orangefs/devorangefs-req.c:609:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/orangefs/devorangefs-req.c:609:26: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/orangefs/devorangefs-req.c:609:26: sparse:     got signed int *
   fs/orangefs/devorangefs-req.c:614:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   fs/orangefs/devorangefs-req.c:614:26: sparse:     expected signed int [noderef] __user *__ptr_clean
   fs/orangefs/devorangefs-req.c:614:26: sparse:     got signed int *
   fs/orangefs/devorangefs-req.c:254:28: sparse: sparse: context imbalance in 'orangefs_devreq_read' - different lock contexts for basic block
--
>> drivers/misc/xilinx_sdfec.c:735:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int enum xsdfec_order [noderef] __user *__ptr_clean @@     got unsigned int enum xsdfec_order * @@
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     expected unsigned int enum xsdfec_order [noderef] __user *__ptr_clean
   drivers/misc/xilinx_sdfec.c:735:15: sparse:     got unsigned int enum xsdfec_order *
>> drivers/misc/xilinx_sdfec.c:760:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected bool [noderef] __user *__ptr_clean @@     got bool * @@
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     expected bool [noderef] __user *__ptr_clean
   drivers/misc/xilinx_sdfec.c:760:15: sparse:     got bool *
   drivers/misc/xilinx_sdfec.c:787:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected bool [noderef] __user *__ptr_clean @@     got bool * @@
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     expected bool [noderef] __user *__ptr_clean
   drivers/misc/xilinx_sdfec.c:787:15: sparse:     got bool *
--
>> drivers/watchdog/cpu5wdt.c:157:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/cpu5wdt.c:157:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/cpu5wdt.c:157:24: sparse:     got int *
   drivers/watchdog/cpu5wdt.c:159:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/cpu5wdt.c:159:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/cpu5wdt.c:159:24: sparse:     got int *
   drivers/watchdog/cpu5wdt.c:161:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/cpu5wdt.c:161:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/cpu5wdt.c:161:21: sparse:     got int *
--
>> drivers/watchdog/acquirewdt.c:131:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/acquirewdt.c:131:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/acquirewdt.c:131:37: sparse:     got char const *
>> drivers/watchdog/acquirewdt.c:161:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/acquirewdt.c:161:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/acquirewdt.c:161:24: sparse:     got int *
   drivers/watchdog/acquirewdt.c:165:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/acquirewdt.c:165:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/acquirewdt.c:165:21: sparse:     got int *
   drivers/watchdog/acquirewdt.c:182:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/acquirewdt.c:182:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/acquirewdt.c:182:24: sparse:     got int *
--
>> drivers/watchdog/wafer5823wdt.c:109:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/wafer5823wdt.c:109:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:109:37: sparse:     got char const *
>> drivers/watchdog/wafer5823wdt.c:143:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:143:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:143:24: sparse:     got int *
   drivers/watchdog/wafer5823wdt.c:149:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:149:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:149:21: sparse:     got int *
   drivers/watchdog/wafer5823wdt.c:170:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:170:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:170:21: sparse:     got int *
   drivers/watchdog/wafer5823wdt.c:179:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/wafer5823wdt.c:179:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/wafer5823wdt.c:179:24: sparse:     got int *
--
>> drivers/watchdog/sbc60xxwdt.c:180:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/sbc60xxwdt.c:180:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:180:37: sparse:     got char const *
>> drivers/watchdog/sbc60xxwdt.c:237:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc60xxwdt.c:237:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:237:24: sparse:     got int *
   drivers/watchdog/sbc60xxwdt.c:241:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc60xxwdt.c:241:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:241:21: sparse:     got int *
   drivers/watchdog/sbc60xxwdt.c:259:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc60xxwdt.c:259:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:259:21: sparse:     got int *
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc60xxwdt.c:270:24: sparse:     got int *
--
>> drivers/watchdog/smsc37b787_wdt.c:404:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char const [noderef] __user *__ptr_clean @@     got char const * @@
   drivers/watchdog/smsc37b787_wdt.c:404:37: sparse:     expected char const [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:404:37: sparse:     got char const *
>> drivers/watchdog/smsc37b787_wdt.c:444:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:444:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:444:24: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:446:24: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:451:21: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:468:21: sparse:     got int *
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/smsc37b787_wdt.c:482:24: sparse:     got int *
--
>> drivers/watchdog/sbc_epx_c3.c:119:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_epx_c3.c:119:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_epx_c3.c:119:24: sparse:     got int *
   drivers/watchdog/sbc_epx_c3.c:121:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_epx_c3.c:121:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_epx_c3.c:121:21: sparse:     got int *
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/watchdog/sbc_epx_c3.c:139:24: sparse:     got int *
--
>> kernel/kcov.c:711:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   kernel/kcov.c:711:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   kernel/kcov.c:711:21: sparse:     got unsigned int *
--
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/stats.c:148:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/stats.c:148:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/stats.c:148:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/stop_task.c:73:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/stop_task.c:73:38: sparse:     expected struct task_struct *curr
   kernel/sched/stop_task.c:73:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/topology.c:481:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct perf_domain *pd @@     got struct perf_domain [noderef] __rcu *pd @@
   kernel/sched/topology.c:481:19: sparse:     expected struct perf_domain *pd
   kernel/sched/topology.c:481:19: sparse:     got struct perf_domain [noderef] __rcu *pd
   kernel/sched/topology.c:643:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:643:49: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:643:49: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:714:50: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:714:50: sparse:     expected struct sched_domain *parent
   kernel/sched/topology.c:714:50: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:721:55: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child @@     got struct sched_domain *[assigned] tmp @@
   kernel/sched/topology.c:721:55: sparse:     expected struct sched_domain [noderef] __rcu *[noderef] __rcu child
   kernel/sched/topology.c:721:55: sparse:     got struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:731:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:731:29: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:731:29: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:736:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:736:20: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:736:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:757:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *sd @@
   kernel/sched/topology.c:757:13: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/topology.c:757:13: sparse:     got struct sched_domain [noderef] __rcu *sd
   kernel/sched/topology.c:919:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:919:70: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:919:70: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:948:59: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:948:59: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:948:59: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:994:57: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:994:57: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:994:57: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:996:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:996:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:996:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1004:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1004:55: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1004:55: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1006:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sibling @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1006:25: sparse:     expected struct sched_domain *sibling
   kernel/sched/topology.c:1006:25: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1076:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1076:62: sparse:     expected struct sched_domain *sd
   kernel/sched/topology.c:1076:62: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1180:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:1180:40: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:1180:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1589:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain [noderef] __rcu *child @@     got struct sched_domain *child @@
   kernel/sched/topology.c:1589:43: sparse:     expected struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:1589:43: sparse:     got struct sched_domain *child
   kernel/sched/topology.c:2186:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain [noderef] __rcu *parent @@     got struct sched_domain *sd @@
   kernel/sched/topology.c:2186:31: sparse:     expected struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2186:31: sparse:     got struct sched_domain *sd
   kernel/sched/topology.c:2289:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2289:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2289:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2310:56: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/topology.c:2310:56: sparse:     expected struct sched_domain *child
   kernel/sched/topology.c:2310:56: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/topology.c:2309:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2309:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2309:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/topology.c:2357:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/topology.c:2357:57: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/topology.c:2357:57: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
>> kernel/sched/core_sched.c:180:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   kernel/sched/core_sched.c:180:23: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   kernel/sched/core_sched.c:180:23: sparse:     got unsigned long long *
   kernel/sched/core_sched.c:275:37: sparse: sparse: incompatible types in conditional expression (different address spaces):
   kernel/sched/core_sched.c:275:37: sparse:    struct task_struct *
   kernel/sched/core_sched.c:275:37: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/psi.c:143:1: sparse: sparse: symbol 'psi_cgroups_enabled' was not declared. Should it be static?
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/sched.h:1737:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1737:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1737:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1750:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1750:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1750:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1737:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1737:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1737:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/sched.h:1750:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/sched.h:1750:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/sched.h:1750:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/topology.c:949:31: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:1610:19: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2340:51: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2341:49: sparse: sparse: dereference of noderef expression
   kernel/sched/topology.c:2343:52: sparse: sparse: dereference of noderef expression
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/sched.h:1177:30: sparse: sparse: context imbalance in 'sched_core_update_cookie' - wrong count at exit
   kernel/sched/build_utility.c: note: in included file:
   kernel/sched/psi.c:746:13: sparse: sparse: dereference of noderef expression
   kernel/sched/psi.c:770:38: sparse: sparse: dereference of noderef expression
   kernel/sched/psi.c:990:6: sparse: sparse: context imbalance in 'cgroup_move_task' - different lock contexts for basic block
--
>> drivers/fpga/dfl.c:1837:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/fpga/dfl.c:1837:16: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/fpga/dfl.c:1837:16: sparse:     got unsigned int *
--
>> drivers/tee/tee_core.c:447:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/tee/tee_core.c:447:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:447:29: sparse:     got unsigned long long *
   drivers/tee/tee_core.c:448:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/tee/tee_core.c:448:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:448:29: sparse:     got unsigned long long *
   drivers/tee/tee_core.c:449:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/tee/tee_core.c:449:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:449:29: sparse:     got unsigned long long *
   drivers/tee/tee_core.c:454:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/tee/tee_core.c:454:29: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:454:29: sparse:     got unsigned long long *
>> drivers/tee/tee_core.c:516:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:516:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:516:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:517:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:517:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:517:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:518:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:518:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:518:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:586:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:586:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:586:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:587:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:587:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:587:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:699:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:699:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:699:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:717:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:717:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:717:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:718:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:718:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:718:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:797:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:797:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:797:13: sparse:     got unsigned int *
   drivers/tee/tee_core.c:798:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/tee/tee_core.c:798:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/tee/tee_core.c:798:13: sparse:     got unsigned int *
--
>> drivers/xen/gntdev.c:817:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed short [noderef] __user *__ptr_clean @@     got signed short * @@
   drivers/xen/gntdev.c:817:13: sparse:     expected signed short [noderef] __user *__ptr_clean
   drivers/xen/gntdev.c:817:13: sparse:     got signed short *
--
>> drivers/xen/privcmd.c:375:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   drivers/xen/privcmd.c:375:31: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   drivers/xen/privcmd.c:375:31: sparse:     got unsigned long *
   drivers/xen/privcmd.c:559:35: sparse: sparse: cast removes address space '__user' of expression
   drivers/xen/privcmd.c:559:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] [usertype] __user *[addressable] [assigned] user_gfn @@     got unsigned long [usertype] * @@
   drivers/xen/privcmd.c:559:32: sparse:     expected unsigned long [noderef] [usertype] __user *[addressable] [assigned] user_gfn
   drivers/xen/privcmd.c:559:32: sparse:     got unsigned long [usertype] *
   drivers/xen/privcmd.c:686:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[usertype] h @@     got void [noderef] __user *uptr @@
   drivers/xen/privcmd.c:686:17: sparse:     expected void *[usertype] h
   drivers/xen/privcmd.c:686:17: sparse:     got void [noderef] __user *uptr
--
   sound/core/control.c:815:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:815:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:816:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:816:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:835:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1529:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
>> sound/core/control.c:1638:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1638:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1638:13: sparse:     got int *
   sound/core/control.c:1642:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1642:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1642:21: sparse:     got int *
   sound/core/control.c:1779:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1779:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1779:24: sparse:     got int *
   sound/core/control.c:1820:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/control.c:1820:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/control.c:1820:24: sparse:     got int *
--
>> sound/core/timer.c:2044:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/timer.c:2044:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/timer.c:2044:13: sparse:     got int *
   sound/core/timer.c:2083:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/timer.c:2083:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/timer.c:2083:24: sparse:     got int *
   sound/core/timer.c:790:25: sparse: sparse: context imbalance in 'snd_timer_process_callbacks' - unexpected unlock
--
>> sound/core/pcm.c:92:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:92:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:92:29: sparse:     got int *
   sound/core/pcm.c:97:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:97:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:97:29: sparse:     got int *
>> sound/core/pcm.c:112:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm.c:112:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm.c:112:29: sparse:     got unsigned int *
   sound/core/pcm.c:114:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:114:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:114:29: sparse:     got int *
   sound/core/pcm.c:119:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm.c:119:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm.c:119:29: sparse:     got unsigned int *
   sound/core/pcm.c:155:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm.c:155:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm.c:155:29: sparse:     got int *
--
>> sound/core/pcm_native.c:1082:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:1082:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:1082:20: sparse:     got unsigned int *
   sound/core/pcm_native.c:1108:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:1108:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:1108:20: sparse:     got unsigned int *
   sound/core/pcm_native.c:3039:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3039:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3039:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3134:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3134:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3134:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3135:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3135:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3135:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3136:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3136:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3136:13: sparse:     got unsigned int *
>> sound/core/pcm_native.c:3171:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean @@     got restricted snd_pcm_state_t * @@
   sound/core/pcm_native.c:3171:13: sparse:     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3171:13: sparse:     got restricted snd_pcm_state_t *
   sound/core/pcm_native.c:3172:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3172:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3172:13: sparse:     got unsigned int *
>> sound/core/pcm_native.c:3173:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3173:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3173:13: sparse:     got signed int *
   sound/core/pcm_native.c:3174:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3174:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3174:13: sparse:     got signed int *
   sound/core/pcm_native.c:3175:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean @@     got restricted snd_pcm_state_t * @@
   sound/core/pcm_native.c:3175:13: sparse:     expected restricted snd_pcm_state_t [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3175:13: sparse:     got restricted snd_pcm_state_t *
   sound/core/pcm_native.c:3176:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3176:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3176:13: sparse:     got signed int *
   sound/core/pcm_native.c:3177:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed int [noderef] __user *__ptr_clean @@     got signed int * @@
   sound/core/pcm_native.c:3177:13: sparse:     expected signed int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3177:13: sparse:     got signed int *
   sound/core/pcm_native.c:3178:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3178:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3178:13: sparse:     got unsigned int *
   sound/core/pcm_native.c:3179:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3179:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3179:13: sparse:     got unsigned int *
>> sound/core/pcm_native.c:3191:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm_native.c:3191:13: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3191:13: sparse:     got int *
>> sound/core/pcm_native.c:3208:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3208:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3208:13: sparse:     got signed long *
   sound/core/pcm_native.c:3216:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3216:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3216:13: sparse:     got signed long *
   sound/core/pcm_native.c:3233:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3233:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3233:13: sparse:     got signed long *
   sound/core/pcm_native.c:3246:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3246:13: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3246:13: sparse:     got signed long *
>> sound/core/pcm_native.c:3257:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3257:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3257:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3259:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3259:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3259:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3262:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3262:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3262:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3273:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3273:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3273:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3275:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3275:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3275:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3278:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *__ptr_clean @@     got unsigned long * @@
   sound/core/pcm_native.c:3278:13: sparse:     expected unsigned long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3278:13: sparse:     got unsigned long *
   sound/core/pcm_native.c:3302:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/pcm_native.c:3302:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3302:24: sparse:     got int *
   sound/core/pcm_native.c:3310:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_native.c:3310:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3310:21: sparse:     got unsigned int *
   sound/core/pcm_native.c:3357:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected signed long [noderef] __user *__ptr_clean @@     got signed long * @@
   sound/core/pcm_native.c:3357:21: sparse:     expected signed long [noderef] __user *__ptr_clean
   sound/core/pcm_native.c:3357:21: sparse:     got signed long *
   sound/core/pcm_native.c:95:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock' - different lock contexts for basic block
   sound/core/pcm_native.c:96:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock' - unexpected unlock
   sound/core/pcm_native.c:97:1: sparse: sparse: context imbalance in 'snd_pcm_group_lock_irq' - different lock contexts for basic block
   sound/core/pcm_native.c:98:1: sparse: sparse: context imbalance in 'snd_pcm_group_unlock_irq' - unexpected unlock
   sound/core/pcm_native.c:145:9: sparse: sparse: context imbalance in 'snd_pcm_stream_lock_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:171:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave' - different lock contexts for basic block
   sound/core/pcm_native.c:184:9: sparse: sparse: context imbalance in '_snd_pcm_stream_lock_irqsave_nested' - different lock contexts for basic block
   sound/core/pcm_native.c:201:39: sparse: sparse: context imbalance in 'snd_pcm_stream_unlock_irqrestore' - unexpected unlock
   sound/core/pcm_native.c:1261:44: sparse: sparse: context imbalance in 'snd_pcm_action_group' - unexpected unlock
   sound/core/pcm_native.c:1331:37: sparse: sparse: context imbalance in 'snd_pcm_stream_group_ref' - different lock contexts for basic block
--
>> sound/core/pcm_lib.c:2436:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2436:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2436:13: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2446:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2446:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2446:21: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2447:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2447:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2447:21: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2457:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2457:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2457:29: sparse:     got unsigned int *
   sound/core/pcm_lib.c:2462:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/pcm_lib.c:2462:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/pcm_lib.c:2462:13: sparse:     got unsigned int *
--
>> sound/core/oss/pcm_oss.c:2608:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2608:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2608:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2610:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2610:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2610:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2636:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2636:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2636:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2641:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2641:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2641:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2646:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2646:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2646:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2648:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2648:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2648:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2654:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2654:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2654:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2659:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2659:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2659:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2661:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2661:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2661:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2666:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2666:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2666:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2671:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2671:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2671:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2673:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2673:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2673:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2678:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2678:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2678:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2683:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2683:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2683:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2690:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2690:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2690:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2695:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2695:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2695:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2697:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2697:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2697:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2704:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2704:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2704:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2717:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2717:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2717:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2722:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2722:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2722:24: sparse:     got int *
   sound/core/oss/pcm_oss.c:2724:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2724:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2724:21: sparse:     got int *
   sound/core/oss/pcm_oss.c:2750:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2750:25: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2750:25: sparse:     got int *
   sound/core/oss/pcm_oss.c:2753:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/pcm_oss.c:2753:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/pcm_oss.c:2753:24: sparse:     got int *
--
>> sound/core/oss/mixer_oss.c:335:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:335:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:335:29: sparse:     got int *
   sound/core/oss/mixer_oss.c:340:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:340:32: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:340:32: sparse:     got int *
   sound/core/oss/mixer_oss.c:342:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:342:32: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:342:32: sparse:     got int *
   sound/core/oss/mixer_oss.c:344:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:344:32: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:344:32: sparse:     got int *
   sound/core/oss/mixer_oss.c:349:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:349:32: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:349:32: sparse:     got int *
   sound/core/oss/mixer_oss.c:354:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:354:32: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:354:32: sparse:     got int *
   sound/core/oss/mixer_oss.c:359:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:359:32: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:359:32: sparse:     got int *
   sound/core/oss/mixer_oss.c:364:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:364:32: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:364:32: sparse:     got int *
   sound/core/oss/mixer_oss.c:369:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:369:32: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:369:32: sparse:     got int *
   sound/core/oss/mixer_oss.c:373:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:373:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:373:21: sparse:     got int *
   sound/core/oss/mixer_oss.c:378:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:378:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:378:24: sparse:     got int *
   sound/core/oss/mixer_oss.c:383:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/oss/mixer_oss.c:383:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/oss/mixer_oss.c:383:24: sparse:     got int *
--
>> sound/core/seq/oss/seq_oss_timer.c:224:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     got int *
   sound/core/seq/oss/seq_oss_timer.c:229:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_timer.c:229:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_timer.c:229:24: sparse:     got int *
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     got int *
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     got int *
--
>> sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:104:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:104:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:104:24: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:109:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:109:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:109:24: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:112:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:112:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:112:24: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:120:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:120:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:120:24: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:123:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:123:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:123:24: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:129:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:129:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:129:24: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     got int *
   sound/core/seq/oss/seq_oss_ioctl.c:169:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/seq/oss/seq_oss_ioctl.c:169:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/seq/oss/seq_oss_ioctl.c:169:24: sparse:     got int *

vim +73 drivers/acpi/apei/erst-dbg.c

885b976fada5bc Huang Ying 2011-02-21  54  
2ff729d506e8db Huang Ying 2010-08-12  55  static long erst_dbg_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
2ff729d506e8db Huang Ying 2010-08-12  56  {
2ff729d506e8db Huang Ying 2010-08-12  57  	int rc;
2ff729d506e8db Huang Ying 2010-08-12  58  	u64 record_id;
2ff729d506e8db Huang Ying 2010-08-12  59  	u32 record_count;
2ff729d506e8db Huang Ying 2010-08-12  60  
2ff729d506e8db Huang Ying 2010-08-12  61  	switch (cmd) {
2ff729d506e8db Huang Ying 2010-08-12  62  	case APEI_ERST_CLEAR_RECORD:
2ff729d506e8db Huang Ying 2010-08-12  63  		rc = copy_from_user(&record_id, (void __user *)arg,
2ff729d506e8db Huang Ying 2010-08-12  64  				    sizeof(record_id));
2ff729d506e8db Huang Ying 2010-08-12  65  		if (rc)
2ff729d506e8db Huang Ying 2010-08-12  66  			return -EFAULT;
2ff729d506e8db Huang Ying 2010-08-12  67  		return erst_clear(record_id);
2ff729d506e8db Huang Ying 2010-08-12  68  	case APEI_ERST_GET_RECORD_COUNT:
2ff729d506e8db Huang Ying 2010-08-12  69  		rc = erst_get_record_count();
2ff729d506e8db Huang Ying 2010-08-12  70  		if (rc < 0)
2ff729d506e8db Huang Ying 2010-08-12  71  			return rc;
2ff729d506e8db Huang Ying 2010-08-12  72  		record_count = rc;
2ff729d506e8db Huang Ying 2010-08-12 @73  		rc = put_user(record_count, (u32 __user *)arg);
2ff729d506e8db Huang Ying 2010-08-12  74  		if (rc)
2ff729d506e8db Huang Ying 2010-08-12  75  			return rc;
2ff729d506e8db Huang Ying 2010-08-12  76  		return 0;
2ff729d506e8db Huang Ying 2010-08-12  77  	default:
2ff729d506e8db Huang Ying 2010-08-12  78  		return -ENOTTY;
2ff729d506e8db Huang Ying 2010-08-12  79  	}
2ff729d506e8db Huang Ying 2010-08-12  80  }
2ff729d506e8db Huang Ying 2010-08-12  81  

:::::: The code at line 73 was first introduced by commit
:::::: 2ff729d506e8db82d76a93bc963df4d0a4d46b57 ACPI, APEI, ERST debug support

:::::: TO: Huang Ying <ying.huang@intel.com>
:::::: CC: Len Brown <len.brown@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
