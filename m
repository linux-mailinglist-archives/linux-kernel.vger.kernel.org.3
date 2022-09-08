Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86265B18CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiIHJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIHJfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:35:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BD80518
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662629702; x=1694165702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TpB5Sk4RBR+2csj8kKHu8sAl9l0ACTj6KlP2wLJp+Pc=;
  b=F7hQvDA3991oksLpwX6sb0MSusAitMqMdgQ31adSeo7bE6bl8cqz0LlR
   gVQNshuyV4YyzMsKgWVaItsgIqJmINiF+QqkwcWrt8D9ZDKF2zGvEC90g
   mcRIPsRNxOvLd43SXTyZLdsC5qxvgd1T5LVoLu7AhHRxI3FcWQqlwzznP
   nWsq0fG6BFNTHjNEdhZzkqOodvnzNqjVPba607Y8mTbhhvGFMiI7gLItA
   CVj20not9O54ZHAQyOP585pei1oVdTNIpdCfj7cVmVZ6R60uvnhHkXLIW
   R0aPiv6z81SZrThCpOVhPvtiUX002cVupLWENSASWiYDN9i0msR8jHXmF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="323315791"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="323315791"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 02:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="943272403"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2022 02:34:59 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWDw3-0007aR-17;
        Thu, 08 Sep 2022 09:34:59 +0000
Date:   Thu, 8 Sep 2022 17:34:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: ERROR: modpost: "memory_add_physaddr_to_nid"
 [drivers/cxl/cxl_pmem.ko] undefined!
Message-ID: <202209081723.xJqTfeTJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0066f1b0e27556381402db3ff31f85d2a2265858
commit: 04ad63f086d1a9649b8b082748cbc7a570ade461 cxl/region: Introduce cxl_pmem_region objects
date:   6 weeks ago
config: ia64-buildonly-randconfig-r003-20220908 (https://download.01.org/0day-ci/archive/20220908/202209081723.xJqTfeTJ-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04ad63f086d1a9649b8b082748cbc7a570ade461
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 04ad63f086d1a9649b8b082748cbc7a570ade461
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/cxl/cxl_pmem.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
