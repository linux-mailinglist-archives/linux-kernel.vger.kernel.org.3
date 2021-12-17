Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2747960E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbhLQVOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:14:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:11171 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236219AbhLQVOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639775677; x=1671311677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PKD8agw6OrHky9JhV5gyaeJZna8zqKMQWp+esUG9fLg=;
  b=ZcwQbWYTTLqm484SFVq1Z8fBuGLfhKeujns+zXyttujpJFnaQ6+FQukY
   rzTNwDAipKwTxAS+krgr1esAegrWu0fZcHEOe65VRsHL0vKr/lPZ7r7mq
   WyI0gTX9NmmeaJGgs0ACJqQH2529pPfULRvA6nW1lgyuTTnImO/8OscCg
   VwmRyNCbx1XXeo4xWTAgVB4gHEqSNvvgXTCCsKOImGojqm8TOONZzDeFh
   kJ0MM2mCKXicuzHqQn8pbeWlWffcZ/I2oA25AAwg+3NAjT9INCGhENfZ4
   Br/9DrIwk1lf1XhuebsOJuVR01FilkTaUg8hEWzhybXiOnfPIs6L0Dqby
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="219849002"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="219849002"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 13:14:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="569138237"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 17 Dec 2021 13:14:34 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myKYj-0005DT-UD; Fri, 17 Dec 2021 21:14:33 +0000
Date:   Sat, 18 Dec 2021 05:13:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumit Gupta <sumitg@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org
Cc:     kbuild-all@lists.01.org, sumitg@nvidia.com, bbasu@nvidia.com,
        vsethi@nvidia.com, jsequeira@nvidia.com
Subject: Re: [Patch v2 5/9] soc: tegra: cbb: Add CBB1.0 driver for Tegra194
Message-ID: <202112180528.6oINgaDF-lkp@intel.com>
References: <20211217120656.16480-6-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217120656.16480-6-sumitg@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on tegra-drm/drm/tegra/for-next v5.16-rc5 next-20211217]
[cannot apply to tegra/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sumit-Gupta/CBB-driver-for-Tegra194-Tegra234-Tegra-Grace/20211217-200840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20211218/202112180528.6oINgaDF-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4289c950622627160bdc937ad22a311db38f4ca8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sumit-Gupta/CBB-driver-for-Tegra194-Tegra234-Tegra-Grace/20211217-200840
        git checkout 4289c950622627160bdc937ad22a311db38f4ca8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/tegra/cbb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/tegra/cbb/tegra-cbb.c: In function 'print_cbb_err':
>> drivers/soc/tegra/cbb/tegra-cbb.c:31:17: warning: function 'print_cbb_err' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      31 |                 seq_vprintf(file, fmt, args);
         |                 ^~~~~~~~~~~


vim +31 drivers/soc/tegra/cbb/tegra-cbb.c

    22	
    23	void print_cbb_err(struct seq_file *file, const char *fmt, ...)
    24	{
    25		va_list args;
    26		struct va_format vaf;
    27	
    28		va_start(args, fmt);
    29	
    30		if (file) {
  > 31			seq_vprintf(file, fmt, args);
    32		} else {
    33			vaf.fmt = fmt;
    34			vaf.va = &args;
    35			pr_crit("%pV", &vaf);
    36		}
    37	
    38		va_end(args);
    39	}
    40	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
