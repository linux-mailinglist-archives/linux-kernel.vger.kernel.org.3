Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4657055D60A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbiF0QPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiF0QPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:15:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2DD18B16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656346539; x=1687882539;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kekurc9X6JTrNjB2lK/+DWq/WVkwoh7fmHvmOLS0wyc=;
  b=fs2i8p2Z3RBHuakcaeyDEIdNwL9b0ubaDB9quu0lzBbK0GUZTdkotFO6
   Lt+CRP59SFX5e9WGjrV3lG9rTaK27r/7W2tQqhnDZw+ro+fD/NjlOLEU8
   nrz41cwmam3a+Qwxg9dWCoyOWwppXMHeC3eQvUC8B6XK4a6MO0UkixijL
   QvjTgwu8bW4VUzlXKd5xy6UcGbfSnfOpOFn4eKoaAh1T0T/jLPFtkkqo9
   ODpo/FAQZbAErcdDeeDRo1LKNHfEgF/FNy2ejTMlb3AX8znHgHpBVxciV
   wHQOQcidbupDCXr7V5e5nXRRg7YR81A21ZCo9KZCnqjJnWACVGGiPoI6e
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282216600"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="282216600"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 09:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="836255127"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2022 09:15:37 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5rOj-0008js-1N;
        Mon, 27 Jun 2022 16:15:37 +0000
Date:   Tue, 28 Jun 2022 00:15:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kas:lam 5/8] drivers/hid/hid-roccat.c:393:21: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202206280036.LpkeOTVp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
head:   5d6223c9876bbed53ff2a2977d2c36868f50c050
commit: db9e8d09f277a3100ecc7c742eec642e874c4f54 [5/8] x86/uaccess: Provide untagged_addr() and remove tags before address check
config: x86_64-randconfig-s021-20220627 (https://download.01.org/0day-ci/archive/20220628/202206280036.LpkeOTVp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?id=db9e8d09f277a3100ecc7c742eec642e874c4f54
        git remote add kas https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git
        git fetch --no-tags kas lam
        git checkout db9e8d09f277a3100ecc7c742eec642e874c4f54
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/block/mtip32xx/ drivers/cxl/core/ drivers/hid/ drivers/misc/genwqe/ drivers/net/hamradio/ drivers/net/ppp/ drivers/net/slip/ drivers/net/wwan/ drivers/video/fbdev/aty/ drivers/video/fbdev/matrox/ drivers/video/fbdev/sis/ drivers/video/fbdev/via/ net/appletalk/ net/atm/ net/ax25/ net/can/ net/mctp/ net/netrom/ net/phonet/ net/rose/ net/x25/ sound/core/ sound/hda/ sound/usb/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/hid/hid-roccat.c:393:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/hid/hid-roccat.c:393:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/hid/hid-roccat.c:393:21: sparse:     got int *
--
>> drivers/block/mtip32xx/mtip32xx.c:3230:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/block/mtip32xx/mtip32xx.c:3230:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/block/mtip32xx/mtip32xx.c:3230:21: sparse:     got unsigned int *
   drivers/block/mtip32xx/mtip32xx.c:3233:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/block/mtip32xx/mtip32xx.c:3233:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/block/mtip32xx/mtip32xx.c:3233:21: sparse:     got unsigned int *
   drivers/block/mtip32xx/mtip32xx.c:3246:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/block/mtip32xx/mtip32xx.c:3246:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/block/mtip32xx/mtip32xx.c:3246:21: sparse:     got unsigned int *
   drivers/block/mtip32xx/mtip32xx.c:3249:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/block/mtip32xx/mtip32xx.c:3249:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/block/mtip32xx/mtip32xx.c:3249:21: sparse:     got unsigned int *
--
>> drivers/cxl/core/mbox.c:438:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/cxl/core/mbox.c:438:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/cxl/core/mbox.c:438:13: sparse:     got unsigned int *
   drivers/cxl/core/mbox.c:443:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/cxl/core/mbox.c:443:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/cxl/core/mbox.c:443:24: sparse:     got unsigned int *
--
>> drivers/misc/genwqe/card_dev.c:1073:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int enum genwqe_card_state [noderef] __user *__ptr_clean @@     got unsigned int enum genwqe_card_state * @@
   drivers/misc/genwqe/card_dev.c:1073:17: sparse:     expected unsigned int enum genwqe_card_state [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1073:17: sparse:     got unsigned int enum genwqe_card_state *
>> drivers/misc/genwqe/card_dev.c:1080:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1080:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1080:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1087:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1087:17: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1087:17: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1100:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1100:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1100:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1106:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1106:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1106:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1116:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1116:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1116:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1123:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1123:17: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1123:17: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1136:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1136:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1136:21: sparse:     got unsigned long long *
   drivers/misc/genwqe/card_dev.c:1142:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] __user *__ptr_clean @@     got unsigned long long * @@
   drivers/misc/genwqe/card_dev.c:1142:21: sparse:     expected unsigned long long [noderef] __user *__ptr_clean
   drivers/misc/genwqe/card_dev.c:1142:21: sparse:     got unsigned long long *
--
>> drivers/net/hamradio/6pack.c:702:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/hamradio/6pack.c:702:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/hamradio/6pack.c:702:23: sparse:     got int *
   drivers/net/hamradio/6pack.c:706:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/hamradio/6pack.c:706:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/hamradio/6pack.c:706:21: sparse:     got int *
--
>> drivers/net/ppp/ppp_generic.c:1041:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:1041:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:1041:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:1048:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:1048:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:1048:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:1055:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:1055:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:1055:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:1070:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:1070:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:1070:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:742:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:742:29: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:742:29: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:752:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:752:29: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:752:29: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:797:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:797:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:797:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:804:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:804:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:804:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:821:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:821:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:821:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:836:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:836:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:836:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:842:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:842:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:842:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:849:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:849:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:849:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:871:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:871:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:871:21: sparse:     got int *
   drivers/net/ppp/ppp_generic.c:939:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_generic.c:939:21: sparse:     got int *
--
>> drivers/net/ppp/ppp_async.c:414:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_async.c:414:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_async.c:414:21: sparse:     got int *
   drivers/net/ppp/ppp_async.c:419:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_async.c:419:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_async.c:419:21: sparse:     got int *
>> drivers/net/ppp/ppp_async.c:429:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/net/ppp/ppp_async.c:429:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_async.c:429:21: sparse:     got unsigned int *
   drivers/net/ppp/ppp_async.c:434:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/net/ppp/ppp_async.c:434:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_async.c:434:21: sparse:     got unsigned int *
   drivers/net/ppp/ppp_async.c:440:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/net/ppp/ppp_async.c:440:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_async.c:440:21: sparse:     got unsigned int *
   drivers/net/ppp/ppp_async.c:445:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/net/ppp/ppp_async.c:445:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_async.c:445:21: sparse:     got unsigned int *
   drivers/net/ppp/ppp_async.c:465:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_async.c:465:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_async.c:465:21: sparse:     got int *
   drivers/net/ppp/ppp_async.c:470:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_async.c:470:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_async.c:470:21: sparse:     got int *
   drivers/net/ppp/ppp_async.c:296:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_async.c:296:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_async.c:296:21: sparse:     got int *
   drivers/net/ppp/ppp_async.c:303:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_async.c:303:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_async.c:303:21: sparse:     got int *
   drivers/net/ppp/ppp_async.c:317:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/ppp_async.c:317:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/ppp_async.c:317:21: sparse:     got int *
--
>> drivers/net/ppp/pppox.c:84:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/pppox.c:84:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/pppox.c:84:21: sparse:     got int *
--
>> drivers/net/ppp/pppoe.c:751:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/pppoe.c:751:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/pppoe.c:751:21: sparse:     got int *
   drivers/net/ppp/pppoe.c:765:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/pppoe.c:765:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/pppoe.c:765:21: sparse:     got int *
   drivers/net/ppp/pppoe.c:778:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/ppp/pppoe.c:778:21: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/ppp/pppoe.c:778:21: sparse:     got int *
--
   drivers/net/slip/slip.c:459:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:459:14: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:459:14: sparse:    void *
   drivers/net/slip/slip.c:893:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/slip/slip.c:893:9: sparse:    void [noderef] __rcu *
   drivers/net/slip/slip.c:893:9: sparse:    void *
>> drivers/net/slip/slip.c:1094:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/slip/slip.c:1099:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/slip/slip.c:1124:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/slip/slip.c:1145:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/slip/slip.c:1150:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/slip/slip.c:1170:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
--
>> drivers/net/wwan/wwan_core.c:790:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/wwan/wwan_core.c:790:23: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/wwan/wwan_core.c:790:23: sparse:     got int *
   drivers/net/wwan/wwan_core.c:843:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   drivers/net/wwan/wwan_core.c:843:24: sparse:     expected int [noderef] __user *__ptr_clean
   drivers/net/wwan/wwan_core.c:843:24: sparse:     got int *
--
>> sound/core/hwdep.c:243:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/hwdep.c:243:24: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:243:24: sparse:     got int *
   sound/core/hwdep.c:273:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/hwdep.c:273:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:273:29: sparse:     got int *
   sound/core/hwdep.c:292:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   sound/core/hwdep.c:292:29: sparse:     expected int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:292:29: sparse:     got int *
>> sound/core/hwdep.c:302:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/hwdep.c:302:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/hwdep.c:302:29: sparse:     got unsigned int *
   sound/core/hwdep.c: note: in included file:
>> sound/core/hwdep_compat.c:26:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/hwdep_compat.c:26:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/hwdep_compat.c:26:13: sparse:     got unsigned int *
   sound/core/hwdep_compat.c:27:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/hwdep_compat.c:27:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/hwdep_compat.c:27:13: sparse:     got unsigned int *
   sound/core/hwdep_compat.c:28:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/core/hwdep_compat.c:28:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/core/hwdep_compat.c:28:13: sparse:     got unsigned int *
--
>> sound/hda/hdmi_chmap.c:678:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:678:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:678:13: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:710:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:710:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:710:29: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:711:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:711:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:711:29: sparse:     got unsigned int *
   sound/hda/hdmi_chmap.c:732:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/hda/hdmi_chmap.c:732:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/hda/hdmi_chmap.c:732:13: sparse:     got unsigned int *
--
>> sound/usb/mixer_quirks.c:226:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __user *__ptr_clean @@     got char * @@
   sound/usb/mixer_quirks.c:226:31: sparse:     expected char [noderef] __user *__ptr_clean
   sound/usb/mixer_quirks.c:226:31: sparse:     got char *
>> sound/usb/mixer_quirks.c:228:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/usb/mixer_quirks.c:228:31: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/usb/mixer_quirks.c:228:31: sparse:     got unsigned int *
--
>> sound/usb/stream.c:157:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/usb/stream.c:157:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/usb/stream.c:157:13: sparse:     got unsigned int *
   sound/usb/stream.c:172:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/usb/stream.c:172:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/usb/stream.c:172:21: sparse:     got unsigned int *
   sound/usb/stream.c:173:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/usb/stream.c:173:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/usb/stream.c:173:21: sparse:     got unsigned int *
   sound/usb/stream.c:177:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/usb/stream.c:177:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/usb/stream.c:177:29: sparse:     got unsigned int *
   sound/usb/stream.c:184:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   sound/usb/stream.c:184:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   sound/usb/stream.c:184:13: sparse:     got unsigned int *
--
>> drivers/video/fbdev/aty/atyfb_base.c:1849:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/aty/atyfb_base.c:1849:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/aty/atyfb_base.c:1849:29: sparse:     got unsigned int *
--
>> drivers/video/fbdev/aty/aty128fb.c:2309:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/aty/aty128fb.c:2309:22: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/aty/aty128fb.c:2309:22: sparse:     got unsigned int *
   drivers/video/fbdev/aty/aty128fb.c:2323:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/aty/aty128fb.c:2323:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/aty/aty128fb.c:2323:24: sparse:     got unsigned int *
--
>> drivers/video/fbdev/matrox/matroxfb_base.c:903:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:903:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:903:37: sparse:     got unsigned int *
   drivers/video/fbdev/matrox/matroxfb_base.c:1044:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:1044:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:1044:37: sparse:     got unsigned int *
   drivers/video/fbdev/matrox/matroxfb_base.c:1069:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:1069:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:1069:37: sparse:     got unsigned int *
   drivers/video/fbdev/matrox/matroxfb_base.c:1083:37: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/matrox/matroxfb_base.c:1083:37: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/matrox/matroxfb_base.c:1083:37: sparse:     got unsigned int *
--
>> drivers/video/fbdev/sis/sis_main.c:1717:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1717:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1717:20: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1736:24: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1799:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1801:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1810:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1812:32: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1820:20: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1827:20: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1835:24: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/sis/sis_main.c:1852:20: sparse:     got unsigned int *
   drivers/video/fbdev/sis/sis_main.c:5425:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/sis/sis_main.c:5428:32: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/sis/sis_main.c:5457:40: sparse: sparse: cast to restricted __le32
   drivers/video/fbdev/sis/sis_main.c:5489:16: sparse: sparse: cast to restricted __le16
--
>> drivers/video/fbdev/via/viafbdev.c:409:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:409:24: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:413:24: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:553:21: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:559:21: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:567:21: sparse:     got unsigned int *
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   drivers/video/fbdev/via/viafbdev.c:600:21: sparse:     got unsigned int *
--
   net/appletalk/ddp.c:100:33: sparse: sparse: restricted __be16 degrades to integer
   net/appletalk/ddp.c:113:33: sparse: sparse: restricted __be16 degrades to integer
   net/appletalk/ddp.c:409:47: sparse: sparse: restricted __be16 degrades to integer
>> net/appletalk/ddp.c:1810:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/appletalk/ddp.c:1810:22: sparse:     expected int [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1810:22: sparse:     got int *
   net/appletalk/ddp.c:1823:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/appletalk/ddp.c:1823:22: sparse:     expected int [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1823:22: sparse:     got int *
>> net/appletalk/ddp.c:1860:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/appletalk/ddp.c:1860:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1860:13: sparse:     got unsigned short *
>> net/appletalk/ddp.c:1861:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected short [noderef] __user *__ptr_clean @@     got short * @@
   net/appletalk/ddp.c:1861:13: sparse:     expected short [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1861:13: sparse:     got short *
>> net/appletalk/ddp.c:1862:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/appletalk/ddp.c:1862:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1862:13: sparse:     got unsigned int *
   net/appletalk/ddp.c:1863:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/appletalk/ddp.c:1863:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1863:13: sparse:     got unsigned int *
   net/appletalk/ddp.c:1864:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/appletalk/ddp.c:1864:13: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1864:13: sparse:     got unsigned short *
   net/appletalk/ddp.c:1865:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/appletalk/ddp.c:1865:13: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/appletalk/ddp.c:1865:13: sparse:     got unsigned int *
--
>> net/atm/pppoatm.c:375:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/pppoatm.c:375:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/pppoatm.c:375:24: sparse:     got int *
   net/atm/pppoatm.c:378:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/pppoatm.c:378:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/pppoatm.c:378:24: sparse:     got int *
>> net/atm/pppoatm.c:450:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/atm/pppoatm.c:450:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/atm/pppoatm.c:450:21: sparse:     got unsigned short *
   net/atm/pppoatm.c:461:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/pppoatm.c:461:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/pppoatm.c:461:24: sparse:     got int *
   net/atm/pppoatm.c:464:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/atm/pppoatm.c:464:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/atm/pppoatm.c:464:24: sparse:     got int *
--
>> net/ax25/af_ax25.c:719:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ax25/af_ax25.c:719:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ax25/af_ax25.c:719:13: sparse:     got int *
   net/ax25/af_ax25.c:796:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ax25/af_ax25.c:796:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/ax25/af_ax25.c:796:13: sparse:     got int *
   net/ax25/af_ax25.c:1774:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ax25/af_ax25.c:1774:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/ax25/af_ax25.c:1774:23: sparse:     got int *
   net/ax25/af_ax25.c:1784:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/ax25/af_ax25.c:1784:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/ax25/af_ax25.c:1784:23: sparse:     got int *
>> net/ax25/af_ax25.c:1806:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected long [noderef] __user *__ptr_clean @@     got long * @@
   net/ax25/af_ax25.c:1806:21: sparse:     expected long [noderef] __user *__ptr_clean
   net/ax25/af_ax25.c:1806:21: sparse:     got long *
--
>> net/can/isotp.c:1456:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/isotp.c:1456:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/isotp.c:1456:13: sparse:     got int *
   net/can/isotp.c:1491:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/isotp.c:1491:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/isotp.c:1491:13: sparse:     got int *
--
>> net/can/j1939/socket.c:752:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/j1939/socket.c:752:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/j1939/socket.c:752:13: sparse:     got int *
   net/can/j1939/socket.c:779:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/can/j1939/socket.c:779:18: sparse:     expected int [noderef] __user *__ptr_clean
   net/can/j1939/socket.c:779:18: sparse:     got int *
--
>> net/mctp/af_mctp.c:337:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/mctp/af_mctp.c:337:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/mctp/af_mctp.c:337:13: sparse:     got int *
--
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/netrom/af_netrom.c:359:13: sparse:     got int *
   net/netrom/af_netrom.c:392:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netrom/af_netrom.c:392:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/netrom/af_netrom.c:392:13: sparse:     got int *
   net/netrom/af_netrom.c:1212:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netrom/af_netrom.c:1212:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/netrom/af_netrom.c:1212:24: sparse:     got int *
   net/netrom/af_netrom.c:1224:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/netrom/af_netrom.c:1224:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/netrom/af_netrom.c:1224:24: sparse:     got int *
--
>> net/phonet/datagram.c:42:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/phonet/datagram.c:42:24: sparse:     expected int [noderef] __user *__ptr_clean
   net/phonet/datagram.c:42:24: sparse:     got int *
>> net/phonet/datagram.c:47:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/phonet/datagram.c:47:29: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/phonet/datagram.c:47:29: sparse:     got unsigned int *
--
>> net/phonet/socket.c:367:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/phonet/socket.c:367:21: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/phonet/socket.c:367:21: sparse:     got unsigned short *
   net/phonet/socket.c:387:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned short [noderef] __user *__ptr_clean @@     got unsigned short * @@
   net/phonet/socket.c:387:24: sparse:     expected unsigned short [noderef] __user *__ptr_clean
   net/phonet/socket.c:387:24: sparse:     got unsigned short *
   net/phonet/socket.c:622:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:622:14: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:622:14: sparse:    struct sock *
   net/phonet/socket.c:645:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:645:17: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:645:17: sparse:    struct sock *
   net/phonet/socket.c:661:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:661:17: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:661:17: sparse:    struct sock *
   net/phonet/socket.c:680:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:680:25: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:680:25: sparse:    struct sock *
   net/phonet/socket.c:729:21: sparse: sparse: context imbalance in 'pn_res_seq_start' - wrong count at exit
   net/phonet/socket.c:744:13: sparse: sparse: context imbalance in 'pn_res_seq_stop' - wrong count at exit
--
>> net/phonet/pep.c:942:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/phonet/pep.c:942:23: sparse:     expected int [noderef] __user *__ptr_clean
   net/phonet/pep.c:942:23: sparse:     got int *
   net/phonet/pep.c:1051:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/phonet/pep.c:1051:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/phonet/pep.c:1051:13: sparse:     got int *
   net/phonet/pep.c:1078:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/phonet/pep.c:1078:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/phonet/pep.c:1078:13: sparse:     got int *
   net/phonet/pep.c:1080:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/phonet/pep.c:1080:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/phonet/pep.c:1080:13: sparse:     got int *
--
>> net/rose/af_rose.c:439:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/rose/af_rose.c:439:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/rose/af_rose.c:439:13: sparse:     got int *
   net/rose/af_rose.c:480:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/rose/af_rose.c:480:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/rose/af_rose.c:480:13: sparse:     got int *
>> net/rose/af_rose.c:1291:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/rose/af_rose.c:1291:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/rose/af_rose.c:1291:24: sparse:     got unsigned int *
   net/rose/af_rose.c:1300:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/rose/af_rose.c:1300:24: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/rose/af_rose.c:1300:24: sparse:     got unsigned int *
--
>> net/x25/af_x25.c:460:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/x25/af_x25.c:460:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/x25/af_x25.c:460:13: sparse:     got int *
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
   net/x25/af_x25.c:470:13: sparse:     expected int [noderef] __user *__ptr_clean
   net/x25/af_x25.c:470:13: sparse:     got int *
>> net/x25/af_x25.c:1381:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/x25/af_x25.c:1381:22: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/x25/af_x25.c:1381:22: sparse:     got unsigned int *
   net/x25/af_x25.c:1396:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [noderef] __user *__ptr_clean @@     got unsigned int * @@
   net/x25/af_x25.c:1396:22: sparse:     expected unsigned int [noderef] __user *__ptr_clean
   net/x25/af_x25.c:1396:22: sparse:     got unsigned int *

vim +393 drivers/hid/hid-roccat.c

206f5f2fcb5ff5 Stefan Achatz 2010-05-19  375  
8211e46004518c Stefan Achatz 2011-01-30  376  static long roccat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
8211e46004518c Stefan Achatz 2011-01-30  377  {
496ad9aa8ef448 Al Viro       2013-01-23  378  	struct inode *inode = file_inode(file);
8211e46004518c Stefan Achatz 2011-01-30  379  	struct roccat_device *device;
8211e46004518c Stefan Achatz 2011-01-30  380  	unsigned int minor = iminor(inode);
8211e46004518c Stefan Achatz 2011-01-30  381  	long retval = 0;
8211e46004518c Stefan Achatz 2011-01-30  382  
8211e46004518c Stefan Achatz 2011-01-30  383  	mutex_lock(&devices_lock);
8211e46004518c Stefan Achatz 2011-01-30  384  
8211e46004518c Stefan Achatz 2011-01-30  385  	device = devices[minor];
8211e46004518c Stefan Achatz 2011-01-30  386  	if (!device) {
8211e46004518c Stefan Achatz 2011-01-30  387  		retval = -ENODEV;
8211e46004518c Stefan Achatz 2011-01-30  388  		goto out;
8211e46004518c Stefan Achatz 2011-01-30  389  	}
8211e46004518c Stefan Achatz 2011-01-30  390  
8211e46004518c Stefan Achatz 2011-01-30  391  	switch (cmd) {
8211e46004518c Stefan Achatz 2011-01-30  392  	case ROCCATIOCGREPSIZE:
8211e46004518c Stefan Achatz 2011-01-30 @393  		if (put_user(device->report_size, (int __user *)arg))
8211e46004518c Stefan Achatz 2011-01-30  394  			retval = -EFAULT;
8211e46004518c Stefan Achatz 2011-01-30  395  		break;
8211e46004518c Stefan Achatz 2011-01-30  396  	default:
8211e46004518c Stefan Achatz 2011-01-30  397  		retval = -ENOTTY;
8211e46004518c Stefan Achatz 2011-01-30  398  	}
8211e46004518c Stefan Achatz 2011-01-30  399  out:
8211e46004518c Stefan Achatz 2011-01-30  400  	mutex_unlock(&devices_lock);
8211e46004518c Stefan Achatz 2011-01-30  401  	return retval;
8211e46004518c Stefan Achatz 2011-01-30  402  }
8211e46004518c Stefan Achatz 2011-01-30  403  

:::::: The code at line 393 was first introduced by commit
:::::: 8211e46004518c977f70f2661da961d5ba617399 HID: roccat: Add ioctl command to retreive report size from chardev

:::::: TO: Stefan Achatz <erazor_de@users.sourceforge.net>
:::::: CC: Jiri Kosina <jkosina@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
