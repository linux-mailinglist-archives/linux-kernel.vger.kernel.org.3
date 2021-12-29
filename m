Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0282480F74
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 04:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbhL2Dyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 22:54:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:58291 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238638AbhL2Dyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 22:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640750079; x=1672286079;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Obldt47fSwUPtbvXE4eQtLyxuXuYT0csaygn336YVTE=;
  b=hOU7zL/lnOBBZAUhtVYRu+CeZ1KYicgyyGjcG1qSUuUnqBAg5YGJWH9G
   T18nisQM6lf+qKIxmsF+xNhNl6Jx5HymOF8XsxVBto8Go61oVwogCYMEZ
   eh/KPc+r/szmS8f4ESxKrjQYI7tCocKvvMrwsuflEt8TzEXUqAu7hyDzs
   lBg7V9CUrIhZXQLJYjvECAE7O6dNi6ET2stfzPUe8naSrki/NxoZeMn+9
   MDqPzQCsrKQLeE/Utztj3UNz0QrC/7t1qjM2dELneskY9q8vRIk9v3DAs
   G/LouO4CoB2PR/rYmBHUGUPoBaBU1nL1epcFHyOiCa2sERfSYsXAoHZT0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="221454215"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="221454215"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 19:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="510370696"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Dec 2021 19:54:36 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2Q2t-0008Mp-JU; Wed, 29 Dec 2021 03:54:35 +0000
Date:   Wed, 29 Dec 2021 11:53:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [luto:sched/lazymm 12/17] idle.c:undefined reference to
 `unlazy_mm_irqs_off'
Message-ID: <202112291114.HDvxVLxl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git sched/lazymm
head:   fbea7977edc16ae85f8e2255b084bc2403801327
commit: a3d2a94bc79f367c31d3962f3957dfe0ded13b58 [12/17] Rework "sched/core: Fix illegal RCU from offline CPUs"
config: arm-randconfig-c002-20211229 (https://download.01.org/0day-ci/archive/20211229/202112291114.HDvxVLxl-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?id=a3d2a94bc79f367c31d3962f3957dfe0ded13b58
        git remote add luto https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git
        git fetch --no-tags luto sched/lazymm
        git checkout a3d2a94bc79f367c31d3962f3957dfe0ded13b58
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: kernel/sched/idle.o: in function `do_idle':
>> idle.c:(.text+0x348): undefined reference to `unlazy_mm_irqs_off'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
