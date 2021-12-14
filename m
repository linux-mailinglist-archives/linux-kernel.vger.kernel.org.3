Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDD6473BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhLND5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:57:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:34169 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhLND5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639454231; x=1670990231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c80rvbuAJVfSyWz3CPd3UL10TlVQu2fDLQ3/tWNO5wM=;
  b=Si7FxOgFWHgiokuEyDuQYOSislgB6WW2G3KZp+EdtkbKnuY1B4sp456u
   t1WPuJZf2f1fO0mGR/7UwKWSseeVASY4i0aeKy03qox0B3WZp1l7ssPYl
   m//Bwa0GMFdbiB/tgaaG83MHr0pt7LbSSyuC/G/UWb65oBqXHsrW4ThZ/
   OHtnp3mVY1D/Ckei8hZzBFv2Yau9hY5KbVQdvt0J5AeF8HbarjjCAkUXV
   cN+fXKhJeSgrS7ZX/WgRdyMA9zwXcNZhgJ1fjkipp/Qzaw0CrYDqzyXOx
   McaETUc11PII4wEbd3Er2uqb6TqOK3hE6vfvFj1TR2QkbidpEyLrTysGZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325163932"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="325163932"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 19:57:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="545019569"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Dec 2021 19:57:08 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mwyw7-0007PV-RG; Tue, 14 Dec 2021 03:57:07 +0000
Date:   Tue, 14 Dec 2021 11:56:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Brazdil <dbrazdil@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] misc: open-dice: Add driver to expose DICE data
 to userspace
Message-ID: <202112141150.Hh48OleF-lkp@intel.com>
References: <20211213195833.772892-3-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213195833.772892-3-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on char-misc/char-misc-testing soc/for-next v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/David-Brazdil/Driver-for-Open-Profile-for-DICE/20211214-040051
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211214/202112141150.Hh48OleF-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/6fb8e9472d98abcc2dfabd43e95fc4ec5819ecd0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review David-Brazdil/Driver-for-Open-Profile-for-DICE/20211214-040051
        git checkout 6fb8e9472d98abcc2dfabd43e95fc4ec5819ecd0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/open-dice.c: In function 'open_dice_probe':
>> drivers/misc/open-dice.c:30:21: warning: format '%d' expects argument of type 'int', but argument 4 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
      30 | #define DRIVER_NAME "open-dice"
         |                     ^~~~~~~~~~~
   drivers/misc/open-dice.c:160:49: note: in expansion of macro 'DRIVER_NAME'
     160 |  snprintf(drvdata->name, sizeof(drvdata->name), DRIVER_NAME"%d", dev_idx++);
         |                                                 ^~~~~~~~~~~
   drivers/misc/open-dice.c:160:62: note: format string is defined here
     160 |  snprintf(drvdata->name, sizeof(drvdata->name), DRIVER_NAME"%d", dev_idx++);
         |                                                             ~^
         |                                                              |
         |                                                              int
         |                                                             %ld


vim +30 drivers/misc/open-dice.c

    29	
  > 30	#define DRIVER_NAME "open-dice"
    31	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
