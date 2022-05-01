Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607605166E1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349418AbiEASPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 14:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEASPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 14:15:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFEAB7F1
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651428713; x=1682964713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V7a7Q/rDRTBOdtQ8KZsvMgeVhUFTscbfCE1qqcEVcww=;
  b=nm2BVkG45/gQjKWqYpUItVFVjrHlSzL04kctEM+f/YZBjQ/soKFBJQbF
   3avopEZZ4kQM3tBu4HO0Q3jIgnAPBsCQ+3yhSnl0wnsnls8O6UZgOHQNL
   nIzMfHTW3WtDEiX/wwqZRAOORleium+h86OfNfZAJMyFZtMIgpWZrVUO0
   qqmUMVLpN8QAi7f7QoxlivvXOabjiwvsSd9E635SoiHzBelcDSVV0sdgX
   9hRVzrMM7prhwbo/671e+3evtUCGpQa0YHfIqbJXGUXyWBZpvMGn9eEKJ
   ERPTm1BCqCewajqwCq5DgEqjpRD+oHbOQ3TGqnQcEDq4t+jNF69ffAEMG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="254475619"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="254475619"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 11:11:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="733078996"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2022 11:11:51 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlE2x-0008yF-7Y;
        Sun, 01 May 2022 18:11:51 +0000
Date:   Mon, 2 May 2022 02:11:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: (.text+0x810): multiple definition of `pcap_init';
 arch/um/drivers/pcap_kern.o:pcap_kern.c:(.text.unlikely+0x0): first defined
 here
Message-ID: <202205020202.NdcLF129-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2da7df52e16110c8d8dda0602db81c15711e7ff
commit: 5e1121cd43d4d3436140a462bfc230ff8aeb1693 um: Some fixes to build UML with musl
date:   1 year, 7 months ago
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220502/202205020202.NdcLF129-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5e1121cd43d4d3436140a462bfc230ff8aeb1693
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5e1121cd43d4d3436140a462bfc230ff8aeb1693
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: /usr/lib/gcc/x86_64-linux-gnu/11/../../../x86_64-linux-gnu/libpcap.a(pcap.o): in function `pcap_init':
>> (.text+0x810): multiple definition of `pcap_init'; arch/um/drivers/pcap_kern.o:pcap_kern.c:(.text.unlikely+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
