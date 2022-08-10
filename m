Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD79258F4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiHJXgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiHJXgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:36:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3A26CD31
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660174573; x=1691710573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3va2yZdcDJ+Dnnzr8fu1MBvEkWFet2Gb7kj4tPhdh+o=;
  b=dTaQNr2iVeR6r2hAp4hax6fE5xhT8cWAY1UX/TeQDKjwcGWDFzllK7bV
   aOE5xBZrZGjI4Bn05470ABwp4S95MrRJe0Jo0ecmGd+0Rk59LZmM/6I2O
   ArcqEB0dL/UGOLgB/5m3Y1pQsmdUAkFRcfnK1TzeVp4/IfLKNsPO1yRJA
   7IXx3V5PySIHT916SB8jvlv7Qqt3G6ivEACcAJglQr9zVYKG0WBPFdjK5
   dJlApT+KaBVSodZWFkJTsJnqmaoNRHGJPiCqESNGrStxWAmn89WuP8xAC
   PN2Bvf7tFZCpW7bYOI6BcEeaag1UbVDDpCtAeeIlxTvcK5ZG7SIAZRiRP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="292475356"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="292475356"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="673476867"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2022 16:36:10 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLvFC-0000qC-0r;
        Wed, 10 Aug 2022 23:36:10 +0000
Date:   Thu, 11 Aug 2022 07:35:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Simone Serra <serrazimone@gmail.com>, gregkh@linuxfoundation.org,
        fabioaiuto83@gmail.com, soumya.negi97@gmail.com,
        hdegoede@redhat.com, straube.linux@gmail.com
Cc:     kbuild-all@lists.01.org, Simone Serra <serrazimone@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes compilation errors after checkpatch warnings
Message-ID: <202208110717.w2MDXPcA-lkp@intel.com>
References: <20220809143743.742636-1-serrazimone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809143743.742636-1-serrazimone@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simone,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on linus/master next-20220810]
[cannot apply to v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Simone-Serra/Fixes-compilation-errors-after-checkpatch-warnings/20220809-223922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 4e23eeebb2e57f5a28b36221aa776b5a1122dde5
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220811/202208110717.w2MDXPcA-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4178fe5425c24dfeabf5c4eb7fd13ada51d007c3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Simone-Serra/Fixes-compilation-errors-after-checkpatch-warnings/20220809-223922
        git checkout 4178fe5425c24dfeabf5c4eb7fd13ada51d007c3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/rtl8723bs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/rtl8723bs/core/rtw_btcoex.c:12:6: warning: no previous prototype for 'rtw_btcoex_MediaStatusNotify' [-Wmissing-prototypes]
      12 | void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 mediaStatus)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/rtw_btcoex_MediaStatusNotify +12 drivers/staging/rtl8723bs/core/rtw_btcoex.c

554c0a3abf216c Hans de Goede 2017-03-29  11  
554c0a3abf216c Hans de Goede 2017-03-29 @12  void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 mediaStatus)
554c0a3abf216c Hans de Goede 2017-03-29  13  {
948d704855312c Shreeya Patel 2017-07-09  14  	if ((mediaStatus == RT_MEDIA_CONNECT)
554c0a3abf216c Hans de Goede 2017-03-29  15  		&& (check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE) == true)) {
554c0a3abf216c Hans de Goede 2017-03-29  16  		rtw_hal_set_hwreg(padapter, HW_VAR_DL_RSVD_PAGE, NULL);
554c0a3abf216c Hans de Goede 2017-03-29  17  	}
554c0a3abf216c Hans de Goede 2017-03-29  18  
554c0a3abf216c Hans de Goede 2017-03-29  19  	hal_btcoex_MediaStatusNotify(padapter, mediaStatus);
554c0a3abf216c Hans de Goede 2017-03-29  20  }
554c0a3abf216c Hans de Goede 2017-03-29  21  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
