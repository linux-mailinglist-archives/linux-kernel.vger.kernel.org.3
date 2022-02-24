Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CACB4C37F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiBXVoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiBXVoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:44:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8F621D088
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645739016; x=1677275016;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jiqXYXpys9xcbuB0hR37GCY7GtngpcftRj3NnXZTul8=;
  b=I1Ty1c23UmN0Ib0lPSzQy6DOqfu+ndHQGIVGyqDDIsmgeWlTtWONRe2v
   HYFMTAgQtRnSjNnqMia5MeT4OWsg6atShVVOrQ10qY5qeB/nPAN0pQRUc
   0CY+kccHNylL1aFjxaJhaWfFFfz1y4zfxwr9mRVaGR1CiAQgo+tqeTdFF
   2t36+0U5k+BaKESAtqimLQurndzwxn9/KrQo4Kr1oVO7xLVgAJKnW/OjX
   FNJ4e+tTQQmxGSTTIa8oxQWK7fSX48GQnP3UrP6FmD95h7ijMtrzTUTtD
   YZA5rknukqPI8Vl1K45Pqr94hFUEb0ZXGPliyJi9wZI52JxfInXU12N/s
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232984813"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="232984813"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 13:43:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="574373275"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Feb 2022 13:43:34 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNLtd-0003Ui-Pk; Thu, 24 Feb 2022 21:43:33 +0000
Date:   Fri, 25 Feb 2022 05:43:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [netfilter-nf:master 47/47] nf_queue.c:undefined reference to
 `sock_gen_put'
Message-ID: <202202250551.bHhoyNSe-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git master
head:   661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd
commit: 661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd [47/47] netfilter: nf_queue: don't assume sk is full socket
config: arm-randconfig-c002-20220223 (https://download.01.org/0day-ci/archive/20220225/202202250551.bHhoyNSe-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git/commit/?id=661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd
        git remote add netfilter-nf git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git
        git fetch --no-tags netfilter-nf master
        git checkout 661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: net/netfilter/nf_queue.o: in function `nf_queue_entry_release_refs':
>> nf_queue.c:(.text+0x60): undefined reference to `sock_gen_put'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
