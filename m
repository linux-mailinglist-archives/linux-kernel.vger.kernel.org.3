Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5263E5A04BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 01:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiHXXeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 19:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiHXXeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:34:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A88D89CF0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661384036; x=1692920036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ibTuhNiaaq0ojDhZM80ZVIwJ9+hKR9rjDIdWi90belc=;
  b=AXPF9eHAwcKJTX35pXC9JbPQTxVheof76U6iAnEjr9iX1+n15hhamdij
   6LjQ2DUAyQZsrlcAQ7I7m1hYGHk0TsCM5BtiAWhKn1R5QEVDitbuj52Z1
   bcDpZZBhSX9WYxeo4G5JJSfFKqvefKyS9M2XtVg4ntgxxOb6XU0EeJ9FN
   68EPux3aulpOS+hKncN/3E96+d3Hi/ryoN3gYQDOAUD610nY0WRJHxinz
   jv3mZ1obxZNBVay8eG47s+yFotdIjqtTg4SqkH5q3ZWLHXl2L19fuAquG
   O604HIdfrdhORlX75wOUxMR99Yl4xHcN9u4sL9/zI3Xd88vx5aM/1aSzt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="277123068"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="277123068"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 16:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="586627399"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2022 16:33:54 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQzsg-0001OJ-0L;
        Wed, 24 Aug 2022 23:33:54 +0000
Date:   Thu, 25 Aug 2022 07:33:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [mel:mm-zonelistupdate-v1r5 1/1] mm/page_alloc.c:4717:1: sparse:
 sparse: symbol 'zonelist_update_seq' was not declared. Should it be static?
Message-ID: <202208250714.TQ945nn2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-zonelistupdate-v1r5
head:   bfc5d44237a98913807e97da064a26a5bd6f49ce
commit: bfc5d44237a98913807e97da064a26a5bd6f49ce [1/1] mm/page_alloc: Fix race condition between build_all_zonelists and page allocation
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220825/202208250714.TQ945nn2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/commit/?id=bfc5d44237a98913807e97da064a26a5bd6f49ce
        git remote add mel https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
        git fetch --no-tags mel mm-zonelistupdate-v1r5
        git checkout bfc5d44237a98913807e97da064a26a5bd6f49ce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> mm/page_alloc.c:4717:1: sparse: sparse: symbol 'zonelist_update_seq' was not declared. Should it be static?
   mm/page_alloc.c:3467:6: sparse: sparse: context imbalance in 'free_unref_page' - different lock contexts for basic block
   mm/page_alloc.c:3574:17: sparse: sparse: context imbalance in 'free_unref_page_list' - unexpected unlock
   mm/page_alloc.c:3778:20: sparse: sparse: context imbalance in 'rmqueue_pcplist' - different lock contexts for basic block
   mm/page_alloc.c:5497:9: sparse: sparse: context imbalance in '__alloc_pages_bulk' - different lock contexts for basic block

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
