Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FE3599CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348975AbiHSNID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348363AbiHSNIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:08:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C345FD0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660914478; x=1692450478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ul9AY54+W+2c0uLgxHZax+CLhL8edhfxOlsyHd1h5oE=;
  b=gSpWs6gVCwCt7rac8Ja0OZQuqDwVtgFZAOHMFQXDdE5eBUyJDRDGCQTC
   +jZXgV3BS1inDO/fIgRE+lmRPUnlC/TVdcUTzTLKcSN/jYmt/0/GX9m1j
   1UL4ExOOPk4i/4aBBw+fdMZ7uXGHZRNMvSLyqJPSSlarZ1ucRweISPSIG
   p3uOaHJCZdFv5hEIHwYdCchtWjzY+nCqL3btLXM4gpdJAbmRc8/w/vFmg
   S07K2wGL6BcCzh7d9RQbfaHqhfgYpPXVvDNZ9wrbx5dndiQSJMy/NZagK
   8OWi4EtMrHGz2HDoSqJe3q3TsNNyTNg8ajetr3qfsPrKSD8KePDfPbRa8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="291764421"
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="291764421"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 06:07:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="936213401"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2022 06:07:56 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oP1j9-0001SR-2t;
        Fri, 19 Aug 2022 13:07:55 +0000
Date:   Fri, 19 Aug 2022 21:07:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nam Cao <namcaov@gmail.com>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, namcaov@gmail.com,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: Re: [PATCH 1/7] staging: rtl8723bs: remove function
 rtw_odm_dbg_comp_msg
Message-ID: <202208192018.BfgiZyOY-lkp@intel.com>
References: <7ff2d658863db4fd5eecc1a53f682510c2765c3f.1660898432.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff2d658863db4fd5eecc1a53f682510c2765c3f.1660898432.git.namcaov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nam,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Nam-Cao/staging-rtl8723bs-remove-dead-functions/20220819-165905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 8379cf83fe6d57a12952de6dcaf7a7fbd7b364fc
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220819/202208192018.BfgiZyOY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3b86aa03519d904d916cb62a1113c0c5549496cb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nam-Cao/staging-rtl8723bs-remove-dead-functions/20220819-165905
        git checkout 3b86aa03519d904d916cb62a1113c0c5549496cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/staging/rtl8723bs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/rtl8723bs/core/rtw_odm.c:13:27: warning: 'odm_comp_str' defined but not used [-Wunused-const-variable=]
      13 | static const char * const odm_comp_str[] = {
         |                           ^~~~~~~~~~~~


vim +/odm_comp_str +13 drivers/staging/rtl8723bs/core/rtw_odm.c

554c0a3abf216c Hans de Goede 2017-03-29  12  
05031914cb8f5b Tom Gardi     2017-08-12 @13  static const char * const odm_comp_str[] = {
554c0a3abf216c Hans de Goede 2017-03-29  14  	/* BIT0 */"ODM_COMP_DIG",
554c0a3abf216c Hans de Goede 2017-03-29  15  	/* BIT1 */"ODM_COMP_RA_MASK",
554c0a3abf216c Hans de Goede 2017-03-29  16  	/* BIT2 */"ODM_COMP_DYNAMIC_TXPWR",
554c0a3abf216c Hans de Goede 2017-03-29  17  	/* BIT3 */"ODM_COMP_FA_CNT",
554c0a3abf216c Hans de Goede 2017-03-29  18  	/* BIT4 */"ODM_COMP_RSSI_MONITOR",
554c0a3abf216c Hans de Goede 2017-03-29  19  	/* BIT5 */"ODM_COMP_CCK_PD",
554c0a3abf216c Hans de Goede 2017-03-29  20  	/* BIT6 */"ODM_COMP_ANT_DIV",
554c0a3abf216c Hans de Goede 2017-03-29  21  	/* BIT7 */"ODM_COMP_PWR_SAVE",
554c0a3abf216c Hans de Goede 2017-03-29  22  	/* BIT8 */"ODM_COMP_PWR_TRAIN",
554c0a3abf216c Hans de Goede 2017-03-29  23  	/* BIT9 */"ODM_COMP_RATE_ADAPTIVE",
554c0a3abf216c Hans de Goede 2017-03-29  24  	/* BIT10 */"ODM_COMP_PATH_DIV",
554c0a3abf216c Hans de Goede 2017-03-29  25  	/* BIT11 */"ODM_COMP_PSD",
554c0a3abf216c Hans de Goede 2017-03-29  26  	/* BIT12 */"ODM_COMP_DYNAMIC_PRICCA",
554c0a3abf216c Hans de Goede 2017-03-29  27  	/* BIT13 */"ODM_COMP_RXHP",
554c0a3abf216c Hans de Goede 2017-03-29  28  	/* BIT14 */"ODM_COMP_MP",
554c0a3abf216c Hans de Goede 2017-03-29  29  	/* BIT15 */"ODM_COMP_DYNAMIC_ATC",
554c0a3abf216c Hans de Goede 2017-03-29  30  	/* BIT16 */"ODM_COMP_EDCA_TURBO",
554c0a3abf216c Hans de Goede 2017-03-29  31  	/* BIT17 */"ODM_COMP_EARLY_MODE",
554c0a3abf216c Hans de Goede 2017-03-29  32  	/* BIT18 */NULL,
554c0a3abf216c Hans de Goede 2017-03-29  33  	/* BIT19 */NULL,
554c0a3abf216c Hans de Goede 2017-03-29  34  	/* BIT20 */NULL,
554c0a3abf216c Hans de Goede 2017-03-29  35  	/* BIT21 */NULL,
554c0a3abf216c Hans de Goede 2017-03-29  36  	/* BIT22 */NULL,
554c0a3abf216c Hans de Goede 2017-03-29  37  	/* BIT23 */NULL,
554c0a3abf216c Hans de Goede 2017-03-29  38  	/* BIT24 */"ODM_COMP_TX_PWR_TRACK",
554c0a3abf216c Hans de Goede 2017-03-29  39  	/* BIT25 */"ODM_COMP_RX_GAIN_TRACK",
554c0a3abf216c Hans de Goede 2017-03-29  40  	/* BIT26 */"ODM_COMP_CALIBRATION",
554c0a3abf216c Hans de Goede 2017-03-29  41  	/* BIT27 */NULL,
554c0a3abf216c Hans de Goede 2017-03-29  42  	/* BIT28 */NULL,
554c0a3abf216c Hans de Goede 2017-03-29  43  	/* BIT29 */NULL,
554c0a3abf216c Hans de Goede 2017-03-29  44  	/* BIT30 */"ODM_COMP_COMMON",
554c0a3abf216c Hans de Goede 2017-03-29  45  	/* BIT31 */"ODM_COMP_INIT",
554c0a3abf216c Hans de Goede 2017-03-29  46  };
554c0a3abf216c Hans de Goede 2017-03-29  47  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
