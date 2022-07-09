Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007FB56C830
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 10:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGIIwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 04:52:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11E59249
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 01:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657356755; x=1688892755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bbrzbTkKP0vx3o8lwVQI0Vs0Pp83Lm8Bx9vd6sQatr0=;
  b=W+9QF9f31TSMUsiFGNb8vTcRK7XzHI8cpe9SqfPq3McECfrmSBMCMySl
   4VSM+tCdbYc773dFLCX9M7TwtpkWRlayr5smo06qxUTkc4X6tW3mntMk5
   uPqT6T+U9uwvr11FB6zhCbX3/IjI5okJfyMjg09WiL3fxj+YDlU56GjKU
   fsjzIt5VWw3cSNDObCq7lhmFhzdX7zInFvDJ+nEmVur7VgwxMchyrj6oB
   G+1iaGSOpLiOzWLxeA+eJeW4vWKE6eZS05MF6mzBIDedeBAIP02Alii4L
   apbZQ+iQ89r8424t89/xRHugBNAUk05zAvUgCBDshT317HF61VZWTlEcn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="267461133"
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="267461133"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 01:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,258,1650956400"; 
   d="scan'208";a="621508286"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Jul 2022 01:52:33 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oA6CX-000OYQ-08;
        Sat, 09 Jul 2022 08:52:33 +0000
Date:   Sat, 9 Jul 2022 16:52:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [jlayton:ceph-netfs-llist 1/10] ERROR: modpost:
 "netfs_require_flush_group" [fs/afs/kafs.ko] undefined!
Message-ID: <202207091619.70ORAvWU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-netfs-llist
head:   fd428464b2220bd6c59f0a30f9dadb4720b3efb5
commit: 3d4ae7bbf12af2c1ee8f93df5d6ea3556bdfb6ca [1/10] netfs: Add a write context
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220709/202207091619.70ORAvWU-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=3d4ae7bbf12af2c1ee8f93df5d6ea3556bdfb6ca
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-netfs-llist
        git checkout 3d4ae7bbf12af2c1ee8f93df5d6ea3556bdfb6ca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

fs/afs/file.c: In function 'afs_init_write_context':
>> fs/afs/file.c:376:2: warning: #warning TRIGGER NEW FLUSH GROUP FOR TESTING [-Wcpp]
376 | #warning TRIGGER NEW FLUSH GROUP FOR TESTING
|  ^~~~~~~
--
ERROR: modpost: "__SCT__tp_func_netfs_write_inode" [fs/afs/kafs.ko] undefined!
>> ERROR: modpost: "netfs_require_flush_group" [fs/afs/kafs.ko] undefined!
ERROR: modpost: "__tracepoint_netfs_dirty_inode" [fs/afs/kafs.ko] undefined!
ERROR: modpost: "__tracepoint_netfs_write_inode" [fs/afs/kafs.ko] undefined!
ERROR: modpost: "__SCT__tp_func_netfs_dirty_inode" [fs/afs/kafs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
