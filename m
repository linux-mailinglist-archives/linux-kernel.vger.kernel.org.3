Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EE053DF48
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348661AbiFFBUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348935AbiFFBUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:20:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD714C42B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 18:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654478404; x=1686014404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NmVZBGlksuSexFuzXYILLT6dasIRhdfxAUrvzCxX+9w=;
  b=WGuZN0swS2WawteKQmT6kKA4RvMwpuDKzKn1750Ryqn/xpbOWT+OQ7Im
   1hSpvpHvEZz7hC1Bq6/aXPdl7J8N60lzapvQ3ZFPfuX9lt0Q0TMVByhBh
   dZxghmVqdgMuWQ+9cu1uHT28vBWJBmV7olLl64V5dpaxZ8UpZvL0JyzKK
   jI0Zmk/TfC8zSFcfaoMe4ti9td5rPGxYobASd3WFLs4jJ4GeTJrkBh/uR
   7l1j4DK941Ft5lb05in7g3hunttVn0lqpnKoODDJwfWPmi3Zuzo7erU0B
   q0TO4qvi4I3vs6CLSVKbXoVaAyFKswRFo+Hi4svD2w2RByONJBYzoznqG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="257054505"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="257054505"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 18:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="682015944"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jun 2022 18:20:03 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny1PW-000CNj-As;
        Mon, 06 Jun 2022 01:20:02 +0000
Date:   Mon, 6 Jun 2022 09:19:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: samples/fprobe/fprobe_example.c:23:15: sparse: sparse: symbol
 'sample_probe' was not declared. Should it be static?
Message-ID: <202206060927.LD3CkG2n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2906aa863381afb0015a9eb7fefad885d4e5a56
commit: f3a112c0c40dd96d53c8bdf3ea8d94d528f3b7b8 x86,rethook,kprobes: Replace kretprobe with rethook on x86
date:   10 weeks ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220606/202206060927.LD3CkG2n-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f3a112c0c40dd96d53c8bdf3ea8d94d528f3b7b8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f3a112c0c40dd96d53c8bdf3ea8d94d528f3b7b8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash samples/fprobe/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> samples/fprobe/fprobe_example.c:23:15: sparse: sparse: symbol 'sample_probe' was not declared. Should it be static?

vim +/sample_probe +23 samples/fprobe/fprobe_example.c

6ee64cc3020b5b Masami Hiramatsu 2022-03-15  20  
6ee64cc3020b5b Masami Hiramatsu 2022-03-15  21  #define BACKTRACE_DEPTH 16
6ee64cc3020b5b Masami Hiramatsu 2022-03-15  22  #define MAX_SYMBOL_LEN 4096
6ee64cc3020b5b Masami Hiramatsu 2022-03-15 @23  struct fprobe sample_probe;
6ee64cc3020b5b Masami Hiramatsu 2022-03-15  24  

:::::: The code at line 23 was first introduced by commit
:::::: 6ee64cc3020b5b5537827c71d8eaac814ad4d346 fprobe: Add sample program for fprobe

:::::: TO: Masami Hiramatsu <mhiramat@kernel.org>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
