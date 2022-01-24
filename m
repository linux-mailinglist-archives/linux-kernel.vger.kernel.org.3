Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8273498E52
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355317AbiAXTk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:40:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:30002 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352963AbiAXTbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643052679; x=1674588679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fpwYfflWld0ugqz8Mb0rqGT+uGIpwsHIjPs+XSu2Ols=;
  b=GtLK60/hwKK6QWAGWVyucVf94Ic/Oy985a6qILffR84E3Cq4HzgqUpCv
   TJKQcWFITtmlLtfpZ0R36zx8iiOOOMGkue+2y3VK4C0V2FKzYqkflGt+W
   H3nZbQ22oQenNZQHxaOV5HEw8YoxVdRMCg+MDFThVL4J5kiO98LD5kWfz
   UsEaabJLfSWMEhteAA4APfRO8kq/T1OPnVWFVudCLofTZbjDSNbr2xTIu
   qxDlZLSMF1bn0gwWlJRlUpv76tm25Q+UOo3U4Nanihr3WV4jYhUc2WC71
   6MRdlqJfuHutebPy3m5xIEMi6KRx4CZ8Djc+aIE/aH0FaM6b6LYeaU4rA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226108575"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226108575"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 11:25:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="532180520"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2022 11:25:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC4xa-000IoS-PV; Mon, 24 Jan 2022 19:25:02 +0000
Date:   Tue, 25 Jan 2022 03:24:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Harsha <harsha.harsha@xilinx.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, saratcha@xilinx.com, harshj@xilinx.com
Subject: Re: [PATCH 3/4] crypto: xilinx: Add Xilinx SHA3 driver
Message-ID: <202201250209.WqpE2vMF-lkp@intel.com>
References: <1642931227-20706-4-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642931227-20706-4-git-send-email-harsha.harsha@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harsha,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master]
[cannot apply to xilinx-xlnx/master v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Harsha/crypto-Add-Xilinx-ZynqMP-SHA3-driver-support/20220123-175102
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220125/202201250209.WqpE2vMF-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fc7aea6e3118ca7210454fdb7c9c588c05c1f171
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Harsha/crypto-Add-Xilinx-ZynqMP-SHA3-driver-support/20220123-175102
        git checkout fc7aea6e3118ca7210454fdb7c9c588c05c1f171
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/crypto/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from ./arch/s390/include/generated/asm/cacheflush.h:1,
                    from drivers/crypto/xilinx/zynqmp-sha.c:6:
>> include/asm-generic/cacheflush.h:53:46: warning: 'struct folio' declared inside parameter list will not be visible outside of this definition or declaration
      53 | static inline void flush_dcache_folio(struct folio *folio) { }
         |                                              ^~~~~


vim +53 include/asm-generic/cacheflush.h

08b0b0059bf1c2 Matthew Wilcox (Oracle  2020-12-16  52) 
08b0b0059bf1c2 Matthew Wilcox (Oracle  2020-12-16 @53) static inline void flush_dcache_folio(struct folio *folio) { }
76b3b58fac350c Christoph Hellwig       2020-06-07  54  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
08b0b0059bf1c2 Matthew Wilcox (Oracle  2020-12-16  55) #define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
4f0bd808134d73 Mike Rapoport           2019-12-23  56  #endif
c296d4dc13aefe Qian Cai                2019-07-16  57  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
