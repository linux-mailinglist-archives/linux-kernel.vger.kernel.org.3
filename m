Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17834934D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351678AbiASGHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:07:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:46040 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350118AbiASGHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642572442; x=1674108442;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fjrscCIOoxbeIy51NH775oFUOIHV/de70txgdZkNLEk=;
  b=TLsuklvUz8YfuaCyB8uRu2d4mqqWEqHBQxAlq5HJjxLY8mKjNmpXerfn
   RjOFgftk9Zx3P4Rn63LcZB4Ym4tHDZKkJgKaiqBLGffu/dHzmhqAvOKnL
   Vwuuy153ejwEaL/HJo91cjr6ZSmHPggGB6mAoj/RuxVfZJtDpqOQlBAVd
   G4ix5axUf01h3COBnbRFhaiwDOupLs0CBE2Gz0M5MqV19NA62B5cploQW
   z+XlGRxZAVbjtqgQI5tgx3/XDRZeDBjRhVZjuRuDdUHo/bL2N55BajPbw
   MJtQo9QKp3M1qrGj+Htw/dkuSsa/nPiiHuUzhSSxa+z+cwN5SZx2mpApy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="224970690"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="224970690"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 22:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="477252912"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Jan 2022 22:07:20 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA47r-000DJy-Mz; Wed, 19 Jan 2022 06:07:19 +0000
Date:   Wed, 19 Jan 2022 14:07:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 73/80]
 drivers/nvdla/nvdla_core_callbacks.c:437:3-8: No need to set .owner here.
 The core will do it.
Message-ID: <202201191448.hkrxXxgW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   e46c3a7e373e6faa03399f1a41c29cf7546c37cb
commit: 72b025fa3bbfeb4e6df66d1753182be5d8ac2374 [73/80] nvdla: Support compilation as module
config: alpha-randconfig-c003-20220119 (https://download.01.org/0day-ci/archive/20220119/202201191448.hkrxXxgW-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/nvdla/nvdla_core_callbacks.c:437:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
