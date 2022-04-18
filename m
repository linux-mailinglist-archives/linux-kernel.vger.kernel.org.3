Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E51505B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiDRPez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbiDRPe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:34:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361263FBF8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650293373; x=1681829373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fsjAJrJUNDzVF+HJA7hj5bXs4z0yjwl1sGT/KtRFSNI=;
  b=VBQ5PjiqZwEm8novpICMaSK3oqMYoo+ZQ44tXv1+tDFtxk8y5bEVWeMY
   PbgUGBaVf1LFeLsuajT1cqLBzcxyWY2+kw5VJ03cSlZy45ElVvyMKNt5x
   v3knnghiUp5E0hEplAqg8/Py31XR8ZY4TZBfW8gR5BN7cBOXaPQSi9ZsS
   qbhOM/iT7hoBQE5l2Ln9CNuLR0qjtNtewpZfC+BMbmg/AEr7TT+oNC55i
   msyD42kLJyPA+0GIE6/0wyMj/MH9x/rxqCrUdUuA15ipl3/6CUvt+nEfV
   nkze9rm3pgQjzBgRtpb0marTMl5sbznNQxKIVANwatKSkOBOM+RjWqzB+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="326432699"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="326432699"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 07:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="625309568"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Apr 2022 07:49:31 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngSh0-0004i8-GB;
        Mon, 18 Apr 2022 14:49:30 +0000
Date:   Mon, 18 Apr 2022 22:49:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@suse.de>
Subject: [tip:x86/sev 42/49] WARNING: modpost:
 vmlinux.o(.text.unlikely+0x1b81a): Section mismatch in reference from the
 function get_secrets_page() to the function .init.text:early_memremap()
Message-ID: <202204182206.xx2xw1wq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sev
head:   101826e02ac6c829bf4e768295e79ae9c37b4b2a
commit: 3a45b3753849c4a12cca2dd176c0192cd2a63e62 [42/49] x86/sev: Register SEV-SNP guest request platform device
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220418/202204182206.xx2xw1wq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3a45b3753849c4a12cca2dd176c0192cd2a63e62
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip x86/sev
        git checkout 3a45b3753849c4a12cca2dd176c0192cd2a63e62
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text.unlikely+0x1b81a): Section mismatch in reference from the function get_secrets_page() to the function .init.text:early_memremap()
The function get_secrets_page() references
the function __init early_memremap().
This is often because get_secrets_page lacks a __init
annotation or the annotation of early_memremap is wrong.
--
>> WARNING: modpost: vmlinux.o(.text.unlikely+0x1b835): Section mismatch in reference from the function get_secrets_page() to the function .init.text:early_memunmap()
The function get_secrets_page() references
the function __init early_memunmap().
This is often because get_secrets_page lacks a __init
annotation or the annotation of early_memunmap is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
