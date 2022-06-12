Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C016547938
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 09:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiFLHvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 03:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbiFLHvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 03:51:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD8752508
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655020264; x=1686556264;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TzSM/syRVB9OKcoZne0iYLG1ONwo1yKGF3iAMljSy8c=;
  b=DoS6IbsjikYCZEuQ/Bx3OX3EFR78vMOaAmllyRCsNf9m3wM9z02c9ilg
   50G/B33dz0gTSX6zYJI9wOvCUmBvrqixH/uuoaWCNqRZXobs5nukjaVQY
   r576GkQcu91isltIeCiJWwynYTJfqLPWB2+mt/ktERyi6rYMUyJyqOple
   I6WLy7pcRt1xJeHeFQ9PE0kyX8zbRxK54BRqHCnjRfPghuuMcvwU5wwl5
   z0FbEFgk6Qv3CkKt774Y2ZQ0kQGeiOy6kcAdSSNlQYXKpmw7cpOzaHqOt
   4cJBy9XgKyyO48Uh8VjxkUsqOXcjpju3jMNQRaHhUtJWnNCs/WAwN86aO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="276782653"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="276782653"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 00:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="611306730"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2022 00:51:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0INA-000JlF-Rz;
        Sun, 12 Jun 2022 07:51:00 +0000
Date:   Sun, 12 Jun 2022 15:50:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Subject: [daveh-devel:testme 2/2] arch/x86/kernel/setup.c:367:15: warning: no
 previous prototype for function 'ima_free_kexec_buffer'
Message-ID: <202206121517.ww6IZORM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git testme
head:   a217a1ebac788fd28ccf79499e9e12e5519d70b7
commit: a217a1ebac788fd28ccf79499e9e12e5519d70b7 [2/2] x86/kexec: Carry forward IMA measurement log on kexec
config: i386-randconfig-a004 (https://download.01.org/0day-ci/archive/20220612/202206121517.ww6IZORM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6466c9abf3674bade1f6ee859f24ebc7aaf9cd88)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/commit/?id=a217a1ebac788fd28ccf79499e9e12e5519d70b7
        git remote add daveh-devel https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git
        git fetch --no-tags daveh-devel testme
        git checkout a217a1ebac788fd28ccf79499e9e12e5519d70b7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/setup.c:367:15: warning: no previous prototype for function 'ima_free_kexec_buffer' [-Wmissing-prototypes]
   int __meminit ima_free_kexec_buffer(void)
                 ^
   arch/x86/kernel/setup.c:367:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __meminit ima_free_kexec_buffer(void)
   ^
   static 
>> arch/x86/kernel/setup.c:385:12: warning: no previous prototype for function 'ima_get_kexec_buffer' [-Wmissing-prototypes]
   int __init ima_get_kexec_buffer(void **addr, size_t *size)
              ^
   arch/x86/kernel/setup.c:385:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init ima_get_kexec_buffer(void **addr, size_t *size)
   ^
   static 
   2 warnings generated.


vim +/ima_free_kexec_buffer +367 arch/x86/kernel/setup.c

   365	
   366	#if defined(CONFIG_IMA) && !defined(CONFIG_OF_FLATTREE)
 > 367	int __meminit ima_free_kexec_buffer(void)
   368	{
   369		int rc;
   370	
   371		if (ima_kexec_buffer_size == 0)
   372			return -ENOENT;
   373	
   374		rc = memblock_phys_free(ima_kexec_buffer_phys,
   375					ima_kexec_buffer_size);
   376		if (rc)
   377			return rc;
   378	
   379		ima_kexec_buffer_phys = 0;
   380		ima_kexec_buffer_size = 0;
   381	
   382		return 0;
   383	}
   384	
 > 385	int __init ima_get_kexec_buffer(void **addr, size_t *size)
   386	{
   387		if (ima_kexec_buffer_size == 0)
   388			return -ENOENT;
   389	
   390		*addr = __va(ima_kexec_buffer_phys);
   391		*size = ima_kexec_buffer_size;
   392	
   393		return 0;
   394	}
   395	#endif
   396	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
