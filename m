Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5FB576AAF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiGOX2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiGOX2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:28:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC66B52FD5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657927679; x=1689463679;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eKrUq/jizIntCZ4/07y5WU5dej2U8dZ4gJgepVElNGI=;
  b=c62AKpT7DpjdAL92pK8NlHcfVolt/nf6ujSVJUGZxSN7Q2LjwPFolyui
   Oqo1tOX26n7jf992CIdi6tMB5Etx6Q6Vv1ByXlBy0iND5y1CX7AlIJNPJ
   +jr8AOv12HKtVIsufokqHUDjwU3uvXh7fhomAMWY0FEFP3w8bMVEDWIfe
   PwWEOOl8RphGt0l2eHgCPAGwAgArV34Yp/5ayskBr7ldm8BdC87t0kmDN
   lpHzk+LKgJ4SndnbtvDihATkQkkCaHYI/xvgWI/gaO5uFicOZOyB2bmsp
   OwLA3DmyARtEOjgNQPNO3LmokO1bZfq4hI+0QkG7lajHtYza2iGhUTfj9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="349883034"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="349883034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 16:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="738841219"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jul 2022 16:27:49 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCUiq-0000s4-Hk;
        Fri, 15 Jul 2022 23:27:48 +0000
Date:   Sat, 16 Jul 2022 07:27:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_events_user.c:392:38: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202207160723.D8leglO3-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
commit: aa3b2b4c669205200615dd8a2cc4af4f81fd0335 user_events: Add print_fmt generation support for basic types
date:   5 months ago
config: sparc64-randconfig-s031-20220716 (https://download.01.org/0day-ci/archive/20220716/202207160723.D8leglO3-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa3b2b4c669205200615dd8a2cc4af4f81fd0335
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout aa3b2b4c669205200615dd8a2cc4af4f81fd0335
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/usb/gadget/function/ drivers/virtio/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
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
