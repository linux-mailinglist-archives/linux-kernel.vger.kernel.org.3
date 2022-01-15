Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C996248F68F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 12:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiAOLjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 06:39:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:28728 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbiAOLjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 06:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642246795; x=1673782795;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DmMtoebpvaKh4eMtsCaCbncM65OQ+qihS1WM9ohtlxE=;
  b=Ac6IvorqdqIL3W4A4oPEro56B5EOBRSdQXwk7FSPKYa78flUrW4XBHnF
   yaPhEPB0I60RlomMlqL78fTnhM8HE/ZU8rKMu+M/cheo2hJuuxEupe6FG
   vDEHlQ2kSI2qAvXC1pkUzOxA65kVq5YRZtZGc7yuNy0WQj9Cu0OXYcQtn
   QSMYLG6aF1m3XejC29zfZA0iJF/1Zz1JDVsfFrqD66k4VgOzJPj2KTrcK
   wzEEKHodPdr6lr3HR9LCKue7DjwbcKX5zelXSHd7eboTDjlrz1XNb0yU3
   ctc7wNBPqDqLrHc0XqYHoC6LjNUMopfcKh7X7KdfCfzEzsIlTqNm5L6no
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="243220002"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="243220002"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 03:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="692547036"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Jan 2022 03:39:53 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8hPU-0009iH-Qu; Sat, 15 Jan 2022 11:39:52 +0000
Date:   Sat, 15 Jan 2022 19:38:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: arch/x86/kernel/alternative.c:1411:2-3: Unneeded semicolon
Message-ID: <202201151903.nIz48hKn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a33f5c380c4bd3fa5278d690421b72052456d9fe
commit: 26c44b776dba4ac692a0bf5a3836feb8a63fea6b x86/alternative: Relax text_poke_bp() constraint
date:   5 weeks ago
config: x86_64-randconfig-c002 (https://download.01.org/0day-ci/archive/20220115/202201151903.nIz48hKn-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/x86/kernel/alternative.c:1411:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
