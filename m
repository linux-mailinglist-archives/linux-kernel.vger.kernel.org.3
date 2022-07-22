Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D7957E244
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiGVNWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:22:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A814093
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658496168; x=1690032168;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4dCRYxzaSN3QlF3PmmCPrNOQ9lt9BRBjpw+0cUrvqJ0=;
  b=LoWpDyQeu5Yzn75vhVmSwhKwZesF740GEQpz+uVgPdMYBU20SXl8pn2t
   Yuoa9F+8RuK+DGu+TgM8ke9+JwisIwWEDH29Il5/k2Wmovh5zBiqrAV3W
   lreK+c0dN9LWkM+irFaKzfGAN1FXaJo86Q9tmBT2g39hLaMJ8Ka29u7rT
   fwwqH5Ixst3rf1IqAoptzgXvZaMrG/ahAqLUz5t8zb5RkDVU/kW0QqMCE
   C/jnuPBtwM/Nz4yh+bityDTh+82eINDmV21HXqq7lAl41mdngzmpTEN87
   kLRo1OY9JFdXTHBU389OmwMm/Mr2i/YVitEhzxhKGqdwymcBAryWzhZhE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="351305197"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="351305197"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 06:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="631562556"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Jul 2022 06:22:47 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEscA-0001T0-1F;
        Fri, 22 Jul 2022 13:22:46 +0000
Date:   Fri, 22 Jul 2022 21:22:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kbusch:dma-prereg-v3-wip 5/6] arc-elf-ld: rsrc.c:undefined
 reference to `io_dma_unmap'
Message-ID: <202207222145.oh14nNlu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git dma-prereg-v3-wip
head:   4625fa7adf745334c0a2eb635121d587df797b29
commit: 1390adeaee356151aeb13383e6ee1ad1c5798816 [5/6] io_uring: add support for dma pre-mapping
config: arc-randconfig-s041-20220721 (https://download.01.org/0day-ci/archive/20220722/202207222145.oh14nNlu-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?id=1390adeaee356151aeb13383e6ee1ad1c5798816
        git remote add kbusch https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git
        git fetch --no-tags kbusch dma-prereg-v3-wip
        git checkout 1390adeaee356151aeb13383e6ee1ad1c5798816
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: arc-elf-ld: DWARF error: could not find abbrev number 1914737
   io_uring/rsrc.o: in function `io_buffer_unmap':
   rsrc.c:(.text+0x2a6): undefined reference to `io_dma_unmap'
>> arc-elf-ld: rsrc.c:(.text+0x2a6): undefined reference to `io_dma_unmap'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
