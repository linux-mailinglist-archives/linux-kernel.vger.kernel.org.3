Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291F24C0A58
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiBWDiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbiBWDim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:38:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518D02E096
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645587496; x=1677123496;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oACJox0844ttu+CNigT0tpLXbqZkDy/VHw5e45I1Y40=;
  b=gNdxIGAlP78fq0cJamXQUc8aVzNUMZbJMDzmVv3paq9cUUbxtJvZb542
   ezebwDd0OQH5xO9V2jjl7liZyk105H1XJUsTW+Y4K7ZcY9uSK49xwcIiM
   H7gbIwzZ5taI5G2rqoVY5kjxVBWpJQAkq2NQJ4F/PzNK4DEx7fjE9twtL
   lBq/55c3aB7yB8dhkG19tSo5eudZ/LjGCziOqWuEJHjUNIRLsalPrqqx3
   fMMAaALX95Lt5LnE7nQ9k0LSufcO47tvvV3vJCiO/Z3duxtdwdMSqmVSc
   My4PzvPYWmXI445f7ArY9GjcDmykrs5M+8l6S/RbHJd8YaHypeO/X+Rky
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="250701661"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="250701661"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 19:38:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="637263626"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2022 19:38:14 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMiTl-0000wN-J1; Wed, 23 Feb 2022 03:38:13 +0000
Date:   Wed, 23 Feb 2022 11:38:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [boqun:dev/arm64 4/4] ERROR: modpost: "memory_block_size_bytes"
 [drivers/hv/hv_balloon.ko] undefined!
Message-ID: <202202231143.eyW0Glnu-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git dev/arm64
head:   abd696a42824ab4956b5f81bbfdfa54c4ef28d88
commit: abd696a42824ab4956b5f81bbfdfa54c4ef28d88 [4/4] Drivers: hv: balloon: Support memory hot add for larger page sizes
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20220223/202202231143.eyW0Glnu-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/commit/?id=abd696a42824ab4956b5f81bbfdfa54c4ef28d88
        git remote add boqun https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git
        git fetch --no-tags boqun dev/arm64
        git checkout abd696a42824ab4956b5f81bbfdfa54c4ef28d88
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "memory_block_size_bytes" [drivers/hv/hv_balloon.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
