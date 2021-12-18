Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E905D479B73
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhLROpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 09:45:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:6848 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhLROpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 09:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639838750; x=1671374750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wikn4a3PlHA25MqM2SHJEZ4eTxooJQogy5sKuMKZyG4=;
  b=QPhUGEBE/jlZtz/PcMfqM2LTt494rzfUahktjBVrWEPRn1/A9jHm5SO+
   yxqv4dVnNnVEBSBn+BbWagwufbX//AhaDdlaML2R0YLFxXkAcYtndppg8
   d03btNT7tpjR+P03qJnh2CC5fKUKB6vzWr709tlCeB23r5fW88Vx3GjBZ
   wm6drtMBy/+jtGosyCpcZgEvMUYdsCFfsYCtYH7xM1kIEOzl+H5BDroSh
   TIqODG69lrG37Ffn43aGz2hZLk1z02W6uOgPLeTLTD7Xw4ci9MytcRETu
   PgQ3oCDJFford+CgmcYwGMc0pPI2GK6PDsBXKC6/X5XhheU6qUYLsreO5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="300702072"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="300702072"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 06:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="483548943"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Dec 2021 06:45:49 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myay4-00067t-E5; Sat, 18 Dec 2021 14:45:48 +0000
Date:   Sat, 18 Dec 2021 22:45:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:locking/debug-refcount 1/3] ERROR: modpost:
 "refcount_bad_magic" [fs/nfs/nfsv4.ko] undefined!
Message-ID: <202112182225.KmqljjpD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git locking/debug-refcount
head:   fb4984c339109f2ee2dd0000e7744aab91b974f5
commit: 488dd36233a4a0d80f516054ee894688fc8f447f [1/3] WIP: add DEBUG_REFCOUNT
config: x86_64-randconfig-r034-20211218 (https://download.01.org/0day-ci/archive/20211218/202112182225.KmqljjpD-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=488dd36233a4a0d80f516054ee894688fc8f447f
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark locking/debug-refcount
        git checkout 488dd36233a4a0d80f516054ee894688fc8f447f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "refcount_bad_magic" [fs/nfs/nfsv4.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
