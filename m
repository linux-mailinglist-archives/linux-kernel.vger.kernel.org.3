Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8BE487737
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiAGL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:58:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:48988 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238319AbiAGL6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641556714; x=1673092714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EdSqS4VAyQDEtNmAwMFPIrwHE7KgmcEsvaxdDJqC04A=;
  b=EYEapJBaskHXfatOtARIVbsP6dRBEgvpu/KQfHS9w0M0U8JeHqsH7rAQ
   CEnM4XC+ynk1TJuHlMeJC6xHmK7H9OQTFhKYcxwytkUlw2jBvMHQhdqbl
   udePKmwnuz1JQzEiSIdvWxYjGwy2fklOUXeLvjmMUE6gZMNO21e7kuo5K
   c2hQwI1wNa6jxekv0XhqmU9kKiY2Cq/XONKGwB3Exo02i4v0I6tIuHipX
   IEtNQMXqWR2AHH/ZQtDM1ejQNqPs+CSSKLP57g7QfcHlRBKfNQ7vnq0L5
   cMdcslXbgF/eIMJAIirKeQNnZzuQ+DL9sZy7MWLcBVxguhRLj8XS04Bfh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="267154513"
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="267154513"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 03:58:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="557243987"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 03:58:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n5nru-007Mat-Eu;
        Fri, 07 Jan 2022 13:57:14 +0200
Date:   Fri, 7 Jan 2022 13:57:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/5] nvmem: core: Remove unused devm_nvmem_unregister()
Message-ID: <YdgqmvBTQ2vZAjsn@smile.fi.intel.com>
References: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
 <202201060932.tcQFIVfQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201060932.tcQFIVfQ-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 09:11:47AM +0800, kernel test robot wrote:
> Hi Andy,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on mtd/mtd/next]
> [also build test WARNING on mtd/mtd/fixes char-misc/char-misc-testing linus/master v5.16-rc8 next-20220105]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/nvmem-core-Remove-unused-devm_nvmem_unregister/20220104-213933
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
> config: mips-randconfig-r002-20220105 (https://download.01.org/0day-ci/archive/20220106/202201060932.tcQFIVfQ-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://github.com/0day-ci/linux/commit/7877de3d47433a75d2beea38b696b3c4fde62082
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Andy-Shevchenko/nvmem-core-Remove-unused-devm_nvmem_unregister/20220104-213933
>         git checkout 7877de3d47433a75d2beea38b696b3c4fde62082
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/nvmem/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/nvmem/core.c:946:12: warning: unused function 'devm_nvmem_match'

Ah, even more to clean up ;)

-- 
With Best Regards,
Andy Shevchenko


