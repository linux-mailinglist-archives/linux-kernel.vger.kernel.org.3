Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856EB5B24B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiIHRf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiIHRfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:35:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E07485FE3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662658524; x=1694194524;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YNFerqpJPpOJPGDi6l26UsPT7NdSVmzfo2zjn07INMQ=;
  b=c5XvHLuA2+oBqOcwrIGc1zTrBBp0YPmoHkhpB8X1S2wWDM8Z/CHNjUB+
   5MaB6mX34MCL8gGQNVOHiJj269h3ZZGyE8h7/osnu9BHpH8fJd+LwYS9F
   FWzNy25gy1QmKMy1gm1MCNaBpdoVyvjC0FoirclTaXf4v+xpETr0gOGk9
   1RPUUVt7Vdzy7KEtIKFAyWJsb6UwQVoHwnAh+m7jzQpQsPTwa9Q+f7y/m
   USEGkLwwmNolGRplF/NNxeW0e/kuwoRbuXnNZtJm6emw08saTYLTFQpeX
   Se1xDdR2IjCcv6Oy/6xthGK9A8Ui9vR4/CKh0ojieZha5sPJ6Pt/Nn6gv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="323472306"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="323472306"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 10:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="704094746"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2022 10:35:22 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWLQw-0000Bh-0o;
        Thu, 08 Sep 2022 17:35:22 +0000
Date:   Fri, 9 Sep 2022 01:34:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matteo Croce <mcroce@microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [esmil:visionfive 1/42] arch/riscv/lib/string.c:90:7: error:
 redefinition of '__memcpy'
Message-ID: <202209090127.x1z9vvlp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   044c1f5e968de7d30940431fbb90da599074ea1c
commit: c247f6e6c7ba6abb92177ba2a742f60a3244d6d2 [1/42] riscv: optimized memcpy
config: riscv-randconfig-r021-20220907 (https://download.01.org/0day-ci/archive/20220909/202209090127.x1z9vvlp-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/esmil/linux/commit/c247f6e6c7ba6abb92177ba2a742f60a3244d6d2
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout c247f6e6c7ba6abb92177ba2a742f60a3244d6d2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> arch/riscv/lib/string.c:90:57: warning: attribute declaration must precede definition [-Wignored-attributes]
   void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
                                                           ^
   include/linux/compiler_attributes.h:372:56: note: expanded from macro '__weak'
   #define __weak                          __attribute__((__weak__))
                                                          ^
   arch/riscv/lib/string.c:31:7: note: previous definition is here
   void *__memcpy(void *dest, const void *src, size_t count)
         ^
>> arch/riscv/lib/string.c:90:7: error: redefinition of '__memcpy'
   void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
         ^
   arch/riscv/include/asm/string.h:25:31: note: expanded from macro 'memcpy'
   #define memcpy(dst, src, len) __memcpy(dst, src, len)
                                 ^
   arch/riscv/lib/string.c:31:7: note: previous definition is here
   void *__memcpy(void *dest, const void *src, size_t count)
         ^
   1 warning and 1 error generated.


vim +/__memcpy +90 arch/riscv/lib/string.c

    89	
  > 90	void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
