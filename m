Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A054B06DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiBJHTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:19:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiBJHTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:19:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0476D1E1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644477574; x=1676013574;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K/9aW3Pi3IUljXaf8zBqBIgFBTMOjs8cQai7xvrjgBw=;
  b=lKRICyUxmZE34jDz5nCOYiWHkS+/nXd0PUtJ4z8K5k79MNxdTHnWDe+d
   ztVygdbqcrGs9P1CQX8G4/Pdzkqi6LmE1oDkyQw/ZbJ01GXBCTg2uiVGC
   SrAtKOYrXJVQGBZ7tXGTQ1Cjihysur4IhfkcXNlm4nSxhENwuFFr0bOMY
   5zGPjWYpFogSR+YObSh1CN5MG3rDFgc+yNtvlTMF2yIa0cqdE2RoN+W0q
   4OJ7dK35Z5cCTAUNJKk0aRgOqjQ4wf3fCb1Ix+h1/sqXnOTog0xlNfHKe
   q3jFk7mj+YiRanBsV950egvzOBUVggfydlRYefR1CozauQ2pCd8+ENCDu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="312717743"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="312717743"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 23:19:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="526366445"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2022 23:19:32 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nI3jn-0002si-IM; Thu, 10 Feb 2022 07:19:31 +0000
Date:   Thu, 10 Feb 2022 15:19:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: [ammarfaizi2-block:bpf/bpf-next/master 212/245]
 arch/powerpc/net/bpf_jit_comp.c:250:59: error: 'struct bpf_binary_header'
 has no member named 'pages'
Message-ID: <202202101503.p1WYvmmS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block bpf/bpf-next/master
head:   e5313968c41ba890a91344773a0474d0246d20a3
commit: ed2d9e1a26cca963ff5ed3b76326d70f7d8201a9 [212/245] bpf: Use size instead of pages in bpf_binary_header
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220210/202202101503.p1WYvmmS-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ed2d9e1a26cca963ff5ed3b76326d70f7d8201a9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block bpf/bpf-next/master
        git checkout ed2d9e1a26cca963ff5ed3b76326d70f7d8201a9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/bpf/bpf-next/master HEAD e5313968c41ba890a91344773a0474d0246d20a3 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   arch/powerpc/net/bpf_jit_comp.c: In function 'bpf_int_jit_compile':
>> arch/powerpc/net/bpf_jit_comp.c:250:59: error: 'struct bpf_binary_header' has no member named 'pages'
     250 |         bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + (bpf_hdr->pages * PAGE_SIZE));
         |                                                           ^~


vim +250 arch/powerpc/net/bpf_jit_comp.c

4ea76e90a97d22 Christophe Leroy 2021-03-22  245  
4ea76e90a97d22 Christophe Leroy 2021-03-22  246  	fp->bpf_func = (void *)image;
4ea76e90a97d22 Christophe Leroy 2021-03-22  247  	fp->jited = 1;
983bdc0245a29c Ravi Bangoria    2021-10-12  248  	fp->jited_len = proglen + FUNCTION_DESCR_SIZE;
4ea76e90a97d22 Christophe Leroy 2021-03-22  249  
4ea76e90a97d22 Christophe Leroy 2021-03-22 @250  	bpf_flush_icache(bpf_hdr, (u8 *)bpf_hdr + (bpf_hdr->pages * PAGE_SIZE));
4ea76e90a97d22 Christophe Leroy 2021-03-22  251  	if (!fp->is_func || extra_pass) {
44a8214de96baf Hari Bathini     2021-10-25  252  		bpf_jit_binary_lock_ro(bpf_hdr);
4ea76e90a97d22 Christophe Leroy 2021-03-22  253  		bpf_prog_fill_jited_linfo(fp, addrs);
4ea76e90a97d22 Christophe Leroy 2021-03-22  254  out_addrs:
4ea76e90a97d22 Christophe Leroy 2021-03-22  255  		kfree(addrs);
4ea76e90a97d22 Christophe Leroy 2021-03-22  256  		kfree(jit_data);
4ea76e90a97d22 Christophe Leroy 2021-03-22  257  		fp->aux->jit_data = NULL;
4ea76e90a97d22 Christophe Leroy 2021-03-22  258  	} else {
4ea76e90a97d22 Christophe Leroy 2021-03-22  259  		jit_data->addrs = addrs;
4ea76e90a97d22 Christophe Leroy 2021-03-22  260  		jit_data->ctx = cgctx;
4ea76e90a97d22 Christophe Leroy 2021-03-22  261  		jit_data->proglen = proglen;
4ea76e90a97d22 Christophe Leroy 2021-03-22  262  		jit_data->image = image;
4ea76e90a97d22 Christophe Leroy 2021-03-22  263  		jit_data->header = bpf_hdr;
4ea76e90a97d22 Christophe Leroy 2021-03-22  264  	}
4ea76e90a97d22 Christophe Leroy 2021-03-22  265  
4ea76e90a97d22 Christophe Leroy 2021-03-22  266  out:
4ea76e90a97d22 Christophe Leroy 2021-03-22  267  	if (bpf_blinded)
4ea76e90a97d22 Christophe Leroy 2021-03-22  268  		bpf_jit_prog_release_other(fp, fp == org_fp ? tmp_fp : org_fp);
4ea76e90a97d22 Christophe Leroy 2021-03-22  269  
4ea76e90a97d22 Christophe Leroy 2021-03-22  270  	return fp;
4ea76e90a97d22 Christophe Leroy 2021-03-22  271  }
983bdc0245a29c Ravi Bangoria    2021-10-12  272  

:::::: The code at line 250 was first introduced by commit
:::::: 4ea76e90a97d22f86adbb10044d29d919e620f2e powerpc/bpf: Move common functions into bpf_jit_comp.c

:::::: TO: Christophe Leroy <christophe.leroy@csgroup.eu>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
