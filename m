Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587E6523F81
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348223AbiEKVga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348234AbiEKVgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:36:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0912735850
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652304984; x=1683840984;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tnv8aVEdMbuFnx6SNCfADImceBgK3EGK1Mda3eNKntQ=;
  b=YylvVn9/dFITg+D+ZCA3iU4vPzTOMEV/2sdMEL5mpTEa6p99odA1UxEB
   /RoZXhjPmI2kkrvmHzmOXo8hWnUWs9HAMUXDeQACM2MfHZRxMK2ZFSrCj
   XthjHdbUPbnwQxmdnxhfjL5pTji9ZT1iW5/tWSU4RLsvONRPs+3SkH/9w
   bqT66c3swEJ5Cd5VBzo0AlsYmNOAO1y/4OXm765BIuUC5DmDxLmeNk4aJ
   sDWg9DE1wVE6pAjflfhb/8wdxKOZm9vvX51JhS6hO5dNVudX0Et9CXBYX
   /jVvgUduLRnKUHwH2Xiqu23SE2hB+PggGmabBgZCE5aTBalALgE19xNl5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="257369167"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="257369167"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 14:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="895521680"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 May 2022 14:36:22 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nou0L-000Jbj-H5;
        Wed, 11 May 2022 21:36:21 +0000
Date:   Thu, 12 May 2022 05:35:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mszyprow:v5.18-next-20220511-dsi-rework 30/35]
 drivers/gpu/drm/drm_mipi_dsi.c:1233: warning: expecting prototype for
 mipi_dsi_init(). Prototype was for mipi_dsi_host_init() instead
Message-ID: <202205120512.Q6FPhYo7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mszyprow/linux.git v5.18-next-20220511-dsi-rework
head:   d29c9c083847e486080eaa98808c232b9937f85f
commit: b34dc79ad31fa0497197519a9060be3ef2e72484 [30/35] drm/mipi-dsi: add support for host initialize callbacks
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220512/202205120512.Q6FPhYo7-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/mszyprow/linux/commit/b34dc79ad31fa0497197519a9060be3ef2e72484
        git remote add mszyprow https://github.com/mszyprow/linux.git
        git fetch --no-tags mszyprow v5.18-next-20220511-dsi-rework
        git checkout b34dc79ad31fa0497197519a9060be3ef2e72484
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_mipi_dsi.c:1233: warning: expecting prototype for mipi_dsi_init(). Prototype was for mipi_dsi_host_init() instead


vim +1233 drivers/gpu/drm/drm_mipi_dsi.c

  1225	
  1226	/**
  1227	 * mipi_dsi_init() - initialize MIPI DSI host
  1228	 * @dsi: DSI peripheral device
  1229	 *
  1230	 * Return: 0 on success or a negative error code on failure.
  1231	 */
  1232	int mipi_dsi_host_init(struct mipi_dsi_device *dsi)
> 1233	{
  1234		const struct mipi_dsi_host_ops *ops = dsi->host->ops;
  1235	
  1236		if (!ops)
  1237			return -ENOSYS;
  1238		if (!ops->init)
  1239			return 0;
  1240	
  1241		return ops->init(dsi->host);
  1242	}
  1243	EXPORT_SYMBOL(mipi_dsi_host_init);
  1244	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
