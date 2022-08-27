Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058E75A3A1C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiH0ViV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 17:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH0ViT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 17:38:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6C05F109
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661636298; x=1693172298;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6eynWqLNIpZ+77MTs5OlmZ76EWauuSlqSoP8zTxqwUE=;
  b=aV6shLacHJ3h0aK3Phe1Dwo5P1sK2VmcBtzl14F2cxepTCkgQE1i1/I5
   09HykSD/8WZ08G58T1am/7Y6NvNswtsHCn8KHMankHQgfnhJHxKT5BnK1
   g4xeWx2mKx7vY0RZwg4dWu+ZrmH6+3D45gabq4RdJ5gwki5b9jhtf0sBG
   VOXkzWJ7uii3b2/9f4VZghfC/zKLT8xByexztBZy75vNstTx9HifXz8xi
   SStYxlhp1gXFyqn3mmcx4MGdv44QWLCfBIbOstdZx47I0XFIF5/2qJ2F/
   CNWX8wJ4imtV8Xv1QJK4OnEY3k9Vro3uMaclarqkSj16PQ/UjRWoeZV3N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="277707144"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="277707144"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 14:38:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="640473709"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2022 14:38:16 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oS3VQ-0000VH-0m;
        Sat, 27 Aug 2022 21:38:16 +0000
Date:   Sun, 28 Aug 2022 05:37:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:vfio_iommufd 31/32] drivers/vfio/vfio.h:139:1: error:
 expected identifier or '(' before '{' token
Message-ID: <202208280502.wOrVPveF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux vfio_iommufd
head:   e2712af9ab672315cac202aee200eac0d63d7537
commit: e44832b4f99da1885565bf73e49805c2f82a7386 [31/32] vfio: Make vfio_container optionally compiled
config: sparc64-randconfig-c041-20220828 (https://download.01.org/0day-ci/archive/20220828/202208280502.wOrVPveF-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/e44832b4f99da1885565bf73e49805c2f82a7386
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe vfio_iommufd
        git checkout e44832b4f99da1885565bf73e49805c2f82a7386
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/vfio/vfio_main.c:36:
>> drivers/vfio/vfio.h:139:1: error: expected identifier or '(' before '{' token
     139 | {
         | ^
>> drivers/vfio/vfio.h:138:19: warning: 'vfio_container_use' used but never defined
     138 | static inline int vfio_container_use(struct vfio_group *group);
         |                   ^~~~~~~~~~~~~~~~~~
--
   In file included from drivers/vfio/vfio_iommufd.c:8:
>> drivers/vfio/vfio.h:139:1: error: expected identifier or '(' before '{' token
     139 | {
         | ^
   drivers/vfio/vfio.h:138:19: warning: 'vfio_container_use' declared 'static' but never defined [-Wunused-function]
     138 | static inline int vfio_container_use(struct vfio_group *group);
         |                   ^~~~~~~~~~~~~~~~~~


vim +139 drivers/vfio/vfio.h

   137	
 > 138	static inline int vfio_container_use(struct vfio_group *group);
 > 139	{
   140		return -EOPNOTSUPP;
   141	}
   142	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
