Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267EE47FDBD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbhL0OAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 09:00:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:38980 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236955AbhL0OAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 09:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640613623; x=1672149623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fI+vasy/JcocGCw2WSA/p27qt8qZEyylmM6e3KRu2yA=;
  b=n+J1RWKRnNcRqPDNlUP3bD2nOlC5TqDJD2eZGNRpV8pqM8rv1rQ2gR5/
   3F6cG4Sk1e7F7TECfjkXgpKv3dK9oei/NpM5BGvcc8YTtwF/SpMKTx3VR
   Ti5kc4vUrWe4aW4pqG4GKODgQlUsvy5bMLn+0TRQFvIfbPiaZ60CuskXx
   y7ayVz69FsWRVvnuaoy8QUIJgPKa+Xtjr46d2AFVQGyPdc7LN7iQxdeDW
   O7MluAfhXzOX5Flo8YBvoKs3V/jTi0p1NGE3Hayqr2ZP25YMc1WgvFt5T
   v9D7+2fuxa/TI8ib8+ot+creY5pGfKeUppPV0e2PUOB/lDNgtIx+nHxhu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="265433722"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="265433722"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 06:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="572045895"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2021 06:00:21 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1qY0-0006Jq-FC; Mon, 27 Dec 2021 14:00:20 +0000
Date:   Mon, 27 Dec 2021 22:00:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2 1/1] m68k: introduce a virtual m68k machine
Message-ID: <202112272147.UoQokuQR-lkp@intel.com>
References: <20211227093931.480329-2-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227093931.480329-2-laurent@vivier.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on geert-m68k/for-next]
[also build test WARNING on linux/master linus/master v5.16-rc7 next-20211224]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Laurent-Vivier/m68k-Add-Virtual-M68k-Machine/20211227-174054
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20211227/202112272147.UoQokuQR-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/02e0dceb9e3bfcc8ef254308394ddb2a6a4cac2f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Laurent-Vivier/m68k-Add-Virtual-M68k-Machine/20211227-174054
        git checkout 02e0dceb9e3bfcc8ef254308394ddb2a6a4cac2f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/virt/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/m68k/virt/config.c:56:12: warning: no previous prototype for 'virt_parse_bootinfo' [-Wmissing-prototypes]
      56 | int __init virt_parse_bootinfo(const struct bi_record *record)
         |            ^~~~~~~~~~~~~~~~~~~
>> arch/m68k/virt/config.c:97:13: warning: no previous prototype for 'config_virt' [-Wmissing-prototypes]
      97 | void __init config_virt(void)
         |             ^~~~~~~~~~~
--
>> arch/m68k/virt/ints.c:48:13: warning: no previous prototype for 'virt_nmi_handler' [-Wmissing-prototypes]
      48 | irqreturn_t virt_nmi_handler(int irq, void *dev_id)
         |             ^~~~~~~~~~~~~~~~


vim +/virt_parse_bootinfo +56 arch/m68k/virt/config.c

    51	
    52	/*
    53	 * Parse a virtual-m68k-specific record in the bootinfo
    54	 */
    55	
  > 56	int __init virt_parse_bootinfo(const struct bi_record *record)
    57	{
    58		int unknown = 0;
    59		const void *data = record->data;
    60	
    61		switch (be16_to_cpu(record->tag)) {
    62		case BI_VIRT_QEMU_VERSION:
    63			virt_bi_data.qemu_version = be32_to_cpup(data);
    64			break;
    65		case BI_VIRT_GF_PIC_BASE:
    66			virt_bi_data.pic.mmio = be32_to_cpup(data);
    67			data += 4;
    68			virt_bi_data.pic.irq = be32_to_cpup(data);
    69			break;
    70		case BI_VIRT_GF_RTC_BASE:
    71			virt_bi_data.rtc.mmio = be32_to_cpup(data);
    72			data += 4;
    73			virt_bi_data.rtc.irq = be32_to_cpup(data);
    74			break;
    75		case BI_VIRT_GF_TTY_BASE:
    76			virt_bi_data.tty.mmio = be32_to_cpup(data);
    77			data += 4;
    78			virt_bi_data.tty.irq = be32_to_cpup(data);
    79			break;
    80		case BI_VIRT_CTRL_BASE:
    81			virt_bi_data.ctrl.mmio = be32_to_cpup(data);
    82			data += 4;
    83			virt_bi_data.ctrl.irq = be32_to_cpup(data);
    84			break;
    85		case BI_VIRT_VIRTIO_BASE:
    86			virt_bi_data.virtio.mmio = be32_to_cpup(data);
    87			data += 4;
    88			virt_bi_data.virtio.irq = be32_to_cpup(data);
    89			break;
    90		default:
    91			unknown = 1;
    92			break;
    93		}
    94		return unknown;
    95	}
    96	
  > 97	void __init config_virt(void)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
