Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514E752E013
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245522AbiESWqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiESWqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:46:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D91C924
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653000360; x=1684536360;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4WvROh5tFvwqX1BBN7Nubmp8LnwE/1Ah73J/GrFmz/w=;
  b=cSEIfLWYU8Ykar58nMPeFdn6qo1iI4KygpAgpiirdr/3yOYR3Bq/f47p
   ThHQQVGQCPT62LSYJckXVSjSLOYYHDeOXnK5fiITVKpg6+dk8Cn+guxo0
   wBaP2/11RQtXcRDh1Smz2X+EVl3xen5PH05+CanBCgSJ9nwFjjyHujqZF
   OnRhpBhaHIgR3Ibqq3TZwR67v+c6kIgagFWSAoDqSo6r7hgxnMfKWZQ2V
   Wb/n6ifPlDMH6Rw9Chkntp9ZIt7lAZLCIynbeXC73cJaN6C2UWMjl5VFA
   U+7iQDXeORmHnQehuVAsqcgKTOIPUE0/bdy2jDc9eqaFFYEFFoNHRQB5p
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="252922151"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="252922151"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 15:45:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="640028243"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2022 15:45:56 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrou4-00041D-9U;
        Thu, 19 May 2022 22:45:56 +0000
Date:   Fri, 20 May 2022 06:45:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [netfilter-nf-next:testing 9/12] core.c:undefined reference to
 `nf_hook_bpf_create'
Message-ID: <202205200652.Klq9MYkT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
head:   4456ac35299c131e2ac26b4dc025b257d810277b
commit: 11b2910d788799e8c68df305994260fd79a61e10 [9/12] netfilter: add bpf base hook program generator
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220520/202205200652.Klq9MYkT-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=11b2910d788799e8c68df305994260fd79a61e10
        git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
        git fetch --no-tags netfilter-nf-next testing
        git checkout 11b2910d788799e8c68df305994260fd79a61e10
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/netfilter/core.o: in function `nf_hook_entries_grow':
>> core.c:(.text+0x893): undefined reference to `nf_hook_bpf_create'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
