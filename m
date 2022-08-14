Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC11591DD4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 06:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiHNEIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 00:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNEIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 00:08:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9E61EAE6;
        Sat, 13 Aug 2022 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660450126; x=1691986126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=edAB/jt4sqHxc5RzVegMVJYdHU9YswUxCooZ50KcXEA=;
  b=NMRE2HBb+V4QGgrQzPFuHMFkEBcAjKlXiy8HmKjaz1XCDGa2ljw7feBS
   Y9vH2e9MUC6uRuTjOWXtDxcNc9x6KPBMO6h5/UHDEKrhLw1Dhkl3XCCCF
   10WKyvZDFwg7Cp3+aRUm2NbrdKo3bn7H1kafTVy//d6+v5Iga/sJsVoE2
   Nlgh8JjghL9j3JShcWwXOmd+Gvi9sOuCwPKy/FA7hvZGk+oPbJVhye8c2
   YJOGQ6ceUNxTPZwzeAmm7JOw3taxJcCX5rKRV079bBiUKMeDIsYESQkjZ
   jnA9Uj8P2tqAdlXXkYgfekJNYGoZnXIqdk3ol5gsSnnpPp4K+CCIq5Dnb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292591523"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="292591523"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 21:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="709416302"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2022 21:08:42 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN4vZ-0002Td-1F;
        Sun, 14 Aug 2022 04:08:41 +0000
Date:   Sun, 14 Aug 2022 12:08:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: exynos: Add CMU_AUD, CMU_IS and
 CMU_MFCMSCL for Exynos850
Message-ID: <202208141234.dc1oJWXs-lkp@intel.com>
References: <20220808201724.27831-2-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808201724.27831-2-semen.protsenko@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on krzk/for-next]
[also build test ERROR on krzk-dt/for-next linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sam-Protsenko/arm64-dts-exynos850-Add-cmu-and-sysmmu-nodes/20220809-041907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220814/202208141234.dc1oJWXs-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c4a995f799014f9233486fa406340888e8e9bc34
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sam-Protsenko/arm64-dts-exynos850-Add-cmu-and-sysmmu-nodes/20220809-041907
        git checkout c4a995f799014f9233486fa406340888e8e9bc34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/exynos/exynos850.dtsi:295.16-17 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
