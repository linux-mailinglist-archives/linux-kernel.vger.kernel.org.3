Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CBC5479DF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiFLLFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 07:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiFLLFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 07:05:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1151336E12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655031907; x=1686567907;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+t7ZRUM3b9Dx/IpCyxXJBg7WxFmk+ae4VrziA9FVvCE=;
  b=noVj/0dlmESMuau49WFgD+jpnsAVqZ/cUI8Mhs8P3bG7qWOSpcd3u9en
   zEG1f9qS49nsXG7oAL//zJkzRBK13+as8CpmdEtJaiJIYnsNd4MltFJKo
   nicc9ux2EimjuBgGQ89DJD+R6y74pEroU9EfRgXFqTffdnyQI9oo6OT13
   +lv3XIJXr9OY6j/s+l7eD1EToIdo9j3W0SkE3Owbm2UttluLzjXt824pj
   +Ld1jU3mS5ezUcoUFMtXw6Vw7QhSSWNZKN1DkV35tM73Ip/auE00LBjTR
   8svL2jKNBVvSYPEYYiLgciVHNm5hzvH2ztSG6viL5n1B7YSvWbMDWaRNy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="258467048"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="258467048"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 04:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="829164642"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2022 04:05:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0LOy-000Jrd-R3;
        Sun, 12 Jun 2022 11:05:04 +0000
Date:   Sun, 12 Jun 2022 19:04:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huan Feng <huan.feng@starfivetech.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 21/54]
 drivers/char/hw_random/starfive-vic-rng.c:238:34: warning: unused variable
 'vic_rng_dt_ids'
Message-ID: <202206121938.SUJ1iMQj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   906be7ef2fb9e2f1fcb740d3d506768cddfc52ca
commit: b422a122c72a7448306ad60808c748d57b98da71 [21/54] drivers/hw_random: Add StarFive JH7100 Random Number Generator driver
config: mips-randconfig-c004-20220611 (https://download.01.org/0day-ci/archive/20220612/202206121938.SUJ1iMQj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ff4abe755279a3a47cc416ef80dbc900d9a98a19)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://github.com/esmil/linux/commit/b422a122c72a7448306ad60808c748d57b98da71
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout b422a122c72a7448306ad60808c748d57b98da71
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/char/hw_random/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/char/hw_random/starfive-vic-rng.c:238:34: warning: unused variable 'vic_rng_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id vic_rng_dt_ids[] = {
                                    ^
   1 warning generated.


vim +/vic_rng_dt_ids +238 drivers/char/hw_random/starfive-vic-rng.c

   237	
 > 238	static const struct of_device_id vic_rng_dt_ids[] = {
   239		{ .compatible = "starfive,vic-rng" },
   240		{ }
   241	};
   242	MODULE_DEVICE_TABLE(of, vic_rng_dt_ids);
   243	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
