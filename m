Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A224B7A72
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbiBOW2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:28:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiBOW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:28:22 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659AB9A4CF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644964091; x=1676500091;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n8KyS8jlXQ5QmufwTz0lhOEyXnChm726adSmltIHKnY=;
  b=IrZKRK47imsYFJvDPxh88Ad7aMIKwL8w6VlDqvKbzT8altUise8H414y
   AYF5hzTGVOr8s5fl+fGSJesubJ/r/eOHysX7SJ7XdWMbHw4qBk0uKlyfm
   S2jv50USXvdC07O8i/+i9wNnc0VS4/Zjf5ThEUqeXy/0b5O1DQnoc5v8y
   rLadPm2zNgE2stNDXSf3xQtOAJcKjUNhJDqkOJ9q57c1c3/z2rBQ7bnY9
   pE/ANrkl89k9wZhfbN/65syr0a8/QAxGvajVuYEBkC+YuMZ0YX6EjRUhc
   ZLUI+jkqo0fXgaH77Gj9URQSzLdHCiYxSwIrC+Kn6RQVVSy4jZG9H8qRg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="336899295"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="336899295"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 14:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="625055436"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Feb 2022 14:28:09 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK6Ir-000A6z-5S; Tue, 15 Feb 2022 22:28:09 +0000
Date:   Wed, 16 Feb 2022 06:27:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:spmi/work 15/38]
 drivers/platform/apple/smc_rtkit.c:429:25: error: 'apple_smc_of_match'
 undeclared here (not in a function); did you mean
 'apple_smc_rtkit_of_match'?
Message-ID: <202202160622.Q0sK1O5M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux spmi/work
head:   76613dba00adb753bc18bf738bf04658f4480994
commit: 63615eb2a0f68ad3d05cf48ccf0771dd613e1f44 [15/38] platform/apple: Add new Apple Mac SMC driver
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220216/202202160622.Q0sK1O5M-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/63615eb2a0f68ad3d05cf48ccf0771dd613e1f44
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux spmi/work
        git checkout 63615eb2a0f68ad3d05cf48ccf0771dd613e1f44
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/platform/apple/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

      72 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:125:17: note: in expansion of macro '__BF_FIELD_CHECK'
     125 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:327:45: note: in expansion of macro 'FIELD_GET'
     327 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                             ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:327:55: note: in expansion of macro 'SMC_DATA'
     327 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   In file included from arch/mips/include/asm/mips-cps.h:10,
                    from arch/mips/include/asm/smp-ops.h:16,
                    from arch/mips/include/asm/smp.h:21,
                    from include/linux/smp.h:113,
                    from include/linux/lockdep.h:14,
                    from include/linux/rcupdate.h:29,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/platform/apple/smc_rtkit.c:8:
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bitfield.h:126:44: note: in definition of macro 'FIELD_GET'
     126 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:327:55: note: in expansion of macro 'SMC_DATA'
     327 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:126:44: note: in definition of macro 'FIELD_GET'
     126 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                            ^~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:327:55: note: in expansion of macro 'SMC_DATA'
     327 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bitfield.h:42:38: note: in definition of macro '__bf_shf'
      42 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/platform/apple/smc_rtkit.c:327:45: note: in expansion of macro 'FIELD_GET'
     327 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                             ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:327:55: note: in expansion of macro 'SMC_DATA'
     327 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bitfield.h:42:38: note: in definition of macro '__bf_shf'
      42 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/platform/apple/smc_rtkit.c:327:45: note: in expansion of macro 'FIELD_GET'
     327 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                             ^~~~~~~~~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/platform/apple/smc_rtkit.c:29:41: note: in expansion of macro 'GENMASK'
      29 | #define SMC_DATA                        GENMASK(63, 32)
         |                                         ^~~~~~~
   drivers/platform/apple/smc_rtkit.c:327:55: note: in expansion of macro 'SMC_DATA'
     327 |         apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
         |                                                       ^~~~~~~~
   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from drivers/platform/apple/smc_rtkit.c:8:
   drivers/platform/apple/smc_rtkit.c: At top level:
>> drivers/platform/apple/smc_rtkit.c:429:25: error: 'apple_smc_of_match' undeclared here (not in a function); did you mean 'apple_smc_rtkit_of_match'?
     429 | MODULE_DEVICE_TABLE(of, apple_smc_of_match);
         |                         ^~~~~~~~~~~~~~~~~~
   include/linux/module.h:244:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |               ^~~~
>> include/linux/module.h:244:21: error: '__mod_of__apple_smc_of_match_device_table' aliased to undefined symbol 'apple_smc_of_match'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |                     ^~~~~~
   drivers/platform/apple/smc_rtkit.c:429:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     429 | MODULE_DEVICE_TABLE(of, apple_smc_of_match);
         | ^~~~~~~~~~~~~~~~~~~


vim +429 drivers/platform/apple/smc_rtkit.c

   312	
   313	static void apple_smc_rtkit_recv(void *cookie, u8 endpoint, u64 message)
   314	{
   315		struct apple_smc_rtkit *smc = cookie;
   316	
   317		if (endpoint != SMC_ENDPOINT) {
   318			dev_err(smc->dev, "Received message for unknown endpoint 0x%x\n", endpoint);
   319			return;
   320		}
   321	
   322		if (FIELD_GET(SMC_MSG, message) != SMC_MSG_NOTIFICATION) {
   323			dev_err(smc->dev, "Received unknown message from worker: 0x%llx\n", message);
   324			return;
   325		}
   326	
 > 327		apple_smc_event_received(smc->core, FIELD_GET(SMC_DATA, message));
   328	}
   329	
   330	static const struct apple_rtkit_ops apple_smc_rtkit_ops = {
   331		.crashed = apple_smc_rtkit_crashed,
   332		.recv_message = apple_smc_rtkit_recv,
   333		.recv_message_early = apple_smc_rtkit_recv_early,
   334		.shmem_setup = apple_smc_rtkit_shmem_setup,
   335		.shmem_destroy = apple_smc_rtkit_shmem_destroy,
   336	};
   337	
   338	static int apple_smc_rtkit_probe(struct platform_device *pdev)
   339	{
   340		struct device *dev = &pdev->dev;
   341		struct apple_smc_rtkit *smc;
   342		int ret;
   343	
   344		smc = devm_kzalloc(dev, sizeof(*smc), GFP_KERNEL);
   345		if (!smc)
   346			return -ENOMEM;
   347	
   348		smc->dev = dev;
   349	
   350		smc->sram = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
   351		if (!smc->sram)
   352			return dev_err_probe(dev, EIO,
   353					     "No SRAM region");
   354	
   355		smc->sram_base = devm_ioremap_resource(dev, smc->sram);
   356		if (IS_ERR(smc->sram_base))
   357			return dev_err_probe(dev, PTR_ERR(smc->sram_base),
   358					     "Failed to map SRAM region");
   359	
   360		smc->rtk =
   361			devm_apple_rtkit_init(dev, smc, NULL, 0, &apple_smc_rtkit_ops);
   362		if (IS_ERR(smc->rtk))
   363			return dev_err_probe(dev, PTR_ERR(smc->rtk),
   364					     "Failed to intialize RTKit");
   365	
   366		ret = apple_rtkit_wake(smc->rtk);
   367		if (ret != 0)
   368			return dev_err_probe(dev, ret,
   369					     "Failed to wake up SMC");
   370	
   371		ret = apple_rtkit_start_ep(smc->rtk, SMC_ENDPOINT);
   372		if (ret != 0) {
   373			dev_err(dev, "Failed to start endpoint");
   374			goto cleanup;
   375		}
   376	
   377		init_completion(&smc->init_done);
   378		init_completion(&smc->cmd_done);
   379	
   380		ret = apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT,
   381					       FIELD_PREP(SMC_MSG, SMC_MSG_INITIALIZE));
   382		if (ret < 0)
   383			return dev_err_probe(dev, ret,
   384					     "Failed to send init message");
   385	
   386		if (wait_for_completion_timeout(&smc->init_done, SMC_TIMEOUT) == 0) {
   387			ret = -ETIMEDOUT;
   388			dev_err(dev, "Timed out initializing SMC");
   389			goto cleanup;
   390		}
   391	
   392		if (!smc->alive) {
   393			ret = -EIO;
   394			goto cleanup;
   395		}
   396	
   397		smc->core = apple_smc_probe(dev, &apple_smc_rtkit_be_ops, smc);
   398		if (IS_ERR(smc->core)) {
   399			ret = PTR_ERR(smc->core);
   400			goto cleanup;
   401		}
   402	
   403		return 0;
   404	
   405	cleanup:
   406		/* Try to shut down RTKit, if it's not completely wedged */
   407		if (apple_rtkit_is_running(smc->rtk))
   408			apple_rtkit_hibernate(smc->rtk);
   409	
   410		return ret;
   411	}
   412	
   413	static int apple_smc_rtkit_remove(struct platform_device *pdev)
   414	{
   415		struct apple_smc_rtkit *smc = platform_get_drvdata(pdev);
   416	
   417		apple_smc_remove(smc->core);
   418	
   419		if (apple_rtkit_is_running(smc->rtk))
   420			apple_rtkit_hibernate(smc->rtk);
   421	
   422		return 0;
   423	}
   424	
   425	static const struct of_device_id apple_smc_rtkit_of_match[] = {
   426		{ .compatible = "apple,smc" },
   427		{},
   428	};
 > 429	MODULE_DEVICE_TABLE(of, apple_smc_of_match);
   430	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
