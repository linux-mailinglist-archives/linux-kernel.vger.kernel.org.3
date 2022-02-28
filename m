Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E2E4C7B68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiB1VMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiB1VMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:12:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB735AA7A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646082686; x=1677618686;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LobaXSROVV91E+AOosHRlE77gRHfzWg5+Pud7kDr9a4=;
  b=jkAemDSIVxqgjcudRLRcTyKNdP2h44V2a9q8cc7Mc4kR5OJcMM0xdxNO
   2XTfAadAk6U6GTJrSaMpKV7WzknQ5OdOhALCP662L9X2pSQXG3rEvEZS4
   8B7wTYLJO3dWAhP3iYgOB5rUFSNTZ3/Qe8E/2b0LXbLYtr9i5QdjrTK20
   k3FbfwscsNQZRxyH/7tq9duKbuyn7GB+kSzwfiPKJPTN19Sf3HlnDeccm
   Wu9jk/WYcZt9qUPeaeikzbpMEHaQ9Ups+ThHIJ0FoQX0ghunaxgnhh9ME
   6GE6Ix3cHMJSBNDNtWIwREBij2Z1mCM9Kqu5rM5lBVCdv5TOcz9navqqm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253180801"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="253180801"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 13:11:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="534622821"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2022 13:11:24 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOnIi-0007mn-8I; Mon, 28 Feb 2022 21:11:24 +0000
Date:   Tue, 1 Mar 2022 05:10:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ambarus:spi-nor/id-collisions-v4 39/39] make[4]: *** No rule to
 make target 'drivers/mtd/spi-nor/xmc.o', needed by
 'drivers/mtd/spi-nor/built-in.a'.
Message-ID: <202203010516.FbpMDFBg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ambarus/linux-0day spi-nor/id-collisions-v4
head:   0dff6e52ceae6f25ba4afb713dde9bec6903fe72
commit: 0dff6e52ceae6f25ba4afb713dde9bec6903fe72 [39/39] mtd: spi-nor: Move XMC to manufacturer ID collisions driver
config: sh-randconfig-r001-20220228 (https://download.01.org/0day-ci/archive/20220301/202203010516.FbpMDFBg-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ambarus/linux-0day/commit/0dff6e52ceae6f25ba4afb713dde9bec6903fe72
        git remote add ambarus https://github.com/ambarus/linux-0day
        git fetch --no-tags ambarus spi-nor/id-collisions-v4
        git checkout 0dff6e52ceae6f25ba4afb713dde9bec6903fe72
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/mtd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[4]: *** No rule to make target 'drivers/mtd/spi-nor/xmc.o', needed by 'drivers/mtd/spi-nor/built-in.a'.
   make[4]: Target '__build' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
