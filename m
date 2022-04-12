Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71BD4FE030
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351680AbiDLMbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355538AbiDLM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:29:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A627353A46
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649763820; x=1681299820;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/CXkkOa1Qb1zYpVNyIs99QKNPxZBdARfFd4I1EE/yEY=;
  b=GsbkOgSzplfKZwBD3YXZXsUmk6vm4beGJ1DdOyi6+Hw3I4C/4lW+TG3h
   Qnx2dGRtQrw/mzfrAdRNIUxHBSJO22FaQPzUTOi6hJAdXP1QBQXYr28TM
   jenVvXDLiz2ZFi2YyIoJezyUNaFmRa1QBV8lYJyCD5O/xQj8tJEPWjb32
   XyC3uxm1DNhC2yJMz2B62b0rKYTvxTYht/LFJVlniKOIONpVIaUWnGIXA
   RcFm+Cm46VaQ7iqw0JgeBJnXgv9WpTxA0LWzwRBhvkXz8SsuNE3fKka2L
   RbvBsoGSx1cItdTv9CxWEOcsVI9R8jeI18SbVr501lfojhjEIgOAQAG0E
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262536050"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="262536050"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="724417241"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2022 04:43:31 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neEvi-0002ou-NZ;
        Tue, 12 Apr 2022 11:43:30 +0000
Date:   Tue, 12 Apr 2022 19:43:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/not-zero-entropy 6/12] ERROR:
 modpost: "random_get_entropy_fallback" [crypto/jitterentropy_rng.ko]
 undefined!
Message-ID: <202204121911.NhZSbyFC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/not-zero-entropy
head:   4ee3bf173a552cd996e048d57f65bb5b471ab577
commit: 223939a5e0da931df37ab6bcd3e84bd74d931f35 [6/12] mips: use fallback for random_get_entropy() instead of zero
config: mips-decstation_64_defconfig (https://download.01.org/0day-ci/archive/20220412/202204121911.NhZSbyFC-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/223939a5e0da931df37ab6bcd3e84bd74d931f35
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/not-zero-entropy
        git checkout 223939a5e0da931df37ab6bcd3e84bd74d931f35
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "random_get_entropy_fallback" [crypto/jitterentropy_rng.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
