Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156A849D92B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiA0DYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:24:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:16377 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbiA0DYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643253887; x=1674789887;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s4jpnYs5i69T36siDuV5ywAUICKH+ahbI+kLEbUj4pg=;
  b=Wnmihun8gxCl2fy8mptjrskL0w7bgQnXHlqOrchHjxtV4bnInIFJeK+b
   yX+MMrX7tqqM9NM9iCBLeDk5oFZsSNcTJ/1LAPYWAQGSInwgTwaEXlHru
   H70JLNSOdLpCUTP+dnDaJTrucYoKezSZiYVKPl7izBHSCF0lMmS0xxhKV
   mqZ6WLUTtNnQ/nB/L5xCMLqthydgkuZCXM7jq1oaGD3G/yrx7NVq4yLSz
   IuhnWn6x++kVb6ICkOZ+kT95ODprudbSGHDoC8oDfEV/bs9bmIsZ93tew
   EIlkSswCqsqyIMw9XCdSSSyBYeCm/yt3jZ1BoeOQMGNC7zGlQJIQ8S3o1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230309565"
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="230309565"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 19:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,319,1635231600"; 
   d="scan'208";a="477712690"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2022 19:24:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCvOk-000M2I-Ck; Thu, 27 Jan 2022 03:24:34 +0000
Date:   Thu, 27 Jan 2022 11:23:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [intel-tdx:host-upstream 3/18] arch/x86/include/asm/seam.h:
 asm/processor.h is included more than once.
Message-ID: <202201271144.mT6UC48t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git host-upstream
head:   6806a9874cdac7e51e15c056986098bf94a062aa
commit: 7dc55ba05dbca07f34a17fe63b9b04a01544c7f3 [3/18] x86/cpu: Implement the SEAMCALL base function
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/x86/include/asm/seam.h: asm/processor.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
