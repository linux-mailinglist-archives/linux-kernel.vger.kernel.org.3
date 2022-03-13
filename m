Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F7B4D7802
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiCMTmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiCMTmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:42:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A53D46649
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647200467; x=1678736467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=svrbwD1vAwBdp0B/NJZW2Wx/ZbO0Qa4uavKbDO0rfLI=;
  b=csr/JtegkULCRjMy22p0atzfZWLq9sKkCxdxPn7oDbMqe2dikOcEC3X4
   +i0BB2MvpZmQFe3riCKKX0wmkLrp7Y/ThjRCZzV4FbQF644kIYzJzNQZv
   ASis6aeYOw3IjpvuwbmgfCgenEd7kQ/NWiJBrU42vVh9e4WS/5OR0AKBV
   aYxZzw1f5EjGaNYXK5eB8AVhho5IPTwyvsFSgSblZH3O6QaaREoJ49zlM
   SBGDVXLhf9DZqb1tUQvqpGTS06xAHk5o6LAJ9j6XOlJCqrsOdHL6OM6w0
   juLhp/Y6lp5+CGaN3zwJkrGibDW17DEOxDlKDAk4dkso7ijWuVeLee3qD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="254723443"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="254723443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 12:41:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="511970430"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Mar 2022 12:41:05 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTU5Q-0009EO-Co; Sun, 13 Mar 2022 19:41:04 +0000
Date:   Mon, 14 Mar 2022 03:40:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [hare-scsi-devel:tls-upcall.v4 121/156] ld.lld: error: undefined
 symbol: inet6_release
Message-ID: <202203140324.e59XsOnR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 33ec82590b0b919215a255fb431d661be4807b45 [121/156] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: hexagon-randconfig-r011-20220313 (https://download.01.org/0day-ci/archive/20220314/202203140324.e59XsOnR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0467eb2cb7654c15ae366967ef35093c5724c416)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=33ec82590b0b919215a255fb431d661be4807b45
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 33ec82590b0b919215a255fb431d661be4807b45
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: inet6_release
   >>> referenced by af_tlsh.c
   >>> tls/af_tlsh.o:(tlsh_release) in archive net/built-in.a
   >>> referenced by af_tlsh.c
   >>> tls/af_tlsh.o:(tlsh_release) in archive net/built-in.a
   >>> did you mean: inet_release
   >>> defined in: net/built-in.a(ipv4/af_inet.o)
--
>> ld.lld: error: undefined symbol: inet6_getname
   >>> referenced by af_tlsh.c
   >>> tls/af_tlsh.o:(tlsh_getname) in archive net/built-in.a
   >>> referenced by af_tlsh.c
   >>> tls/af_tlsh.o:(tlsh_getname) in archive net/built-in.a

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
