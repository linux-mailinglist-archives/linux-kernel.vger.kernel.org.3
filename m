Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA025856DA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbiG2W3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiG2W3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:29:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08518C3DA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659133768; x=1690669768;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YepBuHVRLKYlAqoOKEyWd2c22BjR+nSlbUdSjKtSwkk=;
  b=MO7x3Yv8oH4zD3S57HgxACxH8RPOk+uX8cCOXhUlPEYXxIDKZiv8/YNz
   sxbgwgD7gaqd+wX9XwLCWGVspK1TQQzU9RlnYGpBYGwkorrfgg9sEdQAh
   X/nj/mHLbVHdgz6hz0SOnxUR/gYOAKhHqJvUj1d2ZxBrw7+dZNpdtski7
   DzD49WG9be+X8HjzOUQoU9Uz/OqWw9NEBoKxNEQwzcC9XLfao8MIJbSGD
   00d/ZVkbm4pjC7jvBHJ4kW+4WnOTOvvaV0TlLLaVZVMd1hYsXl5S6nd5s
   gWwVqt2XW7GdG/DIY6rVA7/JQutyr7z9tOh7Ws/wid8MumuErVqRGsAly
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="375163870"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="375163870"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 15:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="743674464"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2022 15:29:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHYU1-000C9D-39;
        Fri, 29 Jul 2022 22:29:25 +0000
Date:   Sat, 30 Jul 2022 06:28:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-next-20220722 8/147]
 drivers/phy/qualcomm/phy-qcom-qmp.h:189:9: warning:
 'QSERDES_V4_TX_CLKBUF_ENABLE' macro redefined
Message-ID: <202207300626.sT5Ckzsc-lkp@intel.com>
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

tree:   https://github.com/steev/linux sc8280xp-next-20220722
head:   c9b9dde616182bba3e7ef9b72ee14fb2bdface89
commit: 8db8e4155ce2f7e6e04e976530fb094468c0f737 [8/147] phy: qcom-qmp: Add sc8280xp USB/DP combo phys
config: hexagon-randconfig-r045-20220729 (https://download.01.org/0day-ci/archive/20220730/202207300626.sT5Ckzsc-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/8db8e4155ce2f7e6e04e976530fb094468c0f737
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-next-20220722
        git checkout 8db8e4155ce2f7e6e04e976530fb094468c0f737
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/phy/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:189:9: warning: 'QSERDES_V4_TX_CLKBUF_ENABLE' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_CLKBUF_ENABLE                     0x08
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:12:9: note: previous definition is here
   #define QSERDES_V4_TX_CLKBUF_ENABLE                     0x008
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:190:9: warning: 'QSERDES_V4_TX_TX_EMP_POST1_LVL' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_TX_EMP_POST1_LVL                  0x0c
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:13:9: note: previous definition is here
   #define QSERDES_V4_TX_TX_EMP_POST1_LVL                  0x00c
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:191:9: warning: 'QSERDES_V4_TX_TX_DRV_LVL' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_TX_DRV_LVL                        0x14
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:15:9: note: previous definition is here
   #define QSERDES_V4_TX_TX_DRV_LVL                        0x014
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:192:9: warning: 'QSERDES_V4_TX_RESET_TSYNC_EN' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_RESET_TSYNC_EN                    0x1c
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:17:9: note: previous definition is here
   #define QSERDES_V4_TX_RESET_TSYNC_EN                    0x01c
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:193:9: warning: 'QSERDES_V4_TX_PRE_STALL_LDO_BOOST_EN' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_PRE_STALL_LDO_BOOST_EN            0x20
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:18:9: note: previous definition is here
   #define QSERDES_V4_TX_PRE_STALL_LDO_BOOST_EN            0x020
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:194:9: warning: 'QSERDES_V4_TX_TX_BAND' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_TX_BAND                           0x24
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:19:9: note: previous definition is here
   #define QSERDES_V4_TX_TX_BAND                           0x024
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:195:9: warning: 'QSERDES_V4_TX_INTERFACE_SELECT' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_INTERFACE_SELECT                  0x2c
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:21:9: note: previous definition is here
   #define QSERDES_V4_TX_INTERFACE_SELECT                  0x02c
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:196:9: warning: 'QSERDES_V4_TX_RES_CODE_LANE_TX' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_RES_CODE_LANE_TX                  0x34
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:23:9: note: previous definition is here
   #define QSERDES_V4_TX_RES_CODE_LANE_TX                  0x034
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:197:9: warning: 'QSERDES_V4_TX_RES_CODE_LANE_RX' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_RES_CODE_LANE_RX                  0x38
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:24:9: note: previous definition is here
   #define QSERDES_V4_TX_RES_CODE_LANE_RX                  0x038
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:198:9: warning: 'QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX           0x3c
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:25:9: note: previous definition is here
   #define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX           0x03c
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:199:9: warning: 'QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX           0x40
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:26:9: note: previous definition is here
   #define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX           0x040
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:200:9: warning: 'QSERDES_V4_TX_TRANSCEIVER_BIAS_EN' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_TRANSCEIVER_BIAS_EN               0x54
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:31:9: note: previous definition is here
   #define QSERDES_V4_TX_TRANSCEIVER_BIAS_EN               0x054
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:201:9: warning: 'QSERDES_V4_TX_HIGHZ_DRVR_EN' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_HIGHZ_DRVR_EN                     0x58
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:32:9: note: previous definition is here
   #define QSERDES_V4_TX_HIGHZ_DRVR_EN                     0x058
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:202:9: warning: 'QSERDES_V4_TX_TX_POL_INV' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_TX_POL_INV                        0x5c
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:33:9: note: previous definition is here
   #define QSERDES_V4_TX_TX_POL_INV                        0x05c
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:203:9: warning: 'QSERDES_V4_TX_PARRATE_REC_DETECT_IDLE_EN' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_PARRATE_REC_DETECT_IDLE_EN        0x60
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:34:9: note: previous definition is here
   #define QSERDES_V4_TX_PARRATE_REC_DETECT_IDLE_EN        0x060
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:204:9: warning: 'QSERDES_V4_TX_LANE_MODE_1' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_LANE_MODE_1                       0x84
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:43:9: note: previous definition is here
   #define QSERDES_V4_TX_LANE_MODE_1                       0x084
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:205:9: warning: 'QSERDES_V4_TX_LANE_MODE_2' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_LANE_MODE_2                       0x88
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:44:9: note: previous definition is here
   #define QSERDES_V4_TX_LANE_MODE_2                       0x088
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:206:9: warning: 'QSERDES_V4_TX_RCV_DETECT_LVL_2' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_RCV_DETECT_LVL_2                  0x9c
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:49:9: note: previous definition is here
   #define QSERDES_V4_TX_RCV_DETECT_LVL_2                  0x09c
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:207:9: warning: 'QSERDES_V4_TX_TRAN_DRVR_EMP_EN' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_TRAN_DRVR_EMP_EN                  0xb8
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:56:9: note: previous definition is here
   #define QSERDES_V4_TX_TRAN_DRVR_EMP_EN                  0x0b8
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
>> drivers/phy/qualcomm/phy-qcom-qmp.h:208:9: warning: 'QSERDES_V4_TX_TX_INTERFACE_MODE' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_TX_INTERFACE_MODE                 0xbc
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:57:9: note: previous definition is here
   #define QSERDES_V4_TX_TX_INTERFACE_MODE                 0x0bc
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
   drivers/phy/qualcomm/phy-qcom-qmp.h:209:9: warning: 'QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1        0xd8
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:64:9: note: previous definition is here
   #define QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1        0x0d8
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
   drivers/phy/qualcomm/phy-qcom-qmp.h:210:9: warning: 'QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1        0xdC
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:65:9: note: previous definition is here
   #define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1        0x0dc
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
   drivers/phy/qualcomm/phy-qcom-qmp.h:211:9: warning: 'QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1        0xe0
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:66:9: note: previous definition is here
   #define QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1        0x0e0
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
   drivers/phy/qualcomm/phy-qcom-qmp.h:212:9: warning: 'QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1        0xe4
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:67:9: note: previous definition is here
   #define QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1        0x0e4
           ^
   In file included from drivers/phy/qualcomm/phy-qcom-qmp-combo.c:25:
   drivers/phy/qualcomm/phy-qcom-qmp.h:213:9: warning: 'QSERDES_V4_TX_VMODE_CTRL1' macro redefined [-Wmacro-redefined]
   #define QSERDES_V4_TX_VMODE_CTRL1                       0xe8
           ^
   drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h:68:9: note: previous definition is here
   #define QSERDES_V4_TX_VMODE_CTRL1                       0x0e8
           ^
   25 warnings generated.


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
