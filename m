Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD81C5857E0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 04:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiG3CCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 22:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3CCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 22:02:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A761C65661
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 19:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659146554; x=1690682554;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gx5rycGitagPi3fepwPMLfTeT8Ptl0OD01QMIyKutxk=;
  b=Jcg77L5Z9+NVRpRmekeJmv7Cg9jfZA3ljcHP1reSPXwD27vAK/kJfyR7
   sghfLZrO13k1xqmnad1uOIqA/7qf1vvvL9+RgXRi1N09nkXFCs8bhVFPM
   XL6yAAHVVUGTqM+ctTR/NOJf815zF1v9RJA2m4Pg+QiggrOtrwJM26O9w
   XULrcnK+Qj8UZ0of+UO4oQoOcAMIcKarzYGvZghHagsEh3QBfQ9QXt1fo
   GPi987KUpmPXuj90dZ4PRy7qEFPr0ddzhAfVaP+7YGU2Wbn/5x0TmDioC
   FqXYWbbadNMwYqx7ije3G02+JkhHIe7UNW/Kr22gKaf6dGb0gkDaq1G2x
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="314690804"
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="314690804"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 19:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,202,1654585200"; 
   d="scan'208";a="629585006"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2022 19:02:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHboG-000CGl-0p;
        Sat, 30 Jul 2022 02:02:32 +0000
Date:   Sat, 30 Jul 2022 10:01:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/fineibt 3/4] ld.lld: error: undefined symbol:
 ftrace_stub_graph
Message-ID: <202207300957.x0WDB02K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fineibt
head:   365543b24a9e31c0c89457717391cdb819cc5501
commit: 311ed6d0d57a551f834efd610dc8b14867012a68 [3/4] ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220730/202207300957.x0WDB02K-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=311ed6d0d57a551f834efd610dc8b14867012a68
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/fineibt
        git checkout 311ed6d0d57a551f834efd610dc8b14867012a68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ftrace_stub_graph
   >>> referenced by fgraph.c
   >>>               trace/fgraph.o:(unregister_ftrace_graph) in archive kernel/built-in.a
   >>> referenced by fgraph.c
   >>>               trace/fgraph.o:(ftrace_graph_return) in archive kernel/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
