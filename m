Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D103B4B3463
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 12:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiBLLAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 06:00:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiBLLAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 06:00:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCF924BD6;
        Sat, 12 Feb 2022 03:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644663645; x=1676199645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qTc5GJOOUJ9y5m3YOgoyTQTdlQ6SLtEu1OqnYMW0m1U=;
  b=jDsF33+LwweLvPyCxPC5MwUIrrkElIOv6o02FrYzSn0l1ieAtJQVoSC4
   aLBhd+HWlRmFn/Hg4Y3SHxWKUzqpwQUKHlwHKzmWVGrCKWLHsZKjS5Rh1
   YU/YrNC79zFND5JxtH0gJwpiHb4fUSw4Uuqz8KvCwibNK6cWJ37fjK/HS
   vcD1eWn320/B6EDmU9+cv/ZQms+tdbZBxFUCH/e3+8wm0OigvhfO6D6Nb
   Fg1c2V81tv2OOgJdk+aHm/y+wAra9GFmEAS6m4To2Z7fVY2q4od8Lna7U
   V3xXHsIWUXHGxQaDffN2Soglf4XFU0l839KZq5sl832+ydGQDDVo3FtG9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="230512834"
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="230512834"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 03:00:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,363,1635231600"; 
   d="scan'208";a="569304982"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2022 03:00:42 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIq8w-00063o-0N; Sat, 12 Feb 2022 11:00:42 +0000
Date:   Sat, 12 Feb 2022 19:00:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Report which option to enable for
 blacklisted PCI devices
Message-ID: <202202121838.P5rALKEy-lkp@intel.com>
References: <alpine.DEB.2.21.2202062133570.34636@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2202062133570.34636@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Maciej,

I love your patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on usb/usb-testing v5.17-rc3 next-20220211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Maciej-W-Rozycki/serial-8250-Correct-basic-issues-with-the-PCI-blacklist/20220212-164230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220212/202202121838.P5rALKEy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c7eb84634519e6497be42f5fe323f9a04ed67127)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/aa68e36c332457acb464b083c920d10f0e5a9865
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Maciej-W-Rozycki/serial-8250-Correct-basic-issues-with-the-PCI-blacklist/20220212-164230
        git checkout aa68e36c332457acb464b083c920d10f0e5a9865
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_pci.c:3535:32: error: initializer element is not a compile-time constant
           { PCI_DEVICE(0x4348, 0x7053), REPORT_CONFIG(PARPORT_SERIAL), },
                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/8250/8250_pci.c:3522:2: note: expanded from macro 'REPORT_CONFIG'
           (IS_ENABLED(CONFIG_##option) ? 0 : (kernel_ulong_t)&#option)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +3535 drivers/tty/serial/8250/8250_pci.c

  3520	
  3521	#define REPORT_CONFIG(option) \
  3522		(IS_ENABLED(CONFIG_##option) ? 0 : (kernel_ulong_t)&#option)
  3523	#define REPORT_8250_CONFIG(option) \
  3524		(IS_ENABLED(CONFIG_SERIAL_8250_##option) ? \
  3525		 0 : (kernel_ulong_t)&"SERIAL_8250_"#option)
  3526	
  3527	static const struct pci_device_id blacklist[] = {
  3528		/* softmodems */
  3529		{ PCI_VDEVICE(AL, 0x5457), }, /* ALi Corporation M5457 AC'97 Modem */
  3530		{ PCI_VDEVICE(MOTOROLA, 0x3052), }, /* Motorola Si3052-based modem */
  3531		{ PCI_DEVICE(0x1543, 0x3052), }, /* Si3052-based modem, default IDs */
  3532	
  3533		/* multi-io cards handled by parport_serial */
  3534		/* WCH CH353 2S1P */
> 3535		{ PCI_DEVICE(0x4348, 0x7053), REPORT_CONFIG(PARPORT_SERIAL), },
  3536		/* WCH CH353 1S1P */
  3537		{ PCI_DEVICE(0x4348, 0x5053), REPORT_CONFIG(PARPORT_SERIAL), },
  3538		/* WCH CH382 2S1P */
  3539		{ PCI_DEVICE(0x1c00, 0x3250), REPORT_CONFIG(PARPORT_SERIAL), },
  3540	
  3541		/* Intel platforms with MID UART */
  3542		{ PCI_VDEVICE(INTEL, 0x081b), REPORT_8250_CONFIG(MID), },
  3543		{ PCI_VDEVICE(INTEL, 0x081c), REPORT_8250_CONFIG(MID), },
  3544		{ PCI_VDEVICE(INTEL, 0x081d), REPORT_8250_CONFIG(MID), },
  3545		{ PCI_VDEVICE(INTEL, 0x1191), REPORT_8250_CONFIG(MID), },
  3546		{ PCI_VDEVICE(INTEL, 0x18d8), REPORT_8250_CONFIG(MID), },
  3547		{ PCI_VDEVICE(INTEL, 0x19d8), REPORT_8250_CONFIG(MID), },
  3548	
  3549		/* Intel platforms with DesignWare UART */
  3550		{ PCI_VDEVICE(INTEL, 0x0936), REPORT_8250_CONFIG(LPSS), },
  3551		{ PCI_VDEVICE(INTEL, 0x0f0a), REPORT_8250_CONFIG(LPSS), },
  3552		{ PCI_VDEVICE(INTEL, 0x0f0c), REPORT_8250_CONFIG(LPSS), },
  3553		{ PCI_VDEVICE(INTEL, 0x228a), REPORT_8250_CONFIG(LPSS), },
  3554		{ PCI_VDEVICE(INTEL, 0x228c), REPORT_8250_CONFIG(LPSS), },
  3555		{ PCI_VDEVICE(INTEL, 0x4b96), REPORT_8250_CONFIG(LPSS), },
  3556		{ PCI_VDEVICE(INTEL, 0x4b97), REPORT_8250_CONFIG(LPSS), },
  3557		{ PCI_VDEVICE(INTEL, 0x4b98), REPORT_8250_CONFIG(LPSS), },
  3558		{ PCI_VDEVICE(INTEL, 0x4b99), REPORT_8250_CONFIG(LPSS), },
  3559		{ PCI_VDEVICE(INTEL, 0x4b9a), REPORT_8250_CONFIG(LPSS), },
  3560		{ PCI_VDEVICE(INTEL, 0x4b9b), REPORT_8250_CONFIG(LPSS), },
  3561		{ PCI_VDEVICE(INTEL, 0x9ce3), REPORT_8250_CONFIG(LPSS), },
  3562		{ PCI_VDEVICE(INTEL, 0x9ce4), REPORT_8250_CONFIG(LPSS), },
  3563	
  3564		/* Exar devices */
  3565		{ PCI_VDEVICE(EXAR, PCI_ANY_ID), REPORT_8250_CONFIG(EXAR), },
  3566		{ PCI_VDEVICE(COMMTECH, PCI_ANY_ID), REPORT_8250_CONFIG(EXAR), },
  3567	
  3568		/* Pericom devices */
  3569		{ PCI_VDEVICE(PERICOM, PCI_ANY_ID), REPORT_8250_CONFIG(PERICOM), },
  3570		{ PCI_VDEVICE(ACCESSIO, PCI_ANY_ID), REPORT_8250_CONFIG(PERICOM), },
  3571	
  3572		/* End of the black list */
  3573		{ }
  3574	};
  3575	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
