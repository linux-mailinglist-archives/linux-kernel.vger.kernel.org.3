Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D996D591AAA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiHMNia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbiHMNiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:38:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411EDB7D5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660397902; x=1691933902;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lNxmtn7TP3KZN3UEnL13yw1zfYL3pBdnH/f59m3DyYY=;
  b=VFCID8EDSpPqcMsqud48iSKUfDALs0IgYxgqCgM0Wqy1+FT6ziMiyJXB
   iVubJ1l+C+iqxKzpP90/8UQkQLzLxVkU4m+DomaYDFQJN7mfQG8y+rXQQ
   19LJOde/qJhuVkEhxulRv2+75yAIlIF7Rs5Pn/VOhP75IpTZCG+oGsq2u
   0d/AU68NC4+yQB6m8RSOKWmTqNVXEEX+YRIdUYu7o5OUe8xwsgjYKAuxo
   h7jI+6INyzYT4tlGfANdf8PspZpYYwtFmD4IuOyxrSarT/KKsm63ocdxq
   ltB4tOND1ZmCefI2YHOSCUeLTidARsjzv1ArU5vFhUDJRn1g2skyRaMcM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="317730183"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="317730183"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 06:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="602762016"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Aug 2022 06:38:19 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMrLG-0001iV-2t;
        Sat, 13 Aug 2022 13:38:18 +0000
Date:   Sat, 13 Aug 2022 21:37:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/tracing_multi_new_1 22/23]
 kernel/bpf/syscall.c:3150:20: error: field has incomplete type 'struct
 ftrace_ops'
Message-ID: <202208132147.npPyYMne-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/tracing_multi_new_1
head:   e27bb6c0f6805082ef71568985f74dcefe7ff6ff
commit: dc38a65ab46f4ba538353c1eb7c64ac36202eb54 [22/23] fix
config: mips-randconfig-r031-20220804 (https://download.01.org/0day-ci/archive/20220813/202208132147.npPyYMne-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=dc38a65ab46f4ba538353c1eb7c64ac36202eb54
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/tracing_multi_new_1
        git checkout dc38a65ab46f4ba538353c1eb7c64ac36202eb54
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/bpf/syscall.c:2523:15: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           multi_func = is_tracing_multi(attr->expected_attach_type);
                        ^
>> kernel/bpf/syscall.c:3150:20: error: field has incomplete type 'struct ftrace_ops'
           struct ftrace_ops fops;
                             ^
   include/linux/bpf.h:51:8: note: forward declaration of 'struct ftrace_ops'
   struct ftrace_ops;
          ^
   kernel/bpf/syscall.c:3158:15: error: call to undeclared function 'bpf_trampoline_multi_detach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           WARN_ON_ONCE(bpf_trampoline_multi_detach(&tr_link->fops, &tr_link->tp, tr_link->id));
                        ^
   kernel/bpf/syscall.c:3166:2: error: call to undeclared function 'bpf_tramp_id_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           bpf_tramp_id_put(tr_link->id);
           ^
   kernel/bpf/syscall.c:3166:2: note: did you mean 'bpf_trampoline_put'?
   include/linux/bpf.h:1021:20: note: 'bpf_trampoline_put' declared here
   static inline void bpf_trampoline_put(struct bpf_trampoline *tr) {}
                      ^
   kernel/bpf/syscall.c:3329:7: error: call to undeclared function 'bpf_tramp_id_alloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           id = bpf_tramp_id_alloc(cnt);
                ^
   kernel/bpf/syscall.c:3329:5: error: incompatible integer to pointer conversion assigning to 'struct bpf_tramp_id *' from 'int' [-Wint-conversion]
           id = bpf_tramp_id_alloc(cnt);
              ^ ~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/syscall.c:3370:8: error: call to undeclared function 'bpf_trampoline_multi_attach'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           err = bpf_trampoline_multi_attach(&link->fops, &link->tp, id);
                 ^
   kernel/bpf/syscall.c:3370:8: note: did you mean 'bpf_tracing_multi_attach'?
   kernel/bpf/syscall.c:3314:12: note: 'bpf_tracing_multi_attach' declared here
   static int bpf_tracing_multi_attach(struct bpf_prog *prog,
              ^
   kernel/bpf/syscall.c:4842:12: error: call to undeclared function 'is_tracing_multi'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   else if (is_tracing_multi(prog->expected_attach_type))
                            ^
   8 errors generated.


vim +3150 kernel/bpf/syscall.c

  3144	
  3145	struct bpf_tracing_multi_link {
  3146		struct bpf_link link;
  3147		enum bpf_attach_type attach_type;
  3148		struct bpf_tramp_prog tp;
  3149		struct bpf_tramp_id *id;
> 3150		struct ftrace_ops fops;
  3151	};
  3152	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
