Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D92F50AFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiDVFyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiDVFyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:54:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E74F466
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650606711; x=1682142711;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d79wJp8dvPtbPBbi8XIPs+bkKxk950fFejn3HzUVIKw=;
  b=cgz1W1B5RYQGm4f0i70KhZys1Kxmo0xCnEawSqOxpYwuj+Mw3anfl4ME
   RP32DAXgRz+ZeTin6Z9oHdwm8lw3SRvqpOMiGZHCIGhGydhPqiRLPLFWv
   zb+CtguhXkL/fMvlpAS3us2u0wn3Q6bUbPanQaqMe2+kWeE79XNBN4XE6
   nnSGTmH/ntNqum6nVHN/PbBZJAJ/RBDsbEIS0Sasgw7/TypfJT9oyTmGL
   7T9N915vKsco19hiJPJ4Hy0b6fPyI9Y/POev/q4R4cQpSHVcnDKZsZF12
   SdbXPNC5Gp3qzExf/9MIpfoe9OXPTzoQ8cWV4Bu6DEa0H4raYBg1FBoQX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245155467"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="245155467"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 22:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="511429433"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2022 22:51:49 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhmCq-0009Hi-Gl;
        Fri, 22 Apr 2022 05:51:48 +0000
Date:   Fri, 22 Apr 2022 13:51:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/soc/fsl/imx-audmux.c:301:16: warning: cast to smaller integer
 type 'enum imx_audmux_type' from 'const void *'
Message-ID: <202204221334.HsOqkl21-lkp@intel.com>
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

Hi Fabio,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b05a5683eba6e2d40eadd5eeef53c4864149a4fe
commit: 6a8b8b582db13a18235f3b0400f103a0573c7859 ASoC: imx-audmux: Remove unused .id_table
date:   1 year, 5 months ago
config: arm64-buildonly-randconfig-r002-20220421 (https://download.01.org/0day-ci/archive/20220422/202204221334.HsOqkl21-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6a8b8b582db13a18235f3b0400f103a0573c7859
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6a8b8b582db13a18235f3b0400f103a0573c7859
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/tty/serial/ sound/soc/codecs/ sound/soc/fsl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/fsl/imx-audmux.c:301:16: warning: cast to smaller integer type 'enum imx_audmux_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
           audmux_type = (enum imx_audmux_type)of_device_get_match_data(&pdev->dev);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +301 sound/soc/fsl/imx-audmux.c

   287	
   288	static int imx_audmux_probe(struct platform_device *pdev)
   289	{
   290		audmux_base = devm_platform_ioremap_resource(pdev, 0);
   291		if (IS_ERR(audmux_base))
   292			return PTR_ERR(audmux_base);
   293	
   294		audmux_clk = devm_clk_get(&pdev->dev, "audmux");
   295		if (IS_ERR(audmux_clk)) {
   296			dev_dbg(&pdev->dev, "cannot get clock: %ld\n",
   297					PTR_ERR(audmux_clk));
   298			audmux_clk = NULL;
   299		}
   300	
 > 301		audmux_type = (enum imx_audmux_type)of_device_get_match_data(&pdev->dev);
   302	
   303		switch (audmux_type) {
   304		case IMX31_AUDMUX:
   305			audmux_debugfs_init();
   306			reg_max = 14;
   307			break;
   308		case IMX21_AUDMUX:
   309			reg_max = 6;
   310			break;
   311		default:
   312			dev_err(&pdev->dev, "unsupported version!\n");
   313			return -EINVAL;
   314		}
   315	
   316		regcache = devm_kzalloc(&pdev->dev, sizeof(u32) * reg_max, GFP_KERNEL);
   317		if (!regcache)
   318			return -ENOMEM;
   319	
   320		imx_audmux_parse_dt_defaults(pdev, pdev->dev.of_node);
   321	
   322		return 0;
   323	}
   324	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
