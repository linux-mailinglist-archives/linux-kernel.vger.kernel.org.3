Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862FF480F99
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 05:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhL2EYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 23:24:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:14276 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhL2EYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 23:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640751882; x=1672287882;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WKNMKlH1DN+zsktbRXy6v/GAlIkk42d6Xnrx/W56eGM=;
  b=RKtedlq9EGFCY2DJCPW80SOoT64SnD42lsIqfpLtNPhHn9/78pmh7mrq
   Kgv//hvisboJ8WgkQMdzQoiKUOmbh/vjeqqVs1xtRenaADtIL4Z0zDt5K
   zDlgpviW0c7MYnvJ3IxVpBPQsT96PHyhANRY1WtfGxG78yAL4eM4bAV5V
   XzE4GE898bzuq+4A8kR+UZFnYpIrg6u1s1ienQ0LxhxwVMe1ixusszRip
   RuRNQ+b1cufqIvC4neoJmOQa4JE8+UWMsPOX5u6J+y0Zr+cYJH26YB4y+
   rbH1EWK8zxl2X8lJVoJ0odn3lgnfuNJMzswgIMqE/og/O1CT+ZmZbCK1J
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241673543"
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="241673543"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 20:24:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,244,1635231600"; 
   d="scan'208";a="468365564"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2021 20:24:40 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2QVz-0008Oy-DV; Wed, 29 Dec 2021 04:24:39 +0000
Date:   Wed, 29 Dec 2021 12:24:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:1390
 ZSTD_decompressSequences() warn: inconsistent indenting
Message-ID: <202112291237.Ilwkjozy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e7c124bd04631973a3cc0df19ab881b56d8a2d50
commit: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10
date:   7 weeks ago
config: x86_64-randconfig-m001-20211228 (https://download.01.org/0day-ci/archive/20211229/202112291237.Ilwkjozy-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:1390 ZSTD_decompressSequences() warn: inconsistent indenting
arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c:1414 ZSTD_decompressSequencesLong() warn: inconsistent indenting

Old smatch warnings:
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:397 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:397 HUF_decompress4X1_usingDTable_internal_body() warn: maybe use && instead of &
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:850 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &
arch/x86/boot/compressed/../../../../lib/zstd/decompress/huf_decompress.c:850 HUF_decompress4X2_usingDTable_internal_body() warn: maybe use && instead of &
arch/x86/boot/compressed/misc.c:292 parse_elf() warn: ignoring unreachable code.

vim +1390 arch/x86/boot/compressed/../../../../lib/zstd/decompress/zstd_decompress_block.c

  1369	
  1370	typedef size_t (*ZSTD_decompressSequences_t)(
  1371	                            ZSTD_DCtx* dctx,
  1372	                            void* dst, size_t maxDstSize,
  1373	                            const void* seqStart, size_t seqSize, int nbSeq,
  1374	                            const ZSTD_longOffset_e isLongOffset,
  1375	                            const int frame);
  1376	
  1377	#ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG
  1378	static size_t
  1379	ZSTD_decompressSequences(ZSTD_DCtx* dctx, void* dst, size_t maxDstSize,
  1380	                   const void* seqStart, size_t seqSize, int nbSeq,
  1381	                   const ZSTD_longOffset_e isLongOffset,
  1382	                   const int frame)
  1383	{
  1384	    DEBUGLOG(5, "ZSTD_decompressSequences");
  1385	#if DYNAMIC_BMI2
  1386	    if (dctx->bmi2) {
  1387	        return ZSTD_decompressSequences_bmi2(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
  1388	    }
  1389	#endif
> 1390	  return ZSTD_decompressSequences_default(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
  1391	}
  1392	#endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG */
  1393	
  1394	
  1395	#ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
  1396	/* ZSTD_decompressSequencesLong() :
  1397	 * decompression function triggered when a minimum share of offsets is considered "long",
  1398	 * aka out of cache.
  1399	 * note : "long" definition seems overloaded here, sometimes meaning "wider than bitstream register", and sometimes meaning "farther than memory cache distance".
  1400	 * This function will try to mitigate main memory latency through the use of prefetching */
  1401	static size_t
  1402	ZSTD_decompressSequencesLong(ZSTD_DCtx* dctx,
  1403	                             void* dst, size_t maxDstSize,
  1404	                             const void* seqStart, size_t seqSize, int nbSeq,
  1405	                             const ZSTD_longOffset_e isLongOffset,
  1406	                             const int frame)
  1407	{
  1408	    DEBUGLOG(5, "ZSTD_decompressSequencesLong");
  1409	#if DYNAMIC_BMI2
  1410	    if (dctx->bmi2) {
  1411	        return ZSTD_decompressSequencesLong_bmi2(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
  1412	    }
  1413	#endif
> 1414	  return ZSTD_decompressSequencesLong_default(dctx, dst, maxDstSize, seqStart, seqSize, nbSeq, isLongOffset, frame);
  1415	}
  1416	#endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT */
  1417	
  1418	
  1419	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
