Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8944F0CFC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 01:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376685AbiDCXks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 19:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiDCXko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:40:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103291081;
        Sun,  3 Apr 2022 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649029130; x=1680565130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dk8wwoPAa+9gWRt+JbyfUk76inxYSrqYeknZJrDq4/I=;
  b=badX6T0/+4YUthVB4EG8SCsfzblDdG1HK5qmZyQWj+zu8/imPIWmvP/6
   HtsoQUAbeRtzltIL1OU6FaUiy5EENMv26fph+5opn82deXJKtKM8UMumi
   f4fsnQ1oJCuoaDLTzhNc8tvGpcfIPpycsbPvqR6nd3NfBuhpwE3GexBgc
   aSnWt12xLI4O0ge7eP+t5QJPyclvS+J3bzLaQnj/L66F6AZuTmxxqtMiO
   TT8GGY06+w+WSrVmLPOwGfLRsupvr1bbBeqDxXjQiQwrojCgtQigsCWAn
   UFPpCybigqM5NntFpX8kzwgcS33hwgQiOK5PimPOKCj6FGe1hU4wEq5RE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="240352748"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="240352748"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 16:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="548456613"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Apr 2022 16:38:48 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nb9nz-0001I9-M1;
        Sun, 03 Apr 2022 23:38:47 +0000
Date:   Mon, 4 Apr 2022 07:38:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH resend 1/4] mtd: nand: make mtk_ecc.c a separated module
Message-ID: <202204040718.xQeZrzYD-lkp@intel.com>
References: <20220403131453.1269229-2-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403131453.1269229-2-gch981213@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuanhong,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220401]
[cannot apply to mtd/nand/next broonie-spi/for-next robh/for-next v5.17 v5.17-rc8 v5.17-rc7 v5.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuanhong-Guo/spi-add-support-for-Mediatek-SPI-NAND-controller/20220403-211703
base:    e5071887cd2296a7704dbcd10c1cedf0f11cdbd5
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20220404/202204040718.xQeZrzYD-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/48656e578a2cec7121f79d875d14403f5b56096e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chuanhong-Guo/spi-add-support-for-Mediatek-SPI-NAND-controller/20220403-211703
        git checkout 48656e578a2cec7121f79d875d14403f5b56096e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   alpha-linux-ld: drivers/mtd/nand/ecc-mtk.o: in function `mtk_ecc_driver_exit':
>> ecc-mtk.o:(.exit.text+0x0): multiple definition of `cleanup_module'; drivers/mtd/nand/ecc-mxic.o:ecc-mxic.o:(.exit.text+0x0): first defined here
   alpha-linux-ld: drivers/mtd/nand/ecc-mtk.o: in function `mtk_ecc_driver_init':
>> ecc-mtk.o:(.init.text+0x0): multiple definition of `init_module'; drivers/mtd/nand/ecc-mxic.o:ecc-mxic.o:(.init.text+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
