Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D9646D770
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhLHP5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:57:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:20265 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhLHP5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:57:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="225112741"
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="225112741"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 07:53:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,189,1635231600"; 
   d="scan'208";a="462807092"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2021 07:53:49 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muzGO-0000l2-Ko; Wed, 08 Dec 2021 15:53:48 +0000
Date:   Wed, 8 Dec 2021 23:53:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 8/19] drivers/tty/mxser.c:1784:30: warning: unused
 variable 'mxser_ops'
Message-ID: <202112082345.v46Z3TI4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   e07aaf938405b723f435206c00fcc50a11a70399
commit: f22cec00dbd414f61389ec805a29e70e55b9d84a [8/19] mxser: switch to uart_driver
config: i386-buildonly-randconfig-r002-20211208 (https://download.01.org/0day-ci/archive/20211208/202112082345.v46Z3TI4-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=f22cec00dbd414f61389ec805a29e70e55b9d84a
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout f22cec00dbd414f61389ec805a29e70e55b9d84a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/tty/mxser.c:377:13: warning: unused function 'mxser_must_no_sw_flow_control' [-Wunused-function]
   static void mxser_must_no_sw_flow_control(unsigned long baseio)
               ^
   drivers/tty/mxser.c:591:13: warning: unused function 'mxser_change_speed' [-Wunused-function]
   static void mxser_change_speed(struct tty_struct *tty,
               ^
   drivers/tty/mxser.c:1394:13: warning: unused function 'mxser_start' [-Wunused-function]
   static void mxser_start(struct tty_struct *tty)
               ^
>> drivers/tty/mxser.c:1784:30: warning: unused variable 'mxser_ops' [-Wunused-const-variable]
   static const struct uart_ops mxser_ops = {
                                ^
   4 warnings generated.


vim +/mxser_ops +1784 drivers/tty/mxser.c

  1783	
> 1784	static const struct uart_ops mxser_ops = {
  1785		.tx_empty       = mxser_tx_empty,
  1786		//.get_mctrl      = mxser_get_mctrl,
  1787		//.set_mctrl      = mxser_set_mctrl,
  1788		.stop_tx        = mxser_stop_tx,
  1789		.start_tx       = mxser_start_tx,
  1790		.stop_rx        = mxser_stop_rx,
  1791		.break_ctl      = mxser_break_ctl,
  1792		//.startup        = mxser_startup,
  1793		//.shutdown       = mxser_shutdown,
  1794		.set_termios    = mxser_set_termios,
  1795		//.pm             = mxser_pm,
  1796		//.type           = mxser_type,
  1797		//.release_port   = mxser_release_port,
  1798		//.request_port   = mxser_request_port,
  1799		//.config_port    = mxser_config_port,
  1800		//.verify_port    = mxser_verify_port,
  1801	};
  1802	
  1803	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
