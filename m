Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3A4EB674
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbiC2XFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiC2XFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:05:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A61153709
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648595013; x=1680131013;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JYC7kZewls0EUBMwCBbLh1pyA6+WveQyyxh7VsX4Siw=;
  b=Jc/VM58gNgh0zZ1LcFEmgXyH1YD8IVYMG2MVyf2fsZTP6SRemGFmE6fG
   00MdvCWh5fZWYUMXZgicNKyAzePq6PrIKaOjnoeMZQEgGZK+FRjvm2Eix
   eIssn5cqOy5B+xDs1QGYYZ+jgHQC3w8UZq1tswlZJVZHqypAIArzwMvKv
   q2IOfyXVXa4DDppKDR7CFkiQRhprH+sFU7BB2Ai7UVhYlrldiuj1Ut1ZP
   stb6A0WM/B/FiRja+LqjP4gp/jXZq/LoVOCZJmCsl8vsTXXUxstRAlXsI
   JfQ6BoRb3kvq3lNm9+fd5zIfSUwlGbVxjJ5EyRNgqT9UCpmM5m83DotZs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="246895042"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="246895042"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 16:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="546606956"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2022 16:03:31 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZKs6-0000kz-Is; Tue, 29 Mar 2022 23:03:30 +0000
Date:   Wed, 30 Mar 2022 07:02:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sh4-linux-gcc: error: unrecognized command-line option
 '-Wout-of-line-declaration'; did you mean '-Wold-style-declaration'?
Message-ID: <202203300652.dL6NnB77-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13776ebb9964b2ea66ffb8c824c0762eed6da784
commit: 6e5be40d32fb1907285277c02e74493ed43d77fe fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
date:   8 months ago
config: sh-randconfig-r032-20220330 (https://download.01.org/0day-ci/archive/20220330/202203300652.dL6NnB77-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5be40d32fb1907285277c02e74493ed43d77fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5be40d32fb1907285277c02e74493ed43d77fe
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> sh4-linux-gcc: error: unrecognized command-line option '-Wout-of-line-declaration'; did you mean '-Wold-style-declaration'?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
