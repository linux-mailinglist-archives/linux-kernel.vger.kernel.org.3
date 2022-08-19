Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87775993C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbiHSDvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 23:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiHSDvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:51:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17FCB5FC
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660881096; x=1692417096;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o6g/5vW2LzbM5xk9w5305aI+SdYx2pAsktvW3DGZUFw=;
  b=M0QonUnIJKSteilqKxVFt5qqg06H051LBJd/G5bp6nkTA2/sV4Uy/Suu
   Yuc1h+R9y63lfyS9eoEdmRZmhWedM12k3U09oSzlosLjBKoJpjerHqY0c
   sk11y4geji0JJ6dCE6aW6XtmXPAhNjwUM9f1rDLeZb1daOss/oq2w65CL
   Pt4L/+W/0c1Ds1sW8rsxZGyb8yWkTTeSTGHCOrtDvgUL8GikmKxR+CD6I
   cc2sC1msqw5zlarsmT//couGRXccm5OGVZSkojEiMEY1q+GWpaW9v6QDB
   ODg6dCKkkTvQRbkoWPYG4ixkiloQH6JqmA2AtcXc9BuGAYTc0tbveoPkh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="279892151"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="279892151"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 20:51:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="936069458"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2022 20:51:33 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOt2j-00012J-11;
        Fri, 19 Aug 2022 03:51:33 +0000
Date:   Fri, 19 Aug 2022 11:50:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 8/16] drivers/clk/clk.c:867:6: error:
 redefinition of 'clk_unprepare'
Message-ID: <202208191116.VPJptuUc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

First bad commit (maybe != root cause):

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   51024ef467ff6c288e679bc72d0e3fcdd54d9b39
commit: 76e6f329b3adc311d5008f4ba833546c7b88369f [8/16] ASoC: apple: Add MCA platform driver for Apple SoCs
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220819/202208191116.VPJptuUc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/76e6f329b3adc311d5008f4ba833546c7b88369f
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 76e6f329b3adc311d5008f4ba833546c7b88369f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clk/clk.c:867:6: error: redefinition of 'clk_unprepare'
     867 | void clk_unprepare(struct clk *clk)
         |      ^~~~~~~~~~~~~
   In file included from drivers/clk/clk.c:9:
   include/linux/clk.h:303:20: note: previous definition of 'clk_unprepare' with type 'void(struct clk *)'
     303 | static inline void clk_unprepare(struct clk *clk)
         |                    ^~~~~~~~~~~~~
>> drivers/clk/clk.c:948:5: error: redefinition of 'clk_prepare'
     948 | int clk_prepare(struct clk *clk)
         |     ^~~~~~~~~~~
   include/linux/clk.h:271:19: note: previous definition of 'clk_prepare' with type 'int(struct clk *)'
     271 | static inline int clk_prepare(struct clk *clk)
         |                   ^~~~~~~~~~~
>> drivers/clk/clk.c:1194:6: error: redefinition of 'clk_is_enabled_when_prepared'
    1194 | bool clk_is_enabled_when_prepared(struct clk *clk)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/clk.h:284:20: note: previous definition of 'clk_is_enabled_when_prepared' with type 'bool(struct clk *)' {aka '_Bool(struct clk *)'}
     284 | static inline bool clk_is_enabled_when_prepared(struct clk *clk)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for COMMON_CLK
   Depends on [n]: !HAVE_LEGACY_CLK [=y]
   Selected by [m]:
   - SND_SOC_APPLE_MCA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && (ARCH_APPLE || COMPILE_TEST [=y])


vim +/clk_unprepare +867 drivers/clk/clk.c

a6adc30ba7bef8 Dong Aisheng     2016-06-30  855  
4dff95dc9477a3 Stephen Boyd     2015-04-30  856  /**
4dff95dc9477a3 Stephen Boyd     2015-04-30  857   * clk_unprepare - undo preparation of a clock source
4dff95dc9477a3 Stephen Boyd     2015-04-30  858   * @clk: the clk being unprepared
4dff95dc9477a3 Stephen Boyd     2015-04-30  859   *
4dff95dc9477a3 Stephen Boyd     2015-04-30  860   * clk_unprepare may sleep, which differentiates it from clk_disable.  In a
4dff95dc9477a3 Stephen Boyd     2015-04-30  861   * simple case, clk_unprepare can be used instead of clk_disable to gate a clk
4dff95dc9477a3 Stephen Boyd     2015-04-30  862   * if the operation may sleep.  One example is a clk which is accessed over
4dff95dc9477a3 Stephen Boyd     2015-04-30  863   * I2c.  In the complex case a clk gate operation may require a fast and a slow
4dff95dc9477a3 Stephen Boyd     2015-04-30  864   * part.  It is this reason that clk_unprepare and clk_disable are not mutually
4dff95dc9477a3 Stephen Boyd     2015-04-30  865   * exclusive.  In fact clk_disable must be called before clk_unprepare.
4dff95dc9477a3 Stephen Boyd     2015-04-30  866   */
4dff95dc9477a3 Stephen Boyd     2015-04-30 @867  void clk_unprepare(struct clk *clk)
b2476490ef1113 Mike Turquette   2012-03-15  868  {
4dff95dc9477a3 Stephen Boyd     2015-04-30  869  	if (IS_ERR_OR_NULL(clk))
4dff95dc9477a3 Stephen Boyd     2015-04-30  870  		return;
b2476490ef1113 Mike Turquette   2012-03-15  871  
a6adc30ba7bef8 Dong Aisheng     2016-06-30  872  	clk_core_unprepare_lock(clk->core);
1e435256d625c2 Olof Johansson   2013-04-27  873  }
4dff95dc9477a3 Stephen Boyd     2015-04-30  874  EXPORT_SYMBOL_GPL(clk_unprepare);
1e435256d625c2 Olof Johansson   2013-04-27  875  
4dff95dc9477a3 Stephen Boyd     2015-04-30  876  static int clk_core_prepare(struct clk_core *core)
4dff95dc9477a3 Stephen Boyd     2015-04-30  877  {
4dff95dc9477a3 Stephen Boyd     2015-04-30  878  	int ret = 0;
b2476490ef1113 Mike Turquette   2012-03-15  879  
a63347251907d7 Stephen Boyd     2015-05-06  880  	lockdep_assert_held(&prepare_lock);
a63347251907d7 Stephen Boyd     2015-05-06  881  
4dff95dc9477a3 Stephen Boyd     2015-04-30  882  	if (!core)
4dff95dc9477a3 Stephen Boyd     2015-04-30  883  		return 0;
b2476490ef1113 Mike Turquette   2012-03-15  884  
4dff95dc9477a3 Stephen Boyd     2015-04-30  885  	if (core->prepare_count == 0) {
9a34b45397e5a3 Marek Szyprowski 2017-08-21  886  		ret = clk_pm_runtime_get(core);
4dff95dc9477a3 Stephen Boyd     2015-04-30  887  		if (ret)
4dff95dc9477a3 Stephen Boyd     2015-04-30  888  			return ret;
b2476490ef1113 Mike Turquette   2012-03-15  889  
9a34b45397e5a3 Marek Szyprowski 2017-08-21  890  		ret = clk_core_prepare(core->parent);
9a34b45397e5a3 Marek Szyprowski 2017-08-21  891  		if (ret)
9a34b45397e5a3 Marek Szyprowski 2017-08-21  892  			goto runtime_put;
9a34b45397e5a3 Marek Szyprowski 2017-08-21  893  
4dff95dc9477a3 Stephen Boyd     2015-04-30  894  		trace_clk_prepare(core);
1c155b3dfe0835 Ulf Hansson      2013-03-12  895  
4dff95dc9477a3 Stephen Boyd     2015-04-30  896  		if (core->ops->prepare)
4dff95dc9477a3 Stephen Boyd     2015-04-30  897  			ret = core->ops->prepare(core->hw);
1c155b3dfe0835 Ulf Hansson      2013-03-12  898  
4dff95dc9477a3 Stephen Boyd     2015-04-30  899  		trace_clk_prepare_complete(core);
b2476490ef1113 Mike Turquette   2012-03-15  900  
9a34b45397e5a3 Marek Szyprowski 2017-08-21  901  		if (ret)
9a34b45397e5a3 Marek Szyprowski 2017-08-21  902  			goto unprepare;
b2476490ef1113 Mike Turquette   2012-03-15  903  	}
b2476490ef1113 Mike Turquette   2012-03-15  904  
4dff95dc9477a3 Stephen Boyd     2015-04-30  905  	core->prepare_count++;
b2476490ef1113 Mike Turquette   2012-03-15  906  
9461f7b33d11cb Jerome Brunet    2018-06-19  907  	/*
9461f7b33d11cb Jerome Brunet    2018-06-19  908  	 * CLK_SET_RATE_GATE is a special case of clock protection
9461f7b33d11cb Jerome Brunet    2018-06-19  909  	 * Instead of a consumer claiming exclusive rate control, it is
9461f7b33d11cb Jerome Brunet    2018-06-19  910  	 * actually the provider which prevents any consumer from making any
9461f7b33d11cb Jerome Brunet    2018-06-19  911  	 * operation which could result in a rate change or rate glitch while
9461f7b33d11cb Jerome Brunet    2018-06-19  912  	 * the clock is prepared.
9461f7b33d11cb Jerome Brunet    2018-06-19  913  	 */
9461f7b33d11cb Jerome Brunet    2018-06-19  914  	if (core->flags & CLK_SET_RATE_GATE)
9461f7b33d11cb Jerome Brunet    2018-06-19  915  		clk_core_rate_protect(core);
9461f7b33d11cb Jerome Brunet    2018-06-19  916  
4dff95dc9477a3 Stephen Boyd     2015-04-30  917  	return 0;
9a34b45397e5a3 Marek Szyprowski 2017-08-21  918  unprepare:
9a34b45397e5a3 Marek Szyprowski 2017-08-21  919  	clk_core_unprepare(core->parent);
9a34b45397e5a3 Marek Szyprowski 2017-08-21  920  runtime_put:
9a34b45397e5a3 Marek Szyprowski 2017-08-21  921  	clk_pm_runtime_put(core);
9a34b45397e5a3 Marek Szyprowski 2017-08-21  922  	return ret;
b2476490ef1113 Mike Turquette   2012-03-15  923  }
b2476490ef1113 Mike Turquette   2012-03-15  924  
a6adc30ba7bef8 Dong Aisheng     2016-06-30  925  static int clk_core_prepare_lock(struct clk_core *core)
a6adc30ba7bef8 Dong Aisheng     2016-06-30  926  {
a6adc30ba7bef8 Dong Aisheng     2016-06-30  927  	int ret;
a6adc30ba7bef8 Dong Aisheng     2016-06-30  928  
a6adc30ba7bef8 Dong Aisheng     2016-06-30  929  	clk_prepare_lock();
a6adc30ba7bef8 Dong Aisheng     2016-06-30  930  	ret = clk_core_prepare(core);
a6adc30ba7bef8 Dong Aisheng     2016-06-30  931  	clk_prepare_unlock();
a6adc30ba7bef8 Dong Aisheng     2016-06-30  932  
a6adc30ba7bef8 Dong Aisheng     2016-06-30  933  	return ret;
a6adc30ba7bef8 Dong Aisheng     2016-06-30  934  }
a6adc30ba7bef8 Dong Aisheng     2016-06-30  935  
4dff95dc9477a3 Stephen Boyd     2015-04-30  936  /**
4dff95dc9477a3 Stephen Boyd     2015-04-30  937   * clk_prepare - prepare a clock source
4dff95dc9477a3 Stephen Boyd     2015-04-30  938   * @clk: the clk being prepared
4dff95dc9477a3 Stephen Boyd     2015-04-30  939   *
4dff95dc9477a3 Stephen Boyd     2015-04-30  940   * clk_prepare may sleep, which differentiates it from clk_enable.  In a simple
4dff95dc9477a3 Stephen Boyd     2015-04-30  941   * case, clk_prepare can be used instead of clk_enable to ungate a clk if the
4dff95dc9477a3 Stephen Boyd     2015-04-30  942   * operation may sleep.  One example is a clk which is accessed over I2c.  In
4dff95dc9477a3 Stephen Boyd     2015-04-30  943   * the complex case a clk ungate operation may require a fast and a slow part.
4dff95dc9477a3 Stephen Boyd     2015-04-30  944   * It is this reason that clk_prepare and clk_enable are not mutually
4dff95dc9477a3 Stephen Boyd     2015-04-30  945   * exclusive.  In fact clk_prepare must be called before clk_enable.
4dff95dc9477a3 Stephen Boyd     2015-04-30  946   * Returns 0 on success, -EERROR otherwise.
4dff95dc9477a3 Stephen Boyd     2015-04-30  947   */
4dff95dc9477a3 Stephen Boyd     2015-04-30 @948  int clk_prepare(struct clk *clk)
b2476490ef1113 Mike Turquette   2012-03-15  949  {
035a61c314eb3d Tomeu Vizoso     2015-01-23  950  	if (!clk)
4dff95dc9477a3 Stephen Boyd     2015-04-30  951  		return 0;
035a61c314eb3d Tomeu Vizoso     2015-01-23  952  
a6adc30ba7bef8 Dong Aisheng     2016-06-30  953  	return clk_core_prepare_lock(clk->core);
7ef3dcc8145263 James Hogan      2013-07-29  954  }
4dff95dc9477a3 Stephen Boyd     2015-04-30  955  EXPORT_SYMBOL_GPL(clk_prepare);
035a61c314eb3d Tomeu Vizoso     2015-01-23  956  

:::::: The code at line 867 was first introduced by commit
:::::: 4dff95dc9477a34de77d24c59dcf1dc593687fcf clk: Remove forward declared function prototypes

:::::: TO: Stephen Boyd <sboyd@codeaurora.org>
:::::: CC: Stephen Boyd <sboyd@codeaurora.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
