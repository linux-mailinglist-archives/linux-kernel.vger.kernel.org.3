Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB68E524845
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351698AbiELIuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiELIuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:50:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E89D2265C7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652345409; x=1683881409;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BP5YD06y/O3Sw9t3ytaTO/BdhrPRV/VfhyJt+TilrsM=;
  b=Srw9LerPCatelqFatshSHKdQ7jw7pl49OUqAi8oRUVQyTkNPs9C6x00s
   lCiUhA8rjBje/8YGE6IELdDingtDVOCSw6fa0rOTAxqvosRU8CzVGd6Pu
   jVcCxafs4m13UYqOfW0GqCgVl95g0nms/FZGDEojUxr/UlcFZQXsXiOmh
   3R9eCvdP9m6AxQJ6pNxvBqlDmE9GJbfDX67tfpHqk4+3KsQryMOHOUwUC
   RKLuHi3P9s1gUjQ0ba8iHVuzBU+YaaQ80rnf+oG7f6acHSo2N4mxxHFPZ
   0D97arH7F1rwBT+g1BfDp9NIB2itQWPLTsCFNPmAvqy6WUTmHuSfVUYqp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269614835"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="269614835"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 01:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="739598351"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 May 2022 01:50:06 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np4WM-000KDc-6n;
        Thu, 12 May 2022 08:50:06 +0000
Date:   Thu, 12 May 2022 16:50:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mszyprow:v5.18-next-20220511-dsi-rework 30/35]
 drivers/gpu/drm/drm_mipi_dsi.c:1233: warning: expecting prototype for
 mipi_dsi_init(). Prototype was for mipi_dsi_host_init() instead
Message-ID: <202205121652.A7CaHuUB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/mszyprow/linux.git v5.18-next-20220511-dsi-rework
head:   d29c9c083847e486080eaa98808c232b9937f85f
commit: b34dc79ad31fa0497197519a9060be3ef2e72484 [30/35] drm/mipi-dsi: add support for host initialize callbacks
config: x86_64-randconfig-a001-20220509 (https://download.01.org/0day-ci/archive/20220512/202205121652.A7CaHuUB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/mszyprow/linux/commit/b34dc79ad31fa0497197519a9060be3ef2e72484
        git remote add mszyprow https://github.com/mszyprow/linux.git
        git fetch --no-tags mszyprow v5.18-next-20220511-dsi-rework
        git checkout b34dc79ad31fa0497197519a9060be3ef2e72484
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/

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
