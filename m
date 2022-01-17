Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB104905F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiAQKbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:31:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:31401 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233539AbiAQKbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642415493; x=1673951493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DLt/oq7kjKruuc4+LDlZyKeZllSdx75zWhl5DKre2hQ=;
  b=JQG8kFM4nrvfAUr5gk2GZMl27YgW5tLfcX6dqEVedg8xzoSgaoEScxpg
   LzEyzjru2/OxoQUaDYwUvJ3AdidF0PiATQvhN0PKUgzKMigSV9TeL07Hp
   yCnKesyY2uDlLo7kO2D0lka5lWws/Z/IhZbXJq/DN83siUsZr/ML5rzk3
   DCan76L0JArKYUV2CSuokljAMgkvYuRPn29yhG29YuGtLO20Jlw81IbEu
   eFgyvzyehrYTupSmwaAR+K9DS8pZ1vkZ6lD1PuhYwuyxnIUY65EJGC2TK
   IRcNlf75raZHZ/0lMabYF9FvNVs8sRNO8LOr8d4nX2rNQV+KZHlTd04ID
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="242157240"
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="242157240"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 02:31:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="476601332"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2022 02:31:31 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9PIQ-000BTk-Is; Mon, 17 Jan 2022 10:31:30 +0000
Date:   Mon, 17 Jan 2022 18:30:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 28/30] drivers/tty/mxser.c:1745:30: warning: unused
 variable 'mxser_ops'
Message-ID: <202201171837.2mMV7e7n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   f297a9ec220495933237083fbf2333eca65eb9b4
commit: c2f304d1e4750e106a884544dfd7539b4853edf5 [28/30] mxser: switch to uart_driver
config: arm-randconfig-r003-20220116 (https://download.01.org/0day-ci/archive/20220117/202201171837.2mMV7e7n-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=c2f304d1e4750e106a884544dfd7539b4853edf5
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout c2f304d1e4750e106a884544dfd7539b4853edf5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/tty/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/mxser.c:1745:30: warning: unused variable 'mxser_ops' [-Wunused-const-variable]
   static const struct uart_ops mxser_ops = {
                                ^
   1 warning generated.


vim +/mxser_ops +1745 drivers/tty/mxser.c

  1744	
> 1745	static const struct uart_ops mxser_ops = {
  1746		.tx_empty       = mxser_tx_empty,
  1747		//.get_mctrl      = mxser_get_mctrl,
  1748		//.set_mctrl      = mxser_set_mctrl,
  1749		.stop_tx        = mxser_stop_tx,
  1750		.start_tx       = mxser_start_tx,
  1751		.stop_rx        = mxser_stop_rx,
  1752		.break_ctl      = mxser_break_ctl,
  1753		.startup        = mxser_startup,
  1754		.shutdown       = mxser_shutdown,
  1755		.set_termios    = mxser_set_termios,
  1756		//.pm             = mxser_pm,
  1757		//.type           = mxser_type,
  1758		//.release_port   = mxser_release_port,
  1759		//.request_port   = mxser_request_port,
  1760		//.config_port    = mxser_config_port,
  1761		//.verify_port    = mxser_verify_port,
  1762	};
  1763	
  1764	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
