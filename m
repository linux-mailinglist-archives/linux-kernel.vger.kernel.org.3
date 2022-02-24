Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32134C2434
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiBXGtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiBXGti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:49:38 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9401B0C72
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 22:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645685349; x=1677221349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7KQZvE2Wclzmq1OG+ehEnQ0C6RIzSlyf8YwzyvcS5jw=;
  b=KQxREU/2IcXCXmLTvT0rvKQ3qzTLHD4v8hV2tQZXoSj4duWNBovxRjvF
   /pgsDDEUq0eyClaRZ+yL/oAD/Q4ekD0er1cT393e1EKcItbnYxf3WvN9w
   i/p5kFCItTJken4DykknQRIrVrheDR7tejlrAQX9crmhYJOAS3O3mkjPV
   xVlwqjk8q8vbQP1XJKIGRxBfeDBnhyp5dMTJMKkBX1BjTwYcSJodPsbFO
   WAeXNwa9j5PCONembBG3i+yVWpjKB/njh3S0cH+/OrwgJnRSKNsTiXENT
   4pBJz4nHxZkex1U+mSIcS59j8hxjsl0vyMINNt6nNBk6wHfQ2b8QZt4lk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239560673"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="239560673"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 22:49:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="637725755"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 23 Feb 2022 22:49:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN7w1-0002Mg-Q7; Thu, 24 Feb 2022 06:49:05 +0000
Date:   Thu, 24 Feb 2022 14:48:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 63/67] tcp.c:undefined reference to
 `nvme_keyring_lookup_generated_key'
Message-ID: <202202241454.BxQTCDeq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   ac729ea3c52bda460616c71d5f5fc47b2e64da6d
commit: ab566bd55ff565627166db4334bb892488261c9c [63/67] nvme-tls: rename 'dhchap' to 'generated' key
config: openrisc-buildonly-randconfig-r005-20220223 (https://download.01.org/0day-ci/archive/20220224/202202241454.BxQTCDeq-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=ab566bd55ff565627166db4334bb892488261c9c
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout ab566bd55ff565627166db4334bb892488261c9c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/nvme/host/core.o: in function `nvme_core_init':
   core.c:(.init.text+0x1d8): undefined reference to `nvme_keyring_init'
   core.c:(.init.text+0x1d8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_init'
   or1k-linux-ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_start_tls':
   tcp.c:(.text+0xd10): undefined reference to `tls_client_hello_user'
   tcp.c:(.text+0xd10): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `tls_client_hello_user'
   or1k-linux-ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_lookup_psk.constprop.0':
>> tcp.c:(.text+0x2ed8): undefined reference to `nvme_keyring_lookup_generated_key'
   tcp.c:(.text+0x2ed8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_generated_key'
   or1k-linux-ld: tcp.c:(.text+0x2efc): undefined reference to `nvme_keyring_lookup_tls'
   tcp.c:(.text+0x2efc): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_tls'
   or1k-linux-ld: tcp.c:(.text+0x2f28): undefined reference to `nvme_keyring_lookup_psk'
   tcp.c:(.text+0x2f28): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_psk'
   or1k-linux-ld: tcp.c:(.text+0x2f44): undefined reference to `nvme_keyring_insert_tls'
   tcp.c:(.text+0x2f44): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_insert_tls'
>> or1k-linux-ld: tcp.c:(.text+0x2f6c): undefined reference to `nvme_keyring_lookup_generated_key'
   tcp.c:(.text+0x2f6c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_generated_key'
   or1k-linux-ld: tcp.c:(.text+0x2f8c): undefined reference to `nvme_keyring_insert_tls'
   tcp.c:(.text+0x2f8c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_insert_tls'
   or1k-linux-ld: tcp.c:(.text+0x2fb0): undefined reference to `nvme_keyring_lookup_tls'
   tcp.c:(.text+0x2fb0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_tls'
   or1k-linux-ld: tcp.c:(.text+0x2fdc): undefined reference to `nvme_keyring_lookup_psk'
   tcp.c:(.text+0x2fdc): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_psk'
   or1k-linux-ld: tcp.c:(.text+0x2ff8): undefined reference to `nvme_keyring_insert_tls'
   tcp.c:(.text+0x2ff8): additional relocation overflows omitted from the output
   or1k-linux-ld: tcp.c:(.text+0x3054): undefined reference to `nvme_keyring_insert_tls'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
