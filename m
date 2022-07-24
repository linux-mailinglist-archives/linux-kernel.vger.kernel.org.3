Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17A157F458
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 11:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiGXJX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 05:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGXJXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 05:23:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA52314097
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 02:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658654633; x=1690190633;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jb0Iq4zpqCCRUvGbgpuWGXaZAmNRPnFO3rIirjOV4zY=;
  b=Wj+AqI5KW9I73hHA9gVVdY8+gmG05F8oCtne4k0tU/pwcePGOtWkoOfs
   eZhRUpOqNfghFkii7whoSoNRE7SN2uYCFShdHYXUdPJUlJD5r5ucCSw+2
   +UkDayJlmnAIkrdMIpRape6KbOcCNCzgCV7cF/XyF2qzVByB0FRF3nZ5F
   uHEiZ3MCW//TxGloKXRGgdCOyCoeu1Gf3GvcHEDKF70PXV+81voSgVv71
   7M+M0spquDv7lR62ljooZ2UaSmu3cTmf30lyQuytW1nAm6MXuSCuNiwN4
   pWrkmGl033fhuW4xbEXgoDhJuaKRpPiG25UVNJzfthapcK8W5OBSMos/k
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="349227211"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="349227211"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 02:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="599296136"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Jul 2022 02:23:51 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFXq3-0003lW-0Q;
        Sun, 24 Jul 2022 09:23:51 +0000
Date:   Sun, 24 Jul 2022 17:23:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:lenovo-x13s-next-20220722 8/141]
 drivers/phy/qualcomm/phy-qcom-qmp.h:189: warning:
 "QSERDES_V4_TX_CLKBUF_ENABLE" redefined
Message-ID: <202207241704.6t2VrWQx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux lenovo-x13s-next-20220722
head:   78d0b0fc70a9e217a976f3f8f1239d1ceb39f2f4
commit: 5269d6cef9825d8d40bb77450e9a4cd5b4d3475f [8/141] phy: qcom-qmp: Add sc8280xp USB/DP combo phys
config: loongarch-randconfig-r003-20220724 (https://download.01.org/0day-ci/archive/20220724/202207241704.6t2VrWQx-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/5269d6cef9825d8d40bb77450e9a4cd5b4d3475f
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev lenovo-x13s-next-20220722
        git checkout 5269d6cef9825d8d40bb77450e9a4cd5b4d3475f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/phy/

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
