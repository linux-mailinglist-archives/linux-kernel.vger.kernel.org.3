Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD09559271B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 02:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiHOAl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 20:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHOAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 20:41:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF765F74
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 17:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660524083; x=1692060083;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NUfzQJPVEspTQtF4rEJIxdoKCxDDUmghzxbwnuhwZqs=;
  b=U3ri8TwBp7EghEgm788s607IGOh5TBHUUuNjpD9LQHkqIWu4pYDDX8Km
   Wcteye3fCX2TWUdF4PT0HqRtTjkDzfHfiK+84dBaMLNonVWw0WuQWSWdt
   O59Uo4+Y+w8CnxPLlLm3JpRY1P58MFMyJ80CEyu9+y0odaTxvp/UgcBIa
   adB9gXd0m78KvVpJxJpvcTttOVkawMsSNuFobzQvwwgtdOngxuhcPQuEd
   kebbUJHotCTrZ2UFCkXXbUMHRdtRbZ8nA+h7N5uBAwnuKGD4vDLORkesr
   jXItKy3UYmS718cQVa62fqLgXffTlfwO6ZvaUYQOajsnbZfC/r2dAM7um
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="292659943"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="292659943"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 17:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="674673589"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2022 17:41:22 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNOAT-0000fB-2F;
        Mon, 15 Aug 2022 00:41:21 +0000
Date:   Mon, 15 Aug 2022 08:41:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/dsa/microchip/ksz9477_i2c.c:89:34: warning:
 'ksz9477_dt_ids' defined but not used
Message-ID: <202208150803.dDl0Nq6W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arun,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f162193d6e48eb4ff51c2ea3612f1daebca1b7e
commit: 07bca160469b4d19ca0a35bc83b26ed18fcbd96d net: dsa: microchip: common menuconfig for ksz series switch
date:   7 weeks ago
config: x86_64-buildonly-randconfig-r002-20220815 (https://download.01.org/0day-ci/archive/20220815/202208150803.dDl0Nq6W-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07bca160469b4d19ca0a35bc83b26ed18fcbd96d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 07bca160469b4d19ca0a35bc83b26ed18fcbd96d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/dsa/microchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/microchip/ksz9477_i2c.c:89:34: warning: 'ksz9477_dt_ids' defined but not used [-Wunused-const-variable=]
      89 | static const struct of_device_id ksz9477_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~


vim +/ksz9477_dt_ids +89 drivers/net/dsa/microchip/ksz9477_i2c.c

20e03777d70923 Tristram Ha   2019-09-10   88  
20e03777d70923 Tristram Ha   2019-09-10  @89  static const struct of_device_id ksz9477_dt_ids[] = {
eee16b147121ce Arun Ramadoss 2022-05-17   90  	{
eee16b147121ce Arun Ramadoss 2022-05-17   91  		.compatible = "microchip,ksz9477",
eee16b147121ce Arun Ramadoss 2022-05-17   92  		.data = &ksz_switch_chips[KSZ9477]
eee16b147121ce Arun Ramadoss 2022-05-17   93  	},
eee16b147121ce Arun Ramadoss 2022-05-17   94  	{
eee16b147121ce Arun Ramadoss 2022-05-17   95  		.compatible = "microchip,ksz9897",
eee16b147121ce Arun Ramadoss 2022-05-17   96  		.data = &ksz_switch_chips[KSZ9897]
eee16b147121ce Arun Ramadoss 2022-05-17   97  	},
eee16b147121ce Arun Ramadoss 2022-05-17   98  	{
eee16b147121ce Arun Ramadoss 2022-05-17   99  		.compatible = "microchip,ksz9893",
eee16b147121ce Arun Ramadoss 2022-05-17  100  		.data = &ksz_switch_chips[KSZ9893]
eee16b147121ce Arun Ramadoss 2022-05-17  101  	},
eee16b147121ce Arun Ramadoss 2022-05-17  102  	{
eee16b147121ce Arun Ramadoss 2022-05-17  103  		.compatible = "microchip,ksz9563",
eee16b147121ce Arun Ramadoss 2022-05-17  104  		.data = &ksz_switch_chips[KSZ9893]
eee16b147121ce Arun Ramadoss 2022-05-17  105  	},
eee16b147121ce Arun Ramadoss 2022-05-17  106  	{
eee16b147121ce Arun Ramadoss 2022-05-17  107  		.compatible = "microchip,ksz8563",
eee16b147121ce Arun Ramadoss 2022-05-17  108  		.data = &ksz_switch_chips[KSZ9893]
eee16b147121ce Arun Ramadoss 2022-05-17  109  	},
eee16b147121ce Arun Ramadoss 2022-05-17  110  	{
eee16b147121ce Arun Ramadoss 2022-05-17  111  		.compatible = "microchip,ksz9567",
eee16b147121ce Arun Ramadoss 2022-05-17  112  		.data = &ksz_switch_chips[KSZ9567]
eee16b147121ce Arun Ramadoss 2022-05-17  113  	},
20e03777d70923 Tristram Ha   2019-09-10  114  	{},
20e03777d70923 Tristram Ha   2019-09-10  115  };
20e03777d70923 Tristram Ha   2019-09-10  116  MODULE_DEVICE_TABLE(of, ksz9477_dt_ids);
20e03777d70923 Tristram Ha   2019-09-10  117  

:::::: The code at line 89 was first introduced by commit
:::::: 20e03777d70923fe7eae0d7f043ef9488393ab95 net: dsa: microchip: add KSZ9477 I2C driver

:::::: TO: Tristram Ha <Tristram.Ha@microchip.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
