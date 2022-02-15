Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9F24B6236
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 05:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiBOEoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 23:44:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiBOEoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 23:44:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543B96E78D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 20:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644900275; x=1676436275;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/JPqNlTP+WilwmrmEowBfe9Qg4iyPhc8669i1DD13Zk=;
  b=VvrJe/SE8yPy7f8Ib9WmJMGjJ/XIFgTlwVUtAaWQq/c4LuK933Kj9fxH
   qcpz8d7nGI0tMxBjgOEt8q+I5KOeCmWH2WWzQXTfvmdz2MfbnPxI3qGbf
   omNua5XKGFDUHSAR34tQi8Twqrqj8QHMxi6xpvIzPKBdQQtt1AQ6vKrv8
   V8Mj5Oi4RD7B84hlm7hK2Dq1ypojb6nil0pK/uLs8zWJbCiNskoJtaw5C
   nF522eVFAA4dw7iyXR8OD1nZVqv66XTvumMYgKCAEe1uRcfnWrlKErNA6
   +Oxt2djTp6M9B8s3whUqDMwJqRntotCSU/xCphaT0NOh4z0owhpbD2hoo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247843368"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="247843368"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 20:44:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="496753459"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2022 20:44:33 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJphY-0009HG-Mu; Tue, 15 Feb 2022 04:44:32 +0000
Date:   Tue, 15 Feb 2022 12:44:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 35/39] ld.lld:
 error: undefined symbol: xa_store_range
Message-ID: <202202151240.VEpRJvjS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   b995bc7182f60aa2b4d8930a7446f10dfbcebcc2
commit: e73334c9144cee0fd83afee287d7e5950e5d256d [35/39] netfs: Generate a buffered writeback from ->writepages()
config: i386-randconfig-a003-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151240.VEpRJvjS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e73334c9144cee0fd83afee287d7e5950e5d256d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout e73334c9144cee0fd83afee287d7e5950e5d256d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: xa_store_range
   >>> referenced by flush.c:204 (fs/netfs/flush.c:204)
   >>>               netfs/flush.o:(netfs_flush_range) in archive fs/built-in.a
   >>> referenced by flush.c:232 (fs/netfs/flush.c:232)
   >>>               netfs/flush.o:(netfs_flush_range) in archive fs/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
