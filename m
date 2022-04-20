Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9C507DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358671AbiDTAzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiDTAzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:55:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE652252C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650415984; x=1681951984;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XQ+7AA0/tIqOmGQEOFBUT/yZ2tkfE6PI9DR65t0c9Eo=;
  b=lvM18qaGh7hWZOU7b4RpDgNl2fMX1qN97Kdw4Hzfifwp+MhMB15+tKN1
   YkKzTe++4OHJk+c0tX2QL9K/1C04Vfpewx/LjsH68mtFhTW8pCPImwkDA
   OlYu3ID3LSqhgfyEbPKwbzgRjOJmkPkpfIw0iyp1RdG9Qk66sZZKVqxT8
   Er38nFaQcEeaixLZcz2sqWHpcu7iwM43JaWHFyWU3l6DRat+qF+IUOe+f
   W2isEL/AXfaSSUxBf8VWhxhlpPNwZln9XgrqV4V/h40bnv/CnFMP0IrCG
   d6mfTH6T7ReGJyaBmH28AV/oeZ9nZ62qmUOq+T1wYmdj3jOpZMVy6UWQX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245801326"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="245801326"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 17:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="862448768"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Apr 2022 17:51:49 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngyZR-0006Nc-7d;
        Wed, 20 Apr 2022 00:51:49 +0000
Date:   Wed, 20 Apr 2022 08:51:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:scsi-gap-zone 10/10] drivers/scsi/scsi_debug.c:5101:5:
 warning: format specifies type 'unsigned int' but the argument has type
 'sector_t' (aka 'unsigned long long')
Message-ID: <202204200815.OaESmWOl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux scsi-gap-zone
head:   8a37a38282a57095a4a3ff6e6c68f2481234ad10
commit: 8a37a38282a57095a4a3ff6e6c68f2481234ad10 [10/10] scsi-debug-dbg
config: arm-randconfig-r025-20220419 (https://download.01.org/0day-ci/archive/20220420/202204200815.OaESmWOl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c1c49a356162b22554088d269f7689bdb044a9f1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/bvanassche/linux/commit/8a37a38282a57095a4a3ff6e6c68f2481234ad10
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche scsi-gap-zone
        git checkout 8a37a38282a57095a4a3ff6e6c68f2481234ad10
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/scsi/scsi_debug.c:5101:5: warning: format specifies type 'unsigned int' but the argument has type 'sector_t' (aka 'unsigned long long') [-Wformat]
                                   zsp->z_start, zsp->z_size);
                                   ^~~~~~~~~~~~
   include/linux/printk.h:519:34: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                   ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +5101 drivers/scsi/scsi_debug.c

  4995	
  4996	static int sdebug_device_create_zones(struct sdebug_dev_info *devip)
  4997	{
  4998		struct sdeb_zone_state *zsp;
  4999		sector_t capacity = get_sdebug_capacity();
  5000		sector_t conv_capacity;
  5001		sector_t zstart = 0;
  5002		unsigned int i;
  5003	
  5004		/*
  5005		 * Set the zone size: if sdeb_zbc_zone_size_mb is not set, figure out
  5006		 * a zone size allowing for at least 4 zones on the device. Otherwise,
  5007		 * use the specified zone size checking that at least 2 zones can be
  5008		 * created for the device.
  5009		 */
  5010		if (!sdeb_zbc_zone_size_mb) {
  5011			devip->zsize = (DEF_ZBC_ZONE_SIZE_MB * SZ_1M)
  5012				>> ilog2(sdebug_sector_size);
  5013			while (capacity < devip->zsize << 2 && devip->zsize >= 2)
  5014				devip->zsize >>= 1;
  5015			if (devip->zsize < 2) {
  5016				pr_err("Device capacity too small\n");
  5017				return -EINVAL;
  5018			}
  5019		} else {
  5020			if (!is_power_of_2(sdeb_zbc_zone_size_mb)) {
  5021				pr_err("Zone size is not a power of 2\n");
  5022				return -EINVAL;
  5023			}
  5024			devip->zsize = (sdeb_zbc_zone_size_mb * SZ_1M)
  5025				>> ilog2(sdebug_sector_size);
  5026			if (devip->zsize >= capacity) {
  5027				pr_err("Zone size too large for device capacity\n");
  5028				return -EINVAL;
  5029			}
  5030		}
  5031	
  5032		devip->zsize_shift = ilog2(devip->zsize);
  5033		devip->nr_zones = (capacity + devip->zsize - 1) >> devip->zsize_shift;
  5034	
  5035		if (sdeb_zbc_zone_cap_mb == 0) {
  5036			devip->zcap = devip->zsize;
  5037		} else {
  5038			devip->zcap = (sdeb_zbc_zone_cap_mb * SZ_1M) >>
  5039				      ilog2(sdebug_sector_size);
  5040			if (devip->zcap > devip->zsize) {
  5041				pr_err("Zone capacity too large\n");
  5042				return -EINVAL;
  5043			}
  5044		}
  5045	
  5046		conv_capacity = (sector_t)sdeb_zbc_nr_conv << devip->zsize_shift;
  5047		if (conv_capacity >= capacity) {
  5048			pr_err("Number of conventional zones too large\n");
  5049			return -EINVAL;
  5050		}
  5051		devip->nr_conv_zones = sdeb_zbc_nr_conv;
  5052		devip->nr_seq_zones = ALIGN(capacity - conv_capacity, devip->zsize) >>
  5053				      devip->zsize_shift;
  5054		devip->nr_zones = devip->nr_conv_zones + devip->nr_seq_zones;
  5055	
  5056		/* Add gap zones if zone capacity is smaller than the zone size */
  5057		pr_info("zcap = %u; zsize = %u\n", devip->zcap, devip->zsize);
  5058		if (devip->zcap < devip->zsize)
  5059			devip->nr_zones += devip->nr_seq_zones;
  5060	
  5061		if (devip->zmodel == BLK_ZONED_HM) {
  5062			/* zbc_max_open_zones can be 0, meaning "not reported" */
  5063			if (sdeb_zbc_max_open >= devip->nr_zones - 1)
  5064				devip->max_open = (devip->nr_zones - 1) / 2;
  5065			else
  5066				devip->max_open = sdeb_zbc_max_open;
  5067		}
  5068	
  5069		devip->zstate = kcalloc(devip->nr_zones,
  5070					sizeof(struct sdeb_zone_state), GFP_KERNEL);
  5071		if (!devip->zstate)
  5072			return -ENOMEM;
  5073	
  5074		for (i = 0; i < devip->nr_zones; i++) {
  5075			zsp = &devip->zstate[i];
  5076	
  5077			zsp->z_start = zstart;
  5078	
  5079			if (i < devip->nr_conv_zones) {
  5080				zsp->z_type = ZBC_ZTYPE_CNV;
  5081				zsp->z_cond = ZBC_NOT_WRITE_POINTER;
  5082				zsp->z_wp = (sector_t)-1;
  5083				zsp->z_size =
  5084					min_t(u64, devip->zsize, capacity - zstart);
  5085			} else if ((zstart & (devip->zsize - 1)) == 0) {
  5086				if (devip->zmodel == BLK_ZONED_HM)
  5087					zsp->z_type = ZBC_ZTYPE_SWR;
  5088				else
  5089					zsp->z_type = ZBC_ZTYPE_SWP;
  5090				zsp->z_cond = ZC1_EMPTY;
  5091				zsp->z_wp = zsp->z_start;
  5092				zsp->z_size =
  5093					min_t(u64, devip->zcap, capacity - zstart);
  5094			} else {
  5095				zsp->z_type = ZBC_ZTYPE_GAP;
  5096				zsp->z_cond = ZBC_NOT_WRITE_POINTER;
  5097				zsp->z_wp = (sector_t)-1;
  5098				zsp->z_size = min_t(u64, devip->zsize - devip->zcap,
  5099						    capacity - zstart);
  5100				pr_info("adding a gap zone; start %u; size %u\n",
> 5101					zsp->z_start, zsp->z_size);
  5102			}
  5103	
  5104			WARN_ON_ONCE((int)zsp->z_size <= 0);
  5105			zstart += zsp->z_size;
  5106		}
  5107	
  5108		return 0;
  5109	}
  5110	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
