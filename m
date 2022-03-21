Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34F74E2AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349415AbiCUOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349450AbiCUOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:36:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C52AEA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647873304; x=1679409304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nxnkKNaR6BH6/BqAXplwtQt6rIWbEcAatC58CanjivI=;
  b=aERwJ4+pNtHRFvZdkb9qqLIMf7Kucr9mcrSbm/YqLf0iLEBMIQ6ClBq/
   lg1Xq5dFs3jrW0sti3hhETcT8b9PbosuzIDGGAIfaYnIrsW214zuItCGS
   pEveyMtvlz5PLnRaSXY9yZd272aFDxjC7SgctA0yb/yBbTd1fGasQ6pKi
   Ik6+AR9Ey//AdKUv/GMPaGAm3ri2X3POyBuZf0ZY8oqDAopKuJwQNmkIa
   yXznby00LjAeOkB+elaJjbv5pxxacmVcy62rV60m9Ax1A3h8xuV6kBX+o
   38F4BgYuMIfFv0YMA8cClFX5HkTdOSpTlUMwYJUuUGXfxx6cOdy5PNZ/T
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257755956"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="257755956"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 07:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="636664711"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2022 07:35:01 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWJ7c-000Hu4-BS; Mon, 21 Mar 2022 14:35:00 +0000
Date:   Mon, 21 Mar 2022 22:34:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yusuf Khan <yusisamerican@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, gregkh@linuxfoundation.org,
        javier@javigon.com, arnd@arndb.de, will@kernel.org,
        axboe@kernel.dk, Yusuf Khan <yusisamerican@gmail.com>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>
Subject: Re: [PATCH v8 1/2] drivers: ddcci: upstream DDCCI driver
Message-ID: <202203212212.7eOgDRf0-lkp@intel.com>
References: <20220321031438.14762-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321031438.14762-1-yusisamerican@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yusuf,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linux/master linus/master lee-backlight/for-backlight-next v5.17 next-20220318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yusuf-Khan/drivers-ddcci-upstream-DDCCI-driver/20220321-111557
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 37fd83916da2e4cae03d350015c82a67b1b334c4
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220321/202203212212.7eOgDRf0-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/42317fc284bbedc623892f2b20e404df80f8c393
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yusuf-Khan/drivers-ddcci-upstream-DDCCI-driver/20220321-111557
        git checkout 42317fc284bbedc623892f2b20e404df80f8c393
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/char/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/char/ddcci.c: In function 'ddcci_device_remove':
>> drivers/char/ddcci.c:1206:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    1206 |         int ret = 0;
         |             ^~~


vim +/ret +1206 drivers/char/ddcci.c

  1201	
  1202	static void ddcci_device_remove(struct device *dev)
  1203	{
  1204		struct ddcci_device	*device = ddcci_verify_device(dev);
  1205		struct ddcci_driver	*driver;
> 1206		int ret = 0;
  1207	
  1208		if (!device)
  1209			return;
  1210		driver = to_ddcci_driver(dev->driver);
  1211	
  1212		if (driver->remove)
  1213			ret = driver->remove(device);
  1214	}
  1215	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
