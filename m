Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1B950A7B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391160AbiDUSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391155AbiDUSF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:05:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A587A4B1E8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650564152; x=1682100152;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+AdcSDTJ9BqO5L8K2PefeVi7JU8dKRkGs1Rx00xlAw4=;
  b=iWQUavdEBTcHzLVyQDCZSa0DUBo6CNfNiFyjWp66gcc01R5+Y9jk3pe/
   ZVCVUdOugyTmuL2ME+VFqGdpjeoaGrmUpPv2rCC1eO5h0QZv99SfVeiFB
   n720yULx/fo4CKyssyNcpB4KE0z6HkokbjIbFbJgRArFe69sc0OOsBA+Y
   /el6v+f9PBn43KnIB+srgb1e+L+bNWdMbvKfWTjeQEF3H3/2JjnMT9LDr
   4Qrx1UU9NvZ7GlGq0kOuseEAAXQA/hIT1ldI1NMRAJP6Or0CnaM/x2GAW
   OrEGIj5ZNivZTJsDsqtq43dGHpoflEAMGsIwu4znVVAW+WgtOIl31/3k9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350876604"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="350876604"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 11:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="648241915"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2022 11:02:30 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhb8P-0008dt-Io;
        Thu, 21 Apr 2022 18:02:29 +0000
Date:   Fri, 22 Apr 2022 02:02:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [stable:linux-5.10.y 3076/5321] drivers/clk/bcm/clk-bcm2835.c:943:6:
 warning: variable 'rem' set but not used
Message-ID: <202204220101.mldVB7z8-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
head:   1052f9bce62982023737a95b7ff1ad26a5149af6
commit: b9c2343373f6bf19358db4e50197f5b3a17831db [3076/5321] clk: bcm-2835: Remove rounding up the dividers
config: arm-bcm2835_defconfig (https://download.01.org/0day-ci/archive/20220422/202204220101.mldVB7z8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=b9c2343373f6bf19358db4e50197f5b3a17831db
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.10.y
        git checkout b9c2343373f6bf19358db4e50197f5b3a17831db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/bcm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/bcm/clk-bcm2835.c:943:6: warning: variable 'rem' set but not used [-Wunused-but-set-variable]
           u64 rem;
               ^
   1 warning generated.


vim +/rem +943 drivers/clk/bcm/clk-bcm2835.c

41691b8862e2a3 Eric Anholt   2015-10-08  933  
41691b8862e2a3 Eric Anholt   2015-10-08  934  static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
41691b8862e2a3 Eric Anholt   2015-10-08  935  				    unsigned long rate,
b9c2343373f6bf Maxime Ripard 2021-09-22  936  				    unsigned long parent_rate)
41691b8862e2a3 Eric Anholt   2015-10-08  937  {
41691b8862e2a3 Eric Anholt   2015-10-08  938  	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
41691b8862e2a3 Eric Anholt   2015-10-08  939  	const struct bcm2835_clock_data *data = clock->data;
9c95b32ca09364 Remi Pommarel 2015-12-06  940  	u32 unused_frac_mask =
9c95b32ca09364 Remi Pommarel 2015-12-06  941  		GENMASK(CM_DIV_FRAC_BITS - data->frac_bits, 0) >> 1;
41691b8862e2a3 Eric Anholt   2015-10-08  942  	u64 temp = (u64)parent_rate << CM_DIV_FRAC_BITS;
9c95b32ca09364 Remi Pommarel 2015-12-06 @943  	u64 rem;
959ca92a3235fc Martin Sperl  2016-02-29  944  	u32 div, mindiv, maxdiv;
41691b8862e2a3 Eric Anholt   2015-10-08  945  
9c95b32ca09364 Remi Pommarel 2015-12-06  946  	rem = do_div(temp, rate);
41691b8862e2a3 Eric Anholt   2015-10-08  947  	div = temp;
41691b8862e2a3 Eric Anholt   2015-10-08  948  	div &= ~unused_frac_mask;
41691b8862e2a3 Eric Anholt   2015-10-08  949  
959ca92a3235fc Martin Sperl  2016-02-29  950  	/* different clamping limits apply for a mash clock */
959ca92a3235fc Martin Sperl  2016-02-29  951  	if (data->is_mash_clock) {
959ca92a3235fc Martin Sperl  2016-02-29  952  		/* clamp to min divider of 2 */
959ca92a3235fc Martin Sperl  2016-02-29  953  		mindiv = 2 << CM_DIV_FRAC_BITS;
959ca92a3235fc Martin Sperl  2016-02-29  954  		/* clamp to the highest possible integer divider */
959ca92a3235fc Martin Sperl  2016-02-29  955  		maxdiv = (BIT(data->int_bits) - 1) << CM_DIV_FRAC_BITS;
959ca92a3235fc Martin Sperl  2016-02-29  956  	} else {
997f16bd5d2e9b Martin Sperl  2016-02-29  957  		/* clamp to min divider of 1 */
959ca92a3235fc Martin Sperl  2016-02-29  958  		mindiv = 1 << CM_DIV_FRAC_BITS;
997f16bd5d2e9b Martin Sperl  2016-02-29  959  		/* clamp to the highest possible fractional divider */
959ca92a3235fc Martin Sperl  2016-02-29  960  		maxdiv = GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
959ca92a3235fc Martin Sperl  2016-02-29  961  				 CM_DIV_FRAC_BITS - data->frac_bits);
959ca92a3235fc Martin Sperl  2016-02-29  962  	}
959ca92a3235fc Martin Sperl  2016-02-29  963  
959ca92a3235fc Martin Sperl  2016-02-29  964  	/* apply the clamping  limits */
959ca92a3235fc Martin Sperl  2016-02-29  965  	div = max_t(u32, div, mindiv);
959ca92a3235fc Martin Sperl  2016-02-29  966  	div = min_t(u32, div, maxdiv);
41691b8862e2a3 Eric Anholt   2015-10-08  967  
41691b8862e2a3 Eric Anholt   2015-10-08  968  	return div;
41691b8862e2a3 Eric Anholt   2015-10-08  969  }
41691b8862e2a3 Eric Anholt   2015-10-08  970  

:::::: The code at line 943 was first introduced by commit
:::::: 9c95b32ca09364e4687b72c4e17b78dc1c420026 clk: bcm2835: add a round up ability to the clock divisor

:::::: TO: Remi Pommarel <repk@triplefau.lt>
:::::: CC: Michael Turquette <mturquette@baylibre.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
