Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B709848FD58
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbiAPOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 09:07:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:19566 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbiAPOHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 09:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642342025; x=1673878025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x4VQ4nR9VUlZ83fYyFKy/XXbdvbRBwbal6RMpIkpZLk=;
  b=X6OncG15/ZbFb6iZKvzw6XY7i33jYaGfQLc7dnXWD4gH45M3PMxDOL3j
   3lnpPwtYQadVRo3Q0R08r9Tu7bXQwxDMamGF3T/9UUKTTJl/xmyfkQHQu
   k3wc4crqe3oU/1AsFEZ837Kv4MVGx32tehQ94HO2Y+kHGIFYyux2cFnjB
   XJfdp9g6wDFF3SKJnhmVIc3jAyvEIjAvhg8ihv9Tbo+0LJM9U2Nz5EpPm
   Z2bcFdgdo7jLXBKRvyS+C6ffRnlDCI/e2YSGqJioiMjuRdnfUgfuDXRyK
   JXpZte7sSlY9a8ViHsgHzenEBMDk5Ye60NBlJ1huaw6U84g8GL3pEnFmN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="242049955"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="242049955"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 06:07:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="517094263"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Jan 2022 06:07:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n96BP-000AlI-RA; Sun, 16 Jan 2022 14:06:59 +0000
Date:   Sun, 16 Jan 2022 22:06:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        gregkh@linuxfoundation.org, realwakka@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: pi433: validate max bit_rate based on
 modulation used
Message-ID: <202201162116.8r1xEw9q-lkp@intel.com>
References: <20220116002333.GA23305@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116002333.GA23305@mail.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paulo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Paulo-Miguel-Almeida/staging-pi433-validate-min-max-bit-rate-settings/20220116-082432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git fa783154524a71ab74e293cd8251155e5971952b
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220116/202201162116.8r1xEw9q-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4bbc9e444fd3bab38d93ae4261102db64385a26c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Paulo-Miguel-Almeida/staging-pi433-validate-min-max-bit-rate-settings/20220116-082432
        git checkout 4bbc9e444fd3bab38d93ae4261102db64385a26c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/staging/pi433/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/pi433/rf69.c:238:30: warning: result of comparison of constant 300000 with expression of type 'u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
               (mod == FSK && bit_rate > 300000) ||
                              ~~~~~~~~ ^ ~~~~~~
   1 warning generated.


vim +238 drivers/staging/pi433/rf69.c

   220	
   221	int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
   222	{
   223		int retval;
   224		u32 bit_rate_reg;
   225		u8 msb;
   226		u8 lsb;
   227		enum modulation mod;
   228	
   229		// check if modulation is configured
   230		mod = rf69_get_modulation(spi);
   231		if (mod == UNDEF) {
   232			dev_dbg(&spi->dev, "setBitRate: modulation is undefined");
   233			return -EINVAL;
   234		}
   235	
   236		// check input value
   237		if (bit_rate < 1200 ||
 > 238		    (mod == FSK && bit_rate > 300000) ||
   239		    (mod == OOK && bit_rate > 32768)) {
   240			dev_dbg(&spi->dev, "setBitRate: illegal input param");
   241			return -EINVAL;
   242		}
   243	
   244		// calculate reg settings
   245		bit_rate_reg = (F_OSC / bit_rate);
   246	
   247		msb = (bit_rate_reg & 0xff00) >> 8;
   248		lsb = (bit_rate_reg & 0xff);
   249	
   250		// transmit to RF 69
   251		retval = rf69_write_reg(spi, REG_BITRATE_MSB, msb);
   252		if (retval)
   253			return retval;
   254		retval = rf69_write_reg(spi, REG_BITRATE_LSB, lsb);
   255		if (retval)
   256			return retval;
   257	
   258		return 0;
   259	}
   260	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
