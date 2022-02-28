Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BF84C6110
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiB1CVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiB1CVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:21:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DDE6C1D6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 18:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646014825; x=1677550825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IX7f15uhCPtjOqUj/3Fj5lIZzjSqwFtZgboxTiGywSA=;
  b=b14zFWErSaG8UJGkGI3n8YCHvlQifPm08+cABOftI1I8cxeUFyivk9MY
   yG3Vg7nyFRpjYqxKKTYJzfb0AqyOmty+WwNPn2vYKXtBx0IjuXomZND0F
   jA04hGWXLZMno7Egps7MA0TjAc+uvz5CJ8Oozm0sqgVqxZbG/nU04MDaJ
   UGavIi8yswc0F0TWoEcYWbH/Ckoue0RtRl0ApHREx7kywV/dK9srbYA1n
   rzED3334fg9vUftk2zlzulaABIhVdctTWn1Apf4lqPtxaj8uzYb03yf1u
   /JaWQnl82jeebdQx0h3as+A+8c1FsfqG0v/s1opIXC26HLG4RFt6sByO0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="232755618"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="232755618"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 18:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="708476735"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2022 18:20:23 -0800
Date:   Mon, 28 Feb 2022 10:20:22 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: {standard input}:2277: Error: pcrel offset for branch to .LS000B
 too far (0x3c)
Message-ID: <20220228022022.GG4548@shbuild999.sh.intel.com>
References: <202202271612.W32UJAj2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202271612.W32UJAj2-lkp@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 04:29:30PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2293be58d6a18cab800e25e42081bacb75c05752
> commit: cf536e185869d4815d506e777bcca6edd9966a6e Makefile: extend 32B aligned debug option to 64B aligned
> date:   9 months ago
> config: csky-randconfig-r003-20220227 (https://download.01.org/0day-ci/archive/20220227/202202271612.W32UJAj2-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf536e185869d4815d506e777bcca6edd9966a6e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout cf536e185869d4815d506e777bcca6edd9966a6e
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    {standard input}: Assembler messages:
> >> {standard input}:2277: Error: pcrel offset for branch to .LS000B too far (0x3c)

Thanks for the report! can you try this following fix? 

Thanks,
Feng

---

From c386ee06e5dbc89b69a0a58edace3f54fd5e2b8f Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Mon, 28 Feb 2022 09:44:04 +0800
Subject: [PATCH] lib/Kconfig.debug: add ARCH dependency for FUNCTION_ALIGNMENT
 option

0Day robots reported there is compiling issue for 'csky' ARCH
when CONFIG_DEBUG_FORCE_DATA_SECTION_ALIGNED is enabled:

"
All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:2277: Error: pcrel offset for branch to .LS000B too far (0x3c)
"

Which has been discussed in [1]. And as there is no solution for csky
yet, add some dependency for this config to limit it to several ARCHs
which have no compiling issue so far.

[1]. https://www.spinics.net/lists/linux-kbuild/msg30298.html

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..39298958ad3a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -417,6 +417,7 @@ config SECTION_MISMATCH_WARN_ONLY
 
 config DEBUG_FORCE_FUNCTION_ALIGN_64B
 	bool "Force all function address 64B aligned" if EXPERT
+	depends on PPC || ARM || X86
 	help
 	  There are cases that a commit from one domain changes the function
 	  address alignment of other domains, and cause magic performance
-- 
2.27.0

