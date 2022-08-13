Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602D259198D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbiHMJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 05:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMJXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 05:23:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96992495C
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660382596; x=1691918596;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YNBQvrYvdzZE0AgajE/iB5ni0WRyW7xZGldh/BfmSpM=;
  b=bBIUB3qsDCZUf6r2GvBidWqpv9RPaJBtCZO98eUVCGrI/zlU38ttsymy
   XznMkC55rempUD7klYSQaxX1Z6QzubQAnhVjhyi0mNunF9A+iCEQRiIVL
   v3CclVspxmxL7ARIsDAHukn4uL5ed1mQmmvRTJBXBAAerr0TSURTJIJzn
   AWUFMMDcb03jYBdWOVcUvmj529jg9GXpLp4DML60Eq2ffSuYJcfehnd97
   FURrqXbB+OmE6XMOwIHL+JYgBurK3E9maJg9FHmxmthk6L483/v/9KlVX
   abVEwt4KNkcY5C1dW00GLtVR65Q1Oe6M3r65bYHJKOzrTRWipZDc5woh4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="272134552"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="272134552"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 02:23:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="556781879"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Aug 2022 02:23:14 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMnMP-0001WN-1e;
        Sat, 13 Aug 2022 09:23:13 +0000
Date:   Sat, 13 Aug 2022 17:22:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/soc/mediatek/mt8195/mt8195-audsys-clk.c:17:8: warning:
 Excessive padding in 'struct afe_gate' (6 padding bytes, where 2 is
 optimal). Optimal fields order: id, name, parent_name, reg, ops, flags, bit,
 cg_flags, consider reordering the fields or addin...
Message-ID: <202208131740.YujhyUNT-lkp@intel.com>
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
head:   69dac8e431af26173ca0a1ebc87054e01c585bcc
commit: 6746cc858259985a945a07075a19ec4d24352407 ASoC: mediatek: mt8195: add platform driver
date:   12 months ago
config: arm-randconfig-c002-20220810 (https://download.01.org/0day-ci/archive/20220813/202208131740.YujhyUNT-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6746cc858259985a945a07075a19ec4d24352407
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6746cc858259985a945a07075a19ec4d24352407
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

clang-analyzer warnings: (new ones prefixed by >>)
           unsigned int space = cdma->slots_free;
                        ^~~~~   ~~~~~~~~~~~~~~~~
   1 warning generated.
   sound/soc/atmel/mchp-i2s-mcc.c:633:9: warning: The result of the left shift is undefined because the left operand is negative [clang-analyzer-core.UndefinedBinaryOperatorResult]
           mrb |= MCHP_I2SMCC_MRB_DMACHUNK(channels);
                  ^
   sound/soc/atmel/mchp-i2s-mcc.c:183:24: note: expanded from macro 'MCHP_I2SMCC_MRB_DMACHUNK'
           (((fls(no_words) - 1) << 8) & MCHP_I2SMCC_MRB_DMACHUNK_MASK)
             ~~~~~~~~~~~~~~~~~~~ ^
   sound/soc/atmel/mchp-i2s-mcc.c:520:22: note: Assuming field 'stream' is not equal to SNDRV_PCM_STREAM_PLAYBACK
           bool is_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/atmel/mchp-i2s-mcc.c:522:2: note: Taking false branch
           dev_dbg(dev->dev, "%s() rate=%u format=%#x width=%u channels=%u\n",
           ^
   include/linux/dev_printk.h:130:2: note: expanded from macro 'dev_dbg'
           if (0)                                                          \
           ^
   sound/soc/atmel/mchp-i2s-mcc.c:526:2: note: Control jumps to 'case 4:'  at line 541
           switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
           ^
   sound/soc/atmel/mchp-i2s-mcc.c:543:3: note:  Execution continues on line 549
                   break;
                   ^
   sound/soc/atmel/mchp-i2s-mcc.c:549:2: note: Control jumps to 'case 4096:'  at line 562
           switch (dev->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
           ^
   sound/soc/atmel/mchp-i2s-mcc.c:565:7: note: Assuming field 'sysclk' is 0
                   if (dev->sysclk)
                       ^~~~~~~~~~~
   sound/soc/atmel/mchp-i2s-mcc.c:565:3: note: Taking false branch
                   if (dev->sysclk)
                   ^
   sound/soc/atmel/mchp-i2s-mcc.c:567:3: note:  Execution continues on line 573
                   break;
                   ^
   sound/soc/atmel/mchp-i2s-mcc.c:573:6: note: Assuming the condition is false
           if (dev->fmt & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/atmel/mchp-i2s-mcc.c:573:2: note: Taking false branch
           if (dev->fmt & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
           ^
   sound/soc/atmel/mchp-i2s-mcc.c:607:13: note: Assuming the condition is false
           } else if (dev->fmt & SND_SOC_DAIFMT_DSP_A) {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/atmel/mchp-i2s-mcc.c:607:9: note: Taking false branch
           } else if (dev->fmt & SND_SOC_DAIFMT_DSP_A) {
                  ^
   sound/soc/atmel/mchp-i2s-mcc.c:633:9: note: The result of the left shift is undefined because the left operand is negative
           mrb |= MCHP_I2SMCC_MRB_DMACHUNK(channels);
                  ^
   sound/soc/atmel/mchp-i2s-mcc.c:183:24: note: expanded from macro 'MCHP_I2SMCC_MRB_DMACHUNK'
           (((fls(no_words) - 1) << 8) & MCHP_I2SMCC_MRB_DMACHUNK_MASK)
             ~~~~~~~~~~~~~~~~~~~ ^
   1 warning generated.
   Suppressed 1 warnings (1 with check filters).
   1 warning generated.
   Suppressed 1 warnings (1 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   2 warnings generated.
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:126:29: warning: Value stored to 'memif' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
           struct mtk_base_afe_memif *memif = &afe->memif[id];
                                      ^~~~~   ~~~~~~~~~~~~~~~
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:126:29: note: Value stored to 'memif' during its initialization is never read
           struct mtk_base_afe_memif *memif = &afe->memif[id];
                                      ^~~~~   ~~~~~~~~~~~~~~~
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:364:6: warning: Array access (via field 'reg_back_up') results in a null pointer dereference [clang-analyzer-core.NullDereference]
                                    afe->reg_back_up[i]);
                                    ^    ~~~~~~~~~~~
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:354:6: note: Left side of '||' is false
           if (pm_runtime_status_suspended(dev) || !afe->suspended)
               ^
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:354:42: note: Assuming field 'suspended' is true
           if (pm_runtime_status_suspended(dev) || !afe->suspended)
                                                   ^~~~~~~~~~~~~~~
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:354:2: note: Taking false branch
           if (pm_runtime_status_suspended(dev) || !afe->suspended)
           ^
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:359:6: note: Assuming field 'reg_back_up' is null
           if (!afe->reg_back_up)
               ^~~~~~~~~~~~~~~~~
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:359:2: note: Taking true branch
           if (!afe->reg_back_up)
           ^
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:360:3: note: Taking false branch
                   dev_dbg(dev, "%s no reg_backup\n", __func__);
                   ^
   include/linux/dev_printk.h:130:2: note: expanded from macro 'dev_dbg'
           if (0)                                                          \
           ^
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:362:14: note: Assuming 'i' is < field 'reg_back_up_list_num'
           for (i = 0; i < afe->reg_back_up_list_num; i++)
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:362:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < afe->reg_back_up_list_num; i++)
           ^
   sound/soc/mediatek/common/mtk-afe-fe-dai.c:364:6: note: Array access (via field 'reg_back_up') results in a null pointer dereference
                                    afe->reg_back_up[i]);
                                    ^    ~~~~~~~~~~~
   1 warning generated.
>> sound/soc/mediatek/mt8195/mt8195-audsys-clk.c:17:8: warning: Excessive padding in 'struct afe_gate' (6 padding bytes, where 2 is optimal). Optimal fields order: id, name, parent_name, reg, ops, flags, bit, cg_flags, consider reordering the fields or adding explicit padding members [clang-analyzer-optin.performance.Padding]
   struct afe_gate {
   ~~~~~~~^~~~~~~~~~
   sound/soc/mediatek/mt8195/mt8195-audsys-clk.c:17:8: note: Excessive padding in 'struct afe_gate' (6 padding bytes, where 2 is optimal). Optimal fields order: id, name, parent_name, reg, ops, flags, bit, cg_flags, consider reordering the fields or adding explicit padding members
   struct afe_gate {
   ~~~~~~~^~~~~~~~~~
   1 warning generated.
   drivers/hwmon/npcm750-pwm-fan.c:876:2: warning: Value stored to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
           ret = npcm7xx_pwm_config_set(data, pwm_port,
           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/npcm750-pwm-fan.c:876:2: note: Value stored to 'ret' is never read
           ret = npcm7xx_pwm_config_set(data, pwm_port,
           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.
   drivers/hwmon/pc87360.c:1450:12: warning: The right operand of '>=' is a garbage value due to array index out of bounds [clang-analyzer-core.UndefinedBinaryOperatorResult]
                   if (init >= init_temp[i]) {
                            ^
   drivers/hwmon/pc87360.c:1203:6: note: Assuming 'data' is non-null
           if (!data)
               ^~~~~
   drivers/hwmon/pc87360.c:1203:2: note: Taking false branch
           if (!data)
           ^
   drivers/hwmon/pc87360.c:1206:2: note: Control jumps to the 'default' case at line 1207
           switch (devid) {
           ^
   drivers/hwmon/pc87360.c:1210:3: note:  Execution continues on line 1233
                   break;
                   ^
   drivers/hwmon/pc87360.c:1234:2: note: Loop condition is false.  Exiting loop
           mutex_init(&data->lock);
           ^
   include/linux/mutex.h:113:32: note: expanded from macro 'mutex_init'
   #define mutex_init(mutex)                                               \
                                                                           ^
   drivers/hwmon/pc87360.c:1235:2: note: Loop condition is false.  Exiting loop
           mutex_init(&data->update_lock);
           ^
   include/linux/mutex.h:113:32: note: expanded from macro 'mutex_init'
   #define mutex_init(mutex)                                               \
                                                                           ^
   drivers/hwmon/pc87360.c:1238:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < LDNI_MAX; i++) {
           ^
   drivers/hwmon/pc87360.c:1240:7: note: Assuming the condition is false
                   if (data->address[i]
                       ^~~~~~~~~~~~~~~~
   drivers/hwmon/pc87360.c:1241:4: note: Left side of '&&' is false
                    && !devm_request_region(dev, extra_isa[i], PC87360_EXTENT,
                    ^
   drivers/hwmon/pc87360.c:1238:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < LDNI_MAX; i++) {
           ^
   drivers/hwmon/pc87360.c:1240:7: note: Assuming the condition is false
                   if (data->address[i]
                       ^~~~~~~~~~~~~~~~
   drivers/hwmon/pc87360.c:1241:4: note: Left side of '&&' is false
                    && !devm_request_region(dev, extra_isa[i], PC87360_EXTENT,
                    ^
   drivers/hwmon/pc87360.c:1238:2: note: Loop condition is true.  Entering loop body
           for (i = 0; i < LDNI_MAX; i++) {
           ^
   drivers/hwmon/pc87360.c:1240:7: note: Assuming the condition is false
                   if (data->address[i]
                       ^~~~~~~~~~~~~~~~
   drivers/hwmon/pc87360.c:1241:4: note: Left side of '&&' is false
                    && !devm_request_region(dev, extra_isa[i], PC87360_EXTENT,
                    ^
   drivers/hwmon/pc87360.c:1238:2: note: Loop condition is false. Execution continues on line 1251
           for (i = 0; i < LDNI_MAX; i++) {
           ^
   drivers/hwmon/pc87360.c:1251:6: note: Assuming field 'fannr' is 0
           if (data->fannr)
               ^~~~~~~~~~~
   drivers/hwmon/pc87360.c:1251:2: note: Taking false branch
           if (data->fannr)
           ^
   drivers/hwmon/pc87360.c:1259:6: note: Assuming field 'innr' is 0
           if (data->innr) {
               ^~~~~~~~~~
   drivers/hwmon/pc87360.c:1259:2: note: Taking false branch
           if (data->innr) {
           ^
   drivers/hwmon/pc87360.c:1275:2: note: Loop condition is false. Execution continues on line 1282
           for (i = 0; i < data->fannr; i++) {
           ^
   drivers/hwmon/pc87360.c:1282:6: note: Assuming 'init' is > 0
           if (init > 0) {
               ^~~~~~~~
   drivers/hwmon/pc87360.c:1282:2: note: Taking true branch
           if (init > 0) {
           ^
   drivers/hwmon/pc87360.c:1283:7: note: Assuming 'devid' is not equal to 233
                   if (devid == 0xe9 && data->address[1]) /* PC87366 */
                       ^~~~~~~~~~~~~
   drivers/hwmon/pc87360.c:1283:21: note: Left side of '&&' is false
                   if (devid == 0xe9 && data->address[1]) /* PC87366 */
                                     ^
   drivers/hwmon/pc87360.c:1286:3: note: Calling 'pc87360_init_device'
                   pc87360_init_device(pdev, use_thermistors);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +17 sound/soc/mediatek/mt8195/mt8195-audsys-clk.c

d62ad762f67585 Trevor Wu 2021-08-19  16  
d62ad762f67585 Trevor Wu 2021-08-19 @17  struct afe_gate {
d62ad762f67585 Trevor Wu 2021-08-19  18  	int id;
d62ad762f67585 Trevor Wu 2021-08-19  19  	const char *name;
d62ad762f67585 Trevor Wu 2021-08-19  20  	const char *parent_name;
d62ad762f67585 Trevor Wu 2021-08-19  21  	int reg;
d62ad762f67585 Trevor Wu 2021-08-19  22  	u8 bit;
d62ad762f67585 Trevor Wu 2021-08-19  23  	const struct clk_ops *ops;
d62ad762f67585 Trevor Wu 2021-08-19  24  	unsigned long flags;
d62ad762f67585 Trevor Wu 2021-08-19  25  	u8 cg_flags;
d62ad762f67585 Trevor Wu 2021-08-19  26  };
d62ad762f67585 Trevor Wu 2021-08-19  27  

:::::: The code at line 17 was first introduced by commit
:::::: d62ad762f67585acfb5e03f71b28a52dc4604cf2 ASoC: mediatek: mt8195: support audsys clock control

:::::: TO: Trevor Wu <trevor.wu@mediatek.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
