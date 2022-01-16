Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA60548FA7D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 04:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiAPDit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 22:38:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:55336 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232790AbiAPDis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 22:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642304328; x=1673840328;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NZrBLzomyK1fjAno3OhU7JYxl0j3I3RNOEPNkAuJAjQ=;
  b=mEaJm2vSJXZVwkHADuTUFgUGGDrJkjCtg9sSrMYkW8dwRLQwPYWqry0o
   QnFgZvWyshSpQFhMpSt90eGitWF1geq0stqq4Ae1aDrfGy03sUGDZ9ZFv
   le6xAWQJAcOjRaWPaXMYUoNeGO31m6iv2TjuiC4nfZcJr8tel06RgkFac
   kkxkkS5nMinlGPgGjyveLWHtR3xsfpG8a9kU0XL7wCYsp0p8IxgnyVglR
   ykkxQmHyoo7Pm+UmQABk9oSQXcATfF7kSaW+PhKQT6Ilz6eBE+VUsGTP9
   PXYQrTh8sqwIKe5tV9+XMujDE1GUZ0k5RR5mvKhYXO4CgKB0V5OixXN4p
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10228"; a="225140302"
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="225140302"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2022 19:38:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,292,1635231600"; 
   d="scan'208";a="624819356"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Jan 2022 19:38:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8wNS-000AQf-Sh; Sun, 16 Jan 2022 03:38:46 +0000
Date:   Sun, 16 Jan 2022 11:37:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 12/15] arch/x86/include/asm/ibt.h:
 linux/types.h is included more than once.
Message-ID: <202201160636.lv3V9cyo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   7b31f08c5f3fb5f3cfd75deb24787569f35315d5
commit: 58d37079552f8571c06f6d41b1721e9c16d7a9f5 [12/15] x86: Disable IBT around firmware
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/x86/include/asm/ibt.h: linux/types.h is included more than once.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
