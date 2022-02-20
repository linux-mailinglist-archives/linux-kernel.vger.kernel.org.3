Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5905C4BCFF2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbiBTQpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 11:45:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbiBTQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 11:45:06 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0054D9F4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645375485; x=1676911485;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uuw83ECe70i64LSACK5EE4QLLa96kqC6jjtdZkdnpHI=;
  b=PWmnoGH1trsiRy5cvn5VCjPdPrvIl7FREzcz0YNNQ0AearcDTmZSDZVv
   Ed1786GNJnP7zPvmt7DWzNHEyFADmGKFYLCX2trtaVxj8XoZyvVzO7kIK
   3zckj90B+Pa5DW5nSMw2ALY0L+g9p4/TBjw+GJRF0iOL281yT4Llp5BmK
   q+FJAfUemCmBRkzbF1wkkCUWgX30mC9yGx1DslwVqyF0iglwB8JfSNn7v
   PD9ebqRJA61tz2aw9D9ugkbPlgDi5NfTuGq7lBR697jd7cH88aE3cW6uD
   +pMXrrw5LjLk2KWMNNOlYqSCiUFIyDhN4YGUMsRb2e4EZf6CTdLvgvzU3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="275976431"
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="275976431"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 08:44:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,383,1635231600"; 
   d="scan'208";a="490200666"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Feb 2022 08:44:42 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLpKE-0000TD-8a; Sun, 20 Feb 2022 16:44:42 +0000
Date:   Mon, 21 Feb 2022 00:43:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [cxl:preview 65/66] ERROR: modpost: "memory_add_physaddr_to_nid"
 [drivers/cxl/cxl_region.ko] undefined!
Message-ID: <202202210002.x2KgnPD6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git preview
head:   3e9e1e72c0c24fcbeb8c96f4e886be138f61496f
commit: 53d6178d706ba207f8c010ee0854ef0e717084e3 [65/66] cxl/region: Create an nd_region
config: ia64-randconfig-r023-20220217 (https://download.01.org/0day-ci/archive/20220221/202202210002.x2KgnPD6-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=53d6178d706ba207f8c010ee0854ef0e717084e3
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl preview
        git checkout 53d6178d706ba207f8c010ee0854ef0e717084e3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "memory_add_physaddr_to_nid" [drivers/cxl/cxl_region.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
