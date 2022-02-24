Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045A64C21FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiBXDAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiBXDAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:00:40 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED86C4842
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645671611; x=1677207611;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gI7JIRRaP3GbGMo5GnOXcrDl7QzB+IB0aRU86vFSBh0=;
  b=DLBP9aGN3C+M9ym2f9pg42KP9hpJ4ce6v0A5dwe1KwhKN1OzpckkJGY+
   ugXiERy6oZXwYUSuQkSJcz8bwNEYfKqrWxxJir6NEBmQHBDLhnt3RlGWv
   Dlnw16JUkDcpdjr7Y8dK4T0fo2/O359FEN/TG8k+5RBSbCh454Z+K+LW+
   WYHJ6mb459Dp8FsYUqSABKdwsTVrxSN4ioky2HDWsgnwAkL5BStBShXFi
   NjQqzC5nZb+jQzJcoJNWnapRZjsWShEsE+z9FR9MRfOYormTFWu9mL3DK
   ghJi33Rgd0eohG3v3hfg7SjVkeob7O7wLlYVnhPSuM/ZnfkZEAeCQbncn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="250965586"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="250965586"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:00:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="574061224"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Feb 2022 19:00:00 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN4MJ-00029T-E5; Thu, 24 Feb 2022 02:59:59 +0000
Date:   Thu, 24 Feb 2022 10:59:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 54/67] tcp.c:undefined reference to
 `tls_client_hello_user'
Message-ID: <202202241024.EIelxH6D-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   ac729ea3c52bda460616c71d5f5fc47b2e64da6d
commit: 4c6b8023e6fd977739a1df4a3309c661a21bb65e [54/67] nvme-tcp: derive keys and start TLS if requested
config: openrisc-buildonly-randconfig-r005-20220223 (https://download.01.org/0day-ci/archive/20220224/202202241024.EIelxH6D-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=4c6b8023e6fd977739a1df4a3309c661a21bb65e
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 4c6b8023e6fd977739a1df4a3309c661a21bb65e
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
>> tcp.c:(.text+0xd50): undefined reference to `tls_client_hello_user'
   tcp.c:(.text+0xd50): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `tls_client_hello_user'
   or1k-linux-ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_lookup_psk.constprop.0':
   tcp.c:(.text+0x2ed4): undefined reference to `nvme_keyring_lookup_dhchap'
   tcp.c:(.text+0x2ed4): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_dhchap'
>> or1k-linux-ld: tcp.c:(.text+0x2ef8): undefined reference to `nvme_keyring_lookup_tls'
   tcp.c:(.text+0x2ef8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_tls'
   or1k-linux-ld: tcp.c:(.text+0x2f24): undefined reference to `nvme_keyring_lookup_psk'
   tcp.c:(.text+0x2f24): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_psk'
>> or1k-linux-ld: tcp.c:(.text+0x2f40): undefined reference to `nvme_keyring_insert_tls'
   tcp.c:(.text+0x2f40): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_insert_tls'
   or1k-linux-ld: tcp.c:(.text+0x2f64): undefined reference to `nvme_keyring_lookup_dhchap'
   tcp.c:(.text+0x2f64): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_dhchap'
   or1k-linux-ld: tcp.c:(.text+0x2f84): undefined reference to `nvme_keyring_insert_tls'
   tcp.c:(.text+0x2f84): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_insert_tls'
   or1k-linux-ld: tcp.c:(.text+0x2fa8): undefined reference to `nvme_keyring_lookup_tls'
   tcp.c:(.text+0x2fa8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_tls'
   or1k-linux-ld: tcp.c:(.text+0x2fd0): undefined reference to `nvme_keyring_lookup_psk'
   tcp.c:(.text+0x2fd0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `nvme_keyring_lookup_psk'
   or1k-linux-ld: tcp.c:(.text+0x2fec): undefined reference to `nvme_keyring_insert_tls'
   tcp.c:(.text+0x2fec): additional relocation overflows omitted from the output
   or1k-linux-ld: tcp.c:(.text+0x3044): undefined reference to `nvme_keyring_insert_tls'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
