Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A60492D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347960AbiARSVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:21:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:29151 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347740AbiARSVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642530100; x=1674066100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EdNqGv3xnFii2TmxzYZKP/EMaaoub73SmUvUqBfCqpo=;
  b=LY0QywZpO8V3/ue0/pBOzLytn41r8QIQ4gwArOqyKtwscleZK/eeVNtT
   CvnODNw0qnhiKuomi/FrK5jhaq9TjNIaA/KeBusurmB0y0UX0n7Q3YTMx
   Flo1E+suGFi37gYqWMS5qW2DZQpckGh6/fZP6ICms47kZpNcbkdZcST7X
   nLtdv121c9kjPdKRimJ/sZSnGGs4sZHhyvg9AtN3tDUXRz83gM0x/Y4Cx
   TLwTXh5rluy0iSLKfezL50M8wb4JJbnwRBcUynv0fAaAZCiQDIhlRh6pj
   xNkGanrln4sC5Ao3oFr0FUO+tQcaeRWGLhXZzxqbSVImE8uo94hm2DmHz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="305615131"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="305615131"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 10:21:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="477079482"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Jan 2022 10:21:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9t6N-000CpV-Dr; Tue, 18 Jan 2022 18:21:03 +0000
Date:   Wed, 19 Jan 2022 02:20:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 19/23] ERROR:
 modpost: "netfs_invalidatepage" [fs/cifs/cifs.ko] undefined!
Message-ID: <202201190252.29bOuDYN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   e229088c2bc0ba29fdff1bc737506aed6ec50581
commit: eab3170e20c001ee23073a8705db22713b529c21 [19/23] netfs: Provide invalidatepage and releasepage calls
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20220119/202201190252.29bOuDYN-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/eab3170e20c001ee23073a8705db22713b529c21
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout eab3170e20c001ee23073a8705db22713b529c21
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "netfs_releasepage" [fs/cifs/cifs.ko] undefined!
>> ERROR: modpost: "netfs_invalidatepage" [fs/cifs/cifs.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
