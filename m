Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4C4D5085
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbiCJR16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244915AbiCJR1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:27:46 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DAA419BD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646933205; x=1678469205;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5S2JUl9ToaDXhYDPYQuADaloWOS3nI2kB7v8hrMXauY=;
  b=NjMw/3K3UsqbCaq+u+yCHG3cUybGOFPUrXYkvzNdqsJT3IsdEOP9CJ5d
   pJsv2Ql5fF2M0gF/6K7rzvvUUEAGeOAsqDo+uz7pmynrT4H0cItEDXlsQ
   Q0mBGzuj8uRKHaz70nPXM4dzafDFm7EJln+SESe4gfSLDfsh77Lk7Od0I
   NZs6lSYk7gE/TP09hjTEdf2qfsvgpvhjllR8qWCJDTime67RcPTzWV3wX
   PKXE1/uSE9aaVNpsqg9DQ4FKezWpPTeKYmaq/NCkKYnzxkGpe5xs7OfaZ
   QQ0aDrhX4+Y4yhAF3qTigct7fnxgcNyZyDuKuhdE3tdiVYIrbMjBoo/ZW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="252880822"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="252880822"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="548093052"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 10 Mar 2022 09:26:33 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSMYa-0005D3-LO; Thu, 10 Mar 2022 17:26:32 +0000
Date:   Fri, 11 Mar 2022 01:25:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     glider <glider@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-stable
 4757/9999] gcc-7: error: unrecognized command line option
 '-ftrivial-auto-var-init=pattern'
Message-ID: <202203110155.PXGwFPtQ-lkp@intel.com>
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

Hi glider,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-stable
head:   cb5d0103b1f8fc3aa997a696472fd774c67a1b1f
commit: a7eda6eddca559c1c3a897a35692f9d49d46c9dd [4757/9999] BACKPORT: security: allow using Clang's zero initialization for stack variables
config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220311/202203110155.PXGwFPtQ-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/a7eda6eddca559c1c3a897a35692f9d49d46c9dd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-stable
        git checkout a7eda6eddca559c1c3a897a35692f9d49d46c9dd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> gcc-7: error: unrecognized command line option '-ftrivial-auto-var-init=pattern'
   make[2]: *** [./Kbuild:22: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1214: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:146: sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
