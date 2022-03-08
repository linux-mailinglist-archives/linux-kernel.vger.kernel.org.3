Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BBE4D248F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 00:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiCHXBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 18:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiCHXBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 18:01:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C155A15A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646780443; x=1678316443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fm8JhLPUKU8DghtgsgBgREYSqzT88w4E4hBF0mKLXLQ=;
  b=aWjgLM9KaXSe7jkK9Gtb3gIz+fXHGLWKgnysCaAZEG0QPayugTGQH/VE
   5meiEVU32NEyTV5wgivH8GRaWwZpOTU2VBcnHtHPMy8b44dfrpJ+/ZRCD
   jEjTRTv/6K+616sZY4NEP28b6CZDKJFRPrDljengLwgOoGV9nTXj3U/CE
   ej64dAWO/HvzYJsbfVbt2WTKr3ZehdZSf4mYphEZ4kPBns97pAmtc2e8U
   91ImDsFvQDuSBSmG7orcPZYTLASOo1JWhUbRvrzpO0Zi+Jks3hSD7vVKN
   uFarp6Ott7xtLCmKSU+g/21cHQMs2JZ5RjOyG3yUwSX9Luba7BbRMklB2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252407479"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="252407479"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 15:00:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="643826577"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 15:00:41 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRior-00029L-7y; Tue, 08 Mar 2022 23:00:41 +0000
Date:   Wed, 9 Mar 2022 06:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Farzad Farshchi <farzadfr@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel test robot <lkp@intel.com>
Subject: [esmil:visionfive 55/61] nvdla_core_callbacks.c:undefined reference
 to `__udivdi3'
Message-ID: <202203090611.3NpTkqvn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   b75fcbba0e03fd9655bc4c8854422d51474664d3
commit: 6146bd9336a5f9d2bb66d6a394863600b61afeb5 [55/61] nvdla: add NVDLA driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203090611.3NpTkqvn-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/6146bd9336a5f9d2bb66d6a394863600b61afeb5
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 6146bd9336a5f9d2bb66d6a394863600b61afeb5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/nvdla/nvdla_core_callbacks.o: in function `dla_get_time_us':
>> nvdla_core_callbacks.c:(.text+0x396): undefined reference to `__udivdi3'
   `.exit.text' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
