Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA964EDF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbiCaQ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbiCaQ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:57:47 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56794232137
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648745760; x=1680281760;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+fBoWZB3yyJ+TT7fPXolFigfgvKVX7lBHwZvtgtgHWc=;
  b=PuMlRapJrZhMaeGiHc0Yrn6lpfsGLEgrKHq3a4zKQqtNliqrcnNU0zeF
   yG2JMLwcJhWv+8DFMV5iRHdkL+6eDp6/0JruH++xH8vH1R6h0v2FoAiFG
   nHOAPqkr58piYV2wVHzpau2X8+qdOPJ6W25XCqMww6Q3qteluYCV0J24a
   6iv6gYeZ/rL/t1pWVIeAurmVM7XCvMuTnR5ThXFIC5U20EI2NxJh43AiI
   tyq599PXpwpIyIMiNWaF7CrDBZpT9ze4PPXzce50t3RHsPYnp5SZLPV0E
   J3Sf7Ip6K64B2PodLxa//FMB2iT7wzjgHvjxpCypexBziJ+mtAX7v+bwv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="320587127"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="320587127"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 09:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="503824395"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2022 09:55:57 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZy5U-0000SW-KR;
        Thu, 31 Mar 2022 16:55:56 +0000
Date:   Fri, 1 Apr 2022 00:55:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [linux-next:master 14693/14948] mm/secretmem.c:173:31: sparse:
 sparse: symbol 'secretmem_iops' was not declared. Should it be static?
Message-ID: <202204010033.oeIla4qb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   fdcbcd1348f4ef713668bae1b0fa9774e1811205
commit: 24209f2f4d623891c9a7541a24bcdeab22670821 [14693/14948] mm/secretmem: fix panic when growing a memfd_secret
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220401/202204010033.oeIla4qb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=24209f2f4d623891c9a7541a24bcdeab22670821
        git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
        git fetch --no-tags linux-next master
        git checkout 24209f2f4d623891c9a7541a24bcdeab22670821
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/secretmem.c:173:31: sparse: sparse: symbol 'secretmem_iops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
