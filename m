Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B165E4B53B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355343AbiBNOsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:48:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355314AbiBNOsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:48:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4728149258
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644850091; x=1676386091;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XjZ3XX92bOJCQMXihJbsWX7fSXKayoIRaT8bUARKYRk=;
  b=YmM5imbhtf4+QXPdr0B2QQHhXr3651vderhYk9v69hb96EFzS78I3PdW
   mx7CJdTB+oL6RTULGaXl8j9ui+hVCNgEB5F//tL6bKOuGmWAJiZ2TyWjq
   Uf2YZjAb6TK882RmWff7TUTZxHACpFN0x5JgEOuq9V7cXT+g1zQPkfNuh
   rPKqxljKgePpcVt/AAIc8C3al3KCFyLvTvcCsgRUspx/OCUmCmXrhyhUc
   WzwwITOrS2i6zVFHhLlpPZQNUO0O7EQ/X2yDrBg9BEzZT7TpF+azzhoNP
   aDv0Holj4mbuTlNgaIGXDU0kCz9NHi17hDWMrcZk1O3kl6G7RwINxJarz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="274673818"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="274673818"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 06:48:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="624261061"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Feb 2022 06:48:09 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJce8-0008fG-RA; Mon, 14 Feb 2022 14:48:08 +0000
Date:   Mon, 14 Feb 2022 22:47:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: drivers/iio/adc/xilinx-ams.c:1195:21: error: unused variable 'ams'
Message-ID: <202202142203.4ofqbic9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   754e0b0e35608ed5206d6a67a791563c631cec07
commit: d5c70627a79455154f5f636096abe6fe57510605 iio: adc: Add Xilinx AMS driver
date:   8 weeks ago
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220214/202202142203.4ofqbic9-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5c70627a79455154f5f636096abe6fe57510605
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d5c70627a79455154f5f636096abe6fe57510605
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/iio/adc/ drivers/net/ethernet/freescale/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iio/adc/xilinx-ams.c: In function 'ams_iounmap_ps':
>> drivers/iio/adc/xilinx-ams.c:1195:21: error: unused variable 'ams' [-Werror=unused-variable]
    1195 |         struct ams *ams = data;
         |                     ^~~
   drivers/iio/adc/xilinx-ams.c: In function 'ams_iounmap_pl':
   drivers/iio/adc/xilinx-ams.c:1202:21: error: unused variable 'ams' [-Werror=unused-variable]
    1202 |         struct ams *ams = data;
         |                     ^~~
   cc1: all warnings being treated as errors


vim +/ams +1195 drivers/iio/adc/xilinx-ams.c

  1192	
  1193	static void ams_iounmap_ps(void *data)
  1194	{
> 1195		struct ams *ams = data;
  1196	
  1197		iounmap(ams->ps_base);
  1198	}
  1199	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
