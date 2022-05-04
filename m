Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016DC51ACC8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbiEDSbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376867AbiEDSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:31:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5644166C81
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651687560; x=1683223560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i4VjohVRk6C9yOQqqNaki7TT3jcWJWu2LsakiJgdnaY=;
  b=MX94HyOutKDJQhTDL7VcnF6HYV+ufiUnHRWxaV05eVlc7R3b55Ti6lyU
   +DTUL3EvthkG7uwJG2DRgqQ5BGJJqli1Q7MRk+vR5qWcB5XuF10ukB6kd
   ToSIvHSFYWRwryZit4P4QpIgsWFT1Wu14iD7c9Gb9lX9rPqI8pZdm+nT3
   NTAbTdzVJMQkR722KR2/BQYLxaFHJHRKclaILce/HAka1jpnv5NrCsClM
   2cRxg/wIaqPSd9rmdJTq9Mm6PX2X71foqJt/XeE1KvppaH+16/Fiah8MY
   cBTWGGmZUm2t1pJVAWMxCuJ338OIU4Bv7CRKmwaCSciqxpSbUGmsTLDJy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="247756642"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="247756642"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 11:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; 
   d="scan'208";a="536949285"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2022 11:05:19 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmJNG-000BgJ-Le;
        Wed, 04 May 2022 18:05:18 +0000
Date:   Thu, 5 May 2022 02:04:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [masahiroy:lto-cleanup-wip 53/61] scripts/mod/modpost.c:2311:52:
 error: 'struct symbol' has no member named 'is_gpl'
Message-ID: <202205050152.9MufMAJv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git lto-cleanup-wip
head:   63a6c25309d336a3bc7185d4fa17fc9e64485d95
commit: 14beda2dc5aff83f69fd5ecf83309250c5c03d79 [53/61] kbuild: embed symbol versions at final link of vmlinux or modules
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220505/202205050152.9MufMAJv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=14beda2dc5aff83f69fd5ecf83309250c5c03d79
        git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
        git fetch --no-tags masahiroy lto-cleanup-wip
        git checkout 14beda2dc5aff83f69fd5ecf83309250c5c03d79
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/um/user-offsets.c:17:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      17 | void foo(void)
         |      ^~~
   scripts/mod/modpost.c: In function 'add_exported_symversions':
>> scripts/mod/modpost.c:2311:52: error: 'struct symbol' has no member named 'is_gpl'
    2311 |                            sym->name, sym->crc, sym->is_gpl ? "_gpl" : "");
         |                                                    ^~
   make[2]: *** [scripts/Makefile.host:112: scripts/mod/modpost.o] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +2311 scripts/mod/modpost.c

  2287	
  2288	/* Record CRCs for exported symbols */
  2289	static void add_exported_symversions(struct buffer *buf, struct module *mod)
  2290	{
  2291		struct symbol *sym;
  2292	
  2293		if (!modversions)
  2294			return;
  2295	
  2296		buf_printf(buf,
  2297			   "\n"
  2298			   "#include <linux/symversion.h>\n"
  2299			   "\n");
  2300	
  2301		list_for_each_entry(sym, &mod->exported_symbols, list) {
  2302			if (!sym->crc_valid) {
  2303				warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n"
  2304				     "Is \"%s\" prototyped in <asm/asm-prototypes.h>?\n",
  2305				     sym->name, mod->name, mod->is_vmlinux ? "" : ".ko",
  2306				     sym->name);
  2307				continue;
  2308			}
  2309	
  2310			buf_printf(buf, "SYMBOL_CRC(%s, 0x%08x, \"%s\");\n",
> 2311				   sym->name, sym->crc, sym->is_gpl ? "_gpl" : "");
  2312		}
  2313	}
  2314	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
