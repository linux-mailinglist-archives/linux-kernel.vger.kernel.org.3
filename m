Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FAD5588A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiFWTZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiFWTYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:24:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097E65D10F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656009328; x=1687545328;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WBX6pC5nvJZsStui+OzM80SgKqdCaKJxjEkAeQk1WEY=;
  b=hLvpxdVsLNEQkr7ogmSynH4DQsIbAuicI8RFqB3+andSDd6GiAn/BBiX
   sCTRYpBITWJJQhk9mQqA+qlz8jqY/Uj7lvc5fTB+57RRnysVzWf4QSoGf
   n7KjO0HKYeutAO9tiVJSQxaXgrfNDhJjn7nvq+sMVEBdQWfI3ZlYb/xKh
   ujnI9eQb+LxWl/NepF2GyrHM2/outZfxAO79f1Ywtn3gwumCBlrBL2XJ7
   QN8NhQs1sr+ViC/clfIM4BJQFreSB8RzSHNsrpvo4cBiEAqkDJBIjC1AD
   dIcPPvE3QjdrhoWfew6GLlmyZfwq+mem+LQAVzpSnfwkZ6DEOHrQNcI9R
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="281883702"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="281883702"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 11:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="592832898"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2022 11:35:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4Rfp-0002jD-7g;
        Thu, 23 Jun 2022 18:35:25 +0000
Date:   Fri, 24 Jun 2022 02:35:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tramp_11 16/21] ld.lld: error: undefined symbol:
 btf_obj_id
Message-ID: <202206240253.PHH3073a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tramp_11
head:   c807110aa605281263da02a78af57847f5c4275e
commit: 314f5bc24b05d05202084c23723269fe449b067b [16/21] bpf: Add bpf_tramp_id object
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220624/202206240253.PHH3073a-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 46be5faaf03466c3751f8a2882bef5a217e15926)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=314f5bc24b05d05202084c23723269fe449b067b
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tramp_11
        git checkout 314f5bc24b05d05202084c23723269fe449b067b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: btf_obj_id
   >>> referenced by trampoline.c:98 (kernel/bpf/trampoline.c:98)
   >>>               vmlinux.o:(bpf_tramp_id_init)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
