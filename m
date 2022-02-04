Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006BB4A9201
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356480AbiBDB3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:29:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:23556 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbiBDB3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643938186; x=1675474186;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y88CjnUzV8lPWNYW0FnLbuUocjczJl17KyjNIiH5oPQ=;
  b=QU5lhcOS0yYzoAOF9hwbnGJrBwSBTOk0bkOf6hEEviwSp3nnrO1Ft46k
   BROMtDjHJGqczyy71SP3oUYcXu/vn15ekr9XraByCx2NS84mEWuj2272/
   clnZPHJcKQkFcKL2v4eenPY+TrSWLVQsFA+PN6+RyJlVY605MyMEWQJLb
   nevkJJz48KK9rrTCqnV6OjxJ1iw7P6bFjiAAKrtwUkGFvzQylayMI275U
   Tvk4o/h71AmcBFTc8uDG0g3voUt1O1kumX/q/IA7XD8idF4K9F96wdfwG
   z9tf2lia+UPX/W1z6q1yZpypfy9PVn2QRgecape2Dsmsr0SyDboVI/k6A
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="228943972"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="228943972"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:29:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="583993797"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Feb 2022 17:29:44 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFnQ0-000WtW-BQ; Fri, 04 Feb 2022 01:29:44 +0000
Date:   Fri, 4 Feb 2022 09:29:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 27/29] ERROR: modpost: "uart_port_tx" [vmlinux] is
 a static EXPORT_SYMBOL
Message-ID: <202202040313.zFpGQpCn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   4c13e2f9afce43aef0685eb559a8fc64dc40aa03
commit: 684fee07c7f9eee78841ae735e5df419cd07aa57 [27/29] tty: serial, add uart_port_tx helper
config: x86_64-randconfig-a004-20220131 (https://download.01.org/0day-ci/archive/20220204/202202040313.zFpGQpCn-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=684fee07c7f9eee78841ae735e5df419cd07aa57
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 684fee07c7f9eee78841ae735e5df419cd07aa57
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "uart_port_tx" [vmlinux] is a static EXPORT_SYMBOL

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
