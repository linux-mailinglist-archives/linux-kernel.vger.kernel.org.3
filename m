Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4CB554439
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352410AbiFVHN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352835AbiFVHNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:13:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA244140C3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655882023; x=1687418023;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oJke41zwp9mN+pI4uVgRv29B+X1P/kRA/qSnAvd3Pc4=;
  b=HszfLoWP/ctxhUoGQqcKyGAj4tJWVlGWAvq3sbqTOO8+3/0P4eGs6hMl
   o05dY7CRT26wbM1FFch/fx/544wJJeierZrh6tL/qc40bVncVEIA/khIh
   xotX+KWYe/CCgirYcf5ZYfgnbFOSdrS8ti6I1pMjoySjzMPUVoTNqspf4
   mnbwcwPYAacsvSSAI1oOsSu3ucdccSvU4Y8C6R/2BUk2hwxsYdbPxK/to
   AK0UP/3M46ZwC6sT0vjpKPgISuXv82eJQDXs7itgaI5alcmV6J/vqYWFj
   nusbza+AiRiALX/7zGNK6zUD0mLLM7XNnaK4auQUoSvzaiSocKlr4I+nE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="269057709"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="269057709"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 00:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="833963253"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2022 00:13:37 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3uYS-0000yf-I8;
        Wed, 22 Jun 2022 07:13:36 +0000
Date:   Wed, 22 Jun 2022 15:13:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Simo Sorce <simo@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: arceb-elf-ld: system_keyring.c:undefined reference to
 `x509_load_certificate_list'
Message-ID: <202206221515.DqpUuvbQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca1fdab7fd27eb069df1384b2850dcd0c2bebe8d
commit: 60050ffe3d770dd1df5b641aa48f49d07a54bd84 certs: Move load_certificate_list() to be with the asymmetric keys code
date:   16 hours ago
config: arc-randconfig-r022-20220622 (https://download.01.org/0day-ci/archive/20220622/202206221515.DqpUuvbQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=60050ffe3d770dd1df5b641aa48f49d07a54bd84
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 60050ffe3d770dd1df5b641aa48f49d07a54bd84
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arceb-elf-ld: certs/system_keyring.o: in function `load_system_certificate_list':
   system_keyring.c:(.init.text+0x142): undefined reference to `x509_load_certificate_list'
>> arceb-elf-ld: system_keyring.c:(.init.text+0x142): undefined reference to `x509_load_certificate_list'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
