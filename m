Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2481058851F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiHCAYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiHCAYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:24:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CA239BB6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659486282; x=1691022282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YJ9F1zfubWLUWqXd3sOpa1teyy5VoGJvngrqfZfARO0=;
  b=Vl1LRKm8cqE0yh1w+V5WOMhFfBNPjLleZJ3htYZAV4L2Jybca23gmlHm
   ly/gUKrbBewtIblrVTQiOiTph6my8BSejkspmCzZeSrgOn0NNgcEBt8WS
   JXO0+xxXBOgsiOI4YrfiB9HCvFiEP8mncqiIaH69uxBRVA2L9uoLH+FLB
   GKdqmdRlRf7FFVInx0+XW/ioJOVw+tkGd/ykuiHWj085flzH11lxEN0AY
   JfTy8ZYSo2DBrwV1cPgaS77JinjFnMc7pDR5dk0iOxlok8hEZTeLeVWAE
   Fw1v0yGQPkeEW/9s4ihLU5jhHyhzKR1/6yg9wxIkURNfm4seBkQ5Hku6K
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290322998"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="290322998"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 17:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="778802035"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Aug 2022 17:24:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ2Bj-000GbN-1J;
        Wed, 03 Aug 2022 00:24:39 +0000
Date:   Wed, 3 Aug 2022 08:24:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alistair Popple <apopple@nvidia.com>
Subject: [akpm-mm:mm-stable 242/251] hmm-tests.c:1607:42: error:
 'HMM_DMIRROR_MIGRATE' undeclared; did you mean 'HMM_DMIRROR_WRITE'?
Message-ID: <202208030814.FpNJkXbm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-stable
head:   1a44131d4f524e18d873bbe363598e39841001bf
commit: f6c3e1ae0114cd0f5123cf38187d450c1b119e67 [242/251] mm/hmm: add a test for cross device private faults
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?id=f6c3e1ae0114cd0f5123cf38187d450c1b119e67
        git remote add akpm-mm https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
        git fetch --no-tags akpm-mm mm-stable
        git checkout f6c3e1ae0114cd0f5123cf38187d450c1b119e67
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hmm-tests.c: In function 'hmm2_double_map':
>> hmm-tests.c:1607:42: error: 'HMM_DMIRROR_MIGRATE' undeclared (first use in this function); did you mean 'HMM_DMIRROR_WRITE'?
    1607 |         ret = hmm_dmirror_cmd(self->fd1, HMM_DMIRROR_MIGRATE, buffer, npages);
         |                                          ^~~~~~~~~~~~~~~~~~~
         |                                          HMM_DMIRROR_WRITE
   hmm-tests.c:1607:42: note: each undeclared identifier is reported only once for each function it appears in

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
