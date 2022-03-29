Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6D34EB3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbiC2TL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbiC2TL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:11:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBD67DE0F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648580983; x=1680116983;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PSxZTOt0Cvmx7FmWkk2gmN8a33ZxTGlRQ9L5GmXrg9s=;
  b=G2Oq+QNK7jlBZk5T3bb2ePwfN5QbmjxXIw1ECLONR4Bd1Hm9FOu0olPh
   qkq0ywcjww7DZURTsG33I0FllmScY0K0D42w9CFikiF98cZucmPp0Qwk/
   /Sll8RspNXWfCXdM1mfH4YE0DACnvf6dGI5KVtOZXIO4o3dQEy35dre8c
   EqGoa/2P70ryLG2d5Mv8+AktegvJv9xf8QmmMF/zKYIJ1HMNrdcCcH23U
   3LppJy4QzpEbmT59jXRLhZU2FGiXNshAxEmENeKwEVznLDVVW3maGOIMG
   ByEvCVO/JdAAGnl/zn7Ka9TQlMqE77eKguCcpz6eGXFNqysxkJOuTV+DD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="246834600"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="246834600"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 12:09:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="521566781"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2022 12:09:35 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZHDi-0000Zg-CZ; Tue, 29 Mar 2022 19:09:34 +0000
Date:   Wed, 30 Mar 2022 03:08:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casper Andersson <casper.casan@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sparx5_switchdev.c:undefined reference to `br_vlan_enabled'
Message-ID: <202203300320.7mLe6ehJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1930a6e739c4b4a654a69164dbe39e554d228915
commit: 3bacfccdcb2d3268adaf66d2ff4024251a93b916 net: sparx5: Add mdb handlers
date:   8 days ago
config: riscv-randconfig-r026-20220329 (https://download.01.org/0day-ci/archive/20220330/202203300320.7mLe6ehJ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3bacfccdcb2d3268adaf66d2ff4024251a93b916
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3bacfccdcb2d3268adaf66d2ff4024251a93b916
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.o: in function `sparx5_handle_port_mdb_del.constprop.0':
>> sparx5_switchdev.c:(.text+0x1e98): undefined reference to `br_vlan_enabled'
   riscv64-linux-ld: drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.o: in function `.L679':
   sparx5_switchdev.c:(.text+0x25e8): undefined reference to `br_vlan_enabled'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
