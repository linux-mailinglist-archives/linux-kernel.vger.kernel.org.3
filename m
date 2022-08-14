Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB64F592666
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 22:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiHNUsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 16:48:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3561758D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660510096; x=1692046096;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WfzRpYDt3Xe8kcRJakKeO57VmiHMSmyYPO0Q4unxeYE=;
  b=HhURFePN36uNOPky6KwrS0CVOdPfnyw1vu14/WF3GyyPzelAUQiXd3Qk
   8WnJw6Xvnd/+Sd5N2ZYfDrPDPwJjQ5iLWMcUku0EEmBlRj8RS29xX0Hao
   qvHVgbRXpnEib2BMWvh5HY1HNWBpnJeLY2BXUwjxStuU49CZ+KKWxI5Se
   IvpZgrB22XsamK1NxrzhJ+8iQ32kVXC3s4rmpFpMI3Cjqb/hm9cy3A7OP
   nayboVl53te7i3Kx2zPG8B5QLLdKf3qP0DU4Nff63n0dya3neiYWKTQci
   zXBFudjAhuZfTLNPDJzAFQEiD+6eihYeaZSe+41F2Fux06qENdqJP7w84
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="289421127"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="289421127"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 13:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="934277480"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2022 13:48:14 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNKWr-0000Wh-2Z;
        Sun, 14 Aug 2022 20:48:13 +0000
Date:   Mon, 15 Aug 2022 04:47:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/media/dvb-frontends/nxt200x.c:1087:12: warning: stack frame
 size (15160) exceeds limit (8192) in 'nxt200x_init'
Message-ID: <202208150405.dJa74zEz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5d6a0f4da9275f6c212de33777778673ba91241a
commit: a52f8a59aef46b59753e583bf4b28fccb069ce64 fortify: Explicitly disable Clang support
date:   11 months ago
config: x86_64-randconfig-a013-20220815 (https://download.01.org/0day-ci/archive/20220815/202208150405.dJa74zEz-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2f79185bafd678f310fafadba2a8c76d2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a52f8a59aef46b59753e583bf4b28fccb069ce64
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a52f8a59aef46b59753e583bf4b28fccb069ce64
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iommu/ drivers/media/dvb-frontends/ drivers/usb/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/dvb-frontends/nxt200x.c:1087:12: warning: stack frame size (15160) exceeds limit (8192) in 'nxt200x_init' [-Wframe-larger-than]
   static int nxt200x_init(struct dvb_frontend* fe)
              ^
>> drivers/media/dvb-frontends/nxt200x.c:519:12: warning: stack frame size (9624) exceeds limit (8192) in 'nxt200x_setup_frontend_parameters' [-Wframe-larger-than]
   static int nxt200x_setup_frontend_parameters(struct dvb_frontend *fe)
              ^
   2 warnings generated.
--
>> drivers/media/dvb-frontends/stv0367.c:995:12: warning: stack frame size (9464) exceeds limit (8192) in 'stv0367ter_algo' [-Wframe-larger-than]
   static int stv0367ter_algo(struct dvb_frontend *fe)
              ^
>> drivers/media/dvb-frontends/stv0367.c:2540:12: warning: stack frame size (9368) exceeds limit (8192) in 'stv0367cab_set_frontend' [-Wframe-larger-than]
   static int stv0367cab_set_frontend(struct dvb_frontend *fe)
              ^
   2 warnings generated.
--
   drivers/usb/host/max3421-hcd.c:1968:34: warning: unused variable 'max3421_of_match_table' [-Wunused-const-variable]
   static const struct of_device_id max3421_of_match_table[] = {
                                    ^
>> drivers/usb/host/max3421-hcd.c:1378:1: warning: stack frame size (11288) exceeds limit (8192) in 'max3421_spi_thread' [-Wframe-larger-than]
   max3421_spi_thread(void *dev_id)
   ^
   2 warnings generated.


vim +/nxt200x_init +1087 drivers/media/dvb-frontends/nxt200x.c

04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1086  
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08 @1087  static int nxt200x_init(struct dvb_frontend* fe)
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1088  {
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1089  	struct nxt200x_state* state = fe->demodulator_priv;
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1090  	int ret = 0;
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1091  
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1092  	if (!state->initialised) {
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1093  		switch (state->demod_chip) {
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1094  			case NXT2002:
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1095  				ret = nxt2002_init(fe);
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1096  				break;
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1097  			case NXT2004:
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1098  				ret = nxt2004_init(fe);
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1099  				break;
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1100  			default:
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1101  				return -EINVAL;
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1102  		}
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1103  		state->initialised = 1;
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1104  	}
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1105  	return ret;
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1106  }
04a45929e7f00e drivers/media/dvb/frontends/nxt200x.c Kirk Lapray 2005-11-08  1107  

:::::: The code at line 1087 was first introduced by commit
:::::: 04a45929e7f00ed4fc7b1d375397f808c8a5d0eb [PATCH] dvb: add nxt200x frontend module

:::::: TO: Kirk Lapray <kirk.lapray@gmail.com>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
