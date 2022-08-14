Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCF0592371
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiHNQVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241112AbiHNQVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:21:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7794C1117C
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660493526; x=1692029526;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EpYKSUhgjQBxHAXHoS+FAxK4JN8zhRoYXtGiiS8x1Cc=;
  b=LLkvei3pbuO//hlY8n+C1UeHSrwVQtSU1T5JXn6P5dG7SzhSY6Yf4uoI
   ZqaNMb+JsSNJdLOMO9RGNPsWrgJEpSeahKq0BrNPy/uJ/q0+NxvE9tymA
   TW0GbNWO0GwmCs3Dc1/3keDZgPFUyXyZ8I8Sx/ED8g63GmNr9VXDJGBhg
   bJ7ha1SYorv0iUccrK/RnqGi37kChhnsFGtFHJYeCfFGwwnDGFfyA0XDE
   Gt5qVgK2yzFsJ9xQg48Mt1/4s7RTCo4N3sbcJhvlIWguF0E4xrnXiPLGv
   0oSvBVBLs26vKPiw0SU/2/DgSPRoPdUnolms4PjorOiuexhS5UCMAwb0V
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="293106212"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="293106212"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 09:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="934241117"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2022 09:12:04 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNGDb-0000Hh-2U;
        Sun, 14 Aug 2022 16:12:03 +0000
Date:   Mon, 15 Aug 2022 00:11:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/mux/mmio.c:76:34: error: storage size of 'field' isn't known
Message-ID: <202208150000.q01BOnro-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea23e7c464bfdec04b52cf61edb62030e9e0d0a
commit: e4d4371253029528c02bfb43a46c252e1c3d035f phy: phy-can-transceiver: Add support for setting mux
date:   4 months ago
config: s390-randconfig-r013-20220803 (https://download.01.org/0day-ci/archive/20220815/202208150000.q01BOnro-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e4d4371253029528c02bfb43a46c252e1c3d035f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e4d4371253029528c02bfb43a46c252e1c3d035f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/mux/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/mux/mmio.c: In function 'mux_mmio_probe':
>> drivers/mux/mmio.c:76:34: error: storage size of 'field' isn't known
      76 |                 struct reg_field field;
         |                                  ^~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from drivers/mux/mmio.c:8:
>> include/linux/bits.h:24:28: error: first argument to '__builtin_choose_expr' not a constant
      24 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |                            ^~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |          ^~~~~~~~~~~~~~~~~~~
   drivers/mux/mmio.c:96:29: note: in expansion of macro 'GENMASK'
      96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
         |                             ^~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bits.h:24:10: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      24 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |          ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |          ^~~~~~~~~~~~~~~~~~~
   drivers/mux/mmio.c:96:29: note: in expansion of macro 'GENMASK'
      96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
         |                             ^~~~~~~
>> drivers/mux/mmio.c:102:29: error: implicit declaration of function 'devm_regmap_field_alloc' [-Werror=implicit-function-declaration]
     102 |                 fields[i] = devm_regmap_field_alloc(dev, regmap, field);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/mux/mmio.c:76:34: warning: unused variable 'field' [-Wunused-variable]
      76 |                 struct reg_field field;
         |                                  ^~~~~
   cc1: some warnings being treated as errors


vim +76 drivers/mux/mmio.c

73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   35  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   36  static int mux_mmio_probe(struct platform_device *pdev)
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   37  {
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   38  	struct device *dev = &pdev->dev;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   39  	struct device_node *np = dev->of_node;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   40  	struct regmap_field **fields;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   41  	struct mux_chip *mux_chip;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   42  	struct regmap *regmap;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   43  	int num_fields;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   44  	int ret;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   45  	int i;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   46  
8ecfaca7926f4bb drivers/mux/mmio.c     Pankaj Bansal 2019-06-12   47  	if (of_device_is_compatible(np, "mmio-mux"))
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   48  		regmap = syscon_node_to_regmap(np->parent);
8ecfaca7926f4bb drivers/mux/mmio.c     Pankaj Bansal 2019-06-12   49  	else
8ecfaca7926f4bb drivers/mux/mmio.c     Pankaj Bansal 2019-06-12   50  		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   51  	if (IS_ERR(regmap)) {
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   52  		ret = PTR_ERR(regmap);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   53  		dev_err(dev, "failed to get regmap: %d\n", ret);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   54  		return ret;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   55  	}
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   56  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   57  	ret = of_property_count_u32_elems(np, "mux-reg-masks");
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   58  	if (ret == 0 || ret % 2)
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   59  		ret = -EINVAL;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   60  	if (ret < 0) {
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   61  		dev_err(dev, "mux-reg-masks property missing or invalid: %d\n",
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   62  			ret);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   63  		return ret;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   64  	}
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   65  	num_fields = ret / 2;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   66  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   67  	mux_chip = devm_mux_chip_alloc(dev, num_fields, num_fields *
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   68  				       sizeof(*fields));
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   69  	if (IS_ERR(mux_chip))
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   70  		return PTR_ERR(mux_chip);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   71  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   72  	fields = mux_chip_priv(mux_chip);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   73  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   74  	for (i = 0; i < num_fields; i++) {
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   75  		struct mux_control *mux = &mux_chip->mux[i];
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  @76  		struct reg_field field;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   77  		s32 idle_state = MUX_IDLE_AS_IS;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   78  		u32 reg, mask;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   79  		int bits;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   80  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   81  		ret = of_property_read_u32_index(np, "mux-reg-masks",
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   82  						 2 * i, &reg);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   83  		if (!ret)
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   84  			ret = of_property_read_u32_index(np, "mux-reg-masks",
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   85  							 2 * i + 1, &mask);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   86  		if (ret < 0) {
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   87  			dev_err(dev, "bitfield %d: failed to read mux-reg-masks property: %d\n",
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   88  				i, ret);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   89  			return ret;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   90  		}
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   91  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   92  		field.reg = reg;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   93  		field.msb = fls(mask) - 1;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   94  		field.lsb = ffs(mask) - 1;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   95  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   96  		if (mask != GENMASK(field.msb, field.lsb)) {
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   97  			dev_err(dev, "bitfield %d: invalid mask 0x%x\n",
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   98  				i, mask);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14   99  			return -EINVAL;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  100  		}
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  101  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14 @102  		fields[i] = devm_regmap_field_alloc(dev, regmap, field);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  103  		if (IS_ERR(fields[i])) {
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  104  			ret = PTR_ERR(fields[i]);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  105  			dev_err(dev, "bitfield %d: failed allocate: %d\n",
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  106  				i, ret);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  107  			return ret;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  108  		}
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  109  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  110  		bits = 1 + field.msb - field.lsb;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  111  		mux->states = 1 << bits;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  112  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  113  		of_property_read_u32_index(np, "idle-states", i,
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  114  					   (u32 *)&idle_state);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  115  		if (idle_state != MUX_IDLE_AS_IS) {
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  116  			if (idle_state < 0 || idle_state >= mux->states) {
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  117  				dev_err(dev, "bitfield: %d: out of range idle state %d\n",
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  118  					i, idle_state);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  119  				return -EINVAL;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  120  			}
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  121  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  122  			mux->idle_state = idle_state;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  123  		}
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  124  	}
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  125  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  126  	mux_chip->ops = &mux_mmio_ops;
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  127  
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  128  	return devm_mux_chip_register(dev, mux_chip);
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  129  }
73726380a26fa1e drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  130  

:::::: The code at line 76 was first introduced by commit
:::::: 73726380a26fa1ed490f30fccee10ed9da28dc0c mux: mmio-based syscon mux controller

:::::: TO: Philipp Zabel <p.zabel@pengutronix.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
