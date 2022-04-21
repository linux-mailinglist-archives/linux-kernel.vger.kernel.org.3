Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BAD50983F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385229AbiDUGvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385347AbiDUGuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:50:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0B615A0A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523553; x=1682059553;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J9wkXi99XEtQ0IvaH6PmAng5i3eMFPAq542Y8gnUy8Q=;
  b=LMJeyfSvpUiZ96vs+n/xjYZdE0Wj1dQH9Xb7WFWXkyOeEI5C16eT2loS
   OKrCm1Ln5w283C+aiWeoZlKzwkz+ihkVBse8DPEB7ol2nCYYPLHj1ZCB8
   BDiHkNHnnp8nfoiRaJFaO5l+WUKbk0Jl3GAtPwXUQ0t1mS+U8CnGUTZiv
   AXsZq/JJ5Mj4rgGBr8CKOrz10M/XJNqHxMh87W7T3Y+O0Tcwg69SlsiFF
   tMnUMFkvSpIKbaFJHpqIz6pTbOE4lHA4xCRvgWEMIIzWEXamYaAymp3K8
   y9be7ERRml1bxoBzWl9K0Dx+NLDXAGqBHlRr1NksjpzDiiYlGdsceniGI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263723416"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263723416"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="702962562"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 23:45:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQZb-00082j-Qf;
        Thu, 21 Apr 2022 06:45:51 +0000
Date:   Thu, 21 Apr 2022 14:45:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2110/2579] include/linux/fscrypt.h:757:37:
 warning: initialization of 'const struct inode *' from 'int' makes pointer
 from integer without a cast
Message-ID: <202204211315.igKpJ2Wz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 1cb1e496fc95fd250b11d4ae7bd593cbe22bb5f6 [2110/2579] headers/deps: fs: Optimize <linux/fs.h> dependencies, remove <linux/fs_api.h> inclusion
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220421/202204211315.igKpJ2Wz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=1cb1e496fc95fd250b11d4ae7bd593cbe22bb5f6
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 1cb1e496fc95fd250b11d4ae7bd593cbe22bb5f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/pci/ fs/crypto/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/crypto/fscrypt_private.h:14,
                    from fs/crypto/fname.c:23:
   include/linux/fscrypt.h: In function 'fscrypt_dio_supported':
   include/linux/fscrypt.h:757:37: error: implicit declaration of function 'file_inode'; did you mean 'd_inode'? [-Werror=implicit-function-declaration]
     757 |         const struct inode *inode = file_inode(iocb->ki_filp);
         |                                     ^~~~~~~~~~
         |                                     d_inode
>> include/linux/fscrypt.h:757:37: warning: initialization of 'const struct inode *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors


vim +757 include/linux/fscrypt.h

c6c89783eba05a5 Eric Biggers 2022-01-28  753  
c6c89783eba05a5 Eric Biggers 2022-01-28  754  static inline bool fscrypt_dio_supported(struct kiocb *iocb,
c6c89783eba05a5 Eric Biggers 2022-01-28  755  					 struct iov_iter *iter)
c6c89783eba05a5 Eric Biggers 2022-01-28  756  {
c6c89783eba05a5 Eric Biggers 2022-01-28 @757  	const struct inode *inode = file_inode(iocb->ki_filp);
c6c89783eba05a5 Eric Biggers 2022-01-28  758  
c6c89783eba05a5 Eric Biggers 2022-01-28  759  	return !fscrypt_needs_contents_encryption(inode);
c6c89783eba05a5 Eric Biggers 2022-01-28  760  }
c6c89783eba05a5 Eric Biggers 2022-01-28  761  

:::::: The code at line 757 was first introduced by commit
:::::: c6c89783eba05a5e159b07cfd8c68d841cc5de42 fscrypt: add functions for direct I/O support

:::::: TO: Eric Biggers <ebiggers@google.com>
:::::: CC: Eric Biggers <ebiggers@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
