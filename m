Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A61F4F9951
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiDHPZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiDHPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:25:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952ACCDC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649431415; x=1680967415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9H8BUXKRrkLgvJdGdu978TupPedHMZGCiuTf1WYFn5c=;
  b=cCC5NJ36d/J3NlKnHr60S6U6B4m26gGr5lBYq23TEJYTZ2PIo+PCcEX9
   oMYi+J2GEbS6BLzg0W4quswaQdkG4IWY2OVkrNJ8IEkUWTLTKF2c9Kw3f
   8WX/llfGVTb0J3Go0/utvgFmRykeHz0qWgT7GudFhlOX/59QLbXwrXzTx
   lwM7QlTzi7X6L7TvjCwCBIA7qdQLY3hgaXQQolETWQej3moW5BEzEXwgL
   e+XGeliVv4CPXZCs3oBxxWUvGKz0ecob3xwvvz6Ol0yjypoYTxOxlpA9A
   et4473fpCqPIS7Io0byoSJ8nIyR5cC+cpUi2xKWaFYaFjiS24XOoiE4xt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="324779728"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="324779728"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 08:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="659521417"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2022 08:23:33 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncqST-0000OV-4I;
        Fri, 08 Apr 2022 15:23:33 +0000
Date:   Fri, 8 Apr 2022 23:23:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Pasanen <dan.pasanen@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 21/887] ld.lld: error: undefined symbol:
 v4wb_dma_inv_range
Message-ID: <202204082305.3yjg0eTb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 158c801c65d225eb8dd0ca0eb79e7bee23710294 [21/887] arm: partially revert 702b94bff3c50542a6e4ab9a4f4cef093262fe65
config: arm-randconfig-r026-20220408 (https://download.01.org/0day-ci/archive/20220408/202204082305.3yjg0eTb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/l1k/linux/commit/158c801c65d225eb8dd0ca0eb79e7bee23710294
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 158c801c65d225eb8dd0ca0eb79e7bee23710294
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
   ld.lld: warning: lld uses blx instruction, no object with architecture supporting feature detected
>> ld.lld: error: undefined symbol: v4wb_dma_inv_range
   >>> referenced by proc-syms.c
   >>> mm/proc-syms.o:(__ksymtab_v4wb_dma_inv_range) in archive arch/arm/built-in.a
--
>> ld.lld: error: undefined symbol: v4wb_dma_clean_range
   >>> referenced by proc-syms.c
   >>> mm/proc-syms.o:(__ksymtab_v4wb_dma_clean_range) in archive arch/arm/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
