Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1F4C8233
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbiCAEUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiCAEUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:20:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6CE2B1B6;
        Mon, 28 Feb 2022 20:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646108389; x=1677644389;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7+GHxMCaOy/eag+P29R1wN7fPuSy9M8xFCoVkKsEOOA=;
  b=JOmarbjFZLqg9sLxvw+dQXvLxTGSsVEqsfpXkUsqPRggnxUygSs+eT2K
   CrLhtIsbe3jmy/5we936tXkJ0JT9ejlUyPkJokzNq7dlu4mJWrgH8dDlk
   T5QyKl2wKI7pSKbt9n49ovl4MnezARSBO215Nq9IQecyZIWy4Qdd1jGX6
   IYjYXck1zGZVJkDVzFsMsqvYvGQy1XJH8Y/uPL9Xrcnoc/9j3AnhmYwpq
   iZXzui6OI79qHig/IC7IM0iVcMp5i2TZVdiKP2FrSKqMmJBOhEQrqUgQD
   JQbfVRdvzzBL8i5KWbb8TfHj1lnKLHwfsFnDX6G+y0+AhJ2Y771SQ3Feh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252784766"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252784766"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 20:19:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="804073353"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Feb 2022 20:19:47 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOtzG-00086g-NB; Tue, 01 Mar 2022 04:19:46 +0000
Date:   Tue, 1 Mar 2022 12:19:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [linux-next:master 3353/9295] drivers/powercap/dtpm.c:525:22:
 sparse: sparse: symbol 'dtpm_node_callback' was not declared. Should it be
 static?
Message-ID: <202203011104.TkmvSjFD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   6705cd745adbbeac6b13002c7a30060f7b2568a5
commit: 3759ec678e8944dc2ea70cab77a300408f78ae27 [3353/9295] powercap/drivers/dtpm: Add hierarchy creation
config: x86_64-randconfig-s021-20220228 (https://download.01.org/0day-ci/archive/20220301/202203011104.TkmvSjFD-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=3759ec678e8944dc2ea70cab77a300408f78ae27
        git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
        git fetch --no-tags linux-next master
        git checkout 3759ec678e8944dc2ea70cab77a300408f78ae27
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/powercap/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/powercap/dtpm.c: note: in included file:
   drivers/powercap/dtpm_subsys.h:12:24: sparse: sparse: symbol 'dtpm_subsys' was not declared. Should it be static?
>> drivers/powercap/dtpm.c:525:22: sparse: sparse: symbol 'dtpm_node_callback' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
