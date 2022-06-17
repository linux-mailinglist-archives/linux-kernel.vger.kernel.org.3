Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B902E54F102
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380276AbiFQG1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiFQG1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:27:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142B72A4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 23:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655447252; x=1686983252;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=740VTPWrUShQ8Brh8mDxlSFegDdp59K64YGFrcrtl6s=;
  b=ME7UPtLHduSZ254R6dBXcifKu+SD/fl0MrIpqxO/mf9E6sUrpEcgG/vt
   WuPSf9vL+sFFiJG84m2Fbgf9yecepmb+VE/m7m6iHwrzNcx1FkorzWVsN
   21eKCThxKv/wm2NNz1vWprUI4cLR5O/A/WnhUDQG5GwBm2DO3B7E+6evJ
   3Av/2eWqKDRQAnIXJnAFkpZL/QGRINs2BXp0WSX1XrRA5fy5N4qJlQUO6
   BlDdrISU73cWcPrIXSUieUm6dpn4qAlXlsbYfwLsi8pO3MEssmYTnuKiy
   E39hlx6sRtVfvnZs2wHNXRLzdSmqAqjwkhwaN6E9yO2n8fQRtuRoQuj8P
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268122020"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268122020"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 23:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="713652152"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Jun 2022 23:27:30 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o25S5-000P9t-QE;
        Fri, 17 Jun 2022 06:27:29 +0000
Date:   Fri, 17 Jun 2022 14:27:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [cip:linux-4.19.y-cip-rt-rebase 2065/9999]
 net/xfrm/xfrm_ipcomp.c:40:30: warning: 'ipcomp_scratches_lock' defined but
 not used
Message-ID: <202206171457.YUwoAiZH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git linux-4.19.y-cip-rt-rebase
head:   4784425d57541175db8c44ceef091a8fb42e5c6f
commit: ad01e51437422285ac98eced7c7136b368bd2ffc [2065/9999] net: xfrm: fix compress vs decompress serialization
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220617/202206171457.YUwoAiZH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?id=ad01e51437422285ac98eced7c7136b368bd2ffc
        git remote add cip https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
        git fetch --no-tags cip linux-4.19.y-cip-rt-rebase
        git checkout ad01e51437422285ac98eced7c7136b368bd2ffc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/xfrm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/xfrm/xfrm_ipcomp.c:23:
>> net/xfrm/xfrm_ipcomp.c:40:30: warning: 'ipcomp_scratches_lock' defined but not used [-Wunused-const-variable=]
      40 | static DEFINE_LOCAL_IRQ_LOCK(ipcomp_scratches_lock);
         |                              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/locallock.h:244:71: note: in definition of macro 'DEFINE_LOCAL_IRQ_LOCK'
     244 | #define DEFINE_LOCAL_IRQ_LOCK(lvar)             __typeof__(const int) lvar
         |                                                                       ^~~~


vim +/ipcomp_scratches_lock +40 net/xfrm/xfrm_ipcomp.c

  > 23	#include <linux/locallock.h>
    24	#include <linux/percpu.h>
    25	#include <linux/slab.h>
    26	#include <linux/smp.h>
    27	#include <linux/vmalloc.h>
    28	#include <net/ip.h>
    29	#include <net/ipcomp.h>
    30	#include <net/xfrm.h>
    31	
    32	struct ipcomp_tfms {
    33		struct list_head list;
    34		struct crypto_comp * __percpu *tfms;
    35		int users;
    36	};
    37	
    38	static DEFINE_MUTEX(ipcomp_resource_mutex);
    39	static void * __percpu *ipcomp_scratches;
  > 40	static DEFINE_LOCAL_IRQ_LOCK(ipcomp_scratches_lock);
    41	static int ipcomp_scratch_users;
    42	static LIST_HEAD(ipcomp_tfms_list);
    43	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
