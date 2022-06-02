Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4AC53BE90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 21:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbiFBTTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 15:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbiFBTTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 15:19:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF51FF7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654197581; x=1685733581;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4gnczcXOvNID4XxHMeyE2k9aZh9fLIqtdd5bKlnKz0w=;
  b=XoEIlLdRD6LkdlBfeoVUMvBy1Ry+MLVtqQFyuZ3J1K9DtZNXgwyf/M8Y
   CsltABojxdVapypCPjbA/EZmQeuN8KSCHFekz7VJFjdwhTQ8RCD1o/zBG
   +JRGqgPLMrwi2qswF+DNcr/MQQ+cvnYJDx+V0iSMsKDYQCgyCQw+4haQV
   MakXWOHwFDBDjpChnE57jypvmiQbTw2bM0ROM1GuVPXQwFKcFt1s0rKXj
   O+iEAE2P0PipVajudfapjlTJayRNZgCvnwmcXR1iEnLWrnuwaNFtZV/Cv
   oZJPpOwPdHiX3fs4dm2k0zoCRiwWGuBInyEUaWPvpRw6M4drSQsWeAcKA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="258127966"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="258127966"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 12:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="530711624"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2022 12:19:40 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwqM7-0005NF-Or;
        Thu, 02 Jun 2022 19:19:39 +0000
Date:   Fri, 3 Jun 2022 03:19:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_lc_dev 4/5] core_linecard_dev.c:undefined
 reference to `auxiliary_device_init'
Message-ID: <202206030331.RWwc4l16-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_lc_dev
head:   ef34c1c33c0ae43a9ad3c0ed3708eb1880972de0
commit: 2d0852c5fa89a48c6fa1f860600b5e24e2faab4b [4/5] mlxsw: core_linecards: Introduce per line card auxiliary device
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220603/202206030331.RWwc4l16-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/jpirko/linux_mlxsw/commit/2d0852c5fa89a48c6fa1f860600b5e24e2faab4b
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_lc_dev
        git checkout 2d0852c5fa89a48c6fa1f860600b5e24e2faab4b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.o: in function `mlxsw_linecard_dev_add':
>> core_linecard_dev.c:(.text+0x129): undefined reference to `auxiliary_device_init'
>> ld: core_linecard_dev.c:(.text+0x14f): undefined reference to `__auxiliary_device_add'
   ld: drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.o: in function `mlxsw_linecard_driver_register':
>> core_linecard_dev.c:(.text+0x1a6): undefined reference to `__auxiliary_driver_register'
   ld: drivers/net/ethernet/mellanox/mlxsw/core_linecard_dev.o: in function `mlxsw_linecard_driver_unregister':
>> core_linecard_dev.c:(.text+0x1ba): undefined reference to `auxiliary_driver_unregister'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
