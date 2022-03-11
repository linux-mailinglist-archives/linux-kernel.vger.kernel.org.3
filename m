Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684264D65C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350140AbiCKQH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245714AbiCKQHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:07:24 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD641D087F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647014781; x=1678550781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8sd/osNdwpZjh8x9Ga7m3iWdLk1yyi5ow5D55whePkk=;
  b=B345YMVjQWwhM4GUzrwJyfrhCBEc/Pb7pnnflGI9gWYbVvDbQ3VBQDCQ
   +wXotgBxbXUaji6ClRVu8DwM5BwyIHBM76faAl+0zH2i1++q0sAFvFxrC
   l6n9k3F0hkzeaU2cfqlt4/k0Un8DGCoWc9bcfygGRcmSavGPPN8JAk3iE
   +T1eORA8E/6ZfiU9+HDDuWWeA9DGqeiMzwFafOuJHlEBksLZDFmd0bLuV
   JvjCnR1Lhw4udwzaz8OjDSzf2wJc6wo4/hHz1D0WfJsbeIxsPz/px+M6O
   AuBJAgwRP/DcP09a5sNEac7OYp4GtwWhE66I/zggOkleT1izWLvZHiLqh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="316320915"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="316320915"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 08:06:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="712887681"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2022 08:06:18 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nShmU-0006ha-0Q; Fri, 11 Mar 2022 16:06:18 +0000
Date:   Sat, 12 Mar 2022 00:06:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH 2/5] staging: vt6656: Remove unused rf_type in baseband.c
Message-ID: <202203112347.5u5Hv6vj-lkp@intel.com>
References: <77dcff8602084484532fcbd734aafd138087c5ee.1646935331.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77dcff8602084484532fcbd734aafd138087c5ee.1646935331.git.philipp.g.hortmann@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Philipp-Hortmann/staging-vt6656-Remove-unused-5GHz-support/20220311-025658
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git b25c7dc13fb8842e8634bd846a7a96f2176f0244
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220311/202203112347.5u5Hv6vj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/747c899152efe7f0dbbcdd5399f1b1de3a7ba51d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Philipp-Hortmann/staging-vt6656-Remove-unused-5GHz-support/20220311-025658
        git checkout 747c899152efe7f0dbbcdd5399f1b1de3a7ba51d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/bluetooth/ drivers/staging/vt6656/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/vt6656/baseband.c:170:35: warning: unused variable 'vt3342_vnt_threshold' [-Wunused-const-variable]
   static const struct vnt_threshold vt3342_vnt_threshold[] = {
                                     ^
   1 warning generated.


vim +/vt3342_vnt_threshold +170 drivers/staging/vt6656/baseband.c

69a809e1569312 Oscar Carter 2020-03-28  169  
69a809e1569312 Oscar Carter 2020-03-28 @170  static const struct vnt_threshold vt3342_vnt_threshold[] = {
69a809e1569312 Oscar Carter 2020-03-28  171  	{0, 0x00, 0x38},	/* Max sensitivity */
69a809e1569312 Oscar Carter 2020-03-28  172  	{66, 0x00, 0x43},
69a809e1569312 Oscar Carter 2020-03-28  173  	{65, 0x00, 0x52},
69a809e1569312 Oscar Carter 2020-03-28  174  	{64, 0x00, 0x68},
69a809e1569312 Oscar Carter 2020-03-28  175  	{63, 0x00, 0x80},
69a809e1569312 Oscar Carter 2020-03-28  176  	{62, 0x00, 0x9c},
69a809e1569312 Oscar Carter 2020-03-28  177  	{61, 0x00, 0xc0},
69a809e1569312 Oscar Carter 2020-03-28  178  	{60, 0x00, 0xea},
69a809e1569312 Oscar Carter 2020-03-28  179  	{59, 0x01, 0x30},
69a809e1569312 Oscar Carter 2020-03-28  180  	{58, 0x01, 0x70},
69a809e1569312 Oscar Carter 2020-03-28  181  	{57, 0x01, 0xb0},
69a809e1569312 Oscar Carter 2020-03-28  182  	{56, 0x02, 0x30},
69a809e1569312 Oscar Carter 2020-03-28  183  	{55, 0x02, 0xc0},
69a809e1569312 Oscar Carter 2020-03-28  184  	{53, 0x04, 0x00},
69a809e1569312 Oscar Carter 2020-03-28  185  	{51, 0x07, 0x00},
69a809e1569312 Oscar Carter 2020-03-28  186  	{49, 0x0a, 0x00},
69a809e1569312 Oscar Carter 2020-03-28  187  	{47, 0x11, 0x00},
69a809e1569312 Oscar Carter 2020-03-28  188  	{45, 0x18, 0x00},
69a809e1569312 Oscar Carter 2020-03-28  189  	{43, 0x26, 0x00},
69a809e1569312 Oscar Carter 2020-03-28  190  	{42, 0x36, 0x00},
69a809e1569312 Oscar Carter 2020-03-28  191  	{41, 0xff, 0x00}
69a809e1569312 Oscar Carter 2020-03-28  192  };
69a809e1569312 Oscar Carter 2020-03-28  193  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
