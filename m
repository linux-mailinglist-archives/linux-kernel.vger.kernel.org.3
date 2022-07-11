Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C933356FF83
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiGKKwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGKKwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:52:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027693C8E8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657533526; x=1689069526;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LjdX+LF/NKbHZWtN8A0s6n7Sww3GeGIsI297RxDs2QQ=;
  b=Hzq9HKFT2J7mM0eNZnNluB9nPyUMlczlvPGEW+A3DVHVgmP8LXIKTiJ4
   VDsbpB9sOk0qv72wnTK/kMyNshvGVuuGegVeB2xiYQCU7Gooldmw/fTkt
   kLvvUaF3WUsXQF+A7jpEtdpwpGMylkxQvY6XXBRA6YJSUs3Yfv1WHNFBM
   rKNC886GEXdNMh03BpTQ0KNrlOCjjqtEkgiB0iyHoA2r6yRbCQsXyccU5
   oM/WJdImusb/krm2mi6HG/5MPB3YJwy6zOxi9Xix219KPFlR6atF/Xbgd
   daQ3HMrb+z63eWmDYgUWTYqQYNDoVrr1j8jdmFKUUerj/yWCKGJw9zjnY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="283375544"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="283375544"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 02:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="544952023"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2022 02:58:23 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAqBK-0000ez-TP;
        Mon, 11 Jul 2022 09:58:22 +0000
Date:   Mon, 11 Jul 2022 17:58:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/soc/qcom/llcc-qcom.c:88:8: warning: Excessive padding in
 'struct llcc_slice_config' (6 padding bytes, where 2 is optimal). Optimal
 fields order: usecase_id, slice_id, max_cap, priority, bonus_ways, res_ways,
 cache_mode, probe_target_ways, fixed_si...
Message-ID: <202207111703.pE1rkAYv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   32346491ddf24599decca06190ebca03ff9de7f8
commit: 2b8175a1f108361c2c1a11b27415631994efbfce soc: qcom: llcc: Add write-cache cacheable support
date:   5 months ago
config: riscv-randconfig-c006-20220707 (https://download.01.org/0day-ci/archive/20220711/202207111703.pE1rkAYv-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 77a38f6839980bfac61babb40d83772c51427011)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2b8175a1f108361c2c1a11b27415631994efbfce
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2b8175a1f108361c2c1a11b27415631994efbfce
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
                                                      ^~~~
   Suppressed 7 warnings (7 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   8 warnings generated.
   drivers/gpio/gpio-virtio.c:24:8: warning: Excessive padding in 'struct virtio_gpio_line' (158 padding bytes, where 30 is optimal). Optimal fields order: res, rxlen, completion, req, lock, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct virtio_gpio_line {
   ~~~~~~~^~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-virtio.c:24:8: note: Excessive padding in 'struct virtio_gpio_line' (158 padding bytes, where 30 is optimal). Optimal fields order: res, rxlen, completion, req, lock, consider reordering the fields or adding explicit padding members
   struct virtio_gpio_line {
   ~~~~~~~^~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-virtio.c:32:8: warning: Excessive padding in 'struct vgpio_irq_line' (183 padding bytes, where 119 is optimal). Optimal fields order: ires, type, disabled, masked, queued, update_pending, queue_pending, ireq, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct vgpio_irq_line {
   ~~~~~~~^~~~~~~~~~~~~~~~
   drivers/gpio/gpio-virtio.c:32:8: note: Excessive padding in 'struct vgpio_irq_line' (183 padding bytes, where 119 is optimal). Optimal fields order: ires, type, disabled, masked, queued, update_pending, queue_pending, ireq, consider reordering the fields or adding explicit padding members
   struct vgpio_irq_line {
   ~~~~~~~^~~~~~~~~~~~~~~~
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   7 warnings generated.
   Suppressed 7 warnings (7 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   12 warnings generated.
   drivers/bus/mhi/core/pm.c:320:17: warning: Value stored to 'dev' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct device *dev = &mhi_cntrl->mhi_dev->dev;
                          ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/core/pm.c:320:17: note: Value stored to 'dev' during its initialization is never read
           struct device *dev = &mhi_cntrl->mhi_dev->dev;
                          ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/core/pm.c:377:17: warning: Value stored to 'dev' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct device *dev = &mhi_cntrl->mhi_dev->dev;
                          ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/core/pm.c:377:17: note: Value stored to 'dev' during its initialization is never read
           struct device *dev = &mhi_cntrl->mhi_dev->dev;
                          ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/core/pm.c:720:17: warning: Value stored to 'dev' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct device *dev = &mhi_cntrl->mhi_dev->dev;
                          ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/core/pm.c:720:17: note: Value stored to 'dev' during its initialization is never read
           struct device *dev = &mhi_cntrl->mhi_dev->dev;
                          ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/core/pm.c:739:17: warning: Value stored to 'dev' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct device *dev = &mhi_cntrl->mhi_dev->dev;
                          ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/core/pm.c:739:17: note: Value stored to 'dev' during its initialization is never read
           struct device *dev = &mhi_cntrl->mhi_dev->dev;
                          ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/core/pm.c:1201:17: warning: Value stored to 'dev' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct device *dev = &mhi_cntrl->mhi_dev->dev;
                          ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/core/pm.c:1201:17: note: Value stored to 'dev' during its initialization is never read
           struct device *dev = &mhi_cntrl->mhi_dev->dev;
                          ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 7 warnings (7 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   7 warnings generated.
   drivers/usb/cdns3/cdns3-ti.c:160:2: warning: Value stored to 'reg' is never read [clang-analyzer-deadcode.DeadStores]
           reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/cdns3/cdns3-ti.c:160:2: note: Value stored to 'reg' is never read
           reg = cdns_ti_readl(data, USBSS_STATIC_CONFIG);
           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   Suppressed 10 warnings (10 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
>> drivers/soc/qcom/llcc-qcom.c:88:8: warning: Excessive padding in 'struct llcc_slice_config' (6 padding bytes, where 2 is optimal). Optimal fields order: usecase_id, slice_id, max_cap, priority, bonus_ways, res_ways, cache_mode, probe_target_ways, fixed_size, dis_cap_alloc, retain_on_pc, activate_on_init, write_scid_en, write_scid_cacheable_en, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct llcc_slice_config {
   ~~~~~~~^~~~~~~~~~~~~~~~~~~
   drivers/soc/qcom/llcc-qcom.c:88:8: note: Excessive padding in 'struct llcc_slice_config' (6 padding bytes, where 2 is optimal). Optimal fields order: usecase_id, slice_id, max_cap, priority, bonus_ways, res_ways, cache_mode, probe_target_ways, fixed_size, dis_cap_alloc, retain_on_pc, activate_on_init, write_scid_en, write_scid_cacheable_en, consider reordering the fields or adding explicit padding members
   struct llcc_slice_config {
   ~~~~~~~^~~~~~~~~~~~~~~~~~~
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   Suppressed 2 warnings (2 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   10 warnings generated.
   drivers/firewire/core-cdev.c:611:2: warning: 7th function call argument is an uninitialized value [clang-analyzer-core.CallAndMessage]
           fw_send_request(client->device->card, &e->r.transaction,
           ^
   drivers/firewire/core-cdev.c:1481:6: note: Assuming field 'speed' is <= field 'link_speed'
           if (a->speed > client->device->card->link_speed ||
               ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/firewire/core-cdev.c:1481:6: note: Left side of '||' is false
           if (a->speed > client->device->card->link_speed ||
               ^
   drivers/firewire/core-cdev.c:1482:6: note: Assuming the condition is false
               a->length > 1024 << a->speed)
               ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/firewire/core-cdev.c:1481:2: note: '?' condition is false
           if (a->speed > client->device->card->link_speed ||
           ^
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^
   include/linux/compiler.h:58:31: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                 ^
   drivers/firewire/core-cdev.c:1481:9: note: Field 'speed' is <= field 'link_speed'
           if (a->speed > client->device->card->link_speed ||
                  ^
   drivers/firewire/core-cdev.c:1481:6: note: Left side of '||' is false
           if (a->speed > client->device->card->link_speed ||
               ^
   drivers/firewire/core-cdev.c:1481:2: note: '?' condition is false
           if (a->speed > client->device->card->link_speed ||
           ^
   include/linux/compiler.h:56:28: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ^
   include/linux/compiler.h:58:69: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                       ^
   include/linux/compiler.h:69:2: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
           ^
   drivers/firewire/core-cdev.c:1481:2: note: Taking false branch
           if (a->speed > client->device->card->link_speed ||
           ^
   include/linux/compiler.h:56:23: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                         ^
   drivers/firewire/core-cdev.c:1485:6: note: Assuming field 'tag' is <= 3
           if (a->tag > 3 || a->channel > 63 || a->sy > 15)
               ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                                                 ^~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/firewire/core-cdev.c:1485:6: note: Left side of '||' is false
           if (a->tag > 3 || a->channel > 63 || a->sy > 15)
               ^
   drivers/firewire/core-cdev.c:1485:20: note: Assuming field 'channel' is <= 63
           if (a->tag > 3 || a->channel > 63 || a->sy > 15)
                             ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )

vim +88 drivers/soc/qcom/llcc-qcom.c

8008e7902f28eb Sai Prakash Ranjan    2022-01-28   60  
99356b03b431f9 Vivek Gautam          2019-07-18   61  /**
171c03171a4cdf Lee Jones             2020-11-03   62   * struct llcc_slice_config - Data associated with the llcc slice
99356b03b431f9 Vivek Gautam          2019-07-18   63   * @usecase_id: Unique id for the client's use case
99356b03b431f9 Vivek Gautam          2019-07-18   64   * @slice_id: llcc slice id for each client
99356b03b431f9 Vivek Gautam          2019-07-18   65   * @max_cap: The maximum capacity of the cache slice provided in KB
99356b03b431f9 Vivek Gautam          2019-07-18   66   * @priority: Priority of the client used to select victim line for replacement
99356b03b431f9 Vivek Gautam          2019-07-18   67   * @fixed_size: Boolean indicating if the slice has a fixed capacity
99356b03b431f9 Vivek Gautam          2019-07-18   68   * @bonus_ways: Bonus ways are additional ways to be used for any slice,
99356b03b431f9 Vivek Gautam          2019-07-18   69   *		if client ends up using more than reserved cache ways. Bonus
99356b03b431f9 Vivek Gautam          2019-07-18   70   *		ways are allocated only if they are not reserved for some
99356b03b431f9 Vivek Gautam          2019-07-18   71   *		other client.
99356b03b431f9 Vivek Gautam          2019-07-18   72   * @res_ways: Reserved ways for the cache slice, the reserved ways cannot
99356b03b431f9 Vivek Gautam          2019-07-18   73   *		be used by any other client than the one its assigned to.
99356b03b431f9 Vivek Gautam          2019-07-18   74   * @cache_mode: Each slice operates as a cache, this controls the mode of the
99356b03b431f9 Vivek Gautam          2019-07-18   75   *             slice: normal or TCM(Tightly Coupled Memory)
99356b03b431f9 Vivek Gautam          2019-07-18   76   * @probe_target_ways: Determines what ways to probe for access hit. When
99356b03b431f9 Vivek Gautam          2019-07-18   77   *                    configured to 1 only bonus and reserved ways are probed.
99356b03b431f9 Vivek Gautam          2019-07-18   78   *                    When configured to 0 all ways in llcc are probed.
99356b03b431f9 Vivek Gautam          2019-07-18   79   * @dis_cap_alloc: Disable capacity based allocation for a client
99356b03b431f9 Vivek Gautam          2019-07-18   80   * @retain_on_pc: If this bit is set and client has maintained active vote
99356b03b431f9 Vivek Gautam          2019-07-18   81   *               then the ways assigned to this client are not flushed on power
99356b03b431f9 Vivek Gautam          2019-07-18   82   *               collapse.
99356b03b431f9 Vivek Gautam          2019-07-18   83   * @activate_on_init: Activate the slice immediately after it is programmed
c4df37fe186de4 Manivannan Sadhasivam 2020-11-30   84   * @write_scid_en: Bit enables write cache support for a given scid.
2b8175a1f10836 Sai Prakash Ranjan    2022-01-28   85   * @write_scid_cacheable_en: Enables write cache cacheable support for a
2b8175a1f10836 Sai Prakash Ranjan    2022-01-28   86   *			     given scid (not supported on v2 or older hardware).
99356b03b431f9 Vivek Gautam          2019-07-18   87   */
99356b03b431f9 Vivek Gautam          2019-07-18  @88  struct llcc_slice_config {
99356b03b431f9 Vivek Gautam          2019-07-18   89  	u32 usecase_id;
99356b03b431f9 Vivek Gautam          2019-07-18   90  	u32 slice_id;
99356b03b431f9 Vivek Gautam          2019-07-18   91  	u32 max_cap;
99356b03b431f9 Vivek Gautam          2019-07-18   92  	u32 priority;
99356b03b431f9 Vivek Gautam          2019-07-18   93  	bool fixed_size;
99356b03b431f9 Vivek Gautam          2019-07-18   94  	u32 bonus_ways;
99356b03b431f9 Vivek Gautam          2019-07-18   95  	u32 res_ways;
99356b03b431f9 Vivek Gautam          2019-07-18   96  	u32 cache_mode;
99356b03b431f9 Vivek Gautam          2019-07-18   97  	u32 probe_target_ways;
99356b03b431f9 Vivek Gautam          2019-07-18   98  	bool dis_cap_alloc;
99356b03b431f9 Vivek Gautam          2019-07-18   99  	bool retain_on_pc;
99356b03b431f9 Vivek Gautam          2019-07-18  100  	bool activate_on_init;
c4df37fe186de4 Manivannan Sadhasivam 2020-11-30  101  	bool write_scid_en;
2b8175a1f10836 Sai Prakash Ranjan    2022-01-28  102  	bool write_scid_cacheable_en;
99356b03b431f9 Vivek Gautam          2019-07-18  103  };
99356b03b431f9 Vivek Gautam          2019-07-18  104  

:::::: The code at line 88 was first introduced by commit
:::::: 99356b03b431f9589bbaec2bc5bacceccb3dd99a soc: qcom: Make llcc-qcom a generic driver

:::::: TO: Vivek Gautam <vivek.gautam@codeaurora.org>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
