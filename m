Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1C59AB76
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 07:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbiHTFTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 01:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHTFTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 01:19:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09C613F3E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 22:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660972768; x=1692508768;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kUd4d01n/xeuJZR/NF5vEXzNHU8yvP/geJKtLQPI39k=;
  b=n0ECPTl2O+kkYBiyzfqJ3wnOLiotIazgK0QRKJYTRxvE+6hWnqHfxiMB
   x7Z2D0ZMnuiTGLZ9ewCvbE7b0SVE+VGyhgZW/jASsRbF7REaPl+E4sqVK
   1jv9eBNHlI0jVde2OwsKevr3oVPIycxxvC5WJW8aV6mZP+GkiZxuFoiq4
   hnhOOsWuZR+5bCCG84bVV0zhQVN6oYLHUorffWwoT1V3OAH6iiACEdiCc
   8kE2IcsUxR0KZ8oPeaiMlsZcJ5NoSZlukizOxRDCYcbl3xh5Yu3G0uYDI
   WTEvHUYOAbHvBgP0pTuGdbqkLLrAQ6XKmi28Ako2+nEkIBNx+acUeaXgc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="273543555"
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="273543555"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 22:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="637522503"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2022 22:19:27 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPGtK-0002C3-1U;
        Sat, 20 Aug 2022 05:19:26 +0000
Date:   Sat, 20 Aug 2022 13:18:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jgunthorpe:vfio_iommufd 25/29] drivers/vfio/vfio_main.c:600:
 undefined reference to `iommufd_vfio_compat_ioas_id'
Message-ID: <202208201310.oYoCaywG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux vfio_iommufd
head:   d2ab4343c9f524e9404059830828188b0f8a15b6
commit: 41be72284fea27e79bd85a42d1967b13d7f26147 [25/29] vfio-iommufd: Allow iommufd to be used in place of a container fd
config: microblaze-randconfig-r001-20220820 (https://download.01.org/0day-ci/archive/20220820/202208201310.oYoCaywG-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jgunthorpe/linux/commit/41be72284fea27e79bd85a42d1967b13d7f26147
        git remote add jgunthorpe https://github.com/jgunthorpe/linux
        git fetch --no-tags jgunthorpe vfio_iommufd
        git checkout 41be72284fea27e79bd85a42d1967b13d7f26147
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/vfio/vfio_main.o: in function `vfio_group_ioctl_set_container':
>> drivers/vfio/vfio_main.c:600: undefined reference to `iommufd_vfio_compat_ioas_id'


vim +600 drivers/vfio/vfio_main.c

   568	
   569	static int vfio_group_ioctl_set_container(struct vfio_group *group,
   570						  int __user *arg)
   571	{
   572		struct vfio_container *container;
   573		struct iommufd_ctx *iommufd;
   574		struct fd f;
   575		int ret = -EINVAL;
   576		int fd;
   577	
   578		if (get_user(fd, arg))
   579			return -EFAULT;
   580	
   581		f = fdget(fd);
   582		if (!f.file)
   583			return -EBADF;
   584	
   585		down_write(&group->group_rwsem);
   586		if (vfio_group_has_container(group))
   587			goto out_unlock;
   588	
   589		container = vfio_container_from_file(f.file);
   590		if (container) {
   591			ret = vfio_container_attach_group(group, container);
   592			goto out_unlock;
   593		}
   594	
   595		iommufd = iommufd_ctx_from_file(f.file);
   596		if (!IS_ERR(iommufd)) {
   597			u32 ioas_id;
   598	
   599			group->iommufd = iommufd;
 > 600			ret = iommufd_vfio_compat_ioas_id(iommufd, &ioas_id);
   601			goto out_unlock;
   602		}
   603	
   604	out_unlock:
   605		up_write(&group->group_rwsem);
   606		fdput(f);
   607		return ret;
   608	}
   609	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
