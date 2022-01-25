Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003BB49A8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319902AbiAYDJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:09:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:54892 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1315599AbiAYCxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643079232; x=1674615232;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UoCuvw3w2BM2aEqWp16vgbE/rRS3x3FZ2GO5SqEMH08=;
  b=lwwUBkHnQ/2iku9qA58Unb5lI1Uh8JopoH8oCb79DZRtEif3v61Wv22K
   SrrIt7TJ5a4BExU9ezlXcnYt3IqwI1OylzXDiE5ujKAYHKyTrWsb6e2xd
   OWXOEUWo+P9Utu39b/tmmrs/QcNyKLtTZTTKif+mlhU/SCdd2GGSpJDEN
   bJnOgR08YMiHBWv218SoGpgeVcqEt2cPcStdjdMyoYQmgo+EddrpFT8Lf
   yWDzBSLUAdgJsLmU6E5bvKTaFAHNy0PjJ4YLGoYcNfmFC9XUwaWr+/K4+
   HWqraH5CvYIA8KuY/hYv+2uCbmM/qjd1OIFHY9RvE9DBKjlfICMy8T75T
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226872346"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="226872346"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 18:36:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="617464132"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2022 18:36:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCBgx-000JEf-5P; Tue, 25 Jan 2022 02:36:19 +0000
Date:   Tue, 25 Jan 2022 10:35:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: fs/proc/base.c:1767:14-18: WARNING: casting value returned by memory
 allocation function to (char *) is useless.
Message-ID: <202201250941.1xbLnDRA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220123-215907/Hao-Lee/proc-use-kmalloc-instead-of-__get_free_page-to-alloc-path-buffer/20220123-181005
head:   98106e76de95ae9aefa914ec056448a5571155dc
commit: 98106e76de95ae9aefa914ec056448a5571155dc proc: alloc PATH_MAX bytes for /proc/${pid}/fd/ symlinks
date:   35 hours ago
config: i386-randconfig-c001-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250941.1xbLnDRA-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> fs/proc/base.c:1767:14-18: WARNING: casting value returned by memory allocation function to (char *) is useless.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
