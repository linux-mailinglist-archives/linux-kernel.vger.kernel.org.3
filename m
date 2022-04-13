Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6A34FFAE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiDMQIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiDMQHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:07:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D01D644C6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649865928; x=1681401928;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l4DbhfHxywn/EQ+sYTtpNBRF4EsncCGGgPFv8MfLgLs=;
  b=hrEeTzBi3vwKfVOQEkTm9CWwcTvi4tdKJWhBUcD7R6AaF3igxfTIwQpQ
   MCpWna3mQhc364j98iif+h3Drqp42zDokV70Rj/uD5YOYnHbNNnYRVXzz
   j/fJAAVrkH+LqhWVORP+PtkEM7gbz7LOzsIEiBNrPME+gqwuKShM+Cgye
   7DOPnSUkPM6kp8vSCerDucHc+arUUoEy/2NOn3+9SDkgGvWVvffFv0nHi
   21DOq9rdlmB/tOTNgtqSQbNtvh9aBKl9HJXtuQvY31J1cz7uh+Z8vfhxU
   fhtTh8pyVAPCBip5v9o6Q69ouYGntZYNM/rHtCqw60IuY3R6tcgYZaxi7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="260302906"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="260302906"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:05:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="526528859"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Apr 2022 09:05:26 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nefUj-0000R2-O1;
        Wed, 13 Apr 2022 16:05:25 +0000
Date:   Thu, 14 Apr 2022 00:04:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [linux-next:master 3834/3955] mm/memory.c:1238:1: sparse: sparse:
 symbol 'vma_needs_copy' was not declared. Should it be static?
Message-ID: <202204140043.Tx7BIBvI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   c97e430ab5539993ab2afc6e80deea80aef9d799
commit: 729c63ce2bbd5813b8061e50cc38187aed05114c [3834/3955] mm/shmem: handle uffd-wp during fork()
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220414/202204140043.Tx7BIBvI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=729c63ce2bbd5813b8061e50cc38187aed05114c
        git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
        git fetch --no-tags linux-next master
        git checkout 729c63ce2bbd5813b8061e50cc38187aed05114c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/memory.c:1238:1: sparse: sparse: symbol 'vma_needs_copy' was not declared. Should it be static?
   mm/memory.c:1031:17: sparse: sparse: context imbalance in 'copy_pte_range' - different lock contexts for basic block
   mm/memory.c:1827:16: sparse: sparse: context imbalance in '__get_locked_pte' - different lock contexts for basic block
   mm/memory.c:1875:9: sparse: sparse: context imbalance in 'insert_page' - different lock contexts for basic block
   mm/memory.c:2377:17: sparse: sparse: context imbalance in 'remap_pte_range' - different lock contexts for basic block
   mm/memory.c:2633:17: sparse: sparse: context imbalance in 'apply_to_pte_range' - unexpected unlock
   mm/memory.c:2922:9: sparse: sparse: context imbalance in 'wp_page_copy' - different lock contexts for basic block
   mm/memory.c:3274:17: sparse: sparse: context imbalance in 'wp_pfn_shared' - unexpected unlock
   mm/memory.c:3341:19: sparse: sparse: context imbalance in 'do_wp_page' - different lock contexts for basic block
   mm/memory.c:5211:5: sparse: sparse: context imbalance in 'follow_invalidate_pte' - wrong count at exit
   mm/memory.c:5332:23: sparse: sparse: context imbalance in 'follow_pfn' - unexpected unlock
   mm/memory.c:5362:9: sparse: sparse: context imbalance in 'follow_phys' - unexpected unlock
   mm/memory.c:5396:9: sparse: sparse: context imbalance in 'generic_access_phys' - unexpected unlock

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
