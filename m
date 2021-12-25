Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B17D47F46A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 21:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhLYUou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 15:44:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:39892 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhLYUot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 15:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640465089; x=1672001089;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uhv/HjV5aHoLgons/I7STq0fjEebXVNFzh8ACXoie7U=;
  b=VHtPp61h9EEE1LTFzZ5xCn6bezQfKYEbiEwyX9GWo9lGyIXwx5oq6mVF
   fqjKEb9CclCDWaOgtg+631u5kEIo191vi6r2yN7+whwlG0enf1E2F/Yvs
   PYIFF0TRkBBJCuCpt+AkFFkc87pTW+MQJa8Lv5FjS/HyiLN1dQK62dPSG
   kx48XGjzkf0cSv1b7FUUJ96loh+8dUmKaBQD1KrRy7bUCYKFnyRMwupyt
   t14dvjQkn+cpbI8cQwIvLhgNNseXeWcNtFI4bZpGoNBG5kYlmQRWBAHlE
   xIPq+R/A8n7MHUekMq3j0rC8Q4/XSuDlfwTsYqZeqBtr6UOSpy0Ye5L/0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="228369366"
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="228369366"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2021 12:44:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,236,1635231600"; 
   d="scan'208";a="509437400"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Dec 2021 12:44:48 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1DuJ-0004ft-F1; Sat, 25 Dec 2021 20:44:47 +0000
Date:   Sun, 26 Dec 2021 04:43:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [l1k:rs485_fixes 2/5] drivers/tty/serial/8250/8250_alpha.c:6:6:
 warning: no previous prototype for 'alpha_jensen_machine'
Message-ID: <202112260407.JHmHBph5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux rs485_fixes
head:   a62f8fcb06b22e357034ec7dc1835d5e54f62aee
commit: ede7cb8cc196acdc42e495e9805291b8d5190468 [2/5] serial: 8250: Move Alpha-specific quirk out of the core
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20211226/202112260407.JHmHBph5-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/ede7cb8cc196acdc42e495e9805291b8d5190468
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k rs485_fixes
        git checkout ede7cb8cc196acdc42e495e9805291b8d5190468
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_alpha.c:6:6: warning: no previous prototype for 'alpha_jensen_machine' [-Wmissing-prototypes]
       6 | bool alpha_jensen_machine(void)
         |      ^~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_alpha.c:11:6: warning: no previous prototype for 'alpha_jensen_set_mctrl' [-Wmissing-prototypes]
      11 | void alpha_jensen_set_mctrl(struct uart_port *port, unsigned int mctrl)
         |      ^~~~~~~~~~~~~~~~~~~~~~


vim +/alpha_jensen_machine +6 drivers/tty/serial/8250/8250_alpha.c

     5	
   > 6	bool alpha_jensen_machine(void)
     7	{
     8		return !strcmp(alpha_mv.vector_name, "Jensen");
     9	}
    10	
  > 11	void alpha_jensen_set_mctrl(struct uart_port *port, unsigned int mctrl)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
