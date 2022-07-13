Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D78572F79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiGMHp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbiGMHpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:45:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1E2E5DD3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657698354; x=1689234354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sykRw959yf7R4wavR8irtRKA6pUd9P2uL3jSk4zJERA=;
  b=VdKDIQRIZGgUw2TRH69PGvwCV5CzArYqPv/OUNMiQm6drGqCApGopn7q
   5q5qAzf/u4f0ILTeJzneoL09SEaNLYO3trs63lFXE8j2quWHhfWEKSqgz
   KvCZr3DHEX2HKEMltqhvUkdBEnU7YJdqWIrVLakW/YHeuHxLhw9cEK3+k
   +f1uzrpaf/2hpmKpKBA8ZZk0QkR5fRXTE4e6PrNxtor76PorbiX7wtBCH
   RTA8a3wv9FOrg9yUnkkY2ARwEkYj2ZyYcrsG2gHEPWW+M/X4L1SWf8k7N
   VugbzHrCuwZu2FefAYHxXnnVjgSUelIb7qmZ0gxPSfwoo/lU+ovGiuZ2G
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="371453197"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="371453197"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 00:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="737781018"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2022 00:45:52 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBX4B-0003H1-LP;
        Wed, 13 Jul 2022 07:45:51 +0000
Date:   Wed, 13 Jul 2022 15:45:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ben Hutchings <bwh@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 7073/7120] module.c:undefined
 reference to `apply_returns'
Message-ID: <202207131507.KAI8N0xI-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   53b881e19526bcc3e51d9668cab955c80dcf584c
commit: f0c3bd645f2f01f9544cfab558041352f811e43b [7073/7120] x86: Undo return-thunk damage
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220713/202207131507.KAI8N0xI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=f0c3bd645f2f01f9544cfab558041352f811e43b
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout f0c3bd645f2f01f9544cfab558041352f811e43b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: arch/x86/um/../kernel/module.o: in function `module_finalize':
>> module.c:(.text+0x219): undefined reference to `apply_returns'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
