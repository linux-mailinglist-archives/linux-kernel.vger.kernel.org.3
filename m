Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DCC52038F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbiEIR2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239579AbiEIR2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:28:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E8A27A8B3;
        Mon,  9 May 2022 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652117092; x=1683653092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=otiC4TvFynudhFP1kaTFZ6i4D4Ja1RMGmlo/+yupe4E=;
  b=mtw4+fO2wCoZPe68fAqYwviwARrQDYdF58RKwheCOe1S6aTGx7KTyk04
   woOPYsBBkHsqV26/S1gy790hZMs44mtd5eDKapB+YXm5vUPMB74l3Cl30
   op+GXttu7bW1f8JYgUNmxCJ2pTkQkkjr7wUT9iNbJsOHYmj405rxDeTxx
   BjGTX/Ul017mjHl/OPnH+vNBRrv54K/eY7ElZvvaDyrg0Fyqr4/CcyZ40
   3r4uRUtjxc1oNvEjsB5+GFlns+AHiQ0ZnKxGg7mn4oimPgBXIBCmYKtlq
   dXFYOjqAqwzcDK9a/tBouLXns4fBqKl8yW+WvI4FsQpBgzfRAt0zjPJFy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="251164226"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="251164226"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 10:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="696675068"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 May 2022 10:24:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no77p-000Gj4-HF;
        Mon, 09 May 2022 17:24:49 +0000
Date:   Tue, 10 May 2022 01:24:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, mchehab+huawei@kernel.org, ardeleanalex@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH V1 4/5] iio: accel: bmi088: Make it possible to config
 scales.
Message-ID: <202205100100.6k4OJbjS-lkp@intel.com>
References: <20220509134629.440965-5-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509134629.440965-5-Qing-wu.Li@leica-geosystems.com.cn>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LI,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on v5.18-rc6 next-20220509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/LI-Qingwu/iio-accel-bmi088-support-BMI085-BMI090L/20220509-215750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-randconfig-r013-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100100.6k4OJbjS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/70883e96ff4d7433fa8974815aba932f8bb2e8e7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review LI-Qingwu/iio-accel-bmi088-support-BMI085-BMI090L/20220509-215750
        git checkout 70883e96ff4d7433fa8974815aba932f8bb2e8e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/accel/bmi088-accel-core.c: In function 'bmi088_accel_set_scale':
>> drivers/iio/accel/bmi088-accel-core.c:244:13: warning: unused variable 'reg' [-Wunused-variable]
     244 |         int reg;
         |             ^~~
>> drivers/iio/accel/bmi088-accel-core.c:243:13: warning: unused variable 'ret' [-Wunused-variable]
     243 |         int ret;
         |             ^~~


vim +/reg +244 drivers/iio/accel/bmi088-accel-core.c

   239	
   240	static int bmi088_accel_set_scale(struct bmi088_accel_data *data, int val, int val2)
   241	{
   242		unsigned int i;
 > 243		int ret;
 > 244		int reg;
   245	
   246		for (i = 0; i < 4; i++)
   247			if (val == data->chip_info->scale_table[i][0] &&
   248			    val2 == data->chip_info->scale_table[i][1])
   249				break;
   250	
   251		if (i >= 4)
   252			return -EINVAL;
   253	
   254		return regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE, i);
   255	}
   256	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
