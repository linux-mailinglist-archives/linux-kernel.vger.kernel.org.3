Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6ACA48416C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiADMDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:03:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:29016 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230392AbiADMDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641297794; x=1672833794;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nXijfQsKVeJHZwZ1akwwHSS0QqvyR7zcD3/47bWcKds=;
  b=ZrAzFVdBKyzkFN/MBge8Fsym8tEpCfCs/TA7xjJFaIfqzhCalRd9NO1y
   BxQwEXARhZoVZ6epEpQH+yvu3v9kEXHmLe7VW3UT32LLsrjRSYkhDjcYV
   4Y8V0WcJ4domfgGC/4QWnLo9Ei9eD6D+e0Qw3yxAb9RMK1vMdAhYPzQ4X
   LLXFHHiH5Eg2n6+ubHbOoSj/vm7yvordZbjFXc7lu8sQ9BIpEmvWklvR9
   RIv9vhuXvFsIvQRw8EfI7PdSxAip9dzal8XBgf46ND3LoUHNgYoyKsfQ6
   ZooKcKjqmitt26RipjZM8dgUHtez69qp4xshdNMoYWihsirPiCTCvZLHL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="266480238"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="266480238"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 04:02:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="574002026"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jan 2022 04:02:48 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4iWd-000FIZ-EP; Tue, 04 Jan 2022 12:02:47 +0000
Date:   Tue, 4 Jan 2022 20:02:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>
Subject: [nbd168-wireless:mt76 14/63]
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h:484:16: error: implicit
 declaration of function 'is_mt7915'
Message-ID: <202201041929.zvGUbHKt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mt76
head:   f30499df8b27936cb612ef95630565bf06f48004
commit: e17a21440b61fcd6086226569f638f5704467d14 [14/63] mt76: mt7915: rely on mt76_connac_mcu_alloc_sta_req
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220104/202201041929.zvGUbHKt-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/e17a21440b61fcd6086226569f638f5704467d14
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mt76
        git checkout e17a21440b61fcd6086226569f638f5704467d14
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the nbd168-wireless/mt76 HEAD f30499df8b27936cb612ef95630565bf06f48004 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from drivers/net/wireless/mediatek/mt76/mt7915/pci.c:11:
   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h: In function 'mt7915_wtbl_size':
>> drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h:484:16: error: implicit declaration of function 'is_mt7915' [-Werror=implicit-function-declaration]
     484 |         return is_mt7915(&dev->mt76) ? MT7915_WTBL_SIZE : MT7916_WTBL_SIZE;
         |                ^~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/net/wireless/mediatek/mt76/mt7915/init.c:8:
   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h: In function 'mt7915_wtbl_size':
>> drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h:484:16: error: implicit declaration of function 'is_mt7915' [-Werror=implicit-function-declaration]
     484 |         return is_mt7915(&dev->mt76) ? MT7915_WTBL_SIZE : MT7916_WTBL_SIZE;
         |                ^~~~~~~~~
   In file included from drivers/net/wireless/mediatek/mt76/mt7915/../mt76_connac_mcu.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt7915/mcu.h:7,
                    from drivers/net/wireless/mediatek/mt76/mt7915/init.c:10:
   drivers/net/wireless/mediatek/mt76/mt7915/../mt76_connac.h: At top level:
>> drivers/net/wireless/mediatek/mt76/mt7915/../mt76_connac.h:103:20: error: conflicting types for 'is_mt7915'; have 'bool(struct mt76_dev *)' {aka '_Bool(struct mt76_dev *)'}
     103 | static inline bool is_mt7915(struct mt76_dev *dev)
         |                    ^~~~~~~~~
   In file included from drivers/net/wireless/mediatek/mt76/mt7915/init.c:8:
   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h:484:16: note: previous implicit declaration of 'is_mt7915' with type 'int()'
     484 |         return is_mt7915(&dev->mt76) ? MT7915_WTBL_SIZE : MT7916_WTBL_SIZE;
         |                ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/is_mt7915 +484 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h

e57b7901469fc0b Ryder Lee 2020-04-25  481  
704f2ebdf4b17cb Bo Jiao   2021-12-20  482  static inline u16 mt7915_wtbl_size(struct mt7915_dev *dev)
704f2ebdf4b17cb Bo Jiao   2021-12-20  483  {
704f2ebdf4b17cb Bo Jiao   2021-12-20 @484  	return is_mt7915(&dev->mt76) ? MT7915_WTBL_SIZE : MT7916_WTBL_SIZE;
704f2ebdf4b17cb Bo Jiao   2021-12-20  485  }
704f2ebdf4b17cb Bo Jiao   2021-12-20  486  

:::::: The code at line 484 was first introduced by commit
:::::: 704f2ebdf4b17cb36bdc9d1379b84c41891cb351 mt76: mt7915: enlarge wcid size to 544

:::::: TO: Bo Jiao <Bo.Jiao@mediatek.com>
:::::: CC: Felix Fietkau <nbd@nbd.name>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
