Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6FF4FCF25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348467AbiDLFz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiDLFzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:55:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6F83525F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649742819; x=1681278819;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qNG+1tG+siToSo3ljGtjfUN0ctqLiV1skUN/CRKaDmE=;
  b=PsZX+duS8Kqv8grhK8ngrO1h0qQfv3HR/FIvVatr0t9/TmpoSZJMh+R5
   rMT+f+v/stM++OKkmEY+/AldYuty/5cAFQeD9ngAlI2lYMNG4L0pNF6QC
   0jnVK/vdllr0v4Kd0FY2uWn6eO0eoEa3PEiSyyQpzME9b7Obs7spGg4C8
   6Zu1tj/t4QNgDNYBbwWOmtEo/ksJoUgYJ8a+Png50GdhEoFumX9Os0e76
   R0/aZd9Vf2AeGJWqy93WOju4GEmr8Qtg6WAruVPq+rK8gKcDqjzF1ufWT
   oCqeM9q3zwrE6z36aU7pzKfEXqaBHToTdSeLft3PWmbqGDUHM5ReAV5Zf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242869476"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="242869476"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 22:53:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="660346509"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Apr 2022 22:53:37 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne9T6-0002YC-Qc;
        Tue, 12 Apr 2022 05:53:36 +0000
Date:   Tue, 12 Apr 2022 13:52:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpoimboe:objtool-run 5/5] arch/x86/lib/copy_user_64.o: warning:
 objtool: copy_user_enhanced_fast_string() falls through to next function
 copy_user_generic_unrolled()
Message-ID: <202204121317.36kQoGCk-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-run
head:   0060ff03f4882dcb7911b968e5d1f31aaf840c33
commit: 0060ff03f4882dcb7911b968e5d1f31aaf840c33 [5/5] todo
config: x86_64-randconfig-c022-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121317.36kQoGCk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=0060ff03f4882dcb7911b968e5d1f31aaf840c33
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe objtool-run
        git checkout 0060ff03f4882dcb7911b968e5d1f31aaf840c33
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/lib/copy_user_64.o: warning: objtool: copy_user_enhanced_fast_string() falls through to next function copy_user_generic_unrolled()
--
>> arch/x86/lib/memcpy_64.o: warning: objtool: __memcpy() falls through to next function memcpy_erms()
--
>> arch/x86/lib/memset_64.o: warning: objtool: __memset() falls through to next function memset_erms()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
