Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6175626CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiF3XSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiF3XSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:18:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEDDE0E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656631097; x=1688167097;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Dfm7axZWAKkEl0Yg6555XwrTd6tTzwlKszTTyyKnpIQ=;
  b=JWhK65Erumn/ez/a8GrFjpnCUJH3Kd1vcnTU/u6tkZTgz7A4c4hLxmSK
   usptliAgEagLju8TH4Vf7B3mf0A4t+9LotCa+08qevwQFngOJ6x0NvwUS
   B+0ornxazoTzBKfVi69dN9Nt33uxxGE9sZAwOO5g+7guoo0U7c+Ue4Uzs
   zTfT+gj9oD1pj/A+CZx2AKeyzP1Ga6u99nvXdyHiTrN/hqjrGMHZXNUac
   IOs7jrkvy5vXl8OeVzRV+tNzJWo9VjeLXmxcdkEhC9yL0fI7hkZVMNP+3
   OeWQzmIHfvfrSLJBjR1fiFvQgOj7RgtLcMjzZZhq5UKDCiT/LvIA0kxa6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="283594277"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="283594277"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 16:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="596012036"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2022 16:18:15 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o73QM-000DIY-ND;
        Thu, 30 Jun 2022 23:18:14 +0000
Date:   Fri, 1 Jul 2022 07:17:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 31/56]
 ld.lld: error: undefined symbol: fscache_begin_cache_operation
Message-ID: <202207010740.uNqYXgaP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   acac17cdb0f9f6db9fc03eea371e399906146f96
commit: 822bd57525b5cf3038ef9d8086398a8aecc95161 [31/56] fscache: Add a function to begin an cache op from a netfslib request
config: arm64-randconfig-r001-20220629 (https://download.01.org/0day-ci/archive/20220701/202207010740.uNqYXgaP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/822bd57525b5cf3038ef9d8086398a8aecc95161
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout 822bd57525b5cf3038ef9d8086398a8aecc95161
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: fscache_begin_cache_operation
   >>> referenced by addr.c
   >>>               ceph/addr.o:(ceph_netfs_ops) in archive fs/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
