Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37254EBCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbiC3IsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiC3IsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:48:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D14C9D0CA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648629977; x=1680165977;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p0bW8i7nB1wL8ak5JGJbJXx5i649tPQ/PXE1pNl7Q/4=;
  b=f9rO6SWt9uA0ev3CX0bX99Z+Ow7X+DwkJSlcTyR70LTUcUORNb8omrGr
   Klbb1S1lw3TZQ2vBL44mFqvQr9FOyOS6TlHPX3jLJI314iBxZC8sTy7++
   dLq7ayL4YN4XxbGtZpk9QaFdUSu8NN2i1D2OnF1OGUZ05gJTv6T+vCOFm
   xVU6V3iIuGcU6vdC80PUccPL59r4agmaiUVVTb+Bl3iht1cpOm860MfSx
   TH6AAmIViAzfojI4gkFmtrEVJmc9HN91Z5PWIBjfpTx1Bq9EE9qSHQI16
   QsYy9wMyqdL3i0S32YaZeAbB8ZMEfCsMlkuAN6Oq2kfHXSA75+ser7EBr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322667664"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="322667664"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 01:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="519589908"
Received: from lkp-server02.sh.intel.com (HELO 7a008980c4ea) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2022 01:46:15 -0700
Received: from kbuild by 7a008980c4ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZTy3-00009V-07; Wed, 30 Mar 2022 08:46:15 +0000
Date:   Wed, 30 Mar 2022 16:45:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Min Li <min.li.xe@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: powerpc64le-linux-ld: warning: orphan section `.stubs' from
 `drivers/mfd/rsmu_core.o' being placed in section `.stubs'
Message-ID: <202203301636.wTL7GMsj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   965181d7ef7e1a863477536dc328c23a7ebc8a1d
commit: a1867f85e06edacd82956d3422caa2b9074f4321 mfd: Add Renesas Synchronization Management Unit (SMU) support
date:   9 months ago
config: powerpc64-randconfig-r012-20220329 (https://download.01.org/0day-ci/archive/20220330/202203301636.wTL7GMsj-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1867f85e06edacd82956d3422caa2b9074f4321
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1867f85e06edacd82956d3422caa2b9074f4321
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/mfd/rsmu_core.o' being placed in section `.stubs'
>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/mfd/rsmu_core.o' being placed in section `.stubs'
>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/mfd/rsmu_core.o' being placed in section `.stubs'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
