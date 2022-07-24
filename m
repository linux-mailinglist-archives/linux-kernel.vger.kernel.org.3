Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5D57F5FC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiGXQVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 12:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:21:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D399101F4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658679671; x=1690215671;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=68I9TlIjaf+ZiKbRkY/eYJ5y3EbpwZfWUtEzzcbAvP4=;
  b=V30nc5EjSUXE5zli6NrWMf8tIoNN1pv2Bu3/le+TMmKn/bssRybuF+Ru
   xFZYfBIMjW12DsbVdP/EYAyhJECdTNWDkAw0x1yA8uUH2gLqD8j4qiZrE
   F6xfpsyUQhLTnyNX8li1WlZDNMeWrhMOji77AzDGQ+ZEsohJK9fgg3Hli
   IB6HHoinWYtkufBp5cQ5gefccPwKaKPcAD8IRCV5wnyp+m8dt62JvQjB6
   9yjDJBUqU3/0twG3JhkFaRRH4lwSLNKxgnjRJjs1AhEa+kOJaq1kx57l1
   nBAow8qMWCNjxdMSi75Wa73+QyOxdB8elzp9oEJKa0D2TnRtptRPH4U9T
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288314263"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="288314263"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 09:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="667212046"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2022 09:21:08 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFeLs-000412-04;
        Sun, 24 Jul 2022 16:21:08 +0000
Date:   Mon, 25 Jul 2022 00:20:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/clocksource/timer-nps.c:84:52: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202207250025.oCc99b1T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   1 year, 11 months ago
config: openrisc-randconfig-s051-20220724 (https://download.01.org/0day-ci/archive/20220725/202207250025.oCc99b1T-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f28ca6bd8211214faf717677bbffe375c2a6072
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/clk/imx/ drivers/clocksource/ drivers/media/ drivers/mfd/ drivers/phy/mediatek/ drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/clocksource/timer-nps.c:84:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void * @@
   drivers/clocksource/timer-nps.c:84:52: sparse:     expected void const [noderef] __iomem *
   drivers/clocksource/timer-nps.c:84:52: sparse:     got void *
   drivers/clocksource/timer-nps.c:103:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got void ** @@
   drivers/clocksource/timer-nps.c:103:37: sparse:     expected void [noderef] __iomem *
   drivers/clocksource/timer-nps.c:103:37: sparse:     got void **
--
>> drivers/tty/serial/ucc_uart.c:264:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     expected void const [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:264:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:268:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     expected void const [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:268:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:286:6: sparse: sparse: symbol 'qe_uart_set_mctrl' was not declared. Should it be static?
   drivers/tty/serial/ucc_uart.c:347:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:347:17: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:347:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void const [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:348:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:348:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:350:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     expected void const [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:350:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:369:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     expected void const [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:369:18: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:382:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:382:17: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:382:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected void const [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:383:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:383:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:386:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     expected void const [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:474:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     expected void const [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:481:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     expected void const [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     expected void const [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:604:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:604:17: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:604:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:605:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:605:17: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:605:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:606:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:606:17: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:606:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:612:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:612:9: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:612:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:613:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:613:9: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:613:9: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:614:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:614:9: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:614:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:625:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:625:17: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:625:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:626:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:626:17: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:626:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:627:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:627:17: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:627:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:637:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:637:9: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:637:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:638:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:638:9: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:638:9: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:639:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:639:9: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:639:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:653:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ucc_uart_pram *uccup @@     got struct ucc_uart_pram [noderef] __iomem *uccup @@
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     expected struct ucc_uart_pram *uccup
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     got struct ucc_uart_pram [noderef] __iomem *uccup
   drivers/tty/serial/ucc_uart.c:661:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:661:9: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:661:9: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:662:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:662:9: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:662:9: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:663:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:663:9: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:663:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:664:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:664:9: sparse:     expected void [noderef] __iomem *
   drivers/tty/serial/ucc_uart.c:664:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:665:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got restricted __be16 * @@

vim +84 drivers/clocksource/timer-nps.c

a53224577e317d Noam Camus      2015-10-17  79  
a5a1d1c2914b53 Thomas Gleixner 2016-12-21  80  static u64 nps_clksrc_read(struct clocksource *clksrc)
a53224577e317d Noam Camus      2015-10-17  81  {
a53224577e317d Noam Camus      2015-10-17  82  	int cluster = raw_smp_processor_id() >> NPS_CLUSTER_OFFSET;
a53224577e317d Noam Camus      2015-10-17  83  
a5a1d1c2914b53 Thomas Gleixner 2016-12-21 @84  	return (u64)ioread32be(nps_msu_reg_low_addr[cluster]);
a53224577e317d Noam Camus      2015-10-17  85  }
a53224577e317d Noam Camus      2015-10-17  86  

:::::: The code at line 84 was first introduced by commit
:::::: a5a1d1c2914b5316924c7893eb683a5420ebd3be clocksource: Use a plain u64 instead of cycle_t

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
