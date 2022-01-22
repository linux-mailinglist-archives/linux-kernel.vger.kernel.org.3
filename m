Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF5496990
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 04:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiAVD0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 22:26:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:57797 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbiAVD0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 22:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642821977; x=1674357977;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hvbyBPLaWxCgYB8n0BNxNTrP+W6kLiBb+EWWPodux5A=;
  b=cuucnEdWMIeDWT/vBHwuItdPRaRNaMVmzpN4sogc7wdEctDkhomhoCkL
   zeT7k7W2Bm6QqdnDEZhhHjDFnnHLHMHLTreRgwGGtgnHPHoZZAhnwT67r
   uawHOoS06+dOoXn0Sf6uA4eoPphzEhckFShwiRFyKoIwfST1ha1s9Cfdk
   dZgP37pWdEW3XqPZz9FaonyaO/FL4iaow2J0lDYpwVxFyme/eBSoPXzAx
   a1cBERbiB7FBIjfyKRnqqZKiTlK4euRRYUKXEKAA40m/WLVjRQmNUe8SG
   q5U5I7UWj6kmzbdXfVvD78ezCsqtT1yzhhpJuLF0xb8NQYf/mSoP5Jp58
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="332139142"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="332139142"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 19:26:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="626939085"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Jan 2022 19:26:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB72c-000Fy0-L3; Sat, 22 Jan 2022 03:26:14 +0000
Date:   Sat, 22 Jan 2022 11:26:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: drivers/nvme/host/fabrics.c:1095:5-8: Unneeded variable: "ret".
 Return "0" on line 1109
Message-ID: <202201221116.hWZkKqts-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b57f458985742bd1c585f4c7f36d04634ce1143
commit: f18ee3d988157ebcadc9b7e5fd34811938f50223 nvme-fabrics: print out valid arguments when reading from /dev/nvme-fabrics
date:   4 weeks ago
config: x86_64-randconfig-c022-20220117 (https://download.01.org/0day-ci/archive/20220122/202201221116.hWZkKqts-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/nvme/host/fabrics.c:1095:5-8: Unneeded variable: "ret". Return "0" on line 1109

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
