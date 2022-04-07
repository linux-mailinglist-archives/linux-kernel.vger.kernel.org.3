Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4509B4F7918
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbiDGIHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242826AbiDGIG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:06:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC713FC8A9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649318677; x=1680854677;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z/jh/VxxcB6amwAjfylzfnVSfhqabz32P6DVxjoUfFQ=;
  b=K/6qQp0MNuXZYe3043TbDrlAqjYNVG10+phbMtaasQwTwZMGTJCB/muA
   pqz3GRaC0hwZe2yD6yxK3Bl68ldcRyW+2C6kFE0RN+MDf0LSSXqhXzvpN
   lBDPLWM+YlrAoxtSQImUDVgfAQKwhphpoSDPaXqTwgbNw1w0WGPxJitYq
   mso7HGit3KBTTCytb4hh9lNAPVETNsnkN+okoJyMQx3Ztu7WbOswIq2RG
   vEGYobET/ZrED4ht/ZgoLmxD1ElMaLjSQCcntrRrSkAo4IX/2UbGn431u
   Y0oAggSebgSq8c8mefz6T3INzcaJ2tDTqJFc0ebtdX7Nl4IBM19LHCdeN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="261436651"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="261436651"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 01:04:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="524821482"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Apr 2022 01:04:35 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncN86-0005Dt-CP;
        Thu, 07 Apr 2022 08:04:34 +0000
Date:   Thu, 7 Apr 2022 16:03:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 56/78] ERROR: modpost: "devm_gen_pool_create"
 [drivers/cxl/cxl_acpi.ko] undefined!
Message-ID: <202204071653.MbrvaMBt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   9b688fc651b9d2b633e8d959454670aba1c39162
commit: 560e2708e4272ad7903fcd9696fca542c96301d5 [56/78] cxl/acpi: Handle address space allocation
config: ia64-buildonly-randconfig-r004-20220406 (https://download.01.org/0day-ci/archive/20220407/202204071653.MbrvaMBt-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=560e2708e4272ad7903fcd9696fca542c96301d5
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 560e2708e4272ad7903fcd9696fca542c96301d5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_gen_pool_create" [drivers/cxl/cxl_acpi.ko] undefined!
>> ERROR: modpost: "gen_pool_add_owner" [drivers/cxl/cxl_acpi.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
