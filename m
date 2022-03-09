Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387214D3885
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiCISO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiCISOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:14:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8B254FB8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646849604; x=1678385604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fjotJj0Le6vZ9kuI41XD/CE8Rc5Fx1t7WC73S1YJXWI=;
  b=FyER5XKQm8WzV5ItEHndtrvgNoVGvAmmNZ6pUrU9Aygbc8fdI5UqFAUU
   d4+XmGtnwDWAfSvVCR0Z38MXh8R/YxZjSUbhEyZiuyjog+dOyCFHlISbH
   uiYkiHX4Dfhp0ghGslFqsYJLltOV76t0tGcyAt4R25B0NhUKoxXcfvLFm
   79YO+Elxd8Md9V7IwVXU+pjOQXhxFuocLziVky/QLlBnSOVIduEO3UGbx
   cjyrol1gKkjGPErbgO00L5fEyaGTIagZ7FDfIm/Mg7NAVIrlFbohJZ3Hf
   AHklMV2Njj65CB1rvfO0WweU9snTI/kin3CxlytF6L2LgQjBLYP9BezHx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255241917"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="255241917"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 10:13:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="538108190"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2022 10:13:21 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS0oL-0003ft-8h; Wed, 09 Mar 2022 18:13:21 +0000
Date:   Thu, 10 Mar 2022 02:12:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Lawrence <paullawrence@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 9996/9999] fs/fuse/dir.c:557:43-44: Unneeded semicolon
Message-ID: <202203100238.1ZdkujYi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   681ba23265bee4f2f0bd461df7d0025f4df17f09
commit: 8efdff35e3052e44d519ccfb9d50594f5df0240b [9996/9999] ANDROID: fuse-bpf: Move fd operations to be synchronous
config: arm-randconfig-c004-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100238.1ZdkujYi-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> fs/fuse/dir.c:557:43-44: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
