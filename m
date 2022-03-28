Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F284E9124
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiC1JY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiC1JYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:24:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B993252E70
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648459364; x=1679995364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hjTpiirgF/3p/aN1MiU+xZ6eVaT7/Me7+/w10TNeV2M=;
  b=E0/e54gL4tEikVv1jTp5MeRfG7FVBjWl13Dr1daPvraTlSyxTtF+dbaw
   m4gCf/p6q7B/1zL3WeTVKC+tPOUokCYTPBdzm/jInftH2p6IvFYdqbnLR
   Q40u/dj85BA7IzvPfCoanw3ntqYAJTTtCMC37xe+hRQPH8yaYQYY9SYwx
   TSSq+tYlSVY0BtVbXhaR4YBPqtiIBTxOiSclkf0KQJ3stAOn3wd2Q4ziu
   ShGMTEOvGNpkB9m05yiAFUUVQgSYOxqW0/D/3c5SVGs+gearYME3wDlRY
   jeZU0TBQUFIyN6tI3IkqEyxgZysKffS19bNOJFv3DZK2JLmOHkm1SC0bf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="256531127"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="256531127"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 02:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="563478824"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 28 Mar 2022 02:22:42 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYlaE-0001um-4r; Mon, 28 Mar 2022 09:22:42 +0000
Date:   Mon, 28 Mar 2022 17:22:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_events_user.c:392:38: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202203281754.okRdoDAL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
commit: aa3b2b4c669205200615dd8a2cc4af4f81fd0335 user_events: Add print_fmt generation support for basic types
date:   6 weeks ago
config: i386-randconfig-s001-20220328 (https://download.01.org/0day-ci/archive/20220328/202203281754.okRdoDAL-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa3b2b4c669205200615dd8a2cc4af4f81fd0335
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout aa3b2b4c669205200615dd8a2cc4af4f81fd0335
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/apei/ drivers/gpu/drm/ kernel/trace/

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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
