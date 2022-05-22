Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4EA530015
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346499AbiEVAtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiEVAs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:48:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480304A901
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 17:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653180538; x=1684716538;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MwZ/siLcOEqv/6vMAg4l/paZ1NqwDsWxbmBCIPD/QJY=;
  b=fr2Qam7G8Zlgqr9kWKcOijZ5D6yK3FSrlgJ+3Y7u78fCpBbp7p4WW+9z
   HF5yxqHPOy0PS0nmMQNHmZGoAswyD71hUzhFR1xeUFJUqIKi5jDuqYbel
   MEE/XN7IlwLoVkmCVBb6+W30nrl3PhrYP+58wKitSbfpzGLrQ0MVa54Rv
   sFwTONUDvuU7Z/EjthzQGDlLPZk2QTjk2cSKLTb19M+rpcGjoREFviZYv
   QvYI7Y5wPpxzFPgAlC6lSFOhBDdkm4BxtgLYV2k4eeh8HLxfewEivODTQ
   MxrL58PvHPXW+wu+8xWyJyielHnQrz5OvSBKhw0utql1i5SlzEkfnm9U4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="359326745"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="359326745"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 17:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="899968011"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 21 May 2022 17:48:57 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsZmC-0006nD-KU;
        Sun, 22 May 2022 00:48:56 +0000
Date:   Sun, 22 May 2022 08:48:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [cel:topic-rpc-with-tls-upcall 16/19] xprtsock.c:undefined reference
 to `tls_client_hello_x509'
Message-ID: <202205220844.ZVEdxK1Z-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   c484b8917f3569f6fdf4026936f9452dbeb1a8c3
commit: ff786916b6c43d3db9b03c15b3379fd96b4bb05c [16/19] SUNRPC: Add RPC-with-TLS support to xprtsock.c
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20220522/202205220844.ZVEdxK1Z-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=ff786916b6c43d3db9b03c15b3379fd96b4bb05c
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout ff786916b6c43d3db9b03c15b3379fd96b4bb05c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: net/sunrpc/xprtsock.o: in function `xs_tls_connect':
>> xprtsock.c:(.text+0x2832): undefined reference to `tls_client_hello_x509'
>> m68k-linux-ld: xprtsock.c:(.text+0x2876): undefined reference to `tls_client_hello_psk'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
