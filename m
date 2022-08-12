Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0ED5916BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 23:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiHLVeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiHLVeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 17:34:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8B29E2DC
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660340039; x=1691876039;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=reTgJ5fV2vfj/2OMjhMaKSNOZpIJX0kYO6SiIyfzfks=;
  b=Ejm+Yx4J5AVjGMe66XgHMe2ZpqzOnISwkOzDbRxCwDP58rqnL7e6dY/1
   JjaIaV18o9x8+OnnDc+81Zl9r7HT48Muv9ZpMFbvutiQHJvmpWde8sfda
   Z61z0HXgjxklmX09Lousfxf5Q6WF9RtB28q4qLAXNRD4LKVADuwCVLn/K
   gr8tXJ6wxC3eC6rI+Ak6hb4wctn6H9QUiIN6wy4NER7UW6y0L3xlM/Md6
   wueXhXcGNxu2yhXCqGlyYYjXhvS0k4rF178heeBmR4PwVy3ASmGgNyvdo
   r7JfhK+jiD86HkJOeM9h0QUvjuDBPmtDPYcBkl0k9yByvoK+YsQ6VVLr5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355699125"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="355699125"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 14:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="606053922"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Aug 2022 14:33:57 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMcI1-0000yd-02;
        Fri, 12 Aug 2022 21:33:57 +0000
Date:   Sat, 13 Aug 2022 05:33:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 33/40]
 drivers/net/ethernet/pensando/ionic/ionic_devlink.c:93:69: error: expected
 ')' before ';' token
Message-ID: <202208130548.6SBXNgLQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_devlink_locking
head:   3752df45a64c94afd110eeb956cd9adaeec586c1
commit: 95a8f1859e438effd49d5c1ae7828e87b8471180 [33/40] net: make drivers to use SET_NETDEV_DEVLINK_PORT to set devlink_port
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220813/202208130548.6SBXNgLQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/jpirko/linux_mlxsw/commit/95a8f1859e438effd49d5c1ae7828e87b8471180
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout 95a8f1859e438effd49d5c1ae7828e87b8471180
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/ethernet/pensando/ionic/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/pensando/ionic/ionic_devlink.c:5:
   drivers/net/ethernet/pensando/ionic/ionic_devlink.c: In function 'ionic_devlink_register':
   include/linux/netdevice.h:2348:1: error: expected ';' before ')' token
    2348 | )}
         | ^
   drivers/net/ethernet/pensando/ionic/ionic_devlink.c:93:9: note: in expansion of macro 'SET_NETDEV_DEVLINK_PORT'
      93 |         SET_NETDEV_DEVLINK_PORT(ionic->lif->netdev, &ionic->dl_port);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/netdevice.h:2348:1: error: expected statement before ')' token
    2348 | )}
         | ^
   drivers/net/ethernet/pensando/ionic/ionic_devlink.c:93:9: note: in expansion of macro 'SET_NETDEV_DEVLINK_PORT'
      93 |         SET_NETDEV_DEVLINK_PORT(ionic->lif->netdev, &ionic->dl_port);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/pensando/ionic/ionic_devlink.c:93:69: error: expected ')' before ';' token
      93 |         SET_NETDEV_DEVLINK_PORT(ionic->lif->netdev, &ionic->dl_port);
         |                                                                     ^
>> drivers/net/ethernet/pensando/ionic/ionic_devlink.c:95:18: error: expected ';' before '}' token
      95 |         return 0;
         |                  ^
         |                  ;
      96 | }
         | ~                 
   drivers/net/ethernet/pensando/ionic/ionic_devlink.c:96:1: error: control reaches end of non-void function [-Werror=return-type]
      96 | }
         | ^
   cc1: some warnings being treated as errors


vim +93 drivers/net/ethernet/pensando/ionic/ionic_devlink.c

    78	
    79	int ionic_devlink_register(struct ionic *ionic)
    80	{
    81		struct devlink *dl = priv_to_devlink(ionic);
    82		struct devlink_port_attrs attrs = {};
    83		int err;
    84	
    85		attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
    86		devlink_port_attrs_set(&ionic->dl_port, &attrs);
    87		err = devlink_port_register(dl, &ionic->dl_port, 0);
    88		if (err) {
    89			dev_err(ionic->dev, "devlink_port_register failed: %d\n", err);
    90			return err;
    91		}
    92	
  > 93		SET_NETDEV_DEVLINK_PORT(ionic->lif->netdev, &ionic->dl_port);
    94		devlink_register(dl);
  > 95		return 0;
    96	}
    97	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
