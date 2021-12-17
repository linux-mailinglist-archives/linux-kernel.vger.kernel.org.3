Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113E5478412
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhLQEfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:35:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:4025 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229511AbhLQEfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639715747; x=1671251747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nsTk2GCSHeSnnQlS3n1iZdnu7KhMPFn3pts3SeWaO6U=;
  b=ORF7QjX21SFYjYsgZ6mZhRc9huECvuiafySyAsVagCp7oU0k7Z+Z8ruM
   nBRdqlznBvIv7mct6bs5k7TiRWMUTvXMvdS8efMfFqfTfUjpK+S5+POST
   uY7lquZrEwOWh564alt0gePIZqQ+chT6EV/NaL7o5oUHFc9MALohJs6Tf
   TNeVbl//yx4TOyZkv5f0pRXC7EtDGX9ZeaykAt1b7B5Zoh+HHSiSKsJL7
   rqVKQQAifv3G6iToiVvagkLGtyPjkoUk6k/01hryatc55EKfonYe0vKaQ
   /mFXB2nCOVdgONhLT6/3HQNMkehb45jOJhQ/gnpe48h4PCEWV4cDIJH25
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="239901367"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="239901367"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 20:35:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="464988526"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2021 20:35:45 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my4y8-0004E7-IA; Fri, 17 Dec 2021 04:35:44 +0000
Date:   Fri, 17 Dec 2021 12:35:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     kbuild-all@lists.01.org, andy.shevchenko@gmail.com,
        pauk.denis@gmail.com, Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
Message-ID: <202112171205.FwhZfLkY-lkp@intel.com>
References: <20211216205303.768991-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216205303.768991-1-eugene.shalygin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugene,

I love your patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on next-20211215]
[cannot apply to v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Eugene-Shalygin/hwmon-asus-ec-sensors-add-driver-for-ASUS-EC/20211217-045428
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20211217/202112171205.FwhZfLkY-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/27e7f47121cb02208740ed895a4cf4c7ab5bee63
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Eugene-Shalygin/hwmon-asus-ec-sensors-add-driver-for-ASUS-EC/20211217-045428
        git checkout 27e7f47121cb02208740ed895a4cf4c7ab5bee63
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hwmon/asus-ec-sensors.c: In function 'asus_ec_probe':
>> drivers/hwmon/asus-ec-sensors.c:690:26: warning: ordered comparison of pointer with integer zero [-Wextra]
     690 |         if (state->board < 0) {
         |                          ^


vim +690 drivers/hwmon/asus-ec-sensors.c

   685	
   686	static int asus_ec_probe(struct platform_device *pdev)
   687	{
   688		struct ec_sensors_data *state = platform_get_drvdata(pdev);
   689	
 > 690		if (state->board < 0) {
   691			return -ENODEV;
   692		}
   693	
   694		return 0;
   695	}
   696	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
