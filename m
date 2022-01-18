Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBCF492E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348737AbiARTXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:23:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:19705 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347785AbiARTXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642533788; x=1674069788;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fam4jN08KIoBl1JR2iTduOH2dhjyiiVlYfvy4wb1B8c=;
  b=RjCDwASBWnUGIZoJe9BTyjcHuyDO9t8SIdF9R9wuBy5J6h1lCKheMfrY
   RV6mh9Jjro+TUSrC8LoHRhe+bipWHQ7zpE/A8HvYV2n1Ad22Zmbh9BCBj
   AS1ps0haCQebZ6OaLokHJ6wDbk33Kk2YN55rOlFEXkN3unvJj9hnCPW6d
   8B23YMA8NF+T0/J+tgVtPunDaM55SNJvNe5CNI4OiRYknQY5/HPG+AHCR
   JRIv2qBFKZ+cGhyCG3F0tDItZ8ZNjhz8jkAA2tTP31H36ZdRIlP3JD9zL
   lfe/oesGwRJ1Zzf13ZxUBo1AQJ6bB7/fiGjrsylsT0Twqv4G2yUfrjQ6P
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244852787"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="244852787"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 11:23:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="625612298"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2022 11:23:06 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9u4P-000Ct0-Es; Tue, 18 Jan 2022 19:23:05 +0000
Date:   Wed, 19 Jan 2022 03:22:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 19/23] ld:
 fs/cifs/file.o:undefined reference to `netfs_invalidatepage'
Message-ID: <202201190316.hRrB5y0R-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20220119/202201190316.hRrB5y0R-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/eab3170e20c001ee23073a8705db22713b529c21
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout eab3170e20c001ee23073a8705db22713b529c21
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld: fs/cifs/file.o:(.rodata+0x288): undefined reference to `netfs_invalidatepage'
>> ld: fs/cifs/file.o:(.rodata+0x290): undefined reference to `netfs_releasepage'
   ld: fs/cifs/file.o:(.rodata+0x348): undefined reference to `netfs_invalidatepage'
   ld: fs/cifs/file.o:(.rodata+0x350): undefined reference to `netfs_releasepage'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
