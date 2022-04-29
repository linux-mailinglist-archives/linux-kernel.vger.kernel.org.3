Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D97551487F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355723AbiD2Ltb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358547AbiD2Lt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:49:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFF0B3C4E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651232770; x=1682768770;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3IbAXj3Snp96wTIHJY4FRC89tWs6r31dabLj1bNt8ys=;
  b=dZJGprgEsZOcALzuvR4lNS/hcaRDVBB0R4hofyUZyy0peR+qAelYU7gS
   ZRUcKOWdvmR2N7XJ4XxZkOFYAMLD/sivjXEaGEp58Be1T620/AS4D+dJd
   ERph0fh0WSXYZ6RYga8JE2nS+JbUFbzd0FUN+innnPwmkF7IrPoGIponm
   38q03DZ9OB3SgShYjRpGwF0nEmyqOOZFZoJrC5M3ySKaIstTjZJqQjbIi
   FNPL9UcdslFyK05TN2JEN3CfZnXuiAzjyaXIZsgBWsVMJdtEyiEhqRfIN
   hfwwbfNsQYiNcamAUq+uK0fZCCW8TXoKCwK1faGZkv0LKhM6LUr9oc/Ah
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="327116496"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="327116496"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:46:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="597292421"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Apr 2022 04:46:08 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkP4Z-0006I5-LW;
        Fri, 29 Apr 2022 11:46:07 +0000
Date:   Fri, 29 Apr 2022 19:45:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 56/78] acpi.c:undefined reference to
 `devm_gen_pool_create'
Message-ID: <202204291941.rnY1BEGs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   9b688fc651b9d2b633e8d959454670aba1c39162
commit: 560e2708e4272ad7903fcd9696fca542c96301d5 [56/78] cxl/acpi: Handle address space allocation
config: ia64-randconfig-c023-20220429 (https://download.01.org/0day-ci/archive/20220429/202204291941.rnY1BEGs-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=560e2708e4272ad7903fcd9696fca542c96301d5
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 560e2708e4272ad7903fcd9696fca542c96301d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/cxl/acpi.o: in function `cxl_parse_cfmws':
>> acpi.c:(.text+0xd82): undefined reference to `devm_gen_pool_create'
>> ia64-linux-ld: acpi.c:(.text+0xed2): undefined reference to `gen_pool_add_owner'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
