Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB5C544177
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbiFICZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbiFICZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:25:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF14F237C91;
        Wed,  8 Jun 2022 19:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654741515; x=1686277515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=azADoCZr4T2Qk8IeCiGMP8wx1mPqqaIUSoDx0L8cJig=;
  b=MtB+KKmGM6y9EcAJiBewsjnmYZoBj+3mhjqTx0YixnKGK2Aq2WSKggYI
   xqfd64Qs10k2P1wqh0uPDdLr4u0bR+bNFDaLYtIBSF25s0X6EOuOCqYmt
   sBIz+PH20FIYMSGRkEJO8fQduOct0ExnzhIlExJBv6cOKW8xEwXScc6uu
   YI/RFl20W/4zI7FPC8yIo2anow01UNA+HeUtsAVXV+A0Fk9x8aDYKKhQz
   HfMFKUWI/5TAkghOTq2FdXkb+0U8cgy4Q8xorsG/xHEMdbpw1qwakkn4r
   iQ48HLLDyGF97TU6N8cp8HaEznfeKbpFLMBaClZLYJFt3Or0tqv7+uuzd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="363446724"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="363446724"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="615663373"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jun 2022 19:25:11 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz7rC-000FLh-Sm;
        Thu, 09 Jun 2022 02:25:10 +0000
Date:   Thu, 9 Jun 2022 10:24:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com,
        digetx@gmail.com, Shreeya Patel <shreeya.patel@collabora.com>
Subject: Re: [PATCH v5 2/2] iio: light: Add support for ltrf216a sensor
Message-ID: <202206090943.Zvfv6OBd-lkp@intel.com>
References: <20220608113553.32083-3-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608113553.32083-3-shreeya.patel@collabora.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shreeya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on v5.19-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Shreeya-Patel/Add-LTRF216A-Driver/20220608-194016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220609/202206090943.Zvfv6OBd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4809a7f42af19c3da77457e1aaf37ddd171fa779
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shreeya-Patel/Add-LTRF216A-Driver/20220608-194016
        git checkout 4809a7f42af19c3da77457e1aaf37ddd171fa779
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iio/adc/ drivers/iio/light/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/light/ltrf216a.c:193:5: warning: no previous prototype for function 'ltrf216a_check_for_data' [-Wmissing-prototypes]
   int ltrf216a_check_for_data(struct i2c_client *client)
       ^
   drivers/iio/light/ltrf216a.c:193:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ltrf216a_check_for_data(struct i2c_client *client)
   ^
   static 
   1 warning generated.


vim +/ltrf216a_check_for_data +193 drivers/iio/light/ltrf216a.c

   192	
 > 193	int ltrf216a_check_for_data(struct i2c_client *client)
   194	{
   195		int ret;
   196	
   197		ret = i2c_smbus_read_byte_data(client, LTRF216A_MAIN_STATUS);
   198		if (ret < 0) {
   199			dev_err(&client->dev, "Failed to read LTRF216A_MAIN_STATUS register: %d\n", ret);
   200			return ret;
   201		}
   202	
   203		return ret;
   204	}
   205	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
