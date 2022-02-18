Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BE14BB13E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 06:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiBRFVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 00:21:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiBRFVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:21:34 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F8D2DD74;
        Thu, 17 Feb 2022 21:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645161678; x=1676697678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PE1icfGCCeAIgmQCq0879L1E1UDE4L2B0pbsEULePJQ=;
  b=ClUbAbgNETh9QlIAw2BdZOie/FgmKuHXU0AscTEVSU7cIAlh6+WvjJMZ
   z4EQtIxuHfRHUVdZqCYIU9l5//Ahf0hL3PmZRznR6Bh6zXGqYufHpoPKY
   fD8F2Xp4UuzPkyWzx0Ysvh6+Xb8smeAEgKY8jSHnliat3IAgr9+Dhqzf6
   T+8UnSEvHE72Ddek0jCPw3hK6znsDQM/yiR7Aot8nSch/W0RDrdJCcgbH
   hJWxktG6yaFhEdCQ8WEighVbKCZBYgnbEk20ffUpQxxG9OhlMqrf9zx/Q
   IJSMBfcW0JfIoVL7ONvt8uIewiIIlwgPcIPHnWJgOx1fmgO40g0UuQysD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250998903"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="250998903"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 21:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="626500106"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Feb 2022 21:21:14 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKvhh-0000z0-MI; Fri, 18 Feb 2022 05:21:13 +0000
Date:   Fri, 18 Feb 2022 13:20:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrea Merello <andrea.merello@gmail.com>, jic23@kernel.org,
        mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, lars@metafoo.de, robh+dt@kernel.org,
        andy.shevchenko@gmail.com, matt.ranostay@konsulko.com,
        ardeleanalex@gmail.com, jacopo@jmondi.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: Re: [v3 11/13] iio: imu: add BNO055 serdev driver
Message-ID: <202202181307.Lb4f99qg-lkp@intel.com>
References: <20220217162710.33615-12-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217162710.33615-12-andrea.merello@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linux/master linus/master v5.17-rc4 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220218-002932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220218/202202181307.Lb4f99qg-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/98d7db4486f0404718da9e85ae13da54d757104b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220218-002932
        git checkout 98d7db4486f0404718da9e85ae13da54d757104b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iio/imu/bno055/bno055.c:285:5: warning: no previous prototype for 'bno055_calibration_load' [-Wmissing-prototypes]
     285 | int bno055_calibration_load(struct bno055_priv *priv, const u8 *data, int len)
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/bno055/bno055.c:748:5: warning: no previous prototype for 'bno055_sysfs_attr_avail' [-Wmissing-prototypes]
     748 | int bno055_sysfs_attr_avail(struct bno055_priv *priv, struct bno055_sysfs_attr *attr,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/bno055/bno055.c:1203:5: warning: no previous prototype for 'bno055_debugfs_reg_access' [-Wmissing-prototypes]
    1203 | int bno055_debugfs_reg_access(struct iio_dev *iio_dev, unsigned int reg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/bno055/bno055.c: In function 'bno055_show_fw_version':
>> drivers/iio/imu/bno055/bno055.c:1235:2: error: implicit declaration of function 'kfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
    1235 |  kfree(buf);
         |  ^~~~~
         |  vfree
   cc1: some warnings being treated as errors


vim +1235 drivers/iio/imu/bno055/bno055.c

16cbcd24402827b Andrea Merello 2022-02-17  1213  
16cbcd24402827b Andrea Merello 2022-02-17  1214  static ssize_t bno055_show_fw_version(struct file *file, char __user *userbuf,
16cbcd24402827b Andrea Merello 2022-02-17  1215  				      size_t count, loff_t *ppos)
16cbcd24402827b Andrea Merello 2022-02-17  1216  {
16cbcd24402827b Andrea Merello 2022-02-17  1217  	struct bno055_priv *priv = file->private_data;
16cbcd24402827b Andrea Merello 2022-02-17  1218  	int rev, ver;
16cbcd24402827b Andrea Merello 2022-02-17  1219  	char *buf;
16cbcd24402827b Andrea Merello 2022-02-17  1220  	int ret;
16cbcd24402827b Andrea Merello 2022-02-17  1221  
16cbcd24402827b Andrea Merello 2022-02-17  1222  	ret = regmap_read(priv->regmap, BNO055_SW_REV_LSB_REG, &rev);
16cbcd24402827b Andrea Merello 2022-02-17  1223  	if (ret)
16cbcd24402827b Andrea Merello 2022-02-17  1224  		return ret;
16cbcd24402827b Andrea Merello 2022-02-17  1225  
16cbcd24402827b Andrea Merello 2022-02-17  1226  	ret = regmap_read(priv->regmap, BNO055_SW_REV_MSB_REG, &ver);
16cbcd24402827b Andrea Merello 2022-02-17  1227  	if (ret)
16cbcd24402827b Andrea Merello 2022-02-17  1228  		return ret;
16cbcd24402827b Andrea Merello 2022-02-17  1229  
16cbcd24402827b Andrea Merello 2022-02-17  1230  	buf = kasprintf(GFP_KERNEL, "ver: 0x%x, rev: 0x%x\n", ver, rev);
16cbcd24402827b Andrea Merello 2022-02-17  1231  	if (!buf)
16cbcd24402827b Andrea Merello 2022-02-17  1232  		return -ENOMEM;
16cbcd24402827b Andrea Merello 2022-02-17  1233  
16cbcd24402827b Andrea Merello 2022-02-17  1234  	ret = simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
16cbcd24402827b Andrea Merello 2022-02-17 @1235  	kfree(buf);
16cbcd24402827b Andrea Merello 2022-02-17  1236  
16cbcd24402827b Andrea Merello 2022-02-17  1237  	return ret;
16cbcd24402827b Andrea Merello 2022-02-17  1238  }
16cbcd24402827b Andrea Merello 2022-02-17  1239  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
