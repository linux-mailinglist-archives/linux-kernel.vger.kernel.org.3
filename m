Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB08E57D6C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiGUWUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiGUWUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:20:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E598A32459
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658442044; x=1689978044;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fZ6kCAH+2wgY/q5oh18R0MM0Nc9/cIncOyti+4hq3HE=;
  b=lLsPAVchS5DRlNvKCdnBcF5m19vS3/OItilPp4WtcO/9T6ZLHQhC0sY3
   XiwsdeXkIPsKFy5K6XcvV6QMAN+I0bWjzKWGrg3ycR/Fies3uTV6Y+b4l
   jopKNhVScIR07QMDM9SB7s8HoP60w4D1XGc6WFYg36orasxOEO5leXbZD
   WXw6cji1byqZo4CR+rkt/X1fKGmW4QQsOxGQE5Z5KiWLkNcucOqH1NMBG
   kgBNUweTY8dJe85EFAZeDfm2mGltM2Ez3TNPIIks5frAUWNwa8V2QQ7Ia
   78f4y0XN7jbuxqPtoEu8kT0j+N+g1sQosypS9HqpiLJkClR8aqkHxr4LO
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="266958409"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="266958409"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 15:20:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="573930595"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2022 15:20:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEeXB-0000do-2r;
        Thu, 21 Jul 2022 22:20:41 +0000
Date:   Fri, 22 Jul 2022 06:20:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 644/7104] synclink.c:undefined
 reference to `free_dma'
Message-ID: <202207220652.CGm6UUjK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   7748091a31277b35d55bffa6fecda439d8526366
commit: 87ae522e467e17a13b796e2cb595f9c3943e4d5e [644/7104] m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch
config: m68k-randconfig-r011-20220721 (https://download.01.org/0day-ci/archive/20220722/202207220652.CGm6UUjK-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=87ae522e467e17a13b796e2cb595f9c3943e4d5e
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout 87ae522e467e17a13b796e2cb595f9c3943e4d5e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: section .rodata VMA [0000000000002000,00000000005fa837] overlaps section .text VMA [0000000000000400,0000000000ffa6bf]
   m68k-linux-ld: drivers/tty/synclink.o: in function `mgsl_release_resources':
>> synclink.c:(.text+0xd1a): undefined reference to `free_dma'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
