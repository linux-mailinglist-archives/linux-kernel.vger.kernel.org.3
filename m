Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D1E503387
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiDPCGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiDPCFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:05:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A3B137F7B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 18:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650074085; x=1681610085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SvwdQsLidhvM69m4szQJ6jWSpz1MI0jnaZ1Ih37mMWM=;
  b=Qt0W27msyxMLcJZxyaixMP+QTUGQxqFvkGj33FSAUEI38G1oR7UpWupV
   dA/GIaxosRjuLlA4uDNn8RdIRfNxzH/JdL+/Dt0FxwGedSVZ0f/AO1XQX
   /oPnlLo4jfk/CoVX60T0WY6WkOCXoE+tVS/7ddTcR7u3oLr3WLs0U1i/t
   xl3cudWa9fdO24hZuzVFTVPriBDmp4zL+SuY+WxXqbvpeES5wOcveA8+b
   KemjTqKGtLUI7AnyOnV4wyP83VBtwondzN4A2qgXG4G2aGHApXmD51dtt
   UCYBOZqlzyIqrzKrLwlCfxzIwa3cgooSFjVGBPGuj1zdCkKVihTKS7oBt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349708868"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="349708868"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 18:47:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="560760534"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 15 Apr 2022 18:47:43 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfXXK-0002e9-ND;
        Sat, 16 Apr 2022 01:47:42 +0000
Date:   Sat, 16 Apr 2022 09:47:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 5/21] af_tlsh.o:undefined reference
 to `inet6_getname'
Message-ID: <202204160942.qYEM1Kw4-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   042d95da69c53834c6a7f9322ceb62dd4fadc16a
commit: 9c714254a834b2b317a3bf5e8fd61c3b8dd0b532 [5/21] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: microblaze-buildonly-randconfig-r002-20220414 (https://download.01.org/0day-ci/archive/20220416/202204160942.qYEM1Kw4-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=9c714254a834b2b317a3bf5e8fd61c3b8dd0b532
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout 9c714254a834b2b317a3bf5e8fd61c3b8dd0b532
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: net/tls/af_tlsh.o: in function `tlsh_getname':
>> af_tlsh.o:(.text+0x3a0): undefined reference to `inet6_getname'
   microblaze-linux-ld: net/tls/af_tlsh.o: in function `tlsh_release':
>> af_tlsh.o:(.text+0x13f4): undefined reference to `inet6_release'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
