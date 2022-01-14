Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD4C48E6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiANIrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:47:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:42426 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbiANIrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642150029; x=1673686029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v21ohnzTmhcgJ7DWRkgSfaRtN9DyPgyjLHvUcQ+azvg=;
  b=DHkYjK7ozXOuJUaZEuSEFcQEdPLATYUZu7W/tlNWw6qsp5Rd26+Lu003
   b5DvOg2thJAjO4rM1jBJSTqNk7izGLDEOWKs9gIy4vCh1jlT3BL5IdnvQ
   MQi2548oU9d8iJyAl2xlQ18SO3/6J1K4onzXN32umzmCaYj1uN29hil99
   4Nj0XFHshQ+87Cp13dkXNKsTeBCogkQHcYNNdpinkYaJ6T1dvPHr1LROD
   eDo/MulUhEfzLdU7alUGtLOzRuvLTU2n0OPVjgv0NBzhTEYdbZhEQZ7Y9
   WibBUhSXjwON1TsvhZKPPT1Gdnyquv5EOm1gOznbh++Viv3Km8tyRN7Ho
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="224193022"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="224193022"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 00:47:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="475706119"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2022 00:43:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8IBL-0008KM-3G; Fri, 14 Jan 2022 08:43:35 +0000
Date:   Fri, 14 Jan 2022 16:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, lenb@kernel.org
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] ACPI / fan: Properly handle fine grain control
Message-ID: <202201141638.lm8dtLqR-lkp@intel.com>
References: <20220113224713.90092-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113224713.90092-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

I love your patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linux/master linus/master v5.16 next-20220114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Srinivas-Pandruvada/ACPI-fan-Properly-handle-fine-grain-control/20220114-064818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220114/202201141638.lm8dtLqR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/f30ef71d0435cd8735ee418eeb0bfc71a58a4554
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivas-Pandruvada/ACPI-fan-Properly-handle-fine-grain-control/20220114-064818
        git checkout f30ef71d0435cd8735ee418eeb0bfc71a58a4554
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/acpi/fan.o: in function `fan_get_max_state':
>> fan.c:(.text+0x28): undefined reference to `__udivdi3'
   ld: drivers/acpi/fan.o: in function `fan_set_cur_state':
   fan.c:(.text+0x18e): undefined reference to `__udivdi3'
   ld: drivers/acpi/fan.o: in function `fan_get_cur_state':
   fan.c:(.text+0x3d5): undefined reference to `__udivdi3'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
