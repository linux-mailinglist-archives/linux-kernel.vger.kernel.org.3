Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82E51AF1C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbiEDUes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357568AbiEDUeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:34:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2B4E387;
        Wed,  4 May 2022 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651696266; x=1683232266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5GhRSMdpdVf05QfepV3o9U0aOcougHdLRETdtU1BceE=;
  b=Mt+ekS5FZ5erIAKIi3qdTFct5hRJu9qRtcj5JyjS8prYPm5OsJ/fp1Xo
   YBQ8SOhf25jIeJj8+grqa0c3Tyh6CD032PSDR2UZcdP0TaSbOVlisv1UJ
   zOAX944ge3UOH1zUMYWsFJwxW70E+tIZ+7ZyKwlWpmjwEEzfSZ5Obq9Zf
   6rfsYfffll/Rk6lVegitDv8XeEr7/KOpLbVW2bqXgQSdxDcpXV0rmAMRP
   SzPv+Fi9rEGB4QNPvEXF0alQFl6G5v2nZRe+FiMQ6A/ReI1kyokyq98ea
   2W4gL/13YshNQPYYPfsIIDn2yo9FHNtXzTpA6kAspa6plcMkPtNRNLIUM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="265484431"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="265484431"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 13:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="568271596"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2022 13:31:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmLeG-000BlC-Rr;
        Wed, 04 May 2022 20:31:00 +0000
Date:   Thu, 5 May 2022 04:30:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lin Meng-Bo <linmengbo0689@protonmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] input/touchscreen: imagis: Add support for Imagis
 IST3038B
Message-ID: <202205050459.Cn4Mj5ny-lkp@intel.com>
References: <20220504152406.8730-4-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504152406.8730-4-markuss.broks@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

I love your patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on linux/master linus/master v5.18-rc5 next-20220504]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Markuss-Broks/Add-support-for-Imagis-IST3038B/20220504-232637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: hexagon-randconfig-r022-20220502 (https://download.01.org/0day-ci/archive/20220505/202205050459.Cn4Mj5ny-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a22f360f66c82a3bc53d9861a62d2d2e5abe897c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Markuss-Broks/Add-support-for-Imagis-IST3038B/20220504-232637
        git checkout a22f360f66c82a3bc53d9861a62d2d2e5abe897c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/input/touchscreen/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/input/touchscreen/imagis.c:366:39: warning: unused variable 'imagis_3038b_data' [-Wunused-const-variable]
   static const struct imagis_properties imagis_3038b_data = {
                                         ^
>> drivers/input/touchscreen/imagis.c:374:39: warning: unused variable 'imagis_3038c_data' [-Wunused-const-variable]
   static const struct imagis_properties imagis_3038c_data = {
                                         ^
   2 warnings generated.


vim +/imagis_3038b_data +366 drivers/input/touchscreen/imagis.c

   365	
 > 366	static const struct imagis_properties imagis_3038b_data = {
   367		.interrupt_msg_cmd = IST3038B_REG_STATUS,
   368		.touch_coord_cmd = IST3038B_REG_STATUS,
   369		.whoami_cmd = IST3038B_REG_CHIPID,
   370		.whoami_val = IST3038B_WHOAMI,
   371		.protocol_b = true,
   372	};
   373	
 > 374	static const struct imagis_properties imagis_3038c_data = {
   375		.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
   376		.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
   377		.whoami_cmd = IST3038C_REG_CHIPID,
   378		.whoami_val = IST3038C_WHOAMI,
   379	};
   380	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
