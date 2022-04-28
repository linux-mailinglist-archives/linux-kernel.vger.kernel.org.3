Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB754512A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiD1Dzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiD1Dzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:55:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB108CCFE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651117958; x=1682653958;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NaOLaDHs9Wa1sK6OgOqLs2aONnd112uv7Auvm5TZXyY=;
  b=QRZpqEeg2tWAl2HmDBXym5mmjfCmhNRs2w61XIm311re9zOxQEcmGJPB
   P1fLco+9gF7vel52CSilYL8mqK/n1tDXTckzT6PIDHcO64FbXpre0esxx
   EOK1rqCU2oIbP/Dqx2EEpssSD3d9vI+eFuLvMmN4wSs7ekwDfmfOlUpqM
   N/iDeojWU3jwTviA4AjyM4zAFrM/FS5HUONIqn30ceMVJGB4+TS+XD2R+
   EZsT6ylr9c99SNLcm0dZ4OTC/0o97+OV58Y/Z7Dnbqcjt0f6bl335De3j
   1DqB+9+N+RFRyMxQqvaJlBA4dJYHn9DxctrW0AREqFjm9CsfGTy6mQFMa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="352582591"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="352582591"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 20:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="540720071"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Apr 2022 20:52:36 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njvCl-00051X-HF;
        Thu, 28 Apr 2022 03:52:35 +0000
Date:   Thu, 28 Apr 2022 11:52:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/stringop-overflow 1/1]
 lib/zstd/decompress/huf_decompress.c:700:5: warning:
 'HUF_fillDTableX2.constprop' accessing 624 bytes in a region of size 52
Message-ID: <202204281117.CPeehgnR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/stringop-overflow
head:   841e98dddf647582547543eba0a1e3e8c8f8db9c
commit: 841e98dddf647582547543eba0a1e3e8c8f8db9c [1/1] Makefile: Enable -Wstringop-overflow
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220428/202204281117.CPeehgnR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=841e98dddf647582547543eba0a1e3e8c8f8db9c
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/stringop-overflow
        git checkout 841e98dddf647582547543eba0a1e3e8c8f8db9c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash lib/zstd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/zstd/decompress/huf_decompress.c: In function 'HUF_readDTableX2_wksp':
>> lib/zstd/decompress/huf_decompress.c:700:5: warning: 'HUF_fillDTableX2.constprop' accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]
     700 |     HUF_fillDTableX2(dt, maxTableLog,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     701 |                    wksp->sortedSymbol, sizeOfSort,
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     702 |                    wksp->rankStart0, wksp->rankVal, maxW,
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     703 |                    tableLog+1,
         |                    ~~~~~~~~~~~
     704 |                    wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/zstd/decompress/huf_decompress.c:700:5: note: referencing argument 6 of type 'U32 (*)[13]' {aka 'unsigned int (*)[13]'}
   lib/zstd/decompress/huf_decompress.c:571:13: note: in a call to function 'HUF_fillDTableX2.constprop'
     571 | static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
         |             ^~~~~~~~~~~~~~~~


vim +700 lib/zstd/decompress/huf_decompress.c

e0c1b49f5b674cc Nick Terrell 2020-09-11  625  
e0c1b49f5b674cc Nick Terrell 2020-09-11  626  size_t HUF_readDTableX2_wksp(HUF_DTable* DTable,
e0c1b49f5b674cc Nick Terrell 2020-09-11  627                         const void* src, size_t srcSize,
e0c1b49f5b674cc Nick Terrell 2020-09-11  628                               void* workSpace, size_t wkspSize)
e0c1b49f5b674cc Nick Terrell 2020-09-11  629  {
e0c1b49f5b674cc Nick Terrell 2020-09-11  630      U32 tableLog, maxW, sizeOfSort, nbSymbols;
e0c1b49f5b674cc Nick Terrell 2020-09-11  631      DTableDesc dtd = HUF_getDTableDesc(DTable);
e0c1b49f5b674cc Nick Terrell 2020-09-11  632      U32 const maxTableLog = dtd.maxTableLog;
e0c1b49f5b674cc Nick Terrell 2020-09-11  633      size_t iSize;
e0c1b49f5b674cc Nick Terrell 2020-09-11  634      void* dtPtr = DTable+1;   /* force compiler to avoid strict-aliasing */
e0c1b49f5b674cc Nick Terrell 2020-09-11  635      HUF_DEltX2* const dt = (HUF_DEltX2*)dtPtr;
e0c1b49f5b674cc Nick Terrell 2020-09-11  636      U32 *rankStart;
e0c1b49f5b674cc Nick Terrell 2020-09-11  637  
e0c1b49f5b674cc Nick Terrell 2020-09-11  638      HUF_ReadDTableX2_Workspace* const wksp = (HUF_ReadDTableX2_Workspace*)workSpace;
e0c1b49f5b674cc Nick Terrell 2020-09-11  639  
e0c1b49f5b674cc Nick Terrell 2020-09-11  640      if (sizeof(*wksp) > wkspSize) return ERROR(GENERIC);
e0c1b49f5b674cc Nick Terrell 2020-09-11  641  
e0c1b49f5b674cc Nick Terrell 2020-09-11  642      rankStart = wksp->rankStart0 + 1;
e0c1b49f5b674cc Nick Terrell 2020-09-11  643      ZSTD_memset(wksp->rankStats, 0, sizeof(wksp->rankStats));
e0c1b49f5b674cc Nick Terrell 2020-09-11  644      ZSTD_memset(wksp->rankStart0, 0, sizeof(wksp->rankStart0));
e0c1b49f5b674cc Nick Terrell 2020-09-11  645  
e0c1b49f5b674cc Nick Terrell 2020-09-11  646      DEBUG_STATIC_ASSERT(sizeof(HUF_DEltX2) == sizeof(HUF_DTable));   /* if compiler fails here, assertion is wrong */
e0c1b49f5b674cc Nick Terrell 2020-09-11  647      if (maxTableLog > HUF_TABLELOG_MAX) return ERROR(tableLog_tooLarge);
e0c1b49f5b674cc Nick Terrell 2020-09-11  648      /* ZSTD_memset(weightList, 0, sizeof(weightList)); */  /* is not necessary, even though some analyzer complain ... */
e0c1b49f5b674cc Nick Terrell 2020-09-11  649  
e0c1b49f5b674cc Nick Terrell 2020-09-11  650      iSize = HUF_readStats_wksp(wksp->weightList, HUF_SYMBOLVALUE_MAX + 1, wksp->rankStats, &nbSymbols, &tableLog, src, srcSize, wksp->calleeWksp, sizeof(wksp->calleeWksp), /* bmi2 */ 0);
e0c1b49f5b674cc Nick Terrell 2020-09-11  651      if (HUF_isError(iSize)) return iSize;
e0c1b49f5b674cc Nick Terrell 2020-09-11  652  
e0c1b49f5b674cc Nick Terrell 2020-09-11  653      /* check result */
e0c1b49f5b674cc Nick Terrell 2020-09-11  654      if (tableLog > maxTableLog) return ERROR(tableLog_tooLarge);   /* DTable can't fit code depth */
e0c1b49f5b674cc Nick Terrell 2020-09-11  655  
e0c1b49f5b674cc Nick Terrell 2020-09-11  656      /* find maxWeight */
e0c1b49f5b674cc Nick Terrell 2020-09-11  657      for (maxW = tableLog; wksp->rankStats[maxW]==0; maxW--) {}  /* necessarily finds a solution before 0 */
e0c1b49f5b674cc Nick Terrell 2020-09-11  658  
e0c1b49f5b674cc Nick Terrell 2020-09-11  659      /* Get start index of each weight */
e0c1b49f5b674cc Nick Terrell 2020-09-11  660      {   U32 w, nextRankStart = 0;
e0c1b49f5b674cc Nick Terrell 2020-09-11  661          for (w=1; w<maxW+1; w++) {
e0c1b49f5b674cc Nick Terrell 2020-09-11  662              U32 curr = nextRankStart;
e0c1b49f5b674cc Nick Terrell 2020-09-11  663              nextRankStart += wksp->rankStats[w];
e0c1b49f5b674cc Nick Terrell 2020-09-11  664              rankStart[w] = curr;
e0c1b49f5b674cc Nick Terrell 2020-09-11  665          }
e0c1b49f5b674cc Nick Terrell 2020-09-11  666          rankStart[0] = nextRankStart;   /* put all 0w symbols at the end of sorted list*/
e0c1b49f5b674cc Nick Terrell 2020-09-11  667          sizeOfSort = nextRankStart;
e0c1b49f5b674cc Nick Terrell 2020-09-11  668      }
e0c1b49f5b674cc Nick Terrell 2020-09-11  669  
e0c1b49f5b674cc Nick Terrell 2020-09-11  670      /* sort symbols by weight */
e0c1b49f5b674cc Nick Terrell 2020-09-11  671      {   U32 s;
e0c1b49f5b674cc Nick Terrell 2020-09-11  672          for (s=0; s<nbSymbols; s++) {
e0c1b49f5b674cc Nick Terrell 2020-09-11  673              U32 const w = wksp->weightList[s];
e0c1b49f5b674cc Nick Terrell 2020-09-11  674              U32 const r = rankStart[w]++;
e0c1b49f5b674cc Nick Terrell 2020-09-11  675              wksp->sortedSymbol[r].symbol = (BYTE)s;
e0c1b49f5b674cc Nick Terrell 2020-09-11  676              wksp->sortedSymbol[r].weight = (BYTE)w;
e0c1b49f5b674cc Nick Terrell 2020-09-11  677          }
e0c1b49f5b674cc Nick Terrell 2020-09-11  678          rankStart[0] = 0;   /* forget 0w symbols; this is beginning of weight(1) */
e0c1b49f5b674cc Nick Terrell 2020-09-11  679      }
e0c1b49f5b674cc Nick Terrell 2020-09-11  680  
e0c1b49f5b674cc Nick Terrell 2020-09-11  681      /* Build rankVal */
e0c1b49f5b674cc Nick Terrell 2020-09-11  682      {   U32* const rankVal0 = wksp->rankVal[0];
e0c1b49f5b674cc Nick Terrell 2020-09-11  683          {   int const rescale = (maxTableLog-tableLog) - 1;   /* tableLog <= maxTableLog */
e0c1b49f5b674cc Nick Terrell 2020-09-11  684              U32 nextRankVal = 0;
e0c1b49f5b674cc Nick Terrell 2020-09-11  685              U32 w;
e0c1b49f5b674cc Nick Terrell 2020-09-11  686              for (w=1; w<maxW+1; w++) {
e0c1b49f5b674cc Nick Terrell 2020-09-11  687                  U32 curr = nextRankVal;
e0c1b49f5b674cc Nick Terrell 2020-09-11  688                  nextRankVal += wksp->rankStats[w] << (w+rescale);
e0c1b49f5b674cc Nick Terrell 2020-09-11  689                  rankVal0[w] = curr;
e0c1b49f5b674cc Nick Terrell 2020-09-11  690          }   }
e0c1b49f5b674cc Nick Terrell 2020-09-11  691          {   U32 const minBits = tableLog+1 - maxW;
e0c1b49f5b674cc Nick Terrell 2020-09-11  692              U32 consumed;
e0c1b49f5b674cc Nick Terrell 2020-09-11  693              for (consumed = minBits; consumed < maxTableLog - minBits + 1; consumed++) {
e0c1b49f5b674cc Nick Terrell 2020-09-11  694                  U32* const rankValPtr = wksp->rankVal[consumed];
e0c1b49f5b674cc Nick Terrell 2020-09-11  695                  U32 w;
e0c1b49f5b674cc Nick Terrell 2020-09-11  696                  for (w = 1; w < maxW+1; w++) {
e0c1b49f5b674cc Nick Terrell 2020-09-11  697                      rankValPtr[w] = rankVal0[w] >> consumed;
e0c1b49f5b674cc Nick Terrell 2020-09-11  698      }   }   }   }
e0c1b49f5b674cc Nick Terrell 2020-09-11  699  
e0c1b49f5b674cc Nick Terrell 2020-09-11 @700      HUF_fillDTableX2(dt, maxTableLog,
e0c1b49f5b674cc Nick Terrell 2020-09-11  701                     wksp->sortedSymbol, sizeOfSort,
e0c1b49f5b674cc Nick Terrell 2020-09-11  702                     wksp->rankStart0, wksp->rankVal, maxW,
e0c1b49f5b674cc Nick Terrell 2020-09-11  703                     tableLog+1,
e0c1b49f5b674cc Nick Terrell 2020-09-11  704                     wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
e0c1b49f5b674cc Nick Terrell 2020-09-11  705  
e0c1b49f5b674cc Nick Terrell 2020-09-11  706      dtd.tableLog = (BYTE)maxTableLog;
e0c1b49f5b674cc Nick Terrell 2020-09-11  707      dtd.tableType = 1;
e0c1b49f5b674cc Nick Terrell 2020-09-11  708      ZSTD_memcpy(DTable, &dtd, sizeof(dtd));
e0c1b49f5b674cc Nick Terrell 2020-09-11  709      return iSize;
e0c1b49f5b674cc Nick Terrell 2020-09-11  710  }
e0c1b49f5b674cc Nick Terrell 2020-09-11  711  

:::::: The code at line 700 was first introduced by commit
:::::: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10

:::::: TO: Nick Terrell <terrelln@fb.com>
:::::: CC: Nick Terrell <terrelln@fb.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
