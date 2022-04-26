Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68DA50ED8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbiDZAZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiDZAZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:25:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAC218E28
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650932518; x=1682468518;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mvoc7eLqb+BcNojoU/FP4VFb3GCXXQd9V67RzUaHIBI=;
  b=jK9t1nc92lBiqdAwECtsm7evK0HwaFC6ekNRvPsMHCW4qw5cyMMrlf73
   Btmq2X1D9fyTwes4vpKwihnukSMoLK4OR+i7uMn2qLTsnfKm3nFtI94nY
   zUH98VAfFZcjzF/kUwDE/lUIoil3AxpDtQmFetSVkKan8kbBnQkLarfKj
   /J8VRMUgpM5JiapnHWeVmWpBv2rTNbcETN0c2WB1cAygkcAmqlw21dCpS
   mnF/opYYHKNV9FYyEzPIcRvsgFn5Ay5NjZo2s2YFrapQsMI+diuBNHkWm
   Vcf3fQpSvt3trtk1bK8ckTh9kjBMWtHB80sCxCKFZ4pEKJCQ1xR8FTgtE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="328342233"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="328342233"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 17:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="537926479"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Apr 2022 17:21:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nj8xm-00032k-UJ;
        Tue, 26 Apr 2022 00:21:54 +0000
Date:   Tue, 26 Apr 2022 08:21:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:pr/22 78/189] kernel/reboot.c:527: warning: expecting
 prototype for devm_register_sys_off_handler(). Prototype was for
 register_sys_off_handler() instead
Message-ID: <202204260827.tAcRW0sh-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux pr/22
head:   7ee315306d1a3b0da8cf2a53e7f55889d0e7f034
commit: ec159207530d80c0a0bd04c1ac94db5766bbc3c0 [78/189] kernel: Add combined power-off+restart handler call chain API
config: arc-randconfig-r043-20220425 (https://download.01.org/0day-ci/archive/20220426/202204260827.tAcRW0sh-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/ec159207530d80c0a0bd04c1ac94db5766bbc3c0
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux pr/22
        git checkout ec159207530d80c0a0bd04c1ac94db5766bbc3c0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/reboot.c:231: warning: Function parameter or member 'cmd' not described in 'do_kernel_restart'
>> kernel/reboot.c:527: warning: expecting prototype for devm_register_sys_off_handler(). Prototype was for register_sys_off_handler() instead
   kernel/reboot.c:1151: warning: Function parameter or member 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'


vim +527 kernel/reboot.c

   515	
   516	/**
   517	 *	devm_register_sys_off_handler - Register system power-off/restart handler
   518	 *	@dev: Device that registers handler
   519	 *	@handler: System-off handler
   520	 *
   521	 *	Registers handler that will be called as last step of the power-off
   522	 *	and restart sequences.
   523	 *
   524	 *	Returns zero on success, or error code on failure.
   525	 */
   526	int register_sys_off_handler(struct sys_off_handler *handler)
 > 527	{
   528		struct sys_off_handler_private_data *priv;
   529		int err, priority;
   530	
   531		priv = sys_off_handler_private_data(handler);
   532	
   533		/* sanity-check whether handler is registered twice */
   534		if (priv->registered)
   535			return -EBUSY;
   536	
   537		if (handler->power_off_cb || handler->power_off_prepare_cb) {
   538			if (handler->power_off_priority == POWEROFF_PRIO_RESERVED)
   539				priority = POWEROFF_PRIO_DEFAULT;
   540			else
   541				priority = handler->power_off_priority;
   542	
   543			priv->power_off_nb.notifier_call = sys_off_handler_power_off;
   544			priv->power_off_nb.priority = priority;
   545	
   546			err = register_power_off_handler(&priv->power_off_nb);
   547			if (err)
   548				goto reset_sys_off_handler;
   549		}
   550	
   551		if (handler->restart_cb) {
   552			if (handler->restart_priority == RESTART_PRIO_RESERVED)
   553				priority = RESTART_PRIO_DEFAULT;
   554			else
   555				priority = handler->restart_priority;
   556	
   557			priv->restart_nb.notifier_call = sys_off_handler_restart;
   558			priv->restart_nb.priority = priority;
   559	
   560			err = register_restart_handler(&priv->restart_nb);
   561			if (err)
   562				goto unreg_power_off_handler;
   563		}
   564	
   565		if (handler->reboot_prepare_cb) {
   566			priv->reboot_nb.notifier_call = sys_off_handler_reboot;
   567			priv->reboot_nb.priority = handler->reboot_priority;
   568	
   569			err = register_reboot_notifier(&priv->reboot_nb);
   570			if (err)
   571				goto unreg_restart_handler;
   572		}
   573	
   574		priv->registered = true;
   575	
   576		return 0;
   577	
   578	unreg_restart_handler:
   579		if (handler->restart_cb)
   580			unregister_restart_handler(&priv->restart_nb);
   581	
   582	unreg_power_off_handler:
   583		if (handler->power_off_cb)
   584			unregister_power_off_handler(&priv->power_off_nb);
   585	
   586	reset_sys_off_handler:
   587		memset(priv, 0, sizeof(*priv));
   588	
   589		return err;
   590	}
   591	EXPORT_SYMBOL(register_sys_off_handler);
   592	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
