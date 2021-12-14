Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8348474574
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhLNOpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:45:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:56467 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232847AbhLNOpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639493119; x=1671029119;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WQKrV4OzD0SqhBtmXwIJ1hykqV9B1YWEhM0wY7GOid8=;
  b=WxSKt/mEAapLseack/aNE+6cHUiaUMbOmUqXSnDInM3HSyYB9nLvmH1o
   oYgbqjfX6oR4Gd0JEdD486wIpd98ZafHwLeflAeaLPSJ90x/wAj9xLMN4
   8TltmrWNpyilnQb8ULq4FaN6LY1ioJLpS9cFjaXwgPB2tJn2Og8PYYa8f
   5ifKoU2t4p7F3YDPb/c2IC/gQb5L0NQDkSUn4B3+/miJefyXbqw/x7Cv4
   s5l+aU19u1oeINMuvvnJIuq8Bu5Lp2wV81v0uPWRE8Y/QEeymF1gpjd8Q
   B/dAs3K8bAWjwOmIHh9tVF2wCyc6oMo4BoTB3gb9kbbOw7eAc4Aj44tBJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302368706"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="302368706"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 06:45:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="505380509"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Dec 2021 06:45:10 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx93G-0000PT-0V; Tue, 14 Dec 2021 14:45:10 +0000
Date:   Tue, 14 Dec 2021 22:44:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/pinctrl/bcm/pinctrl-bcm2835.c:412:14: warning: variable
 'group' is used uninitialized whenever 'for' loop exits because its
 condition is false
Message-ID: <202112142208.QW0tVv0m-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
commit: 29d45a642d4ea8de7e89b57f856046df7c3b219f pinctrl: bcm2835: Replace BUG with BUG_ON
date:   5 months ago
config: mips-randconfig-c004-20211214 (https://download.01.org/0day-ci/archive/20211214/202112142208.QW0tVv0m-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a2ddb6c8ac29412b1361810972e15221fa021c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29d45a642d4ea8de7e89b57f856046df7c3b219f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 29d45a642d4ea8de7e89b57f856046df7c3b219f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/pinctrl/bcm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/bcm/pinctrl-bcm2835.c:412:14: warning: variable 'group' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
           for (i = 0; i < BCM2835_NUM_IRQS; i++) {
                       ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/bcm/pinctrl-bcm2835.c:423:10: note: uninitialized use occurs here
           switch (group) {
                   ^~~~~
   drivers/pinctrl/bcm/pinctrl-bcm2835.c:412:14: note: remove the condition if it is always true
           for (i = 0; i < BCM2835_NUM_IRQS; i++) {
                       ^~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/bcm/pinctrl-bcm2835.c:409:11: note: initialize the variable 'group' to silence this warning
           int group;
                    ^
                     = 0
   1 warning generated.


vim +412 drivers/pinctrl/bcm/pinctrl-bcm2835.c

00445b5d5866c7b drivers/pinctrl/bcm/pinctrl-bcm2835.c Phil Elwell    2015-02-24  402  
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  403  static void bcm2835_gpio_irq_handler(struct irq_desc *desc)
00445b5d5866c7b drivers/pinctrl/bcm/pinctrl-bcm2835.c Phil Elwell    2015-02-24  404  {
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  405  	struct gpio_chip *chip = irq_desc_get_handler_data(desc);
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  406  	struct bcm2835_pinctrl *pc = gpiochip_get_data(chip);
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  407  	struct irq_chip *host_chip = irq_desc_get_chip(desc);
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  408  	int irq = irq_desc_get_irq(desc);
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  409  	int group;
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  410  	int i;
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  411  
73345a18d464b1b drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2019-08-12 @412  	for (i = 0; i < BCM2835_NUM_IRQS; i++) {
73345a18d464b1b drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2019-08-12  413  		if (chip->irq.parents[i] == irq) {
0d885e9da176ad3 drivers/pinctrl/bcm/pinctrl-bcm2835.c Thierry Reding 2017-07-20  414  			group = i;
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  415  			break;
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  416  		}
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  417  	}
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  418  	/* This should not happen, every IRQ has a bank */
29d45a642d4ea8d drivers/pinctrl/bcm/pinctrl-bcm2835.c Jason Wang     2021-06-24  419  	BUG_ON(i == BCM2835_NUM_IRQS);
00445b5d5866c7b drivers/pinctrl/bcm/pinctrl-bcm2835.c Phil Elwell    2015-02-24  420  
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  421  	chained_irq_enter(host_chip, desc);
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  422  
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  423  	switch (group) {
00445b5d5866c7b drivers/pinctrl/bcm/pinctrl-bcm2835.c Phil Elwell    2015-02-24  424  	case 0: /* IRQ0 covers GPIOs 0-27 */
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  425  		bcm2835_gpio_irq_handle_bank(pc, 0, 0x0fffffff);
00445b5d5866c7b drivers/pinctrl/bcm/pinctrl-bcm2835.c Phil Elwell    2015-02-24  426  		break;
00445b5d5866c7b drivers/pinctrl/bcm/pinctrl-bcm2835.c Phil Elwell    2015-02-24  427  	case 1: /* IRQ1 covers GPIOs 28-45 */
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  428  		bcm2835_gpio_irq_handle_bank(pc, 0, 0xf0000000);
00445b5d5866c7b drivers/pinctrl/bcm/pinctrl-bcm2835.c Phil Elwell    2015-02-24  429  		bcm2835_gpio_irq_handle_bank(pc, 1, 0x00003fff);
00445b5d5866c7b drivers/pinctrl/bcm/pinctrl-bcm2835.c Phil Elwell    2015-02-24  430  		break;
b1d84a3d0a26c58 drivers/pinctrl/bcm/pinctrl-bcm2835.c Stefan Wahren  2020-02-08  431  	case 2: /* IRQ2 covers GPIOs 46-57 */
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  432  		bcm2835_gpio_irq_handle_bank(pc, 1, 0x003fc000);
00445b5d5866c7b drivers/pinctrl/bcm/pinctrl-bcm2835.c Phil Elwell    2015-02-24  433  		break;
00445b5d5866c7b drivers/pinctrl/bcm/pinctrl-bcm2835.c Phil Elwell    2015-02-24  434  	}
00445b5d5866c7b drivers/pinctrl/bcm/pinctrl-bcm2835.c Phil Elwell    2015-02-24  435  
85ae9e512f437cd drivers/pinctrl/bcm/pinctrl-bcm2835.c Linus Walleij  2016-11-14  436  	chained_irq_exit(host_chip, desc);
e1b2dc70cd5b00e drivers/pinctrl/pinctrl-bcm2835.c     Simon Arlott   2012-09-27  437  }
e1b2dc70cd5b00e drivers/pinctrl/pinctrl-bcm2835.c     Simon Arlott   2012-09-27  438  

:::::: The code at line 412 was first introduced by commit
:::::: 73345a18d464b1b945b29f54f630ace6873344e2 pinctrl: bcm2835: Pass irqchip when adding gpiochip

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
