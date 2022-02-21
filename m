Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459A84BE44E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356318AbiBUL1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:27:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356308AbiBUL0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:26:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE92712
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645442658; x=1676978658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4lDTi0Ymb7VmmGXBYtiWCetSs8DKqsvQl3orMu6vIQ4=;
  b=kLZURpOv2K6V6WyM7huCFU3ZnLHuDEba1xNzsRVNAoVGuS+YB/3u+zro
   2DD7evIxITw+1fnWKiMcamqAl0dPIHTCEvbs7xV1/mjhNeHPllzCjldnf
   yoAiJ0Tp81wYu5WGCeJlRFQIhYzucNB12u9Fufi78XXXgC6SpYF1S2Mgz
   czOCH1SXh1aajowwqrybTWr7IJ7x3CY0FuEBV9DiP8j2UQUF17zr4QskO
   fiHPouiJUwjuZAKIxLQvMYX4kiHqBCYNJWXLwveA+1qeF9s1glgUpxrE3
   P4CFr9K4qy/lA+nUa0Hc7w6JyJMXq8uQS1nATqOCUuiRNDtLwvH4A6JRz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="249070825"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="249070825"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 03:24:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="547297985"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Feb 2022 03:24:13 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM6nd-0001Xg-54; Mon, 21 Feb 2022 11:24:13 +0000
Date:   Mon, 21 Feb 2022 19:24:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [ammarfaizi2-block:rostedt/linux-trace/for-next 22/32]
 kernel/trace/trace_events_user.c:392:38: sparse: sparse: Using plain integer
 as NULL pointer
Message-ID: <202202211917.j3vO1UWa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/for-next
head:   864ea0e10cc90416a01b46f0d47a6f26dc020820
commit: aa3b2b4c669205200615dd8a2cc4af4f81fd0335 [22/32] user_events: Add print_fmt generation support for basic types
config: x86_64-randconfig-s032-20220221 (https://download.01.org/0day-ci/archive/20220221/202202211917.j3vO1UWa-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/aa3b2b4c669205200615dd8a2cc4af4f81fd0335
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/for-next
        git checkout aa3b2b4c669205200615dd8a2cc4af4f81fd0335
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/trace/trace_events_user.c:392:38: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/trace_events_user.c:413:40: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/trace_events_user.c:858:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:858:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:858:16: sparse:    void *
   kernel/trace/trace_events_user.c:922:13: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/trace_events_user.c:922:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *buf @@     got char * @@
   kernel/trace/trace_events_user.c:922:13: sparse:     expected void [noderef] __user *buf
   kernel/trace/trace_events_user.c:922:13: sparse:     got char *
   kernel/trace/trace_events_user.c:938:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:938:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:938:16: sparse:    void *
   kernel/trace/trace_events_user.c:965:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:965:9: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:965:9: sparse:    void *

vim +392 kernel/trace/trace_events_user.c

   361	
   362	static const char *user_field_format(const char *type)
   363	{
   364		if (strcmp(type, "s64") == 0)
   365			return "%lld";
   366		if (strcmp(type, "u64") == 0)
   367			return "%llu";
   368		if (strcmp(type, "s32") == 0)
   369			return "%d";
   370		if (strcmp(type, "u32") == 0)
   371			return "%u";
   372		if (strcmp(type, "int") == 0)
   373			return "%d";
   374		if (strcmp(type, "unsigned int") == 0)
   375			return "%u";
   376		if (strcmp(type, "s16") == 0)
   377			return "%d";
   378		if (strcmp(type, "u16") == 0)
   379			return "%u";
   380		if (strcmp(type, "short") == 0)
   381			return "%d";
   382		if (strcmp(type, "unsigned short") == 0)
   383			return "%u";
   384		if (strcmp(type, "s8") == 0)
   385			return "%d";
   386		if (strcmp(type, "u8") == 0)
   387			return "%u";
   388		if (strcmp(type, "char") == 0)
   389			return "%d";
   390		if (strcmp(type, "unsigned char") == 0)
   391			return "%u";
 > 392		if (strstr(type, "char[") != 0)
   393			return "%s";
   394	
   395		/* Unknown, likely struct, allowed treat as 64-bit */
   396		return "%llu";
   397	}
   398	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
