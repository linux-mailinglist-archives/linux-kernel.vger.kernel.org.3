Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431BD481A81
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbhL3Hus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:50:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:16666 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhL3Hur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640850647; x=1672386647;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E4rUNXOvO1jHd34OPqfGBdS40DTrulxFPeCyAJAXELc=;
  b=nXt6I/dRccyrqlHVMBpa2fASWHQS6olEB5zBM0k0KaI/FeGHHKyEVbOw
   X7p9icOGvIM3/2YObX9hnL59FhjO7QBL1Wrr80WYe5z6FxMokaGuUwC0o
   dMozhlzEAu3u+e32JB440vzd/CqDVfxdZdCVhpPIHclk0gRwSOJojOu3D
   2Ce73WIUPnnkwYEqhjiJ27pDyZY0fr0ekMr0E/DUTgcM7ftiEbNxM4FWb
   TXSSwUb5S+JheXpL7KLSRHLjm3KnWITmEcCf6ZphY5aoy4yMjWfu6ODn7
   kUgUrW4/FymbihHVu4P9HEOJ9LhC/jXXAWMU5q4O0TbNxYuP2tYrs9qsh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="222305908"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="222305908"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 23:50:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="486823279"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 29 Dec 2021 23:50:45 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2qCy-0009t4-RL; Thu, 30 Dec 2021 07:50:44 +0000
Date:   Thu, 30 Dec 2021 15:50:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH goldwynr] btrfs: btrfs_buffered_read_iomap_ops can be
 static
Message-ID: <20211230075014.GA25567@87202af68ceb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/btrfs/inode.c:8440:24: warning: symbol 'btrfs_buffered_read_iomap_ops' was not declared. Should it be static?

Fixes: 3f7d55b62cad ("btrfs: iomap_begin() for buffered read")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b50cf3192fa9e..ca8df86d42002 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8437,7 +8437,7 @@ static int btrfs_read_iomap_end(struct inode *inode, loff_t pos,
 	return 0;
 }
 
-const struct iomap_ops btrfs_buffered_read_iomap_ops = {
+static const struct iomap_ops btrfs_buffered_read_iomap_ops = {
 	.iomap_begin = btrfs_read_iomap_begin,
 	.iomap_end = btrfs_read_iomap_end,
 };
