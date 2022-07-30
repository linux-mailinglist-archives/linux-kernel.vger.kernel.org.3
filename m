Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF758581F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 04:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbiG3Cxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 22:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiG3Cxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 22:53:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078EFDEC9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 19:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659149618; x=1690685618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vhKf90t6KvqONIdB8vqV3sB+z3Ml92QmyBashDzdK4E=;
  b=ImXAOlOKCcNJjYSRAS6jzJkMzHsSLPPCpH1TFMp2o0WmjEKoP4JsLnoZ
   v4wJBky98oZpjx+nh5h01Ub9d4TMmNPgkXCi878vmBZNpxCTJObnOEW1L
   InGWuNrfV9e2Eb5HSo6yRN0hBbq2cesNI/aE2rT5B2/XyApJJsDZlIrMD
   Jr2tpNBnDzPUsn7vIy/GhnDzibeY7K+tivY3CwzgSSZO0gI1Cj3Zd2VU5
   JvIx5c4KOpeliCAqyu5v6/ULRpM4X4E6fd6a0NepHzyQD2mN65g7vSlj2
   PWcF8/BzGekH6Tfja5OhsUH61Avgzey23SaGrbbUZau6aQbFEPzOKpoK6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="287641316"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="287641316"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 19:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="577162244"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Jul 2022 19:53:34 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHcbe-000CJ7-07;
        Sat, 30 Jul 2022 02:53:34 +0000
Date:   Sat, 30 Jul 2022 10:52:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/fineibt 3/4] fgraph.c:undefined reference to
 `ftrace_stub_graph'
Message-ID: <202207301052.NQbDVC7Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fineibt
head:   365543b24a9e31c0c89457717391cdb819cc5501
commit: 311ed6d0d57a551f834efd610dc8b14867012a68 [3/4] ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220730/202207301052.NQbDVC7Z-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=311ed6d0d57a551f834efd610dc8b14867012a68
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/fineibt
        git checkout 311ed6d0d57a551f834efd610dc8b14867012a68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: kernel/trace/fgraph.o: in function `unregister_ftrace_graph':
>> fgraph.c:(.text+0xf6c): undefined reference to `ftrace_stub_graph'
>> ld: kernel/trace/fgraph.o:(.data+0x31c): undefined reference to `ftrace_stub_graph'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
