Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79574A3540
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354414AbiA3Iye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:54:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:50060 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354391AbiA3Iy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643532869; x=1675068869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZM/9TReuyCVp2siJygg8nKwW3jkjj3ryvnrMx3Fa3+I=;
  b=Q+/97jzjp0gbCDg5Cz6gZ3c4f0bhoor5frUShEBCdfcKWy6C1nJKEZSZ
   DXeKFmyetA9AN0y5w8Ym69Vhzo26m+94yBcEyZVdvUORZgZ9xa9MHvCMX
   SFKfoXV1SJgrjFcnp060201sGGYGGbvuxOkfqpmzBi2RxIWLtVsy6ybuf
   ug6Ej86/Mk2aSuYM3HNgYjgpiAW3QkgrLvjkWaHImDEfE33cd1P/x3zlp
   DsqTT1qKkhz2adQOWNQ8LrB4AHRyr69gttJ3ypnYD7jL3yHSxVhQSrLkV
   +cFwp5Upv8saVtw7VbkW7fV9QUJIGDXbXG5hthb6X/ZBcvnNiuOZ6Irkj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="333686865"
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="333686865"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 00:54:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="522212040"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2022 00:54:26 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nE5yc-000QHO-4T; Sun, 30 Jan 2022 08:54:26 +0000
Date:   Sun, 30 Jan 2022 16:53:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Randy Dunlap <rdunlap@infradead.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb: typec: mux: select not-visible INTEL_SCU_IPC
Message-ID: <202201301532.7WyZkoRm-lkp@intel.com>
References: <20220130041220.9968-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130041220.9968-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on linux/master linus/master balbi-usb/testing/next peter-chen-usb/for-usb-next v5.17-rc1 next-20220128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Randy-Dunlap/usb-typec-mux-select-not-visible-INTEL_SCU_IPC/20220130-121346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220130/202201301532.7WyZkoRm-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/15c19e705dc558a4a954897a8a4d369164035341
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Randy-Dunlap/usb-typec-mux-select-not-visible-INTEL_SCU_IPC/20220130-121346
        git checkout 15c19e705dc558a4a954897a8a4d369164035341
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/usb/typec/mux/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/usb/typec/mux/intel_pmc_mux.c:19:10: fatal error: asm/intel_scu_ipc.h: No such file or directory
      19 | #include <asm/intel_scu_ipc.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for INTEL_SCU_IPC
   Depends on X86 && X86_PLATFORM_DEVICES
   Selected by
   - TYPEC_MUX_INTEL_PMC && USB_SUPPORT && TYPEC && ACPI


vim +19 drivers/usb/typec/mux/intel_pmc_mux.c

6701adfa9693bd Heikki Krogerus 2020-03-02  18  
b62851491a55bc Heikki Krogerus 2020-04-16 @19  #include <asm/intel_scu_ipc.h>
6701adfa9693bd Heikki Krogerus 2020-03-02  20  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
