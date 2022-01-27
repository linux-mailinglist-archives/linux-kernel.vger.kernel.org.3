Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E458449EE18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 23:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243016AbiA0Wab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 17:30:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:56021 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239018AbiA0Waa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 17:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643322630; x=1674858630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sqFXrxG+x8Gorb7kLd7edUEVCFSnejSdIy4RxBmuDu0=;
  b=KTVJUnGm7MkPQwqQRFjvMmtGApB1S36B05w2p8C192m1qoq6pt1Cn8e2
   wx/4tXbPvwALJo5xmaJUrbBt6lrcjFcSm5ekXtrfbp6oYOKJgKh3sB+S8
   bf9euno7v5PShWsGrQ2zSf95bQDQr6I6AFUfG5kOUZJlBfgWkwqiqWr7O
   7bo68WdY1bg+QJabWb220cq6KdiIQ5p40gILkuCGswbduYnGpM6QbFsty
   AoTJJpCSIkQfnRL/PkLfBhCkp1BXp+fTI/eR4tVm6k7XKXCbBGQZZujbx
   Psoh5FtQ8zl4eDVOZdUOGt7QcOw24VczNsYjCOfR75ptdudbXDrEV3yo+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230561888"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="230561888"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 14:30:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="480488594"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2022 14:30:29 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDDHg-000N71-Bl; Thu, 27 Jan 2022 22:30:28 +0000
Date:   Fri, 28 Jan 2022 06:30:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH davidhildenbrand] early_node_zone_for_memory_block() can
 be static
Message-ID: <20220127223014.GA44143@ca5a2f49b72c>
References: <202201280621.HyzMsDkU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201280621.HyzMsDkU-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/base/memory.c:648:13: warning: symbol 'early_node_zone_for_memory_block' was not declared. Should it be static?

Fixes: 176a3d535903 ("tmp")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index fa20ca42862f4..0b396e4c30667 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -645,7 +645,7 @@ int register_memory(struct memory_block *memory)
 	return ret;
 }
 
-struct zone *early_node_zone_for_memory_block(int nid, struct memory_block *mem)
+static struct zone *early_node_zone_for_memory_block(int nid, struct memory_block *mem)
 {
 	const unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	const unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
