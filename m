Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F564D2A48
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiCIIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiCIIEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:04:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BBB443E3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646812991; x=1678348991;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z7z7kfSXI27fbHo4U2icD+FttVjXzELiWAu+O3A/ZCU=;
  b=NIHfhgpQdw3yb7FmeDJLbzTISPvVtjpwp5GLzCUMX7z6MmwgXh8NtkDH
   G9kZ+alNlmvV9nfo+dU5Y8aiQEnoN00nZNIeJHped4/ZbSpGkbZfy0dOV
   18/md2wTYdWUPfSDTreML3z4TtktCTjVIlkZT6ezwIiGHbSmg9BcJDxej
   0aFuRgLf6ikHeuQmQVWgLJR9ObmwuimZCL0G020L++jxDvAoYI73ydX3I
   RHlecjmek+4C065pAIZYibpA58cliHieV2JYan9HzOJGMgKN7h3ci/VBO
   Esh6YmLPzyEGn/cPVWLtg0OPd3qwxrcoHZjphuEuvDQvN9PlfnZinEFQA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253746052"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="253746052"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 00:02:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="596187237"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2022 00:02:58 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRrHd-0002sy-U5; Wed, 09 Mar 2022 08:02:57 +0000
Date:   Wed, 9 Mar 2022 16:02:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 50/54] mips-linux-ld:
 fs/cifs/file.o:undefined reference to `netfs_invalidatepage'
Message-ID: <202203091557.kAVHVqyJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   2842e665b5eef341d10584ea2b8c4877b9141587
commit: a80918300e1cb9538bea4a225c7a45fe75f4678a [50/54] netfs: Provide invalidatepage and releasepage calls
config: mips-bmips_be_defconfig (https://download.01.org/0day-ci/archive/20220309/202203091557.kAVHVqyJ-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/a80918300e1cb9538bea4a225c7a45fe75f4678a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout a80918300e1cb9538bea4a225c7a45fe75f4678a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mips-linux-ld: fs/cifs/file.o:(.rodata+0xd4): undefined reference to `netfs_invalidatepage'
>> mips-linux-ld: fs/cifs/file.o:(.rodata+0xd8): undefined reference to `netfs_releasepage'
   mips-linux-ld: fs/cifs/file.o:(.rodata+0x12c): undefined reference to `netfs_invalidatepage'
   mips-linux-ld: fs/cifs/file.o:(.rodata+0x130): undefined reference to `netfs_releasepage'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
