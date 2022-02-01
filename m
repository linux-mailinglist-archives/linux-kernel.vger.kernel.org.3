Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A582F4A5926
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbiBAJZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:25:32 -0500
Received: from mga07.intel.com ([134.134.136.100]:43060 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235822AbiBAJZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643707531; x=1675243531;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DTd887lRJLK2q+0GzomTQxzGarAtyLH+xvkN94NP8Z0=;
  b=JAqieAP5Ft0tziFRRoQ2mEPlFZn21wyH+nko7UeQqQVQ9PavFNN5Rr9N
   +h8OAMHjst0vqYcDPMV71uj6FHJiLoykD3HNb5aOwRxfDHhddS2isz9xj
   PKFn0nEw9RIF5BChkMzIeZE5xV1tKR2WnF9+MM8ML+ignEklU32NHRQFz
   ToAPK/ljJnrzVaRxoQkW6fLR7i6cLleJ5ftpfZ1WOqFNNjME+Y9f56w+S
   GjA6jkij+YBN8MEoDvN85EdlJWuSiw5eGknRoanmsIG1PRQLnSCzyx340
   Gvxrtjzj8PoO6TLU/CbpfsfSWdWa4EoTGlVBSnkmAnzgT35WZgLt0sMDA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="310959309"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="310959309"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="479592060"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 01:25:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEpPk-000T3j-HU; Tue, 01 Feb 2022 09:25:28 +0000
Date:   Tue, 1 Feb 2022 17:24:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tri Vo <trong@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 5870/5871] arm-linux-gnueabi-ld: trusty-ipc.c:undefined reference to
 `trusty_dma_buf_get_shared_mem_id'
Message-ID: <202202011726.KY34w4dH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   b60d55f33484d855a546f7cfc59a28a5771e8bee
commit: 629a4d3318cc1234675f62b69fba8791592e8a83 [5870/5871] ANDROID: trusty: Support setting trusty_shared_mem_id_t
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202011726.KY34w4dH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/629a4d3318cc1234675f62b69fba8791592e8a83
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout 629a4d3318cc1234675f62b69fba8791592e8a83
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/trusty/trusty-ipc.o: in function `dn_share_fd':
   trusty-ipc.c:(.text+0x2a5c): undefined reference to `trusty_dma_buf_get_ffa_tag'
>> arm-linux-gnueabi-ld: trusty-ipc.c:(.text+0x2a70): undefined reference to `trusty_dma_buf_get_shared_mem_id'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
