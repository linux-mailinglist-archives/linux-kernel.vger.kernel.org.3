Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F2F4B3B3C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiBMMNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:13:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiBMMNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:13:01 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401585B8AC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644754375; x=1676290375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZYB68LCx4yFPTjdSR/HWUSiQhzE6FrY4X+s6uCvFbKY=;
  b=cfSGp3nbeYNEvDdaZER3HnAWoZlqkzE8RqjbcxG0waYjn0LA8nSH6wJb
   1PPlY+Js0IWKOa1pHClwwV1Ur7aNFiIW1Anl9DzwLREBP1tPHwzjdBW1T
   9k59IGttSsbxoc6znN/0qkvKio8RBwzLl4/IRisty6RKCXQSB5jmO6KtL
   hC/EkQwr63cMKS9J6TyMgUrjOpONJYVbI0per35hLctpGpKf8TOCdCAuA
   U7qW/V5gA04wgjxj8BIYQe7WXEfML4nxUSzu5tPOjBy+gLdBHb7VhBXUa
   9pjKveLlpWN/DqrgbXkAApkQW6/Y64ZRZXm6/ANQ45q1gUKQSWpmP9qYM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="250150615"
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="250150615"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 04:12:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,365,1635231600"; 
   d="scan'208";a="679928484"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 04:12:53 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJDkK-0007Tk-Mq; Sun, 13 Feb 2022 12:12:52 +0000
Date:   Sun, 13 Feb 2022 20:12:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: drivers/clk/bcm/clk-bcm2835.c:942:6: error: variable 'rem' set but
 not used
Message-ID: <202202132034.ZltYqjTa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: 8ca011ef4af48a7af7b15afd8a4a44039dd04cea clk: bcm-2835: Remove rounding up the dividers
date:   4 months ago
config: arm-randconfig-r006-20220213 (https://download.01.org/0day-ci/archive/20220213/202202132034.ZltYqjTa-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 478c237e21b2c3a83e46f26fcbeb3876682f9b14)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8ca011ef4af48a7af7b15afd8a4a44039dd04cea
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8ca011ef4af48a7af7b15afd8a4a44039dd04cea
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/bcm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clk/bcm/clk-bcm2835.c:942:6: error: variable 'rem' set but not used [-Werror,-Wunused-but-set-variable]
           u64 rem;
               ^
   1 error generated.


vim +/rem +942 drivers/clk/bcm/clk-bcm2835.c

41691b8862e2a3 Eric Anholt   2015-10-08  932  
41691b8862e2a3 Eric Anholt   2015-10-08  933  static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
41691b8862e2a3 Eric Anholt   2015-10-08  934  				    unsigned long rate,
8ca011ef4af48a Maxime Ripard 2021-09-22  935  				    unsigned long parent_rate)
41691b8862e2a3 Eric Anholt   2015-10-08  936  {
41691b8862e2a3 Eric Anholt   2015-10-08  937  	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
41691b8862e2a3 Eric Anholt   2015-10-08  938  	const struct bcm2835_clock_data *data = clock->data;
9c95b32ca09364 Remi Pommarel 2015-12-06  939  	u32 unused_frac_mask =
9c95b32ca09364 Remi Pommarel 2015-12-06  940  		GENMASK(CM_DIV_FRAC_BITS - data->frac_bits, 0) >> 1;
41691b8862e2a3 Eric Anholt   2015-10-08  941  	u64 temp = (u64)parent_rate << CM_DIV_FRAC_BITS;
9c95b32ca09364 Remi Pommarel 2015-12-06 @942  	u64 rem;
959ca92a3235fc Martin Sperl  2016-02-29  943  	u32 div, mindiv, maxdiv;
41691b8862e2a3 Eric Anholt   2015-10-08  944  
9c95b32ca09364 Remi Pommarel 2015-12-06  945  	rem = do_div(temp, rate);
41691b8862e2a3 Eric Anholt   2015-10-08  946  	div = temp;
41691b8862e2a3 Eric Anholt   2015-10-08  947  	div &= ~unused_frac_mask;
41691b8862e2a3 Eric Anholt   2015-10-08  948  
959ca92a3235fc Martin Sperl  2016-02-29  949  	/* different clamping limits apply for a mash clock */
959ca92a3235fc Martin Sperl  2016-02-29  950  	if (data->is_mash_clock) {
959ca92a3235fc Martin Sperl  2016-02-29  951  		/* clamp to min divider of 2 */
959ca92a3235fc Martin Sperl  2016-02-29  952  		mindiv = 2 << CM_DIV_FRAC_BITS;
959ca92a3235fc Martin Sperl  2016-02-29  953  		/* clamp to the highest possible integer divider */
959ca92a3235fc Martin Sperl  2016-02-29  954  		maxdiv = (BIT(data->int_bits) - 1) << CM_DIV_FRAC_BITS;
959ca92a3235fc Martin Sperl  2016-02-29  955  	} else {
997f16bd5d2e9b Martin Sperl  2016-02-29  956  		/* clamp to min divider of 1 */
959ca92a3235fc Martin Sperl  2016-02-29  957  		mindiv = 1 << CM_DIV_FRAC_BITS;
997f16bd5d2e9b Martin Sperl  2016-02-29  958  		/* clamp to the highest possible fractional divider */
959ca92a3235fc Martin Sperl  2016-02-29  959  		maxdiv = GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
959ca92a3235fc Martin Sperl  2016-02-29  960  				 CM_DIV_FRAC_BITS - data->frac_bits);
959ca92a3235fc Martin Sperl  2016-02-29  961  	}
959ca92a3235fc Martin Sperl  2016-02-29  962  
959ca92a3235fc Martin Sperl  2016-02-29  963  	/* apply the clamping  limits */
959ca92a3235fc Martin Sperl  2016-02-29  964  	div = max_t(u32, div, mindiv);
959ca92a3235fc Martin Sperl  2016-02-29  965  	div = min_t(u32, div, maxdiv);
41691b8862e2a3 Eric Anholt   2015-10-08  966  
41691b8862e2a3 Eric Anholt   2015-10-08  967  	return div;
41691b8862e2a3 Eric Anholt   2015-10-08  968  }
41691b8862e2a3 Eric Anholt   2015-10-08  969  

:::::: The code at line 942 was first introduced by commit
:::::: 9c95b32ca09364e4687b72c4e17b78dc1c420026 clk: bcm2835: add a round up ability to the clock divisor

:::::: TO: Remi Pommarel <repk@triplefau.lt>
:::::: CC: Michael Turquette <mturquette@baylibre.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
