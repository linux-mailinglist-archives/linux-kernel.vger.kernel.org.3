Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2328553C163
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 01:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbiFBX6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 19:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiFBX57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 19:57:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3386B7CF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 16:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654214277; x=1685750277;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qQ4KXhgTLmYjPUNNwObqJCRTjrPtVSMqApnEkiZmtGE=;
  b=K4cvetgpagtlxJZS4R5yIZtBa6PWcH/kvjCKC9jMvtpyH80efsPe+EXG
   SS25XboENjWgY/riErWCl4JgSswBVyuVDVW8rip2w+KDfADSKuMOM/U7l
   gcOPtVvukzNEcyRdrtNIyOtSkDxhkCLjVO6YmZ6gbmDR2JEt5bghq9/Vv
   +bdY/Ekc1CN0HTnK7uBsDuz9gWepfwNWehtOojEU25R1drvjKXn0sQNma
   b9RMFBVe67bfqEru+gqjShhFjqsr+fv25A1Klue2zeO7eLfmqrtM7upkm
   iavQH5HiaAZCVc9qu0CPTTW8GQJratgSMTq7Soqb4B0WOu7OPR2YpuLvI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="301487966"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="301487966"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 16:57:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="824489993"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jun 2022 16:57:56 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwuhO-0005X9-3z;
        Thu, 02 Jun 2022 23:57:54 +0000
Date:   Fri, 3 Jun 2022 07:57:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <cong.wang@bytedance.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [congwang:sk_data_ready 6/7] net/smc/af_smc.c:254:25: error:
 incompatible pointer types passing 'int (**)(struct sock *)' to parameter of
 type 'void (**)(struct sock *)'
Message-ID: <202206030727.VT50e3vR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sk_data_ready
head:   9c95f9de643d020bc671ae23c5723d811d6f11f7
commit: 55e436c5d3f795345e5b0d946f98fa64540c496e [6/7] net: make ->sk_data_ready() return int
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220603/202206030727.VT50e3vR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/55e436c5d3f795345e5b0d946f98fa64540c496e
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sk_data_ready
        git checkout 55e436c5d3f795345e5b0d946f98fa64540c496e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/host/ net/smc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/nvme/host/tcp.c:1610:20: error: incompatible function pointer types assigning to 'void (*)(struct sock *)' from 'int (*)(struct sock *)' [-Werror,-Wincompatible-function-pointer-types]
           queue->data_ready = queue->sock->sk->sk_data_ready;
                             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:1612:33: error: incompatible function pointer types assigning to 'int (*)(struct sock *)' from 'void (struct sock *)' [-Werror,-Wincompatible-function-pointer-types]
           queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
                                          ^ ~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/tcp.c:1644:26: error: incompatible function pointer types assigning to 'int (*)(struct sock *)' from 'void (*)(struct sock *)' [-Werror,-Wincompatible-function-pointer-types]
           sock->sk->sk_data_ready = queue->data_ready;
                                   ^ ~~~~~~~~~~~~~~~~~
   3 errors generated.
--
>> net/smc/af_smc.c:254:25: error: incompatible pointer types passing 'int (**)(struct sock *)' to parameter of type 'void (**)(struct sock *)' [-Werror,-Wincompatible-pointer-types]
           smc_clcsock_restore_cb(&clcsk->sk_data_ready, &smc->clcsk_data_ready);
                                  ^~~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:317:51: note: passing argument to parameter 'target_cb' here
   static inline void smc_clcsock_restore_cb(void (**target_cb)(struct sock *),
                                                     ^
   net/smc/af_smc.c:254:48: error: incompatible pointer types passing 'int (**)(struct sock *)' to parameter of type 'void (**)(struct sock *)' [-Werror,-Wincompatible-pointer-types]
           smc_clcsock_restore_cb(&clcsk->sk_data_ready, &smc->clcsk_data_ready);
                                                         ^~~~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:318:16: note: passing argument to parameter 'saved_cb' here
                                             void (**saved_cb)(struct sock *))
                                                     ^
   net/smc/af_smc.c:828:25: error: incompatible pointer types passing 'int (**)(struct sock *)' to parameter of type 'void (**)(struct sock *)' [-Werror,-Wincompatible-pointer-types]
           smc_clcsock_replace_cb(&clcsk->sk_data_ready, smc_fback_data_ready,
                                  ^~~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:306:51: note: passing argument to parameter 'target_cb' here
   static inline void smc_clcsock_replace_cb(void (**target_cb)(struct sock *),
                                                     ^
>> net/smc/af_smc.c:828:48: error: incompatible function pointer types passing 'int (struct sock *)' to parameter of type 'void (*)(struct sock *)' [-Werror,-Wincompatible-function-pointer-types]
           smc_clcsock_replace_cb(&clcsk->sk_data_ready, smc_fback_data_ready,
                                                         ^~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:307:15: note: passing argument to parameter 'new_cb' here
                                             void (*new_cb)(struct sock *),
                                                    ^
   net/smc/af_smc.c:829:11: error: incompatible pointer types passing 'int (**)(struct sock *)' to parameter of type 'void (**)(struct sock *)' [-Werror,-Wincompatible-pointer-types]
                                  &smc->clcsk_data_ready);
                                  ^~~~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:308:16: note: passing argument to parameter 'saved_cb' here
                                             void (**saved_cb)(struct sock *))
                                                     ^
   net/smc/af_smc.c:2483:25: error: incompatible pointer types passing 'int (**)(struct sock *)' to parameter of type 'void (**)(struct sock *)' [-Werror,-Wincompatible-pointer-types]
           smc_clcsock_replace_cb(&smc->clcsock->sk->sk_data_ready,
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:306:51: note: passing argument to parameter 'target_cb' here
   static inline void smc_clcsock_replace_cb(void (**target_cb)(struct sock *),
                                                     ^
   net/smc/af_smc.c:2484:11: error: incompatible function pointer types passing 'int (struct sock *)' to parameter of type 'void (*)(struct sock *)' [-Werror,-Wincompatible-function-pointer-types]
                                  smc_clcsock_data_ready, &smc->clcsk_data_ready);
                                  ^~~~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:307:15: note: passing argument to parameter 'new_cb' here
                                             void (*new_cb)(struct sock *),
                                                    ^
   net/smc/af_smc.c:2484:35: error: incompatible pointer types passing 'int (**)(struct sock *)' to parameter of type 'void (**)(struct sock *)' [-Werror,-Wincompatible-pointer-types]
                                  smc_clcsock_data_ready, &smc->clcsk_data_ready);
                                                          ^~~~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:308:16: note: passing argument to parameter 'saved_cb' here
                                             void (**saved_cb)(struct sock *))
                                                     ^
   net/smc/af_smc.c:2501:26: error: incompatible pointer types passing 'int (**)(struct sock *)' to parameter of type 'void (**)(struct sock *)' [-Werror,-Wincompatible-pointer-types]
                   smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:317:51: note: passing argument to parameter 'target_cb' here
   static inline void smc_clcsock_restore_cb(void (**target_cb)(struct sock *),
                                                     ^
   net/smc/af_smc.c:2502:12: error: incompatible pointer types passing 'int (**)(struct sock *)' to parameter of type 'void (**)(struct sock *)' [-Werror,-Wincompatible-pointer-types]
                                          &smc->clcsk_data_ready);
                                          ^~~~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:318:16: note: passing argument to parameter 'saved_cb' here
                                             void (**saved_cb)(struct sock *))
                                                     ^
   10 errors generated.
--
>> net/smc/smc_close.c:218:27: error: incompatible pointer types passing 'int (**)(struct sock *)' to parameter of type 'void (**)(struct sock *)' [-Werror,-Wincompatible-pointer-types]
                           smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:317:51: note: passing argument to parameter 'target_cb' here
   static inline void smc_clcsock_restore_cb(void (**target_cb)(struct sock *),
                                                     ^
   net/smc/smc_close.c:219:13: error: incompatible pointer types passing 'int (**)(struct sock *)' to parameter of type 'void (**)(struct sock *)' [-Werror,-Wincompatible-pointer-types]
                                                  &smc->clcsk_data_ready);
                                                  ^~~~~~~~~~~~~~~~~~~~~~
   net/smc/smc.h:318:16: note: passing argument to parameter 'saved_cb' here
                                             void (**saved_cb)(struct sock *))
                                                     ^
   2 errors generated.


vim +254 net/smc/af_smc.c

aaa4d33f6da1e1 Karsten Graul 2018-03-16  245  
0558226cebee25 Wen Gu        2022-04-22  246  static void smc_fback_restore_callbacks(struct smc_sock *smc)
0558226cebee25 Wen Gu        2022-04-22  247  {
0558226cebee25 Wen Gu        2022-04-22  248  	struct sock *clcsk = smc->clcsock->sk;
0558226cebee25 Wen Gu        2022-04-22  249  
0558226cebee25 Wen Gu        2022-04-22  250  	write_lock_bh(&clcsk->sk_callback_lock);
0558226cebee25 Wen Gu        2022-04-22  251  	clcsk->sk_user_data = NULL;
0558226cebee25 Wen Gu        2022-04-22  252  
0558226cebee25 Wen Gu        2022-04-22  253  	smc_clcsock_restore_cb(&clcsk->sk_state_change, &smc->clcsk_state_change);
0558226cebee25 Wen Gu        2022-04-22 @254  	smc_clcsock_restore_cb(&clcsk->sk_data_ready, &smc->clcsk_data_ready);
0558226cebee25 Wen Gu        2022-04-22  255  	smc_clcsock_restore_cb(&clcsk->sk_write_space, &smc->clcsk_write_space);
0558226cebee25 Wen Gu        2022-04-22  256  	smc_clcsock_restore_cb(&clcsk->sk_error_report, &smc->clcsk_error_report);
0558226cebee25 Wen Gu        2022-04-22  257  
0558226cebee25 Wen Gu        2022-04-22  258  	write_unlock_bh(&clcsk->sk_callback_lock);
0558226cebee25 Wen Gu        2022-04-22  259  }
0558226cebee25 Wen Gu        2022-04-22  260  

:::::: The code at line 254 was first introduced by commit
:::::: 0558226cebee256aa3f8ec0cc5a800a10bf120a6 net/smc: Fix slab-out-of-bounds issue in fallback

:::::: TO: Wen Gu <guwen@linux.alibaba.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
