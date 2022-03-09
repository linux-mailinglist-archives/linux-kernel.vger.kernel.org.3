Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D401D4D359A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbiCIQ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbiCIQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:21:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ED13A5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646842819; x=1678378819;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uQaFjxnhDmWW/A/begYFww9lfX3qbyY1C3VpweNIXT4=;
  b=cAstdKAcJjaVun/U32rKoscbjEL1nzOfjVxWbZ+grMKxPiTv9oYfsHTE
   a7o38Oew0kD66j33WZRzq87jgqlSZYhkM/Qro/K9PJ1M7kPWRC9nO9mWb
   rQxm/PcwqPRAAtUHwaWYmjshdriClzxDX/qWG81OQoAJIjzIbvJzeUYjt
   3EcTkU6SX+ahUuatqpwsygyE0dr/VDG/ExTOjdGJzoBPAJo0JOlWzeMyC
   qmirMpBst5SsYln1cJwm7mPPvWZ400FGra8mhv9SGiLvnzbPypwze5YzG
   FP0BkXUda5HInzkND34ybzdroRZ4pou5wqRZliyNaEv7LM2XbEzuGlLJF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="279741257"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="279741257"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 08:20:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="578435113"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2022 08:20:16 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRz2t-0003Wo-H0; Wed, 09 Mar 2022 16:20:15 +0000
Date:   Thu, 10 Mar 2022 00:19:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Subject: /tmp/ccxeevnD.s: Warning: Can not find match relax hint.  Line: 1775
Message-ID: <202203100020.Ow4SqtVo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexei,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   330f4c53d3c2d8b11d86ec03a964b86dc81452f5
commit: 29db4bea1d10b73749d7992c1fc9ac13499e8871 bpf: Prepare relo_core.c for kernel duty.
date:   3 months ago
config: nds32-buildonly-randconfig-r002-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100020.Ow4SqtVo-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29db4bea1d10b73749d7992c1fc9ac13499e8871
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 29db4bea1d10b73749d7992c1fc9ac13499e8871
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   tools/lib/bpf/relo_core.c: In function 'bpf_core_apply_relo_insn':
   tools/lib/bpf/relo_core.c:1346:1: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1346 | }
         | ^
   /tmp/ccxeevnD.s: Assembler messages:
>> /tmp/ccxeevnD.s: Warning: Can not find match relax hint.  Line: 1775

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
