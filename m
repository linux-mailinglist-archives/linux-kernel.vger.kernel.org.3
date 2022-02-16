Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBF44B7F12
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbiBPEAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:00:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbiBPEAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:00:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921B4FFF9B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644984027; x=1676520027;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=804JHE6Fv7atys+WOJVPF4T8Hi310vN125IFQ39rmtM=;
  b=FhT4dIymEW7XxH6AJMTzL2TvPntpy0F+939AqVCmiOpPYsLcdg8OPx5r
   BrEJw0iKhsB4uNDjU6ZkHk7HcWHt3W45tPhEDhKoHpbW5aQrDSziXcdG/
   6hmxjyT7hNWoXn8yUU3BApL0UF/Jrmka/dx6QC83ZolsNG0qPd7iFatOY
   V5fvVDJfyuLETxcGKwGnKDxvRgUvNCLCEKHgQ3piQMT3Jtf5dlnurRu+2
   1EoxvBkzDa9SASQjl+QjivNehI+RL/NDW8COxOV8O/sYigZ7F4itAekpg
   QVoWOeoKs3lItfI55XMlAoI5HDypJrPLuzR3iTSlkw/vK/PCOtIvMD9yl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="336950104"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="336950104"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 20:00:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="544675182"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 Feb 2022 20:00:23 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKBUM-000ANr-Q7; Wed, 16 Feb 2022 04:00:22 +0000
Date:   Wed, 16 Feb 2022 11:59:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 13/43]
 microblaze-linux-ld: fs/cifs/file.o:undefined reference to
 `netfs_invalidatepage'
Message-ID: <202202161121.d9Sn2Iuf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   d40df0841e9f8de3713a19dd3f0ba283c860cb93
commit: 60665769a5330f764ee6d9428f67a6e19f06c67b [13/43] netfs: Provide invalidatepage and releasepage calls
config: microblaze-mmu_defconfig (https://download.01.org/0day-ci/archive/20220216/202202161121.d9Sn2Iuf-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/60665769a5330f764ee6d9428f67a6e19f06c67b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 60665769a5330f764ee6d9428f67a6e19f06c67b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> microblaze-linux-ld: fs/cifs/file.o:(.rodata+0x470): undefined reference to `netfs_invalidatepage'
>> microblaze-linux-ld: fs/cifs/file.o:(.rodata+0x474): undefined reference to `netfs_releasepage'
   microblaze-linux-ld: fs/cifs/file.o:(.rodata+0x4c8): undefined reference to `netfs_invalidatepage'
   microblaze-linux-ld: fs/cifs/file.o:(.rodata+0x4cc): undefined reference to `netfs_releasepage'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
