Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0A47CA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhLVAIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:08:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:57995 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhLVAIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640131703; x=1671667703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+Kd6+3r82uqMPpSHVeUAT9puU51gS5ltwJhFAyXCn1M=;
  b=WlDJbKuFlYRoD9ZUWa5RSj5oIcFoWCGDyPJd52Y2c7BzUk42BGmsZKjC
   rrorPgd6USANgF/+A0AL9V0ucGEOBxUVLiWfjqec1SMdsi630rt3f6BwQ
   6enaRxw7Y6VhBCEwVROl3Tr6EA0Qv/TSlgh7LpaLKjWvppPLo77xi0ZbN
   VOu8PfdsugxfrzIunE44LeSbupjClfK2DOmhSGk1ALhnGG6T0ZJlbNGAG
   YucHm+9zuH+Exp89bk6/UzrTAatw4k3FIpK+SlwVTidnmcs9hyU5uauGq
   x1m+RZTGIYORRqbO//WOwRstZe2JOVcAdcsqdKJOnpfYQ9sZv2LIFhVMm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240468592"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="240468592"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 16:08:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="684835939"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 16:08:21 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzpB6-0009gG-FV; Wed, 22 Dec 2021 00:08:20 +0000
Date:   Wed, 22 Dec 2021 08:07:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [axboe-block:nvme-passthru-wip.2 15/23] exit.c:(.text+0xac0):
 multiple definition of `io_uring_cmd_import_fixed';
 kernel/fork.o:fork.c:(.text+0x600): first defined here
Message-ID: <202112220837.r55Kf9nN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git nvme-passthru-wip.2
head:   7567defdb3c6a81e4114a03ddf3d6c158df81a76
commit: bc18161c9b80cf2d647710257f9716ee6c66fee4 [15/23] io_uring: add flag and helper for fixed-buffer uring-cmd
config: nds32-randconfig-r032-20211220 (https://download.01.org/0day-ci/archive/20211222/202112220837.r55Kf9nN-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=bc18161c9b80cf2d647710257f9716ee6c66fee4
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block nvme-passthru-wip.2
        git checkout bc18161c9b80cf2d647710257f9716ee6c66fee4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: kernel/exit.o: in function `io_uring_cmd_import_fixed':
>> exit.c:(.text+0xac0): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x600): first defined here
   nds32le-linux-ld: fs/exec.o: in function `io_uring_cmd_import_fixed':
   exec.c:(.text+0x19c0): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x600): first defined here
   nds32le-linux-ld: block/fops.o: in function `io_uring_cmd_import_fixed':
   fops.c:(.text+0x1480): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x600): first defined here
   nds32le-linux-ld: drivers/nvme/host/core.o: in function `io_uring_cmd_import_fixed':
   core.c:(.text+0x2d00): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x600): first defined here
   nds32le-linux-ld: drivers/nvme/host/ioctl.o: in function `io_uring_cmd_import_fixed':
   ioctl.c:(.text+0x980): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x600): first defined here
   nds32le-linux-ld: drivers/nvme/host/multipath.o: in function `io_uring_cmd_import_fixed':
   multipath.c:(.text+0xa00): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x600): first defined here
   nds32le-linux-ld: drivers/nvme/host/fabrics.o: in function `io_uring_cmd_import_fixed':
   fabrics.c:(.text+0xb40): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x600): first defined here
   nds32le-linux-ld: drivers/nvme/host/fc.o: in function `io_uring_cmd_import_fixed':
   fc.c:(.text+0x4740): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x600): first defined here
   nds32le-linux-ld: drivers/nvme/target/passthru.o: in function `io_uring_cmd_import_fixed':
   passthru.c:(.text+0x780): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x600): first defined here
   nds32le-linux-ld: drivers/nvme/target/fcloop.o: in function `io_uring_cmd_import_fixed':
   fcloop.c:(.text+0x2240): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x600): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
