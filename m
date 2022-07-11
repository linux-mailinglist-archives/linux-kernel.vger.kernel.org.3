Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE99556D294
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 03:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiGKBcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 21:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiGKBcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 21:32:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40806175A0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 18:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657503128; x=1689039128;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Do+BW5NtmQCWf25mXM2YMS+0i+lDGjpkd8tw8rKmEiU=;
  b=DeduY02A63yO5GGyqMbHj9yzFuO0kLQCtjAXF8zdHq6P90qY6BJoCl8Z
   BI2HFDOsbOl5txjYIt5oVzTOp57Y1UWBbuhtwDKbv6QdddVilJE3i+uAp
   fAjtt6x1H0w9VpJoNRD84DY+Ojy+AYJO7iig/jDo3C3i7OHi3dPw67pWM
   5i/q5m6/Mr27ifDELnhoK6jZgrnVB5staJM9YGngvHkFXKzg+d0EjvSUB
   VuKLb5LT8Qo5SU2tASZVZ66auLa3sBMYonp1JA8qpxVbaH3nJ5cKGQQpA
   UjN1kSK0uhOI9BLiKjj4f0oUPGrliyEiApHJv2mGdHOr5tVVhht5BmoSc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="264965455"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="264965455"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 18:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="652263497"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2022 18:32:06 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAiHN-00006z-Im;
        Mon, 11 Jul 2022 01:32:05 +0000
Date:   Mon, 11 Jul 2022 09:31:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:143:8: warning: Excessive
 padding in 'struct dw_hdmi' (36 padding bytes, where 4 is optimal). Optimal
 fields order: next_bridge, audio, cec, dev, isfr_clk, iahb_clk, cec_clk,
 i2c, plat_data, ddc, regs, pinctrl, de...
Message-ID: <202207110750.5CHg2vAB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   952c53cd357c71338a59d444933ed48a879229e1
commit: 5bcc48395b9f35dace564de47fcf434cdb67a8e1 drm: bridge: dw-hdmi: Attach to next bridge if available
date:   12 months ago
config: s390-randconfig-c005-20220703 (https://download.01.org/0day-ci/archive/20220711/202207110750.5CHg2vAB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5bcc48395b9f35dace564de47fcf434cdb67a8e1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5bcc48395b9f35dace564de47fcf434cdb67a8e1
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390 clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)
           ^
   include/linux/irqflags.h:238:34: note: expanded from macro 'local_irq_restore'
   #define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
                                    ^
   include/linux/spinlock_api_smp.h:161:2: note: Calling 'should_resched'
           preempt_enable();
           ^
   include/linux/preempt.h:195:15: note: expanded from macro 'preempt_enable'
           if (unlikely(preempt_count_dec_and_test())) \
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/preempt.h:160:27: note: expanded from macro 'preempt_count_dec_and_test'
           ({ preempt_count_sub(1); should_resched(0); })
                                    ^~~~~~~~~~~~~~~~~
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   arch/s390/include/asm/preempt.h:67:18: note: Left side of '||' is false
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:21: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                              ^
   include/linux/compiler_types.h:290:3: note: expanded from macro '__native_word'
           (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
            ^
   arch/s390/include/asm/preempt.h:67:18: note: Left side of '||' is false
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:21: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                              ^
   include/linux/compiler_types.h:290:3: note: expanded from macro '__native_word'
           (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
            ^
   arch/s390/include/asm/preempt.h:67:18: note: Left side of '||' is true
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:21: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                              ^
   include/linux/compiler_types.h:291:28: note: expanded from macro '__native_word'
            sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
                                     ^
   arch/s390/include/asm/preempt.h:67:18: note: Taking false branch
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:2: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
           ^
   include/linux/compiler_types.h:328:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:316:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:308:3: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                   ^
   arch/s390/include/asm/preempt.h:67:18: note: Loop condition is false.  Exiting loop
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:2: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
           ^
   include/linux/compiler_types.h:328:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:316:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:306:2: note: expanded from macro '__compiletime_assert'
           do {                                                            \
           ^
   arch/s390/include/asm/preempt.h:67:18: note: Dereference of null pointer
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:50:2: note: expanded from macro 'READ_ONCE'
           __READ_ONCE(x);                                                 \
           ^
   include/asm-generic/rwonce.h:44:24: note: expanded from macro '__READ_ONCE'
   #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
                           ^
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
>> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:143:8: warning: Excessive padding in 'struct dw_hdmi' (36 padding bytes, where 4 is optimal). Optimal fields order: next_bridge, audio, cec, dev, isfr_clk, iahb_clk, cec_clk, i2c, plat_data, ddc, regs, pinctrl, default_state, unwedge_state, curr_conn, regm, enable_audio, disable_audio, cec_notifier, plugged_cb, codec_dev, phy, mutex, audio_mutex, cec_notifier_mutex, previous_mode, bridge, connector, version, vic, force, audio_lock, sample_rate, audio_cts, audio_n, reg_shift, last_connector_result, hdmi_data, sink_is_hdmi, sink_has_audio, disabled, bridge_is_on, rxsense, phy_mask, mc_clkdis, audio_enable, edid, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct dw_hdmi {
   ~~~~~~~^~~~~~~~~
   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c:143:8: note: Excessive padding in 'struct dw_hdmi' (36 padding bytes, where 4 is optimal). Optimal fields order: next_bridge, audio, cec, dev, isfr_clk, iahb_clk, cec_clk, i2c, plat_data, ddc, regs, pinctrl, default_state, unwedge_state, curr_conn, regm, enable_audio, disable_audio, cec_notifier, plugged_cb, codec_dev, phy, mutex, audio_mutex, cec_notifier_mutex, previous_mode, bridge, connector, version, vic, force, audio_lock, sample_rate, audio_cts, audio_n, reg_shift, last_connector_result, hdmi_data, sink_is_hdmi, sink_has_audio, disabled, bridge_is_on, rxsense, phy_mask, mc_clkdis, audio_enable, edid, consider reordering the fields or adding explicit padding members
   struct dw_hdmi {
   ~~~~~~~^~~~~~~~~
   Suppressed 20 warnings (8 in non-user code, 12 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   18 warnings generated.
   arch/s390/include/asm/preempt.h:67:18: warning: Dereference of null pointer [clang-analyzer-core.NullDereference]
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:50:2: note: expanded from macro 'READ_ONCE'
           __READ_ONCE(x);                                                 \
           ^
   include/asm-generic/rwonce.h:44:24: note: expanded from macro '__READ_ONCE'
   #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
                           ^
   drivers/dma-buf/dma-buf.c:425:6: note: Assuming field 'name' is null
           if (dmabuf->name)
               ^~~~~~~~~~~~
   drivers/dma-buf/dma-buf.c:425:2: note: Taking false branch
           if (dmabuf->name)
           ^
   drivers/dma-buf/dma-buf.c:427:2: note: Calling 'spin_unlock'
           spin_unlock(&dmabuf->name_lock);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:394:2: note: Calling '__raw_spin_unlock'
           raw_spin_unlock(&lock->rlock);
           ^
   include/linux/spinlock.h:284:32: note: expanded from macro 'raw_spin_unlock'
   #define raw_spin_unlock(lock)           _raw_spin_unlock(lock)
                                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_api_smp.h:71:32: note: expanded from macro '_raw_spin_unlock'
   #define _raw_spin_unlock(lock) __raw_spin_unlock(lock)
                                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_api_smp.h:150:2: note: Loop condition is false.  Exiting loop
           spin_release(&lock->dep_map, _RET_IP_);
           ^
   include/linux/lockdep.h:540:30: note: expanded from macro 'spin_release'
   #define spin_release(l, i)                      lock_release(l, i)
                                                   ^
   include/linux/lockdep.h:360:31: note: expanded from macro 'lock_release'
   # define lock_release(l, i)                     do { } while (0)
                                                   ^
   include/linux/spinlock_api_smp.h:152:2: note: Calling 'should_resched'
           preempt_enable();
           ^
   include/linux/preempt.h:195:15: note: expanded from macro 'preempt_enable'
           if (unlikely(preempt_count_dec_and_test())) \
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/preempt.h:160:27: note: expanded from macro 'preempt_count_dec_and_test'
           ({ preempt_count_sub(1); should_resched(0); })
                                    ^~~~~~~~~~~~~~~~~
   include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                               ^
   arch/s390/include/asm/preempt.h:67:18: note: Left side of '||' is false
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:21: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                              ^
   include/linux/compiler_types.h:290:3: note: expanded from macro '__native_word'
           (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
            ^
   arch/s390/include/asm/preempt.h:67:18: note: Left side of '||' is false
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:21: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                              ^
   include/linux/compiler_types.h:290:3: note: expanded from macro '__native_word'
           (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
            ^
   arch/s390/include/asm/preempt.h:67:18: note: Left side of '||' is true
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:21: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                              ^
   include/linux/compiler_types.h:291:28: note: expanded from macro '__native_word'
            sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
                                     ^
   arch/s390/include/asm/preempt.h:67:18: note: Taking false branch
           return unlikely(READ_ONCE(S390_lowcore.preempt_count) ==
                           ^
   include/asm-generic/rwonce.h:49:2: note: expanded from macro 'READ_ONCE'
           compiletime_assert_rwonce_type(x);                              \
           ^
   include/asm-generic/rwonce.h:36:2: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \

vim +143 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c

faba6c3cff1776 drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-01-17  142  
b21f4b658df885 drivers/gpu/drm/bridge/dw_hdmi.c          Andy Yan              2014-12-05 @143  struct dw_hdmi {
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  144  	struct drm_connector connector;
70c963ec4f15a1 drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-01-17  145  	struct drm_bridge bridge;
5bcc48395b9f35 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Laurent Pinchart      2020-05-14  146  	struct drm_bridge *next_bridge;
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  147  
be41fc55f1aa3c drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-01-17  148  	unsigned int version;
be41fc55f1aa3c drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-01-17  149  
be41fc55f1aa3c drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-01-17  150  	struct platform_device *audio;
a616e63c56ef35 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Russell King          2017-08-02  151  	struct platform_device *cec;
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  152  	struct device *dev;
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  153  	struct clk *isfr_clk;
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  154  	struct clk *iahb_clk;
ebe32c3e282a62 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Pierre-Hugues Husson  2017-11-25  155  	struct clk *cec_clk;
3efc2fa3b777e6 drivers/gpu/drm/bridge/dw-hdmi.c          Vladimir Zapolskiy    2016-08-24  156  	struct dw_hdmi_i2c *i2c;
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  157  
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  158  	struct hdmi_data_info hdmi_data;
b21f4b658df885 drivers/gpu/drm/bridge/dw_hdmi.c          Andy Yan              2014-12-05  159  	const struct dw_hdmi_plat_data *plat_data;
b21f4b658df885 drivers/gpu/drm/bridge/dw_hdmi.c          Andy Yan              2014-12-05  160  
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  161  	int vic;
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  162  
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  163  	u8 edid[HDMI_EDID_LEN];
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  164  
f1585f6e29f5ab drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-03-06  165  	struct {
f1585f6e29f5ab drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-03-06  166  		const struct dw_hdmi_phy_ops *ops;
f1585f6e29f5ab drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-03-06  167  		const char *name;
f1585f6e29f5ab drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-03-06  168  		void *data;
f1585f6e29f5ab drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-03-06  169  		bool enabled;
f1585f6e29f5ab drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-03-06  170  	} phy;
faba6c3cff1776 drivers/gpu/drm/bridge/dw-hdmi.c          Laurent Pinchart      2017-01-17  171  
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  172  	struct drm_display_mode previous_mode;
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  173  
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  174  	struct i2c_adapter *ddc;
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  175  	void __iomem *regs;
05b1342f5014b7 drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-07-21  176  	bool sink_is_hdmi;
f709ec07e38a71 drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-07-21  177  	bool sink_has_audio;
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  178  
50f9495efe308e drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Douglas Anderson      2019-05-02  179  	struct pinctrl *pinctrl;
50f9495efe308e drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Douglas Anderson      2019-05-02  180  	struct pinctrl_state *default_state;
50f9495efe308e drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Douglas Anderson      2019-05-02  181  	struct pinctrl_state *unwedge_state;
50f9495efe308e drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Douglas Anderson      2019-05-02  182  
b872a8e16b3fb1 drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-06-05  183  	struct mutex mutex;		/* for state below and previous_mode */
381f05a7a8428c drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-06-05  184  	enum drm_connector_force force;	/* mutex-protected force state */
ca7b6b7176ffea drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Laurent Pinchart      2020-05-26  185  	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
b872a8e16b3fb1 drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-06-05  186  	bool disabled;			/* DRM has disabled our bridge */
381f05a7a8428c drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-06-05  187  	bool bridge_is_on;		/* indicates the bridge is on */
aeac23bda87fd9 drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-06-05  188  	bool rxsense;			/* rxsense state */
aeac23bda87fd9 drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-06-05  189  	u8 phy_mask;			/* desired phy int mask settings */
7cc4ab225ae30b drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Russell King          2017-07-31  190  	u8 mc_clkdis;			/* clock disable register */
b872a8e16b3fb1 drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-06-05  191  
b90120a9660884 drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-03-27  192  	spinlock_t audio_lock;
6bcf495317857e drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-02-02  193  	struct mutex audio_mutex;
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  194  	unsigned int sample_rate;
b90120a9660884 drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-03-27  195  	unsigned int audio_cts;
b90120a9660884 drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-03-27  196  	unsigned int audio_n;
b90120a9660884 drivers/gpu/drm/bridge/dw_hdmi.c          Russell King          2015-03-27  197  	bool audio_enable;
0cd9d1428322ec drivers/gpu/drm/bridge/dw_hdmi.c          Andy Yan              2014-12-05  198  
80e2f97968b537 drivers/gpu/drm/bridge/dw-hdmi.c          Neil Armstrong        2017-03-03  199  	unsigned int reg_shift;
80e2f97968b537 drivers/gpu/drm/bridge/dw-hdmi.c          Neil Armstrong        2017-03-03  200  	struct regmap *regm;
a7d555d2f2bd67 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Romain Perier         2017-04-14  201  	void (*enable_audio)(struct dw_hdmi *hdmi);
a7d555d2f2bd67 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Romain Perier         2017-04-14  202  	void (*disable_audio)(struct dw_hdmi *hdmi);
e84b8d75ac116e drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Russell King          2017-07-31  203  
7070fe7386c1a4 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Dariusz Marcinkiewicz 2019-08-14  204  	struct mutex cec_notifier_mutex;
e84b8d75ac116e drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Russell King          2017-07-31  205  	struct cec_notifier *cec_notifier;
a9c82d63ca4819 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Cheng-Yi Chiang       2019-10-28  206  
a9c82d63ca4819 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Cheng-Yi Chiang       2019-10-28  207  	hdmi_codec_plugged_cb plugged_cb;
a9c82d63ca4819 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Cheng-Yi Chiang       2019-10-28  208  	struct device *codec_dev;
a9c82d63ca4819 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c Cheng-Yi Chiang       2019-10-28  209  	enum drm_connector_status last_connector_result;
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  210  };
9aaf880ed4ee3c drivers/staging/imx-drm/imx-hdmi.c        Fabio Estevam         2013-11-29  211  

:::::: The code at line 143 was first introduced by commit
:::::: b21f4b658df885068c65852ef3d9d2f4f2821b03 drm: imx: imx-hdmi: move imx-hdmi to bridge/dw_hdmi

:::::: TO: Andy Yan <andy.yan@rock-chips.com>
:::::: CC: Philipp Zabel <p.zabel@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
