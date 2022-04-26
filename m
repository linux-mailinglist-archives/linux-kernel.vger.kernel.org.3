Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C3A50EF64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbiDZDtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243522AbiDZDtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:49:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A243DA4F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 20:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650944795; x=1682480795;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=emfwYc5fgHxI2OznSJXHIzi/JD0lS47tRN/WzpvOD5E=;
  b=Qjl3o7uUu8ODDR63I1iIX3Xdcs1CO6odFRLnxhhq9XVuFbplqPtsXXDX
   fapapljO01hptOziSQzfCrm8F4qqGo823KBgihaXR5Rj9/y9uNHzXRVHE
   VYjiRYKsSMcxA7466Vdilo7+KjsI+FbPK/pQTkGMD6XKJWE0Bk9DjIP6W
   5cYauZivhckpLyyULaFaLSbd6gUmeNE17uzXYv+y5vEVT1f1AmeUCm1Kl
   yjw+VPFetdZdPc4uwfNQOnJFhQeG1hRKkmIKJStDMJYiHOrGZ/QxvEz4a
   TvF2SwhbFSk/a9k/xoKpx/lDGK1QeW0Jbp91ly/M+oVmmJpPj/ZIV6KCv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="351882436"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="351882436"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 20:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="677962620"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Apr 2022 20:46:20 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njC9b-0003Bk-JT;
        Tue, 26 Apr 2022 03:46:19 +0000
Date:   Tue, 26 Apr 2022 11:45:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2022.04.18b] BUILD REGRESSION
 ad68d8bf085421e4f22731c8b64c0b774a154e06
Message-ID: <62676af1.i7L+J5fhS2CqZy/O%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2022.04.18b
branch HEAD: ad68d8bf085421e4f22731c8b64c0b774a154e06  rcu/nocb: Add an option to offload all CPUs on boot

Error/Warning reports:

https://lore.kernel.org/lkml/202204202111.gA58hkDX-lkp@intel.com
https://lore.kernel.org/llvm/202204201732.oTzYh0Xo-lkp@intel.com
https://lore.kernel.org/llvm/202204202254.kr5zvuSL-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

include/linux/cpumask.h:276:9: error: expected identifier or '(' before 'for'
include/linux/cpumask.h:277:25: error: initializer element is not constant
include/linux/cpumask.h:278:23: error: expected '=', ',', ';', 'asm' or '__attribute__' before '<' token
include/linux/cpumask.h:278:36: error: expected identifier or '(' before ')' token
kernel/rcu/tree_nocb.h:1213:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
kernel/rcu/tree_nocb.h:1217:9: error: expected identifier or '(' before 'if'
kernel/rcu/tree_nocb.h:1245:9: error: expected identifier or '(' before 'else'
kernel/rcu/tree_nocb.h:1251:22: error: type defaults to 'int' in declaration of 'cpu' [-Werror=implicit-int]
kernel/rcu/tree_nocb.h:1259:9: error: conflicting types for 'rcu_organize_nocb_kthreads'; have 'int()'
kernel/rcu/tree_nocb.h:1259:9: error: function declaration isn't a prototype [-Werror=strict-prototypes]
kernel/rcu/tree_nocb.h:1259:9: error: type defaults to 'int' in declaration of 'rcu_organize_nocb_kthreads' [-Werror=implicit-int]
kernel/rcu/tree_nocb.h:1260:1: error: expected identifier or '(' before '}' token
kernel/rcu/tree_nocb.h:1339:20: error: conflicting types for 'rcu_organize_nocb_kthreads'; have 'void(void)'

Unverified Error/Warning (likely false positive, please contact us if interested):

include/linux/cpumask.h:277:17: warning: data definition has no type or storage class
kernel/rcu/tree_nocb.h:1199:14: warning: variable 'need_rcu_nocb_mask' set but not used [-Wunused-but-set-variable]
kernel/rcu/tree_nocb.h:1200:14: warning: variable 'offload_all' set but not used [-Wunused-but-set-variable]
kernel/rcu/tree_nocb.h:1211:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
kernel/rcu/tree_nocb.h:1217:2: error: expected identifier or '('
kernel/rcu/tree_nocb.h:1259:28: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
kernel/rcu/tree_nocb.h:1259:2: error: conflicting types for 'rcu_organize_nocb_kthreads'
kernel/rcu/tree_nocb.h:1259:2: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
kernel/rcu/tree_nocb.h:1259:9: warning: data definition has no type or storage class
kernel/rcu/tree_nocb.h:1260:1: error: extraneous closing brace ('}')

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-randconfig-r031-20220420
|   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
|   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
|   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
|-- riscv-randconfig-r002-20220420
|   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
|   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
|   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
|-- sparc64-randconfig-c003-20220420
|   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
|   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
|   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
|   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
|   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
|   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
|   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
|-- sparc64-randconfig-r025-20220420
|   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
|   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
|   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
|   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
|   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
|   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
|   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
|-- x86_64-randconfig-a015
|   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
|   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
|   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
|   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
|   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
|   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
|   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
|-- x86_64-randconfig-s021
|   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
|   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
|   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
|   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
|   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
|   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
|   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
|-- x86_64-randconfig-s022
|   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
|   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
|   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
|   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
|   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
|   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
|   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
|-- x86_64-rhel-8.3
|   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
|   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
|   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
|   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
|   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
|   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
|   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
|-- x86_64-rhel-8.3-func
|   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
|   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
|   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
|   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
|   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
|   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
|   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
|-- x86_64-rhel-8.3-kselftests
|   |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
|   |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
|   |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
|   |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
|   |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
|   |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
|   |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
|   |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
|   |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
|   `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used
`-- x86_64-rhel-8.3-kunit
    |-- include-linux-cpumask.h:error:expected-asm-or-__attribute__-before-token
    |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-)-token
    |-- include-linux-cpumask.h:error:expected-identifier-or-(-before-for
    |-- include-linux-cpumask.h:error:initializer-element-is-not-constant
    |-- include-linux-cpumask.h:warning:data-definition-has-no-type-or-storage-class
    |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-int()
    |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads-have-void(void)
    |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-else
    |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-if
    |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(-before-token
    |-- kernel-rcu-tree_nocb.h:error:function-declaration-isn-t-a-prototype
    |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-cpu
    |-- kernel-rcu-tree_nocb.h:error:type-defaults-to-int-in-declaration-of-rcu_organize_nocb_kthreads
    |-- kernel-rcu-tree_nocb.h:warning:data-definition-has-no-type-or-storage-class
    |-- kernel-rcu-tree_nocb.h:warning:this-if-clause-does-not-guard...
    |-- kernel-rcu-tree_nocb.h:warning:variable-need_rcu_nocb_mask-set-but-not-used
    `-- kernel-rcu-tree_nocb.h:warning:variable-offload_all-set-but-not-used

clang_recent_errors
|-- arm64-randconfig-r014-20220420
|   `-- kernel-rcu-tree_nocb.h:warning:misleading-indentation-statement-is-not-part-of-the-previous-if
|-- riscv-randconfig-r024-20220420
|   |-- kernel-rcu-tree_nocb.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
|   |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads
|   |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(
|   |-- kernel-rcu-tree_nocb.h:error:extraneous-closing-brace-(-)
|   |-- kernel-rcu-tree_nocb.h:error:type-specifier-missing-defaults-to-int-Werror-Wimplicit-int
|   `-- kernel-rcu-tree_nocb.h:warning:misleading-indentation-statement-is-not-part-of-the-previous-if
`-- x86_64-randconfig-a014
    |-- kernel-rcu-tree_nocb.h:error:a-function-declaration-without-a-prototype-is-deprecated-in-all-versions-of-C-Werror-Wstrict-prototypes
    |-- kernel-rcu-tree_nocb.h:error:conflicting-types-for-rcu_organize_nocb_kthreads
    |-- kernel-rcu-tree_nocb.h:error:expected-identifier-or-(
    |-- kernel-rcu-tree_nocb.h:error:extraneous-closing-brace-(-)
    |-- kernel-rcu-tree_nocb.h:error:type-specifier-missing-defaults-to-int-Werror-Wimplicit-int
    `-- kernel-rcu-tree_nocb.h:warning:misleading-indentation-statement-is-not-part-of-the-previous-if

elapsed time: 8791m

configs tested: 156
configs skipped: 4

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
sh                          rsk7203_defconfig
powerpc                 linkstation_defconfig
sh                 kfr2r09-romimage_defconfig
riscv                            allmodconfig
m68k                          hp300_defconfig
m68k                       m5208evb_defconfig
powerpc                      ppc6xx_defconfig
arc                                 defconfig
powerpc                     asp8347_defconfig
sh                           se7712_defconfig
arc                        nsim_700_defconfig
ia64                             alldefconfig
arm                            qcom_defconfig
nios2                         3c120_defconfig
mips                        vocore2_defconfig
powerpc                     tqm8541_defconfig
powerpc                        cell_defconfig
powerpc                     mpc83xx_defconfig
arm                         nhk8815_defconfig
powerpc                     stx_gp3_defconfig
ia64                      gensparse_defconfig
sh                        apsh4ad0a_defconfig
mips                         cobalt_defconfig
arm                        trizeps4_defconfig
sh                                  defconfig
arc                      axs103_smp_defconfig
sh                          sdk7780_defconfig
arm                          pxa910_defconfig
powerpc64                           defconfig
powerpc                       ppc64_defconfig
parisc                           alldefconfig
parisc64                            defconfig
arc                          axs101_defconfig
sh                             shx3_defconfig
ia64                          tiger_defconfig
powerpc                  iss476-smp_defconfig
m68k                                defconfig
s390                          debug_defconfig
arm                            xcep_defconfig
arm                          pxa3xx_defconfig
sparc                       sparc32_defconfig
powerpc                      pcm030_defconfig
xtensa                    smp_lx200_defconfig
s390                             allyesconfig
sh                   secureedge5410_defconfig
arm64                            alldefconfig
sh                          polaris_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220420
arm                  randconfig-c002-20220421
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220420
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220422
mips                 randconfig-c004-20220422
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220422
powerpc              randconfig-c003-20220422
s390                 randconfig-c005-20220422
riscv                randconfig-c006-20220424
mips                 randconfig-c004-20220424
arm                  randconfig-c002-20220424
powerpc              randconfig-c003-20220424
mips                        bcm63xx_defconfig
arm                         orion5x_defconfig
powerpc                      walnut_defconfig
arm                        vexpress_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         socfpga_defconfig
arm                       spear13xx_defconfig
mips                         tb0219_defconfig
powerpc                        fsp2_defconfig
powerpc                     tqm8560_defconfig
powerpc                     tqm5200_defconfig
mips                malta_qemu_32r6_defconfig
mips                      bmips_stb_defconfig
hexagon                          alldefconfig
arm                     davinci_all_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220420
riscv                randconfig-r042-20220420
hexagon              randconfig-r045-20220420
s390                 randconfig-r044-20220420

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
