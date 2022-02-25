Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE8C4C44DD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbiBYMsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbiBYMsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:48:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42B5673F7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645793289; x=1677329289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0UzBsK8y2iQaAbuzl+TvKEQv2YG32E6hH7WzIhC5PH4=;
  b=kV+io/canr0En6/SSpJnEAskCZMS640yLj8XxFjYzfEQjSSS+lm7vEcC
   shBzobm1R08hBX2RjQSvfUIxuV+qZjNrvT/ZGtrS2T/Li32kygQ5RYDCd
   H+IV5NhxbWorW5tr/zhyDiU7aZM4UqMb5giM2xIdYmDNiCIfO31eeXRH0
   3z5Ns4VtUJ36JkUhmSYmC0odQlFKCzB1LF0QAOkFQpZrisHD4QkLubV73
   vfaIRHQi/VLbJq3J3LL1G9CMrV7hACPMTWyJUDV1Jw8hMCRpL0V3mqjMt
   QXoSox+w7RcUX2/mbHI679CJL8g+IO3WJ4T0K3W4RF3meiBojavnJ0qvG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="251317862"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="251317862"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 04:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="491969037"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Feb 2022 04:48:07 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNa11-0004JI-6C; Fri, 25 Feb 2022 12:48:07 +0000
Date:   Fri, 25 Feb 2022 20:47:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: ld.lld: error: undefined symbol: pci_remap_iospace
Message-ID: <202202252051.nEOp7nyy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   53ab78cd6d5aba25575a7cfb95729336ba9497d8
commit: 09d97da660ff77df20984496aa0abcd6b88819f2 MIPS: Only define pci_remap_iospace() for Ralink
date:   3 months ago
config: mips-randconfig-r006-20220225 (https://download.01.org/0day-ci/archive/20220225/202202252051.nEOp7nyy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09d97da660ff77df20984496aa0abcd6b88819f2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09d97da660ff77df20984496aa0abcd6b88819f2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: pci_remap_iospace
   >>> referenced by pci.c
   >>>               pci/pci.o:(devm_pci_remap_iospace) in archive drivers/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
