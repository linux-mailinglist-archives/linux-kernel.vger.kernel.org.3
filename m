Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7894DB9DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239427AbiCPVC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiCPVCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:02:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AED8D87
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647464469; x=1679000469;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UcKTF09zWMtVPXzfB442+VXNOwnoIP9p0oq0fG5aprc=;
  b=NmpIaDjshDBBK2Rklyrdqv9mueg4O/8RjX2gzAn/hrkJXchqm0DmGyQ9
   djvM7obE6PcJfl4CGW/RXe+2XBOW+RpyPNQjs7vxgBq9gxP+TP/j6AzW2
   UahpkS3YfoCyBazOQgEuBRKKTURnuID9BmNGo5x0C7U2yU4niRY6faDLA
   11aA0UOuV90hWMZPMnguxo7dP6XF1HBvRfYxyEOkjMdbtKYqB1iyX6EN/
   Bl3lB8UMtfxIlS9ck8r8UN2OlcsXWEzRFEDTjl6Pw2474Auer/iLWU4tl
   K27FxJPPHnxWA5va2bWFYsRZgc7B68hVe6lBpN/lAS+Ab9PcD/V6vwM2y
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244163436"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="244163436"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 14:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="541093203"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2022 14:00:44 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUal9-000CvY-MJ; Wed, 16 Mar 2022 21:00:43 +0000
Date:   Thu, 17 Mar 2022 05:00:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>
Subject: [pinchartl-media:am572x/vip 3/129]
 drivers/media/platform/ti-vpe/vip.c:892:22: warning: variable 'list_length'
 set but not used
Message-ID: <202203170449.Gb8UPhN9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/pinchartl/media.git am572x/vip
head:   2a2995588382c94f9346c69248af9c716e532b9b
commit: e2cd6cd91c127527f1c3a04d236a968740d99a45 [3/129] media: ti-vpe: Add the VIP driver
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220317/202203170449.Gb8UPhN9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add pinchartl-media git://linuxtv.org/pinchartl/media.git
        git fetch --no-tags pinchartl-media am572x/vip
        git checkout e2cd6cd91c127527f1c3a04d236a968740d99a45
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/media/platform/ti-vpe/vip.c: In function 'populate_desc_list':
>> drivers/media/platform/ti-vpe/vip.c:892:22: warning: variable 'list_length' set but not used [-Wunused-but-set-variable]
     892 |         unsigned int list_length;
         |                      ^~~~~~~~~~~
   drivers/media/platform/ti-vpe/vip.c: In function 'vip_try_fmt_vid_cap':
   drivers/media/platform/ti-vpe/vip.c:1635:35: error: implicit declaration of function 'v4l2_subdev_alloc_pad_config'; did you mean 'v4l2_subdev_alloc_state'? [-Werror=implicit-function-declaration]
    1635 |                         pad_cfg = v4l2_subdev_alloc_pad_config(port->subdev);
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                   v4l2_subdev_alloc_state
   drivers/media/platform/ti-vpe/vip.c:1635:33: warning: assignment to 'struct v4l2_subdev_pad_config *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1635 |                         pad_cfg = v4l2_subdev_alloc_pad_config(port->subdev);
         |                                 ^
   In file included from include/media/v4l2-device.h:13,
                    from drivers/media/platform/ti-vpe/vip.h:17,
                    from drivers/media/platform/ti-vpe/vip.c:28:
   drivers/media/platform/ti-vpe/vip.c:1642:48: error: passing argument 2 of '((const struct v4l2_subdev_pad_ops *)v4l2_subdev_call_wrappers.pad)->set_fmt' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1642 |                                                pad_cfg, &format);
         |                                                ^~~~~~~
         |                                                |
         |                                                struct v4l2_subdev_pad_config *
   include/media/v4l2-subdev.h:1190:65: note: in definition of macro 'v4l2_subdev_call'
    1190 |                                                         __sd, ##args);  \
         |                                                                 ^~~~
   drivers/media/platform/ti-vpe/vip.c:1642:48: note: expected 'struct v4l2_subdev_state *' but argument is of type 'struct v4l2_subdev_pad_config *'
    1642 |                                                pad_cfg, &format);
         |                                                ^~~~~~~
   include/media/v4l2-subdev.h:1190:65: note: in definition of macro 'v4l2_subdev_call'
    1190 |                                                         __sd, ##args);  \
         |                                                                 ^~~~
   drivers/media/platform/ti-vpe/vip.c:1642:48: error: passing argument 2 of '((const struct v4l2_subdev_pad_ops *)__sd->ops->pad)->set_fmt' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1642 |                                                pad_cfg, &format);
         |                                                ^~~~~~~
         |                                                |
         |                                                struct v4l2_subdev_pad_config *
   include/media/v4l2-subdev.h:1192:60: note: in definition of macro 'v4l2_subdev_call'
    1192 |                         __result = __sd->ops->o->f(__sd, ##args);       \
         |                                                            ^~~~
   drivers/media/platform/ti-vpe/vip.c:1642:48: note: expected 'struct v4l2_subdev_state *' but argument is of type 'struct v4l2_subdev_pad_config *'
    1642 |                                                pad_cfg, &format);
         |                                                ^~~~~~~
   include/media/v4l2-subdev.h:1192:60: note: in definition of macro 'v4l2_subdev_call'
    1192 |                         __result = __sd->ops->o->f(__sd, ##args);       \
         |                                                            ^~~~
   drivers/media/platform/ti-vpe/vip.c:1659:25: error: implicit declaration of function 'v4l2_subdev_free_pad_config' [-Werror=implicit-function-declaration]
    1659 |                         v4l2_subdev_free_pad_config(pad_cfg);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/media/platform/ti-vpe/vip.c: In function 'free_port':
   drivers/media/platform/ti-vpe/vip.c:3614:9: error: implicit declaration of function 'v4l2_async_notifier_unregister'; did you mean 'v4l2_async_nf_unregister'? [-Werror=implicit-function-declaration]
    3614 |         v4l2_async_notifier_unregister(&port->notifier);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         v4l2_async_nf_unregister
   drivers/media/platform/ti-vpe/vip.c:3615:9: error: implicit declaration of function 'v4l2_async_notifier_cleanup'; did you mean 'v4l2_async_nf_cleanup'? [-Werror=implicit-function-declaration]
    3615 |         v4l2_async_notifier_cleanup(&port->notifier);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         v4l2_async_nf_cleanup
   drivers/media/platform/ti-vpe/vip.c: In function 'vip_create_streams':
>> drivers/media/platform/ti-vpe/vip.c:3636:42: warning: variable 'bus' set but not used [-Wunused-but-set-variable]
    3636 |         struct v4l2_fwnode_bus_parallel *bus;
         |                                          ^~~
   drivers/media/platform/ti-vpe/vip.c: In function 'vip_register_subdev_notif':
   drivers/media/platform/ti-vpe/vip.c:3784:9: error: implicit declaration of function 'v4l2_async_notifier_init'; did you mean 'v4l2_async_nf_init'? [-Werror=implicit-function-declaration]
    3784 |         v4l2_async_notifier_init(notifier);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
         |         v4l2_async_nf_init
   drivers/media/platform/ti-vpe/vip.c:3786:15: error: implicit declaration of function 'v4l2_async_notifier_add_fwnode_subdev'; did you mean 'v4l2_async_nf_add_fwnode_remote'? [-Werror=implicit-function-declaration]
    3786 |         asd = v4l2_async_notifier_add_fwnode_subdev(notifier, subdev,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               v4l2_async_nf_add_fwnode_remote
   drivers/media/platform/ti-vpe/vip.c:3786:13: warning: assignment to 'struct v4l2_async_subdev *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    3786 |         asd = v4l2_async_notifier_add_fwnode_subdev(notifier, subdev,
         |             ^
   drivers/media/platform/ti-vpe/vip.c:3796:15: error: implicit declaration of function 'v4l2_async_notifier_register'; did you mean 'v4l2_async_nf_register'? [-Werror=implicit-function-declaration]
    3796 |         ret = v4l2_async_notifier_register(dev->v4l2_dev, notifier);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               v4l2_async_nf_register
   drivers/media/platform/ti-vpe/vip.c: In function 'vip_probe':
>> drivers/media/platform/ti-vpe/vip.c:4016:25: warning: variable 'pinctrl' set but not used [-Wunused-but-set-variable]
    4016 |         struct pinctrl *pinctrl;
         |                         ^~~~~~~
   drivers/media/platform/ti-vpe/vip.c: In function 'add_out_dtd':
   drivers/media/platform/ti-vpe/vip.c:722:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
     722 |                 plane = 1;
         |                 ~~~~~~^~~
   drivers/media/platform/ti-vpe/vip.c:724:9: note: here
     724 |         case VIP_SRCE_LUMA:
         |         ^~~~
   cc1: some warnings being treated as errors


vim +/list_length +892 drivers/media/platform/ti-vpe/vip.c

   887	
   888	static void populate_desc_list(struct vip_stream *stream)
   889	{
   890		struct vip_port *port = stream->port;
   891		struct vip_dev *dev = port->dev;
 > 892		unsigned int list_length;
   893	
   894		stream->desc_next = stream->desc_list.buf.addr;
   895		add_stream_dtds(stream);
   896	
   897		list_length = stream->desc_next - stream->desc_list.buf.addr;
   898		vpdma_map_desc_buf(dev->shared->vpdma, &stream->desc_list.buf);
   899	}
   900	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
