Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61894AE935
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiBIFY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:24:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiBIFVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:21:25 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A820EC03C1A6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644384087; x=1675920087;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9ZPG7Vx7bw7Ff3rJaRHL7dpWZ5aygBRkVKwB+8cablY=;
  b=NmXlm1wKupTVKCivCzn86WtVlqFYPp6LHZrfy/79I1NvtrIb//EbNoKN
   Isp2cZVWeHrLM/nlRB8PNn3vj/WkNipiA1J7EyCkZljqc4qI9EK8IghZH
   9wCG3ajxSjSE45rzRS4SFGSAtvB2/4/9oWkrR5VX/KI6eiTsol+CFyAFc
   Mp2SgMxf2dRDXBYudtqafiqbtIOyIuOzzg0Q2wq2xxKPxGXFmXiuXqwRB
   WqpW4PSXEj6NU85sXontOQEcQrjofyMqg1Adivcqae0zFzJd4kro4hGVL
   cYBsIy7YjlBE9PIrZ/9JKI6mgHvvV1BUrTWuzMTdYXmOJz25z4crwR8Mu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="273656557"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="273656557"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 21:21:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="485092656"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2022 21:21:26 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHfPx-0001Fj-IV; Wed, 09 Feb 2022 05:21:25 +0000
Date:   Wed, 9 Feb 2022 13:20:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:iommufd 31/31] drivers/iommu/iommufd/device.c:122:40:
 warning: variable 'ioaspt' set but not used
Message-ID: <202202091306.YxErokC5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux iommufd
head:   6b5b3f20ed6b64824c2d447b4f4555fcb390bf3b
commit: 6b5b3f20ed6b64824c2d447b4f4555fcb390bf3b [31/31] mad musings
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220209/202202091306.YxErokC5-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/6b5b3f20ed6b64824c2d447b4f4555fcb390bf3b
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe iommufd
        git checkout 6b5b3f20ed6b64824c2d447b4f4555fcb390bf3b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/iommu/iommufd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iommu/iommufd/device.c: In function 'iommufd_device_attach_sw':
>> drivers/iommu/iommufd/device.c:122:40: warning: variable 'ioaspt' set but not used [-Wunused-but-set-variable]
     122 |         struct iommufd_ioas_pagetable *ioaspt;
         |                                        ^~~~~~


vim +/ioaspt +122 drivers/iommu/iommufd/device.c

   119	
   120	static int iommufd_device_attach_sw(struct iommufd_device *idev, u32 *pt_id)
   121	{
 > 122		struct iommufd_ioas_pagetable *ioaspt;
   123		struct iommufd_object *obj;
   124	
   125		obj = iommufd_get_object(idev->ictx, *pt_id,
   126					 IOMMUFD_OBJ_IOAS_PAGETABLE);
   127		if (IS_ERR(obj))
   128			return PTR_ERR(obj);
   129		ioaspt = container_of(obj, struct iommufd_ioas_pagetable, obj);
   130		iommufd_put_object_keep_user(obj);
   131		//idev->ioaspt = ioaspt;
   132		return 0;
   133	}
   134	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
