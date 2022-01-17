Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9147491081
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242794AbiAQSzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:55:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:11989 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbiAQSzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642445747; x=1673981747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rSSDTIAen0zDd6kEhdfoILJM56+4S6HFTy7KKtUouJM=;
  b=aZGXvDZyHrryTyb0QhJRkjLvdcjgUHlqwIjcGmYajIxabdyMIrmT02pP
   wxsDNIHcQxyrKdseAF8rHIvDI45MsIlYUhA7bw2fOyKMLfQ34DdSinY2s
   G86EqwpRYgrg/BGhPheE6oVLeBm0mkB1cbNmTU6ldSq2PShn+vQpaZMs/
   COL2aujh3PE8oUz0MJ3dinTbqNCCYnWLA6T0WzP/q0K/6a35AKZ4LMu0j
   sJduiWpXbxL4A3iGGd4njHJ7zFpT12L6+GBTQDBGXFjmQclgxfYy9sOC7
   6oj6IZev5lhMDxYZr9LjAD96MBaOGT9x8Cz/oOWtC8I9sFO+cAgX/6odF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244475536"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="244475536"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="594872834"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jan 2022 10:55:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9XAO-000Bmq-QO; Mon, 17 Jan 2022 18:55:44 +0000
Date:   Tue, 18 Jan 2022 02:54:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 20/24]
 xtensa-linux-ld: fs/fscache/stats.o:undefined reference to
 `netfs_stats_show'
Message-ID: <202201180236.bFOg48wO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   12617e48874cc7e301b04f65b22b762cca3aea01
commit: d775438577aaab8808eaf4cfb2963d941a439b8b [20/24] netfs, fscache: Make netfslib depend on fscache
config: xtensa-randconfig-r021-20220116 (https://download.01.org/0day-ci/archive/20220118/202201180236.bFOg48wO-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/d775438577aaab8808eaf4cfb2963d941a439b8b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout d775438577aaab8808eaf4cfb2963d941a439b8b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: fs/fscache/stats.o:(.text+0xac): undefined reference to `netfs_stats_show'
   xtensa-linux-ld: fs/fscache/stats.o: in function `fscache_stats_show':
>> stats.c:(.text+0x1a7): undefined reference to `netfs_stats_show'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
