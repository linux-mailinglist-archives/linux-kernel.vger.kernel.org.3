Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF6488336
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 12:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiAHLYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 06:24:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:27374 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231526AbiAHLYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 06:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641641094; x=1673177094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KGHtlv0F6HbVTNiHzHQH2xlz0DPmQk0dFgjdN+uiArA=;
  b=kIF1opfl77wOYfT+R2gwM04VdLuJDd/STe3iGCc6miLOaZQOYQSzO7Iy
   mAuI+0XeSDhE5jcqkGkQw8n0yUahx7wP2M6QQRkakx3BhJ/vNzIZ9RTjW
   e01H13NMpAbsL9wEBcjAug2AJMi+P6sAERzbA0OxY1CPx7Ueu1qUPMdSE
   03++ZOvewKospGtVocCxOxfJKjxjeQP7lP5ptVJOfhEn7uwkbPX9ofUXZ
   tPnHiVsrqg9AjKptupQ0qJEqw53k+Ccs0UpOuSFBzlXXK6d7xkttuhOLL
   RqmbLIOndHyNeKQ10kVQdqrROM64ljfLopPuKZjPhUI6Yf9VTqIE3h9+e
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="267321959"
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="267321959"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 03:24:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,272,1635231600"; 
   d="scan'208";a="473625565"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2022 03:24:52 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n69q8-0000a0-4m; Sat, 08 Jan 2022 11:24:52 +0000
Date:   Sat, 8 Jan 2022 19:24:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huang Pei <huangpei@loongson.cn>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [linux-next:master 10529/11475] arch/mips/include/asm/local.h:
 asm/asm.h is included more than once.
Message-ID: <202201081910.SaeiHm0S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   b8170452cd5121b11a5726e3ea8dbdfc2d74e771
commit: 10657660c16e689bfad204190e7031b9b1622a35 [10529/11475] MIPS: rework local_t operation on MIPS64
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/mips/include/asm/local.h: asm/asm.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
