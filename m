Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5388047917E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbhLQQah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:30:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:52544 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhLQQah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639758637; x=1671294637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WZoWLbwvk72sjBrsflJAsBLZK2RLWN0sMTnR+iKK/PU=;
  b=d5apCf5aUs2kcoqNFNVJt30u7xwjKgC29P5aogdFUbIk1mfgtEUacqUg
   Tz+wTiArGrXp+4L0WrMrPSMp5jtjNXxLJ7H77/EyNewSX8Iu8DgP5jaZw
   CNhRM4RNQWiaWtDCiWyLeqNcs469nspUAzN4HhsHuUrzabu8oqywDtrB6
   MtUDAwUOGbXhBYJt5zkI0yLYoB42KIjX1CeZ64CgYnIuyEvy/tWsgbH1n
   abhdjd06hHnRx9KuUlZ2QYVRZI98oI3SVy2ttYgxzh0OO4Y1T/zmzt1mk
   yEorR9l8NP/NmPsnVAzeJZVC+oTZFlI7wB+IrRTXp4SEwXUg4ZxxpWUFi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="219797929"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="219797929"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 08:30:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="605937516"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Dec 2021 08:30:19 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myG7e-0004vt-RY; Fri, 17 Dec 2021 16:30:18 +0000
Date:   Sat, 18 Dec 2021 00:29:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     kbuild-all@lists.01.org, cosmin.tanislav@analog.com,
        demonsingur@gmail.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: accel: add ADXL367 driver
Message-ID: <202112180019.g2mLoEZq-lkp@intel.com>
References: <20211217114548.1659721-3-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217114548.1659721-3-cosmin.tanislav@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cosmin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v5.16-rc5 next-20211217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cosmin-Tanislav/Add-ADXL367-driver/20211217-194722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211218/202112180019.g2mLoEZq-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c227f49f87d7be7884f44bfdd422713610cdd29c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cosmin-Tanislav/Add-ADXL367-driver/20211217-194722
        git checkout c227f49f87d7be7884f44bfdd422713610cdd29c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/iio/accel/ net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/adxl367.c:990:5: warning: no previous prototype for 'adxl367_write_raw_get_fmt' [-Wmissing-prototypes]
     990 | int adxl367_write_raw_get_fmt(struct iio_dev *indio_dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/adxl367.c:212:18: warning: 'adxl367_time_scale_tbl' defined but not used [-Wunused-const-variable=]
     212 | static const int adxl367_time_scale_tbl[] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~~


vim +/adxl367_write_raw_get_fmt +990 drivers/iio/accel/adxl367.c

   989	
 > 990	int adxl367_write_raw_get_fmt(struct iio_dev *indio_dev,
   991				      struct iio_chan_spec const *chan,
   992				      long info)
   993	{
   994		switch (info) {
   995		case IIO_CHAN_INFO_SCALE:
   996			if (chan->type != IIO_ACCEL)
   997				return -EINVAL;
   998	
   999			return IIO_VAL_INT_PLUS_NANO;
  1000		default:
  1001			return IIO_VAL_INT_PLUS_MICRO;
  1002		}
  1003	}
  1004	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
