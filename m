Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB03474BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhLNTWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:22:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:54560 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhLNTWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639509726; x=1671045726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vyRVHuRWEi9cD5IUb7C3Xi38X3r6IlSCHFYV7cx47BE=;
  b=H4W9JVnhLdjOkn7nke/XpMvjEnC92pP75fv0aab3eG1NtRFY1TKpA9Dd
   +4bkTOhNHksZKbCXVPn8UosajjVHR8/YXXX0nMzeuZ4mQ4l+tDvhY7SK+
   lNdwNcRqe2J6A77TQffhaj3Lg+8wmChrQBLvKlzTJalReVypUBhXnvtux
   2KcH6YzXD/ozGh7o3XGFsonz+29g8QLos/H8UHoDlu2p5iXb7r0WspH7c
   GhJ8mfpTU013mXtqlKG7CdcCVhCxbPMQ2wH3mWOZK0Uv+9s2nWA+OHbaS
   6uXc9b56i950EA/6tKqe1Z7ri8V3LUGnSUk1/SUzArd2SbUhR0KzOgBLW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225924701"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="225924701"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 11:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="614416036"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Dec 2021 11:17:22 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxDIf-0000fG-AQ; Tue, 14 Dec 2021 19:17:21 +0000
Date:   Wed, 15 Dec 2021 03:17:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikita Travkin <nikita@trvn.ru>, thierry.reding@gmail.com,
        lee.jones@linaro.org
Cc:     kbuild-all@lists.01.org, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, sboyd@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pwm: Add clock based PWM output driver
Message-ID: <202112150357.lrG18diq-lkp@intel.com>
References: <20211213150335.51888-3-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213150335.51888-3-nikita@trvn.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on thierry-reding-pwm/for-next]
[also build test ERROR on v5.16-rc5 next-20211213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nikita-Travkin/Clock-based-PWM-output-driver/20211213-230628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
config: microblaze-randconfig-r003-20211214 (https://download.01.org/0day-ci/archive/20211215/202112150357.lrG18diq-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/454624747f4637529777274ae1b5ab7af33fd130
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nikita-Travkin/Clock-based-PWM-output-driver/20211213-230628
        git checkout 454624747f4637529777274ae1b5ab7af33fd130
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [drivers/pwm/pwm-clk.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
