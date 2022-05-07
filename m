Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41FC51E6E2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiEGMYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiEGMY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:24:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1199F1A3AC
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651926043; x=1683462043;
  h=date:from:cc:subject:message-id:mime-version;
  bh=dWE27ObTsmRFl4YwonH6s8TCzixHYcf9Ym+71uMqB9U=;
  b=Z57OpDejTeKdwW1Pt608qJVZEAiFMYBgHjfz0z0G1kR9+pktCN7EcMQe
   af5jM7aqZ8fCPymEUVuPw79b2TUtJuqb6AwNHin9cjTZn+fMjVucCGhpT
   xVK4gmkdJc+0M9LBu2r5b7jbOPXnlWCR/xAv9z/Tqw6s6JyuISkxbH3pE
   xE5DDTFoYXwhV+3WA63SfpdZfTM7Mj9+DnCZtrgOISwgMvtScJG8h4rOF
   jzLHUM+sCy1omOXEObE8C5sjx3lEomgXQZzRz+bMo8H49D5kfBpLGRVPT
   KkU+yXT9TWbmLWCnzOXLCEzutErQ/QRb7CgdkrWm9WbF2J+7VaAy4GnYi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="267541471"
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="267541471"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 05:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,207,1647327600"; 
   d="scan'208";a="812782368"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 May 2022 05:20:41 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnJQP-000EYL-1z;
        Sat, 07 May 2022 12:20:41 +0000
Date:   Sat, 7 May 2022 20:20:31 +0800
From:   kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        swedhanav <swedhana.viswanathan@intel.com>
Subject: [mchinth:sep_socwatch_linux_5_17 1/1]
 drivers/platform/x86/socperf/socperfdrv.o: warning: objtool:
 socperf_Service_IOCTL()+0x1e: unreachable instruction
Message-ID: <202205072006.fzA1yAt5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_17
head:   279a0843e522ec88123ebc978d37ddb6bf7bb2b8
commit: 279a0843e522ec88123ebc978d37ddb6bf7bb2b8 [1/1] Merge branch 'master' into sep_socwatch_linux_5_17
config: x86_64-randconfig-a004-20220502 (https://download.01.org/0day-ci/archive/20220507/202205072006.fzA1yAt5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/mchinth/linux/commit/279a0843e522ec88123ebc978d37ddb6bf7bb2b8
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_17
        git checkout 279a0843e522ec88123ebc978d37ddb6bf7bb2b8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/x86/socperf/socperfdrv.c:208:13: warning: no previous prototype for 'SOCPERF_Read_Data3' [-Wmissing-prototypes]
     208 | extern VOID SOCPERF_Read_Data3(PVOID data_buffer)
         |             ^~~~~~~~~~~~~~~~~~
   drivers/platform/x86/socperf/socperfdrv.c:990:1: warning: no previous prototype for 'SOCPERF_Switch_Group3' [-Wmissing-prototypes]
     990 | SOCPERF_Switch_Group3(VOID)
         | ^~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/socperf/socperfdrv.c:1175:13: warning: no previous prototype for 'lwpmudrv_Stop_Mem' [-Wmissing-prototypes]
    1175 | extern VOID lwpmudrv_Stop_Mem(VOID)
         |             ^~~~~~~~~~~~~~~~~
   drivers/platform/x86/socperf/socperfdrv.c:1392:22: warning: no previous prototype for 'socperf_Service_IOCTL' [-Wmissing-prototypes]
    1392 | extern IOCTL_OP_TYPE socperf_Service_IOCTL(IOCTL_USE_INODE struct file *filp,
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/socperf/socperfdrv.c:1516:13: warning: no previous prototype for 'socperf_Device_Control' [-Wmissing-prototypes]
    1516 | extern long socperf_Device_Control(IOCTL_USE_INODE struct file *filp,
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/socperf/socperfdrv.c:1551:13: warning: no previous prototype for 'socperf_Device_Control_Compat' [-Wmissing-prototypes]
    1551 | extern long socperf_Device_Control_Compat(struct file *filp, unsigned int cmd,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/socperf/socperfdrv.c:1602:12: warning: no previous prototype for 'SOCPERF_Abnormal_Terminate' [-Wmissing-prototypes]
    1602 | extern int SOCPERF_Abnormal_Terminate(void)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/socperf/socperfdrv.o: warning: objtool: socperf_Service_IOCTL()+0x1e: unreachable instruction
--
   drivers/platform/x86/socwatch/sw_driver.c: In function 'sw_collection_stop_i':
   drivers/platform/x86/socwatch/sw_driver.c:573:101: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     573 |                         "Warning: some trace_notifier probe functions could NOT be unregistered!\n");
         |                                                                                                     ^
   drivers/platform/x86/socwatch/sw_driver.c: In function 'sw_collection_poll_i':
   drivers/platform/x86/socwatch/sw_driver.c:642:56: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     642 |                 pw_pr_debug("DEBUG: EMPTY POLL LIST\n");
         |                                                        ^
   drivers/platform/x86/socwatch/sw_driver.c: In function 'sw_load_driver_i':
   drivers/platform/x86/socwatch/sw_driver.c:1698:62: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
    1698 |                         pw_pr_debug("OK, resetting worked\n");
         |                                                              ^
   drivers/platform/x86/socwatch/sw_driver.c: In function 'sw_unload_driver_i':
   drivers/platform/x86/socwatch/sw_driver.c:1715:62: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
    1715 |                         pw_pr_debug("OK, resetting worked\n");
         |                                                              ^
>> drivers/platform/x86/socwatch/sw_driver.o: warning: objtool: sw_unlocked_handle_ioctl_i()+0x171: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
