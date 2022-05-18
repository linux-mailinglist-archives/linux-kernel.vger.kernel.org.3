Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71652B2B0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiERGq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiERGqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:46:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957B113CCE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652856383; x=1684392383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eFg/OiSzC+FbPf82f+mKznpjNGbY+1W6OsvZJl8tgKA=;
  b=cgr5TL8Pd/LYxQGw0Cbz6ztfXGLzKx3DQQAWdj1XOnOu+wFGzAAohlvt
   6od4uH60bjqFyICIJcvwW61fdAFhQzN0e26nTAyyJhu7PNiWXRXqhhXA7
   6wCq763+vQzz04eO3G/Hb+/sIqGA74Uj2Os61kVK+TkBjg36CZsXPRovH
   2I02z/Gv3f6xCD/ir6iMPMYy5wZE+X0LaOY0i8tpsNQhMjIfPW0p4V0tM
   SmJZU08M+iG/ip36cJRwAprMc6GByB6kJC4uBOmGbvhuSu896NxPS59ec
   3lATdI2oTPU1wmEMDk7Vkw65AYW8LsznJpbwlaRTXDSyRx03S15NMSKBK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271460235"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="271460235"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 23:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="660994892"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2022 23:46:21 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrDRs-0001t1-D4;
        Wed, 18 May 2022 06:46:20 +0000
Date:   Wed, 18 May 2022 14:45:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/can/spi/mcp251xfd/mcp251xfd.h:481:34: warning: field
 hw_tx_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' is less aligned than
 'struct mcp251xfd_hw_tx_obj_raw' and is usually due to ...
Message-ID: <202205181414.n8QRDe8k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   210e04ff768142b96452030c4c2627512b30ad95
commit: eb79a267c9b3e608e7762a1b221428f37ace3aa3 can: mcp251xfd: rename all remaining occurrence to mcp251xfd
date:   1 year, 8 months ago
config: arm-randconfig-c002-20220518 (https://download.01.org/0day-ci/archive/20220518/202205181414.n8QRDe8k-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eb79a267c9b3e608e7762a1b221428f37ace3aa3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout eb79a267c9b3e608e7762a1b221428f37ace3aa3
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/can/spi/mcp251xfd/mcp251xfd.h:481:34: warning: field hw_tx_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' is less aligned than 'struct mcp251xfd_hw_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
                   struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
                                                  ^
   drivers/net/can/spi/mcp251xfd/mcp251xfd.h:485:34: warning: field hw_tx_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:483:2)' is less aligned than 'struct mcp251xfd_hw_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:483:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
                   struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
                                                  ^
   drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:511:1: warning: unused function 'mcp251xfd_chip_set_mode_nowait' [-Wunused-function]
   mcp251xfd_chip_set_mode_nowait(const struct mcp251xfd_priv *priv,
   ^
   3 warnings generated.
--
>> drivers/net/can/spi/mcp251xfd/mcp251xfd.h:481:34: warning: field hw_tx_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' is less aligned than 'struct mcp251xfd_hw_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:479:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
                   struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
                                                  ^
   drivers/net/can/spi/mcp251xfd/mcp251xfd.h:485:34: warning: field hw_tx_obj within 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:483:2)' is less aligned than 'struct mcp251xfd_hw_tx_obj_raw' and is usually due to 'struct mcp251xfd_tx_obj_load_buf::(unnamed at drivers/net/can/spi/mcp251xfd/mcp251xfd.h:483:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
                   struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
                                                  ^
   2 warnings generated.


vim +481 drivers/net/can/spi/mcp251xfd/mcp251xfd.h

   477	
   478	union mcp251xfd_tx_obj_load_buf {
   479		struct __packed {
   480			struct mcp251xfd_buf_cmd cmd;
 > 481			struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
   482		} nocrc;
   483		struct __packed {
   484			struct mcp251xfd_buf_cmd_crc cmd;
   485			struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
   486			__be16 crc;
   487		} crc;
   488	} ____cacheline_aligned;
   489	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
