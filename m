Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760F8479E9E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 01:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhLSAyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 19:54:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:58396 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhLSAyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 19:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639875248; x=1671411248;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X7hSCNpz7bzR0o9Lap3ECTUXmgsoTH7pY1YA8bn4uA0=;
  b=iFxGsc8VSTyMsYnyWdf3stAhQOhJQcYsU7nTSgz+z3b863wWmMsX0eoL
   TgrDWwSwzaF3MAl+6u0BMaNH5Y3xcmC0VSndHFYvmIKfVti4DsAkzorPl
   gJx1tqfKNyyXlEgI++njbTy88aqikxwxg/K8Mo3EDsseqW5D7/cRgqAcO
   Y5JVSd3WqW6bLRZTvxTFzaHEwmvapOlZUVtr2dqmtV0QOtQmDoBQgxYg9
   bkIoTpjo4G3xTRSg+JiD7KNt4HU1ISgGkfIY0fBxdxAC13V0Q/axm+qLj
   w4w3qLfZVpMDZtiJ2eR4kdcNiOexFTIbe5feZHXHorFAtzFZDY4oXR+0Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10202"; a="238707861"
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="238707861"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2021 16:54:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,217,1635231600"; 
   d="scan'208";a="466940149"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Dec 2021 16:54:07 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mykSk-0006aR-CD; Sun, 19 Dec 2021 00:54:06 +0000
Date:   Sun, 19 Dec 2021 08:54:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:locking/debug-refcount 1/3] ERROR: modpost:
 "refcount_bad_magic" [net/sunrpc/auth_gss/auth_rpcgss.ko] undefined!
Message-ID: <202112190815.A03KAOQo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git locking/debug-refcount
head:   fb4984c339109f2ee2dd0000e7744aab91b974f5
commit: 488dd36233a4a0d80f516054ee894688fc8f447f [1/3] WIP: add DEBUG_REFCOUNT
config: x86_64-randconfig-m031-20211218 (https://download.01.org/0day-ci/archive/20211219/202112190815.A03KAOQo-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=488dd36233a4a0d80f516054ee894688fc8f447f
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark locking/debug-refcount
        git checkout 488dd36233a4a0d80f516054ee894688fc8f447f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "refcount_bad_magic" [net/sunrpc/auth_gss/auth_rpcgss.ko] undefined!
>> ERROR: modpost: "refcount_bad_magic" [drivers/scsi/mpi3mr/mpi3mr.ko] undefined!
>> ERROR: modpost: "refcount_bad_magic" [fs/cifs/cifs.ko] undefined!
ERROR: modpost: "refcount_bad_magic" [fs/nfs/nfsv4.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
