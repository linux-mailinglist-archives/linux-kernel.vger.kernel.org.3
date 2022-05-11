Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A2A523CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346518AbiEKSvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346494AbiEKSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:51:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F671E1238
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652295069; x=1683831069;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p22jqMyd9Gd9xko9YeWm7snKhmAr9/rzXbOCBbDXaEU=;
  b=EyA//dqud0CihvhQyy/zgx76jy/rNWqMRXllP0JjY9wC23dzgm6OTvE5
   77kpeK8iTEIcomrPbT+328yEpZbCVcbUejgpQ14nw5CxCzhDlezsJhGdq
   u4b0/vGsAnPEq2ro2/YwSIVH8kO01mDo/OldRrvZhvNA/7TAHm3K8yhXz
   ywEdwm7c72FDn9/bjHX7q44sXVv1GrkIGc5jqJkdw14wPlBT8komvORQO
   VrX4bjGfKqPZVpAamb5OtQ4gSaE8hbxkRTI7h64IlCKqFOsPXReSrZlP+
   jKfMPvJxhPi1Lt7AlYcpqz57LWlx4IvVhjGyIoZSHcKGbwT0lHkluAh//
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="268623218"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="268623218"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 11:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="739346950"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2022 11:51:07 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1norQQ-000JQO-Uc;
        Wed, 11 May 2022 18:51:06 +0000
Date:   Thu, 12 May 2022 02:50:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Shych <michaelsh@nvidia.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>
Subject: [pdx86-platform-drivers-x86:review-hans 40/59]
 drivers/platform/mellanox/nvsw-sn2201.c:942:16: warning: variable 'j' set
 but not used
Message-ID: <202205120232.oCAO8rb3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   57709a27d9744f5af4bbeec3ba3105c6aa1075eb
commit: 9e267f050444fa018c9a06b0cc07effac084b920 [40/59] platform/mellanox: Add support for new SN2201 system
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220512/202205120232.oCAO8rb3-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=9e267f050444fa018c9a06b0cc07effac084b920
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout 9e267f050444fa018c9a06b0cc07effac084b920
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/platform/mellanox/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/platform/mellanox/nvsw-sn2201.c: In function 'nvsw_sn2201_config_post_init':
>> drivers/platform/mellanox/nvsw-sn2201.c:942:16: warning: variable 'j' set but not used [-Wunused-but-set-variable]
     942 |         int i, j, err;
         |                ^


vim +/j +942 drivers/platform/mellanox/nvsw-sn2201.c

   936	
   937	static int nvsw_sn2201_config_post_init(struct nvsw_sn2201 *nvsw_sn2201)
   938	{
   939		struct mlxreg_hotplug_device *sn2201_dev;
   940		struct i2c_adapter *adap;
   941		struct device *dev;
 > 942		int i, j, err;
   943	
   944		dev = nvsw_sn2201->dev;
   945		adap = i2c_get_adapter(nvsw_sn2201->main_mux_deferred_nr);
   946		if (!adap) {
   947			dev_err(dev, "Failed to get adapter for bus %d\n",
   948				nvsw_sn2201->main_mux_deferred_nr);
   949			return -ENODEV;
   950		}
   951		i2c_put_adapter(adap);
   952	
   953		/* Update board info. */
   954		sn2201_dev = nvsw_sn2201->sn2201_devs;
   955		for (i = 0, j = 0; i < nvsw_sn2201->sn2201_devs_num; i++, sn2201_dev++) {
   956			sn2201_dev->adapter = i2c_get_adapter(sn2201_dev->nr);
   957			if (!sn2201_dev->adapter)
   958				return -ENODEV;
   959			i2c_put_adapter(sn2201_dev->adapter);
   960		}
   961	
   962		err = nvsw_sn2201_create_static_devices(nvsw_sn2201, nvsw_sn2201->sn2201_devs,
   963							nvsw_sn2201->sn2201_devs_num);
   964		if (err)
   965			dev_err(dev, "Failed to create static devices\n");
   966	
   967		return err;
   968	}
   969	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
