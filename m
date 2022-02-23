Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97564C1E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbiBWWLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbiBWWLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:11:20 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A594DF62
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645654252; x=1677190252;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yngl5EjFVJrNgtDP4WkS6h5DZITf9sOuUSoryQVKxuw=;
  b=hvbMY+1MtJpLLTIt1IpG8Lh31AnbbyhkhBUQ+x6JLBp2J0iDezr+g4Kb
   YCFCyVWPhaU0T5zLqJTTfuNsS+jwfLFpZ04Vrzphen3rkI0g4+wXfJ10q
   VeejuMX2BWpp5OfvMiI1xK8vVReKLvEXRu5ulZrlgJpVdbSn2FnNf8dg6
   ntCqDIdOML+E/hEpQ2aeqjiqfQpOz3FQ5Xm/gBg0YpXcBmlPaBwz725n3
   yWXCuebGUka8SlrHXXx0v0QD+jS+A8EeaGakdmEUfL+D4faYAESJdWQlv
   RXeNRX6Gee8POAiId28oSWq8vexofGHD2tww+UDMcA23zCjgWif6M5mHv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="249671021"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="249671021"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:10:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="783525886"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2022 14:10:50 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMzqT-0001sk-MW; Wed, 23 Feb 2022 22:10:49 +0000
Date:   Thu, 24 Feb 2022 06:10:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>
Subject: [thierryreding:for-5.18/work 125/143]
 drivers/soc/tegra/cbb/tegra234-cbb.c:31:10: fatal error:
 soc/tegra/tegra-grace-cbb.h: No such file or directory
Message-ID: <202202240633.d1qLZfuY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/thierryreding/linux for-5.18/work
head:   1cdb7fffbcf8f949410bfa97c8cca5acc0285a48
commit: 680fb4639742070b06e49b485cbfa8b21772884f [125/143] soc: tegra: cbb: Add support for tegra-grace SOC
config: arm64-buildonly-randconfig-r004-20220223 (https://download.01.org/0day-ci/archive/20220224/202202240633.d1qLZfuY-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/thierryreding/linux/commit/680fb4639742070b06e49b485cbfa8b21772884f
        git remote add thierryreding https://github.com/thierryreding/linux
        git fetch --no-tags thierryreding for-5.18/work
        git checkout 680fb4639742070b06e49b485cbfa8b21772884f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/iommu/ drivers/soc/tegra/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/tegra/cbb/tegra234-cbb.c:31:10: fatal error: soc/tegra/tegra-grace-cbb.h: No such file or directory
      31 | #include <soc/tegra/tegra-grace-cbb.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +31 drivers/soc/tegra/cbb/tegra234-cbb.c

  > 31	#include <soc/tegra/tegra-grace-cbb.h>
    32	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
