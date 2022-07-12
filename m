Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDA25726D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiGLT5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiGLT5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:57:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6EB1F5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657655853; x=1689191853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+pUV0uYtEDATsa+O/SRyLSlwebxYRQT6JOI8EuwDzQE=;
  b=AgCfAtKyx11UFA6ZQxzJH6Q2VA8K4JfggBSo29aMieMIWZ4S8rZDwEmj
   bdkAjE/ahvCT0xiQhzu3njZ08Ty0o/7XFAnVI9Wc/VI67pSWrNpEqpQR7
   LFibrSy43A99+TWwBLfELQGucSbn5oWalijjIJ9j1PFEP4ld+hxSoH1iA
   Igp8rjziVyGCuYf+3ViVyqpIHG7Avc8jGeyVWiypSrqbIp2rnUC1YJ44d
   i4YKihWZdZj1jeXJWRph0VhzDkavKNxoSszBSMGAnBflRiZ2J2y/Colnp
   nr7p8wpMpX2xQs6j+zh3zc7TrwJsQjthUWp62qGPEEJD4FhRE7IsnM8Qx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="265442051"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="265442051"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="737605179"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2022 12:57:31 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBM0h-0002dv-9N;
        Tue, 12 Jul 2022 19:57:31 +0000
Date:   Wed, 13 Jul 2022 03:57:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Hutchings <bwh@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 6996/7120]
 arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_epilogue()+0x10:
 unreachable instruction
Message-ID: <202207130344.dwXyDmTk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   ba398a0e54049bb6a1c102245ae84103f103ff2c
commit: 8ca9dceaa17983afec1cc8e1a6e76d6bd142447a [6996/7120] objtool: Assume only ELF functions do sibling calls
config: x86_64-rhel-8.3-syz (https://download.01.org/0day-ci/archive/20220713/202207130344.dwXyDmTk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=8ca9dceaa17983afec1cc8e1a6e76d6bd142447a
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout 8ca9dceaa17983afec1cc8e1a6e76d6bd142447a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_epilogue()+0x10: unreachable instruction


objdump-func vmlinux.o ftrace_epilogue:
0000 000000000008ca70 <ftrace_epilogue>:
0000    8ca70:	e9 00 00 00 00       	jmp    8ca75 <ftrace_epilogue+0x5>	8ca71: R_X86_64_PLT32	ftrace_stub-0x4
0005    8ca75:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
