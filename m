Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF62B4C0E31
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbiBWIZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiBWIZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:25:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC6669CF7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645604722; x=1677140722;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sUIJizs+jsV9BZI9X1fxroEL3Cg5oANWcK9QUyljVuo=;
  b=hJmkzeHW8Fqn6FGHzQgD6qHEHsH995Q510aMZo/O2Z8SDPn/Mmi0Q/3a
   wY1YR9JBPeX7fnEtiHLxpDUvh0jzR5V//8J/4+wCnCGPEwVjmClM1F89H
   0R6AcfvSsC27XSJ7/yJKBcQw7+DsQ5/IyyP8iasfwzv3qLiQGbdqtB0gS
   2k5I7jD7SbOeF7Gl1SG9Jgf/ROIsUnhXW8b/w44osz/a9qykPObFz3T1k
   0r7qyLcWmd2EO1tdj1H0oIJM+xz5IAUZNU25TYBuxGHvWMItEVO/LDUR6
   BJH0x0dgQKDLhNxCc6nogvzbq9Xu9GvlGE4HGewal4GULc3Yp4rqH14F9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251648886"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="251648886"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 00:25:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="776596195"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2022 00:25:20 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMmxb-00019t-VN; Wed, 23 Feb 2022 08:25:19 +0000
Date:   Wed, 23 Feb 2022 16:24:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [boqun:dev/arm64 4/4] ERROR: modpost: "memory_block_size_bytes"
 [drivers/hv/hv_balloon.ko] undefined!
Message-ID: <202202231610.E8BW2Nc5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git dev/arm64
head:   abd696a42824ab4956b5f81bbfdfa54c4ef28d88
commit: abd696a42824ab4956b5f81bbfdfa54c4ef28d88 [4/4] Drivers: hv: balloon: Support memory hot add for larger page sizes
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220223/202202231610.E8BW2Nc5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/commit/?id=abd696a42824ab4956b5f81bbfdfa54c4ef28d88
        git remote add boqun https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git
        git fetch --no-tags boqun dev/arm64
        git checkout abd696a42824ab4956b5f81bbfdfa54c4ef28d88
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "memory_block_size_bytes" [drivers/hv/hv_balloon.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
