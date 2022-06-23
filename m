Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E975574B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiFWIAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiFWIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:00:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D2D4706F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655971230; x=1687507230;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gEmi4IGiEfTut6Thi+VJyyW3msIRy1Zh9LcZovJqofQ=;
  b=G9q7xNCLq0oijbU2zQvR8QKBUfKWoezN9Kou2c7lpQ/bP+rXuY61OBzq
   9Lk26+KIdpiRniHBwl57/snkAEpj0KzZ6s7+klde0cPHvxl+Dvs2DvtJu
   c8p6XUveAcFDL68jsYCoptooE4xwAU6gzveRaf3EUKjhY9sLvsAKhjW9j
   R/TyP29vsG4AMphjnHQJdYp26gtT1MAQkI0IblHCFUfjb2eKjgd0MUE5a
   cSY25Q2YFjX64YutOpE8aMGJQp9qEqlLW+Uhr21ZSkBtHZAPPbfUNoF5J
   oZW2YWKBCJp4wUjAEJAyQtV9BkpmlfpoVOMCG23LO299m6YUCtzttOLEI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281733713"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281733713"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 01:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644618978"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jun 2022 01:00:23 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4HlH-0000uj-0h;
        Thu, 23 Jun 2022 08:00:23 +0000
Date:   Thu, 23 Jun 2022 15:59:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <bwidawsk@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 38/49] include/linux/memregion.h:19:6: warning: no
 previous prototype for 'memregion_free'
Message-ID: <202206231509.bXt14BdC-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   b2d4fd5c97b59f622e6c45ac51020cdcd66bb022
commit: e4b2a6ac46c3288f73b88e0aa69afd2a815930d7 [38/49] cxl/region: Add region creation support
config: alpha-randconfig-r022-20220623 (https://download.01.org/0day-ci/archive/20220623/202206231509.bXt14BdC-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=e4b2a6ac46c3288f73b88e0aa69afd2a815930d7
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout e4b2a6ac46c3288f73b88e0aa69afd2a815930d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/cxl/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/cxl/core/port.c:4:
>> include/linux/memregion.h:19:6: warning: no previous prototype for 'memregion_free' [-Wmissing-prototypes]
      19 | void memregion_free(int id)
         |      ^~~~~~~~~~~~~~


vim +/memregion_free +19 include/linux/memregion.h

a6c7f4c6aea5f4c Dan Williams 2019-11-06  10  
33dd70752cd76f4 Dan Williams 2019-11-06  11  #ifdef CONFIG_MEMREGION
33dd70752cd76f4 Dan Williams 2019-11-06  12  int memregion_alloc(gfp_t gfp);
33dd70752cd76f4 Dan Williams 2019-11-06  13  void memregion_free(int id);
33dd70752cd76f4 Dan Williams 2019-11-06  14  #else
33dd70752cd76f4 Dan Williams 2019-11-06  15  static inline int memregion_alloc(gfp_t gfp)
33dd70752cd76f4 Dan Williams 2019-11-06  16  {
33dd70752cd76f4 Dan Williams 2019-11-06  17  	return -ENOMEM;
33dd70752cd76f4 Dan Williams 2019-11-06  18  }
33dd70752cd76f4 Dan Williams 2019-11-06 @19  void memregion_free(int id)

:::::: The code at line 19 was first introduced by commit
:::::: 33dd70752cd76f4d883a165a674f13121a4155ed lib: Uplevel the pmem "region" ida to a global allocator

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
