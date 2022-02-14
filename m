Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0F4B4520
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbiBNJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:03:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbiBNJDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:03:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AAC5FF0F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644829373; x=1676365373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ndoVfMGj2QDjYVtr2QpgZyBrsIZl2teIl2BNdMfYu4w=;
  b=MJSqKho7vnxfjGBGpRXQzDulCq/LjzoCz2Nrloi76ZFe5MJ5gjNPOJOy
   T+LAh+CBVvMS36jwIuebcFw9ed3nWp1+LYSF0qkP+GCOPPdVbSPGp2/1M
   a50XXP828JavBIxBQgazTXIXr9w7TRlCHD7RAlByS8Qjozmgfu/awPBEE
   RiVpWW885YbN8e9HTGTX73gLCL1H6s3EaqRxxGSfBO8QBh9N2f9h3KdUy
   RcXzSutZ8ckCgwlw4OdnnnYCRpHtxzJOyAx+T7UPlKRt1mBT4ygvHmgrC
   W0f3CUdyArO0bwpSIUifbdes0NLU60lJBQ+vz2tp58Lxlh+1bUJz4+Q+k
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250253546"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250253546"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="775016283"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2022 01:02:50 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJXFx-0008Ke-Pc; Mon, 14 Feb 2022 09:02:49 +0000
Date:   Mon, 14 Feb 2022 17:02:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 54/65] ERROR: modpost: "__umoddi3"
 [drivers/cxl/cxl_region.ko] undefined!
Message-ID: <202202141628.XeQ22sHZ-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   edd6d7383869c634498f4b4cb7cf73ca0d460bf3
commit: 272c07117bd268471c338ceffb8e0ac4936d0e09 [54/65] cxl/region: Introduce a cxl_region driver
config: i386-randconfig-a005-20220214 (https://download.01.org/0day-ci/archive/20220214/202202141628.XeQ22sHZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ea071884b0cc7210b3cc5fe858f0e892a779a23b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=272c07117bd268471c338ceffb8e0ac4936d0e09
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 272c07117bd268471c338ceffb8e0ac4936d0e09
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [drivers/cxl/cxl_region.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
