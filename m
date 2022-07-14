Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217F05752A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiGNQWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiGNQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:22:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA18662494
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657815749; x=1689351749;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NWWyJ0+BJR4OZy7OqwOmT/M1PbOFhDAx1wh/tO/XuYc=;
  b=n/7O6MMb2/oOIk/WlYjVKGlOVxVJxzUGPrzUL8fQltaMUp7iQb+rp6vz
   J3Y1WkNm/TixRjVAkZJQ+TkQ0mgCm894hIwhSM6Fh+du3R+C4peUAz7hn
   ev+uFVaZxfnGdzdpqj7/eIIwhklbsbVK/vyr0FjOhVZ36rKmdygHRfniM
   GcVaP1OqKg2EQEwytNdmBNBB/cy5XjG+Fj3z4/MKEYEwHugjNAs19CCOq
   Q1YhWTtzqJqnJnangpQA5OgIFMfr3kTTLWcCi6MBwFcA5UrmEO5oWkMfk
   7wR7T6DQo+51b8fAE8kMlE2tbqluqxBMhNSn9+bfdHIWkUyg3++Ruy0E1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268590209"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="268590209"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 09:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="596149473"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2022 09:22:27 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC1be-0000r4-MS;
        Thu, 14 Jul 2022 16:22:26 +0000
Date:   Fri, 15 Jul 2022 00:21:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tglx-devel:depthtracking 28/38] arch/x86/entry/entry_64.o: warning:
 objtool: .altinstr_replacement+0x15: unsupported relocation in alternatives
 section
Message-ID: <202207150029.zuZ1vOEj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git depthtracking
head:   81d2c1b17a61bfeca4b92a5d6e1fb6f5ff464826
commit: b05c8cdb2f065b83900983321afc3d449908003c [28/38] x86/retbleed: Add SKL return thunk
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220715/202207150029.zuZ1vOEj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=b05c8cdb2f065b83900983321afc3d449908003c
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel depthtracking
        git checkout b05c8cdb2f065b83900983321afc3d449908003c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0x15: unsupported relocation in alternatives section
--
>> arch/x86/entry/entry_64_compat.o: warning: objtool: .altinstr_replacement+0x15: unsupported relocation in alternatives section

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
