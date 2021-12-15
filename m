Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991F4475AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbhLOOpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:45:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:43960 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhLOOpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639579506; x=1671115506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZHmEESDH4aNsqmxsYKHweXgwqdjm2ni2LH+24NGm0iw=;
  b=dGjgE+sMZjr66yuSoG51SvQlkvX1s0cSvylfv7ARBB3TI9LKQfv328kA
   kmeHJcCs8rVCOxVXmgBvc9me3aLBEjHfwUXZB3/EZZoNv9vzXNZLK0iCs
   FQA75NrVXDMe3iT6md6bRjqVguAe6XTi2JkWtxEvkIu+zhhlLgySPpQPY
   ysC65Uq2fj8RGOkCYgqchoCPKjOTSL3IYCFm3St717NnFIafM6q08JhUd
   lZ44pSG0pRWzkaFPRjOxr+8xpeo6cL4IextE3ORhhadn49h+15dIMvGkT
   ypQhKZcqkG7wk0bEDzjzL+vgyBTobPQL0VX31QWT4HykR7FmElG7GAouI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="239051795"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="239051795"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 06:45:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="505826955"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2021 06:45:04 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxVWh-0001tu-4F; Wed, 15 Dec 2021 14:45:03 +0000
Date:   Wed, 15 Dec 2021 22:44:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 8/33] drivers/tty/tty_port.c:228:2: warning:
 'xmit_buf' is deprecated
Message-ID: <202112152217.TA9FNAE3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   d61595c5423534810c1a3c0d4a88dd2fd81d750c
commit: 8825023d7d2eb9e5dc298ad1996a0c753b2c4580 [8/33] tty: add kfifo to tty_port
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211215/202112152217.TA9FNAE3-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=8825023d7d2eb9e5dc298ad1996a0c753b2c4580
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 8825023d7d2eb9e5dc298ad1996a0c753b2c4580
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/tty/tty_port.c: In function 'tty_port_alloc_xmit_buf':
>> drivers/tty/tty_port.c:228:2: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     228 |  if (port->xmit_buf == NULL)
         |  ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:18: note: declared here
     115 |   unsigned char *xmit_buf __attribute__((deprecated));
         |                  ^~~~~~~~
   drivers/tty/tty_port.c:229:3: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     229 |   port->xmit_buf = (unsigned char *)get_zeroed_page(GFP_KERNEL);
         |   ^~~~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:18: note: declared here
     115 |   unsigned char *xmit_buf __attribute__((deprecated));
         |                  ^~~~~~~~
   drivers/tty/tty_port.c:231:2: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     231 |  if (port->xmit_buf == NULL)
         |  ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:18: note: declared here
     115 |   unsigned char *xmit_buf __attribute__((deprecated));
         |                  ^~~~~~~~
   drivers/tty/tty_port.c: In function 'tty_port_free_xmit_buf':
   drivers/tty/tty_port.c:240:2: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     240 |  if (port->xmit_buf != NULL) {
         |  ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:18: note: declared here
     115 |   unsigned char *xmit_buf __attribute__((deprecated));
         |                  ^~~~~~~~
   drivers/tty/tty_port.c:241:3: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     241 |   free_page((unsigned long)port->xmit_buf);
         |   ^~~~~~~~~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:18: note: declared here
     115 |   unsigned char *xmit_buf __attribute__((deprecated));
         |                  ^~~~~~~~
   drivers/tty/tty_port.c:242:3: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     242 |   port->xmit_buf = NULL;
         |   ^~~~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:18: note: declared here
     115 |   unsigned char *xmit_buf __attribute__((deprecated));
         |                  ^~~~~~~~
   drivers/tty/tty_port.c: In function 'tty_port_destructor':
   drivers/tty/tty_port.c:270:2: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     270 |  if (port->xmit_buf)
         |  ^~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:18: note: declared here
     115 |   unsigned char *xmit_buf __attribute__((deprecated));
         |                  ^~~~~~~~
   drivers/tty/tty_port.c:271:3: warning: 'xmit_buf' is deprecated [-Wdeprecated-declarations]
     271 |   free_page((unsigned long)port->xmit_buf);
         |   ^~~~~~~~~
   In file included from include/linux/tty.h:12,
                    from drivers/tty/tty_port.c:8:
   include/linux/tty_port.h:115:18: note: declared here
     115 |   unsigned char *xmit_buf __attribute__((deprecated));
         |                  ^~~~~~~~


vim +/xmit_buf +228 drivers/tty/tty_port.c

8cde11b2baa1d0 drivers/tty/tty_port.c  Johan Hovold 2017-05-18  223  
9e48565d217a8a drivers/char/tty_port.c Alan Cox     2008-10-13  224  int tty_port_alloc_xmit_buf(struct tty_port *port)
9e48565d217a8a drivers/char/tty_port.c Alan Cox     2008-10-13  225  {
9e48565d217a8a drivers/char/tty_port.c Alan Cox     2008-10-13  226  	/* We may sleep in get_zeroed_page() */
44e4909e453eaa drivers/char/tty_port.c Alan Cox     2009-11-30  227  	mutex_lock(&port->buf_mutex);
9e48565d217a8a drivers/char/tty_port.c Alan Cox     2008-10-13 @228  	if (port->xmit_buf == NULL)
9e48565d217a8a drivers/char/tty_port.c Alan Cox     2008-10-13  229  		port->xmit_buf = (unsigned char *)get_zeroed_page(GFP_KERNEL);
44e4909e453eaa drivers/char/tty_port.c Alan Cox     2009-11-30  230  	mutex_unlock(&port->buf_mutex);
9e48565d217a8a drivers/char/tty_port.c Alan Cox     2008-10-13  231  	if (port->xmit_buf == NULL)
9e48565d217a8a drivers/char/tty_port.c Alan Cox     2008-10-13  232  		return -ENOMEM;
9e48565d217a8a drivers/char/tty_port.c Alan Cox     2008-10-13  233  	return 0;
9e48565d217a8a drivers/char/tty_port.c Alan Cox     2008-10-13  234  }
9e48565d217a8a drivers/char/tty_port.c Alan Cox     2008-10-13  235  EXPORT_SYMBOL(tty_port_alloc_xmit_buf);
9e48565d217a8a drivers/char/tty_port.c Alan Cox     2008-10-13  236  

:::::: The code at line 228 was first introduced by commit
:::::: 9e48565d217a8a96cc7577308ad41e9e4b806a62 tty: Split tty_port into its own file

:::::: TO: Alan Cox <alan@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
