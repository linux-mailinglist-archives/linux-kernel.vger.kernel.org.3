Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7624C48A478
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345505AbiAKAhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:37:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:18924 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343757AbiAKAhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641861438; x=1673397438;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SR+++ersNS/5l3n7F87zQbFRq8Xp7jf8VDmIMgXIv2g=;
  b=UYL4yIkf0WGEi2U2Dt1OE39UJa8WcTaj4BJy/LbTQF6BsCOffC+H+Hyo
   5YySTifTVAHr6QOoJMjz9+8JFt/WypYbuGrLd850pVTweisfizXeactVL
   4DJyBkDs/9wZTomzfzUgIvCOnt8gvMQnhG+PHzU4qrs1Wtmle7bD2Dnqi
   Md4PWMbrVbI43oufyX4AftkRNzzo4mkXCISjf1tNhsyix+bz1lsCiLPF7
   OV/n8pqG0T6IdaI1APVl/hkLD73QkvDwAZpgZccCIIbAdmSFa0dQ0xHnk
   KCwKzpeJmpoxBCyc9g2jwbKbbKfB3HjOl6ZnQIvzGbYXsq+cDvEozk6lf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243164923"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="243164923"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 16:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="490191739"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Jan 2022 16:37:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n75A4-00047T-7i; Tue, 11 Jan 2022 00:37:16 +0000
Date:   Tue, 11 Jan 2022 08:36:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: fs/iomap/buffered-io.c:1093:53: warning: format '%lu' expects
 argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka
 'unsigned int'}
Message-ID: <202201110815.jsASX6ar-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220111-073805/trondmy-kernel-org/iomap-Address-soft-lockup-in-iomap_finish_ioend/20211231-034313
head:   f1c8b8b2e616895aa0f5be4e53d4cd1ffa751001
commit: f1c8b8b2e616895aa0f5be4e53d4cd1ffa751001 iomap: Address soft lockup in iomap_finish_ioend()
date:   54 minutes ago
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220111/202201110815.jsASX6ar-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/f1c8b8b2e616895aa0f5be4e53d4cd1ffa751001
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220111-073805/trondmy-kernel-org/iomap-Address-soft-lockup-in-iomap_finish_ioend/20211231-034313
        git checkout f1c8b8b2e616895aa0f5be4e53d4cd1ffa751001
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash fs/iomap/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/iomap/buffered-io.c: In function 'iomap_finish_ioends':
>> fs/iomap/buffered-io.c:1093:53: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1093 |  trace_printk("pages %u, start sector 0x%llx size %lu pcnt %u",
         |                                                   ~~^
         |                                                     |
         |                                                     long unsigned int
         |                                                   %u
   ......
    1096 |   ioend->io_size,
         |   ~~~~~~~~~~~~~~                                     
         |        |
         |        size_t {aka unsigned int}
   fs/iomap/buffered-io.c:1106:53: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1106 |  trace_printk("pages %u, start sector 0x%llx size %lu pcnt %u",
         |                                                   ~~^
         |                                                     |
         |                                                     long unsigned int
         |                                                   %u
   ......
    1109 |   ioend->io_size,
         |   ~~~~~~~~~~~~~~                                     
         |        |
         |        size_t {aka unsigned int}
   fs/iomap/buffered-io.c: In function 'iomap_ioend_can_merge':
   fs/iomap/buffered-io.c:1121:33: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1121 | "off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx, next off 0x%llx sect 0x%llx",
         |                               ~~^
         |                                 |
         |                                 long unsigned int
         |                               %u
   ......
    1124 |   ioend->io_size, (ioend->io_size >> 9),
         |   ~~~~~~~~~~~~~~                 
         |        |
         |        size_t {aka unsigned int}
>> fs/iomap/buffered-io.c:1121:39: warning: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    1121 | "off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx, next off 0x%llx sect 0x%llx",
         |                                     ~~^
         |                                       |
         |                                       long unsigned int
         |                                     %x
   ......
    1124 |   ioend->io_size, (ioend->io_size >> 9),
         |                   ~~~~~~~~~~~~~~~~~~~~~
         |                                   |
         |                                   size_t {aka unsigned int}


vim +1093 fs/iomap/buffered-io.c

  1072	
  1073	/*
  1074	 * Ioend completion routine for merged bios. This can only be called from task
  1075	 * contexts as merged ioends can be of unbound length. Hence we have to break up
  1076	 * the page writeback completion into manageable chunks to avoid long scheduler
  1077	 * holdoffs. We aim to keep scheduler holdoffs down below 10ms so that we get
  1078	 * good batch processing throughput without creating adverse scheduler latency
  1079	 * conditions.
  1080	 */
  1081	void
  1082	iomap_finish_ioends(struct iomap_ioend *ioend, int error)
  1083	{
  1084		struct list_head tmp;
  1085		u32 pages;
  1086	
  1087		might_sleep();
  1088	
  1089		list_replace_init(&ioend->io_list, &tmp);
  1090		pages = iomap_finish_ioend(ioend, error);
  1091	
  1092		while (!list_empty(&tmp)) {
> 1093		trace_printk("pages %u, start sector 0x%llx size %lu pcnt %u",
  1094			ioend->io_pages,
  1095			ioend->io_sector,
  1096			ioend->io_size,
  1097			pages);
  1098			if (pages > 32768) {
  1099				cond_resched();
  1100				pages = 0;
  1101			}
  1102			ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
  1103			list_del_init(&ioend->io_list);
  1104			pages += iomap_finish_ioend(ioend, error);
  1105		}
  1106		trace_printk("pages %u, start sector 0x%llx size %lu pcnt %u",
  1107			ioend->io_pages,
  1108			ioend->io_sector,
  1109			ioend->io_size,
  1110			pages);
  1111	}
  1112	EXPORT_SYMBOL_GPL(iomap_finish_ioends);
  1113	
  1114	/*
  1115	 * We can merge two adjacent ioends if they have the same set of work to do.
  1116	 */
  1117	static bool
  1118	iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
  1119	{
  1120		trace_printk(
> 1121	"off 0x%llx, sect 0x%llx size %lu/0x%lx end 0x%llx, next off 0x%llx sect 0x%llx",
  1122			ioend->io_offset,
  1123			ioend->io_sector,
  1124			ioend->io_size, (ioend->io_size >> 9),
  1125			ioend->io_sector + (ioend->io_size >> 9),
  1126			next->io_offset,
  1127			next->io_sector);
  1128	
  1129		if (ioend->io_bio->bi_status != next->io_bio->bi_status)
  1130			return false;
  1131		if ((ioend->io_flags & IOMAP_F_SHARED) ^
  1132		    (next->io_flags & IOMAP_F_SHARED))
  1133			return false;
  1134		if ((ioend->io_type == IOMAP_UNWRITTEN) ^
  1135		    (next->io_type == IOMAP_UNWRITTEN))
  1136			return false;
  1137		if (ioend->io_offset + ioend->io_size != next->io_offset)
  1138			return false;
  1139		/*
  1140		 * Do not merge physically discontiguous ioends. The filesystem
  1141		 * completion functions will have to iterate the physical
  1142		 * discontiguities even if we merge the ioends at a logical level, so
  1143		 * we don't gain anything by merging physical discontiguities here.
  1144		 */
  1145	
  1146		if (ioend->io_sector + (ioend->io_size >> 9) != next->io_sector)
  1147			return false;
  1148		return true;
  1149	}
  1150	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
