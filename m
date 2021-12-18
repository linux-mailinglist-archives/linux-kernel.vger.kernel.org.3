Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC51479BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhLRSS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:18:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:33263 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhLRSSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639851535; x=1671387535;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dyI0MVzolrrHOY0DA65JXHsn2GhW9WvW9ugenPb5ey0=;
  b=Xz22ikiClqBCMIRAxKFwBVsD7F8i2tZC3qAav888ViEC46GZWUUVOo9j
   Xqx2H1YIrcn4I/AeAYm2xejWhZVYuOJLNesNaudI31Pr/DZ8UsLH+O2CP
   RJJjy4xIFzQBg96IGA5pyMOX/iDrHeEsI4gQUeF/aVxxYsv5CJCm0CV5H
   u0ZXeFZevS+2oXVCEP3lDBghDELCXyrmHWb4qQyQnoe+biRbh+faSs/4V
   DaxWfSvECFmUGhUcvJXlynHj7hDqT3g9lJc1MFdgxiM0yFmjyUezF4rHy
   JwJq+G3RqdevNDLy17PiZh+9Eiz+2pdK/5FD91A9f1hJhlGnCeOaO5AC2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="219953588"
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="219953588"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 10:18:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,216,1635231600"; 
   d="scan'208";a="466874993"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2021 10:18:54 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myeIH-0006Hi-93; Sat, 18 Dec 2021 18:18:53 +0000
Date:   Sun, 19 Dec 2021 02:18:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: fs/ntfs3/frecord.o: warning: objtool: .text.unlikely: unexpected end
 of section
Message-ID: <202112190215.HofhLHPL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9eaa88c7036eda3f6c215f87ca693594cf90559b
commit: 6e5be40d32fb1907285277c02e74493ed43d77fe fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
date:   4 months ago
config: x86_64-buildonly-randconfig-r005-20211218 (https://download.01.org/0day-ci/archive/20211219/202112190215.HofhLHPL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5be40d32fb1907285277c02e74493ed43d77fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5be40d32fb1907285277c02e74493ed43d77fe
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ntfs3/frecord.o: warning: objtool: .text.unlikely: unexpected end of section

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
