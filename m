Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C965274D2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 03:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiEOBOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 21:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiEOBN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 21:13:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B561563CE
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 18:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652577237; x=1684113237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wljWS3mt6gMkGRD2LbSHbh6O8yPHpf7NkN9ELDe8TtY=;
  b=IPgTIye9EalJQxK4vPVOYG9U+B/yWAXqO9TC1xhU592hnSck+d+2a7Ba
   Ak8+rSZBNqsyEn23dJgRPcYJX3JGNXWP14j+c1sq4JscErd7oIzKGPwCh
   V5x56IlXUhGkaL3r0R1z4gxnz2Rp+bhML+mzgglx0JMYXx17pR0j/pcSj
   II9ikAbZNkc9XtXaxfNw0gE4l7wbuC1TrWsCB1/TBhSxXpbcYOYos4+yh
   7/TiUJIYpNa4F46+gfyO9z5p69M5RSAznREFU8y+IBoGcBdF60IeyfdCc
   gFVi40OM54CiOlOjW9sVoLpOOY0CrHZe5O/hYzUvdWVtDlrf4iH8WY9jT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="331185655"
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="331185655"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 18:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="699012891"
Received: from lkp-server01.sh.intel.com (HELO d1462bc4b09b) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 May 2022 18:13:53 -0700
Received: from kbuild by d1462bc4b09b with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nq2pU-0001Af-0s;
        Sun, 15 May 2022 01:13:52 +0000
Date:   Sun, 15 May 2022 09:13:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jcmvbkbc-xtensa:xtensa-5.18-kprobes 44/46]
 arch/xtensa/lib/xtensa-isa.c:36:19: warning: function 'set_error' might be a
 candidate for 'gnu_printf' format attribute
Message-ID: <202205150949.b2YQdGYC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jcmvbkbc/linux-xtensa xtensa-5.18-kprobes
head:   8d9b04fec534d588aeb00d6003276eebf2eb73e0
commit: 2086c5362a3fd72d711247bfcad13cc94a96c180 [44/46] xtensa: import libisa
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220515/202205150949.b2YQdGYC-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jcmvbkbc/linux-xtensa/commit/2086c5362a3fd72d711247bfcad13cc94a96c180
        git remote add jcmvbkbc-xtensa https://github.com/jcmvbkbc/linux-xtensa
        git fetch --no-tags jcmvbkbc-xtensa xtensa-5.18-kprobes
        git checkout 2086c5362a3fd72d711247bfcad13cc94a96c180
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/xtensa/lib/xtensa-isa.c: In function 'set_error':
>> arch/xtensa/lib/xtensa-isa.c:36:19: warning: function 'set_error' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      36 |                   fmt, args);
         |                   ^~~


vim +36 arch/xtensa/lib/xtensa-isa.c

    25	
    26	
    27	static void set_error(xtensa_isa isa, int error_code,
    28			      const char *fmt, ...)
    29	{
    30		va_list args;
    31	
    32		va_start(args, fmt);
    33		isa->xtisa_errno = error_code;
    34		vsnprintf(isa->xtisa_error_msg,
    35			  sizeof(isa->xtisa_error_msg),
  > 36			  fmt, args);
    37		va_end(args);
    38	}
    39	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
