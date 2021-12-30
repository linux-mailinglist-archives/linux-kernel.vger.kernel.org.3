Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC44819DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 06:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhL3Fwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 00:52:42 -0500
Received: from mga01.intel.com ([192.55.52.88]:35148 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhL3Fwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 00:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640843561; x=1672379561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=48SUI3doQSnryX4YpdDJpoGdbBod4TYaCJbA1gygGeI=;
  b=FwAkqjWpUgtDtVXgThR4Bf/o6yLVChrviPMQ7B7iJpOeFgeQ4YmxCLlP
   N8XJGqjZSCDWNoO4BgjJZv9m9+4oUV05BiX8XMVPgffSMUmjhPi6T6bOi
   vQF35uqszCYTZlY40VKkY6836TOMKUEG9EeqZlY/LG8L4ZGNo+26bWB1I
   AP8ZU4kAGscTExJ6Ii/po7C+7hrb68QPiwcpxCTiO/vtbwcaYrLtHgZSg
   32g7cr9x/JISws33a/GmWq2lZ2PSMXhXLADdMg47bVAWKW/+o9vfcbbEC
   gfXsB2p5XtoEiPg0Cd46vq35oALUIBSpVU8vANoWZbEnzN61LaCEAwFW5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="265864059"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="265864059"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 21:52:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="510780541"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Dec 2021 21:52:40 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2oMh-0009o2-Bu; Thu, 30 Dec 2021 05:52:39 +0000
Date:   Thu, 30 Dec 2021 13:52:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [goldwynr:iomap 24/33] fs/btrfs/file.c:485:22: error: initialization
 of 'void (*)(struct inode *, loff_t,  unsigned int,  struct page *)' {aka
 'void (*)(struct inode *, long long int,  unsigned int,  struct page *)'}
 from incompatible pointer type 'void (*)(struct inode *, loff...
Message-ID: <202112301342.KO6jKDK5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/goldwynr/linux iomap
head:   30c74a8c201365178cae26d0d7aefa120c3245ab
commit: 528f37bbbb59a7cf5ec08a7512eb7f86904e3684 [24/33] btrfs: define iomap_page_ops
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20211230/202112301342.KO6jKDK5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/goldwynr/linux/commit/528f37bbbb59a7cf5ec08a7512eb7f86904e3684
        git remote add goldwynr https://github.com/goldwynr/linux
        git fetch --no-tags goldwynr iomap
        git checkout 528f37bbbb59a7cf5ec08a7512eb7f86904e3684
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the goldwynr/iomap HEAD 30c74a8c201365178cae26d0d7aefa120c3245ab builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> fs/btrfs/file.c:485:22: error: initialization of 'void (*)(struct inode *, loff_t,  unsigned int,  struct page *)' {aka 'void (*)(struct inode *, long long int,  unsigned int,  struct page *)'} from incompatible pointer type 'void (*)(struct inode *, loff_t,  unsigned int,  struct page *, struct iomap *)' {aka 'void (*)(struct inode *, long long int,  unsigned int,  struct page *, struct iomap *)'} [-Werror=incompatible-pointer-types]
     485 |         .page_done = btrfs_page_done,
         |                      ^~~~~~~~~~~~~~~
   fs/btrfs/file.c:485:22: note: (near initialization for 'btrfs_iomap_page_ops.page_done')
   fs/btrfs/file.c: In function 'btrfs_buffered_iomap_end':
   fs/btrfs/file.c:1715:29: error: 'bi' redeclared as different kind of symbol
    1715 |         struct btrfs_iomap *bi = iomap->private;
         |                             ^~
   fs/btrfs/file.c:1712:69: note: previous definition of 'bi' with type 'struct btrfs_iomap *'
    1712 |                 loff_t length, ssize_t written, struct btrfs_iomap *bi)
         |                                                 ~~~~~~~~~~~~~~~~~~~~^~
   fs/btrfs/file.c:1715:34: error: 'iomap' undeclared (first use in this function)
    1715 |         struct btrfs_iomap *bi = iomap->private;
         |                                  ^~~~~
   fs/btrfs/file.c:1715:34: note: each undeclared identifier is reported only once for each function it appears in
   At top level:
   fs/btrfs/file.c:484:36: warning: 'btrfs_iomap_page_ops' defined but not used [-Wunused-const-variable=]
     484 | static const struct iomap_page_ops btrfs_iomap_page_ops = {
         |                                    ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +485 fs/btrfs/file.c

   483	
   484	static const struct iomap_page_ops btrfs_iomap_page_ops = {
 > 485		.page_done = btrfs_page_done,
   486	};
   487	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
