Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080AF576815
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiGOUYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGOUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:24:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB965887F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657916686; x=1689452686;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AoizdhSeDl37Xno53dNGxzkOPTnyopDaEGKvgfzTA5k=;
  b=NxaE+CEqx/DzO2Bk561MvYGVwQ26xMYDkNmGOpRVEjh/aD18ySuDhzWG
   pWbA5tpFwUMqdzxtMZsTPWvoqPOSSkN//CkupOO2txawP2SJDfiys7PN1
   O6uaWSlMAen0hTg9FbFBZGKKDyQ+qonnBgtxfmr1cChitdAAkJWQLAfM5
   4X21rIebAV94z4R4uk1CAyBf8kYhrbI82CGP2UNQOJfCea9WcgVsLuz5y
   WItgF8AwbhXvi9gfC7ye8/YDIKCzTHC5q4huW5rlU9fJzJxL9Ooxvx5sZ
   MZtXMHi7a3smmVUe/430JGnH0Nz1qzgS0h3KvcTVBMkrQ33Ls8YDUHxTa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="372207759"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="372207759"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 13:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="923643943"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2022 13:24:44 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCRrg-0000jo-4V;
        Fri, 15 Jul 2022 20:24:44 +0000
Date:   Sat, 16 Jul 2022 04:23:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [andersson:wip/sc8280xp-next-20220708-incomplete 8/25]
 drivers/phy/qualcomm/phy-qcom-qmp.h:189: warning:
 "QSERDES_V4_TX_CLKBUF_ENABLE" redefined
Message-ID: <202207160430.XARxrMnR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sc8280xp-next-20220708-incomplete
head:   49ce77f5c8eae56c32a9638a971b18ae1078a222
commit: 8c54a7c837ca1e4182639b42ee827cbe47f897be [8/25] phy: qcom-qmp: Add sc8280xp USB/DP combo phys
config: arm64-randconfig-m031-20220715 (https://download.01.org/0day-ci/archive/20220716/202207160430.XARxrMnR-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/8c54a7c837ca1e4182639b42ee827cbe47f897be
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sc8280xp-next-20220708-incomplete
        git checkout 8c54a7c837ca1e4182639b42ee827cbe47f897be
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/phy/qualcomm/phy-qcom-edp.c:26:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:189: warning: "QSERDES_V4_TX_CLKBUF_ENABLE" redefined
     189 | #define QSERDES_V4_TX_CLKBUF_ENABLE                     0x08
         | 
   In file included from drivers/phy/qualcomm/phy-qcom-qmp.h:16:
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:12: note: this is the location of the previous definition
      12 | #define QSERDES_V4_TX_CLKBUF_ENABLE                     0x008
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:190: warning: "QSERDES_V4_TX_TX_EMP_POST1_LVL" redefined
     190 | #define QSERDES_V4_TX_TX_EMP_POST1_LVL                  0x0c
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:13: note: this is the location of the previous definition
      13 | #define QSERDES_V4_TX_TX_EMP_POST1_LVL                  0x00c
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:191: warning: "QSERDES_V4_TX_TX_DRV_LVL" redefined
     191 | #define QSERDES_V4_TX_TX_DRV_LVL                        0x14
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:15: note: this is the location of the previous definition
      15 | #define QSERDES_V4_TX_TX_DRV_LVL                        0x014
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:192: warning: "QSERDES_V4_TX_RESET_TSYNC_EN" redefined
     192 | #define QSERDES_V4_TX_RESET_TSYNC_EN                    0x1c
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:17: note: this is the location of the previous definition
      17 | #define QSERDES_V4_TX_RESET_TSYNC_EN                    0x01c
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:193: warning: "QSERDES_V4_TX_PRE_STALL_LDO_BOOST_EN" redefined
     193 | #define QSERDES_V4_TX_PRE_STALL_LDO_BOOST_EN            0x20
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:18: note: this is the location of the previous definition
      18 | #define QSERDES_V4_TX_PRE_STALL_LDO_BOOST_EN            0x020
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:194: warning: "QSERDES_V4_TX_TX_BAND" redefined
     194 | #define QSERDES_V4_TX_TX_BAND                           0x24
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:19: note: this is the location of the previous definition
      19 | #define QSERDES_V4_TX_TX_BAND                           0x024
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:195: warning: "QSERDES_V4_TX_INTERFACE_SELECT" redefined
     195 | #define QSERDES_V4_TX_INTERFACE_SELECT                  0x2c
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:21: note: this is the location of the previous definition
      21 | #define QSERDES_V4_TX_INTERFACE_SELECT                  0x02c
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:196: warning: "QSERDES_V4_TX_RES_CODE_LANE_TX" redefined
     196 | #define QSERDES_V4_TX_RES_CODE_LANE_TX                  0x34
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:23: note: this is the location of the previous definition
      23 | #define QSERDES_V4_TX_RES_CODE_LANE_TX                  0x034
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:197: warning: "QSERDES_V4_TX_RES_CODE_LANE_RX" redefined
     197 | #define QSERDES_V4_TX_RES_CODE_LANE_RX                  0x38
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:24: note: this is the location of the previous definition
      24 | #define QSERDES_V4_TX_RES_CODE_LANE_RX                  0x038
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:198: warning: "QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX" redefined
     198 | #define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX           0x3c
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:25: note: this is the location of the previous definition
      25 | #define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX           0x03c
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:199: warning: "QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX" redefined
     199 | #define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX           0x40
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:26: note: this is the location of the previous definition
      26 | #define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX           0x040
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:200: warning: "QSERDES_V4_TX_TRANSCEIVER_BIAS_EN" redefined
     200 | #define QSERDES_V4_TX_TRANSCEIVER_BIAS_EN               0x54
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:31: note: this is the location of the previous definition
      31 | #define QSERDES_V4_TX_TRANSCEIVER_BIAS_EN               0x054
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:201: warning: "QSERDES_V4_TX_HIGHZ_DRVR_EN" redefined
     201 | #define QSERDES_V4_TX_HIGHZ_DRVR_EN                     0x58
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:32: note: this is the location of the previous definition
      32 | #define QSERDES_V4_TX_HIGHZ_DRVR_EN                     0x058
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:202: warning: "QSERDES_V4_TX_TX_POL_INV" redefined
     202 | #define QSERDES_V4_TX_TX_POL_INV                        0x5c
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:33: note: this is the location of the previous definition
      33 | #define QSERDES_V4_TX_TX_POL_INV                        0x05c
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:203: warning: "QSERDES_V4_TX_PARRATE_REC_DETECT_IDLE_EN" redefined
     203 | #define QSERDES_V4_TX_PARRATE_REC_DETECT_IDLE_EN        0x60
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:34: note: this is the location of the previous definition
      34 | #define QSERDES_V4_TX_PARRATE_REC_DETECT_IDLE_EN        0x060
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:204: warning: "QSERDES_V4_TX_LANE_MODE_1" redefined
     204 | #define QSERDES_V4_TX_LANE_MODE_1                       0x84
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:43: note: this is the location of the previous definition
      43 | #define QSERDES_V4_TX_LANE_MODE_1                       0x084
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:205: warning: "QSERDES_V4_TX_LANE_MODE_2" redefined
     205 | #define QSERDES_V4_TX_LANE_MODE_2                       0x88
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:44: note: this is the location of the previous definition
      44 | #define QSERDES_V4_TX_LANE_MODE_2                       0x088
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:206: warning: "QSERDES_V4_TX_RCV_DETECT_LVL_2" redefined
     206 | #define QSERDES_V4_TX_RCV_DETECT_LVL_2                  0x9c
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:49: note: this is the location of the previous definition
      49 | #define QSERDES_V4_TX_RCV_DETECT_LVL_2                  0x09c
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:207: warning: "QSERDES_V4_TX_TRAN_DRVR_EMP_EN" redefined
     207 | #define QSERDES_V4_TX_TRAN_DRVR_EMP_EN                  0xb8
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:56: note: this is the location of the previous definition
      56 | #define QSERDES_V4_TX_TRAN_DRVR_EMP_EN                  0x0b8
         | 
>> drivers/phy/qualcomm/phy-qcom-qmp.h:208: warning: "QSERDES_V4_TX_TX_INTERFACE_MODE" redefined
     208 | #define QSERDES_V4_TX_TX_INTERFACE_MODE                 0xbc
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:57: note: this is the location of the previous definition
      57 | #define QSERDES_V4_TX_TX_INTERFACE_MODE                 0x0bc
         | 
   drivers/phy/qualcomm/phy-qcom-qmp.h:209: warning: "QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1" redefined
     209 | #define QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1        0xd8
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:64: note: this is the location of the previous definition
      64 | #define QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1        0x0d8
         | 
   drivers/phy/qualcomm/phy-qcom-qmp.h:210: warning: "QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1" redefined
     210 | #define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1        0xdC
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:65: note: this is the location of the previous definition
      65 | #define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1        0x0dc
         | 
   drivers/phy/qualcomm/phy-qcom-qmp.h:211: warning: "QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1" redefined
     211 | #define QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1        0xe0
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:66: note: this is the location of the previous definition
      66 | #define QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1        0x0e0
         | 
   drivers/phy/qualcomm/phy-qcom-qmp.h:212: warning: "QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1" redefined
     212 | #define QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1        0xe4
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:67: note: this is the location of the previous definition
      67 | #define QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1        0x0e4
         | 
   drivers/phy/qualcomm/phy-qcom-qmp.h:213: warning: "QSERDES_V4_TX_VMODE_CTRL1" redefined
     213 | #define QSERDES_V4_TX_VMODE_CTRL1                       0xe8
         | 
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:68: note: this is the location of the previous definition
      68 | #define QSERDES_V4_TX_VMODE_CTRL1                       0x0e8
         | 


vim +/QSERDES_V4_TX_CLKBUF_ENABLE +189 drivers/phy/qualcomm/phy-qcom-qmp.h

   187	
   188	/* Only for QMP V4 PHY - TX registers */
 > 189	#define QSERDES_V4_TX_CLKBUF_ENABLE			0x08
 > 190	#define QSERDES_V4_TX_TX_EMP_POST1_LVL			0x0c
 > 191	#define QSERDES_V4_TX_TX_DRV_LVL			0x14
 > 192	#define QSERDES_V4_TX_RESET_TSYNC_EN			0x1c
 > 193	#define QSERDES_V4_TX_PRE_STALL_LDO_BOOST_EN		0x20
 > 194	#define QSERDES_V4_TX_TX_BAND				0x24
 > 195	#define QSERDES_V4_TX_INTERFACE_SELECT			0x2c
 > 196	#define QSERDES_V4_TX_RES_CODE_LANE_TX			0x34
 > 197	#define QSERDES_V4_TX_RES_CODE_LANE_RX			0x38
 > 198	#define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX 		0x3c
 > 199	#define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX 		0x40
 > 200	#define QSERDES_V4_TX_TRANSCEIVER_BIAS_EN		0x54
 > 201	#define QSERDES_V4_TX_HIGHZ_DRVR_EN			0x58
 > 202	#define QSERDES_V4_TX_TX_POL_INV			0x5c
 > 203	#define QSERDES_V4_TX_PARRATE_REC_DETECT_IDLE_EN	0x60
 > 204	#define QSERDES_V4_TX_LANE_MODE_1			0x84
 > 205	#define QSERDES_V4_TX_LANE_MODE_2			0x88
 > 206	#define QSERDES_V4_TX_RCV_DETECT_LVL_2			0x9c
 > 207	#define QSERDES_V4_TX_TRAN_DRVR_EMP_EN			0xb8
 > 208	#define QSERDES_V4_TX_TX_INTERFACE_MODE			0xbc
 > 209	#define QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1	0xd8
 > 210	#define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1	0xdC
 > 211	#define QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1	0xe0
 > 212	#define QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1	0xe4
 > 213	#define QSERDES_V4_TX_VMODE_CTRL1			0xe8
   214	#define QSERDES_V4_TX_PI_QEC_CTRL			0x104
   215	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
