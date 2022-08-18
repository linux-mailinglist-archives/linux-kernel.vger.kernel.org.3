Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797C659798D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbiHQWRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiHQWRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:17:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF5FAB057
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660774619; x=1692310619;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DdQixe7lPEWevE5VDFa/PRDsX4sunYOWGd2MMjbo8v8=;
  b=PfsXXwFdRfs3TrKIttuxIGxWXia5h4limPIl3hhPqzobW0GzQrpSy6P3
   cBGRvhXd0UafKs85/3mtcBK7vA2yY3L52iaNH4IJ0c2uJBH47XsJ11YT1
   93HLkA92l5/Nwb7PpUIH5MQk36OHUIG1pknOT9zjqiEuyLphUn0kMlXpO
   Ecr90cBpzRm/GLkygnqtoBxzGZ65iNRslgIVbBEUs1Qst1Essjzb/Z52K
   I3lDXdrIpq+yz6wGsDh2NbpfCi+a/6//+9Ge+TdtkUklTOBdQWot9TzXQ
   AhbPvQDnkcyh6GERATyuTiiS30UXuxSQKpp4mehrPU8donaH82YN4zrDk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="292610910"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="292610910"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 15:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="696941486"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2022 15:16:38 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oORL3-0001Ot-18;
        Wed, 17 Aug 2022 22:16:37 +0000
Date:   Thu, 18 Aug 2022 06:16:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [ammarfaizi2-block:stable/linux-stable-rc/queue/5.10 460/539]
 drivers/mtd/nand/raw/nand_timings.c:295:43: warning: 'onfi_nvddr_timings'
 defined but not used
Message-ID: <202208180635.x7J8xnj6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block stable/linux-stable-rc/queue/5.10
head:   a70e361f9a0a781e38da56942a68184c8240f409
commit: 40fb2a4945bc14fe18ddb9563c14f0bb78d1fee0 [460/539] mtd: rawnand: Add NV-DDR timings
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220818/202208180635.x7J8xnj6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/40fb2a4945bc14fe18ddb9563c14f0bb78d1fee0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block stable/linux-stable-rc/queue/5.10
        git checkout 40fb2a4945bc14fe18ddb9563c14f0bb78d1fee0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/mtd/nand/raw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/nand_timings.c:295:43: warning: 'onfi_nvddr_timings' defined but not used [-Wunused-const-variable=]
     295 | static const struct nand_interface_config onfi_nvddr_timings[] = {
         |                                           ^~~~~~~~~~~~~~~~~~


vim +/onfi_nvddr_timings +295 drivers/mtd/nand/raw/nand_timings.c

   294	
 > 295	static const struct nand_interface_config onfi_nvddr_timings[] = {
   296		/* Mode 0 */
   297		{
   298			.type = NAND_NVDDR_IFACE,
   299			.timings.mode = 0,
   300			.timings.nvddr = {
   301				.tCCS_min = 500000,
   302				.tR_max = 200000000,
   303				.tPROG_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   304				.tBERS_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   305				.tAC_min = 3000,
   306				.tAC_max = 25000,
   307				.tADL_min = 400000,
   308				.tCAD_min = 45000,
   309				.tCAH_min = 10000,
   310				.tCALH_min = 10000,
   311				.tCALS_min = 10000,
   312				.tCAS_min = 10000,
   313				.tCEH_min = 20000,
   314				.tCH_min = 10000,
   315				.tCK_min = 50000,
   316				.tCS_min = 35000,
   317				.tDH_min = 5000,
   318				.tDQSCK_min = 3000,
   319				.tDQSCK_max = 25000,
   320				.tDQSD_min = 0,
   321				.tDQSD_max = 18000,
   322				.tDQSHZ_max = 20000,
   323				.tDQSQ_max = 5000,
   324				.tDS_min = 5000,
   325				.tDSC_min = 50000,
   326				.tFEAT_max = 1000000,
   327				.tITC_max = 1000000,
   328				.tQHS_max = 6000,
   329				.tRHW_min = 100000,
   330				.tRR_min = 20000,
   331				.tRST_max = 500000000,
   332				.tWB_max = 100000,
   333				.tWHR_min = 80000,
   334				.tWRCK_min = 20000,
   335				.tWW_min = 100000,
   336			},
   337		},
   338		/* Mode 1 */
   339		{
   340			.type = NAND_NVDDR_IFACE,
   341			.timings.mode = 1,
   342			.timings.nvddr = {
   343				.tCCS_min = 500000,
   344				.tR_max = 200000000,
   345				.tPROG_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   346				.tBERS_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   347				.tAC_min = 3000,
   348				.tAC_max = 25000,
   349				.tADL_min = 400000,
   350				.tCAD_min = 45000,
   351				.tCAH_min = 5000,
   352				.tCALH_min = 5000,
   353				.tCALS_min = 5000,
   354				.tCAS_min = 5000,
   355				.tCEH_min = 20000,
   356				.tCH_min = 5000,
   357				.tCK_min = 30000,
   358				.tCS_min = 25000,
   359				.tDH_min = 2500,
   360				.tDQSCK_min = 3000,
   361				.tDQSCK_max = 25000,
   362				.tDQSD_min = 0,
   363				.tDQSD_max = 18000,
   364				.tDQSHZ_max = 20000,
   365				.tDQSQ_max = 2500,
   366				.tDS_min = 3000,
   367				.tDSC_min = 30000,
   368				.tFEAT_max = 1000000,
   369				.tITC_max = 1000000,
   370				.tQHS_max = 3000,
   371				.tRHW_min = 100000,
   372				.tRR_min = 20000,
   373				.tRST_max = 500000000,
   374				.tWB_max = 100000,
   375				.tWHR_min = 80000,
   376				.tWRCK_min = 20000,
   377				.tWW_min = 100000,
   378			},
   379		},
   380		/* Mode 2 */
   381		{
   382			.type = NAND_NVDDR_IFACE,
   383			.timings.mode = 2,
   384			.timings.nvddr = {
   385				.tCCS_min = 500000,
   386				.tR_max = 200000000,
   387				.tPROG_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   388				.tBERS_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   389				.tAC_min = 3000,
   390				.tAC_max = 25000,
   391				.tADL_min = 400000,
   392				.tCAD_min = 45000,
   393				.tCAH_min = 4000,
   394				.tCALH_min = 4000,
   395				.tCALS_min = 4000,
   396				.tCAS_min = 4000,
   397				.tCEH_min = 20000,
   398				.tCH_min = 4000,
   399				.tCK_min = 20000,
   400				.tCS_min = 15000,
   401				.tDH_min = 1700,
   402				.tDQSCK_min = 3000,
   403				.tDQSCK_max = 25000,
   404				.tDQSD_min = 0,
   405				.tDQSD_max = 18000,
   406				.tDQSHZ_max = 20000,
   407				.tDQSQ_max = 1700,
   408				.tDS_min = 2000,
   409				.tDSC_min = 20000,
   410				.tFEAT_max = 1000000,
   411				.tITC_max = 1000000,
   412				.tQHS_max = 2000,
   413				.tRHW_min = 100000,
   414				.tRR_min = 20000,
   415				.tRST_max = 500000000,
   416				.tWB_max = 100000,
   417				.tWHR_min = 80000,
   418				.tWRCK_min = 20000,
   419				.tWW_min = 100000,
   420			},
   421		},
   422		/* Mode 3 */
   423		{
   424			.type = NAND_NVDDR_IFACE,
   425			.timings.mode = 3,
   426			.timings.nvddr = {
   427				.tCCS_min = 500000,
   428				.tR_max = 200000000,
   429				.tPROG_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   430				.tBERS_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   431				.tAC_min = 3000,
   432				.tAC_max = 25000,
   433				.tADL_min = 400000,
   434				.tCAD_min = 45000,
   435				.tCAH_min = 3000,
   436				.tCALH_min = 3000,
   437				.tCALS_min = 3000,
   438				.tCAS_min = 3000,
   439				.tCEH_min = 20000,
   440				.tCH_min = 3000,
   441				.tCK_min = 15000,
   442				.tCS_min = 15000,
   443				.tDH_min = 1300,
   444				.tDQSCK_min = 3000,
   445				.tDQSCK_max = 25000,
   446				.tDQSD_min = 0,
   447				.tDQSD_max = 18000,
   448				.tDQSHZ_max = 20000,
   449				.tDQSQ_max = 1300,
   450				.tDS_min = 1500,
   451				.tDSC_min = 15000,
   452				.tFEAT_max = 1000000,
   453				.tITC_max = 1000000,
   454				.tQHS_max = 1500,
   455				.tRHW_min = 100000,
   456				.tRR_min = 20000,
   457				.tRST_max = 500000000,
   458				.tWB_max = 100000,
   459				.tWHR_min = 80000,
   460				.tWRCK_min = 20000,
   461				.tWW_min = 100000,
   462			},
   463		},
   464		/* Mode 4 */
   465		{
   466			.type = NAND_NVDDR_IFACE,
   467			.timings.mode = 4,
   468			.timings.nvddr = {
   469				.tCCS_min = 500000,
   470				.tR_max = 200000000,
   471				.tPROG_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   472				.tBERS_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   473				.tAC_min = 3000,
   474				.tAC_max = 25000,
   475				.tADL_min = 400000,
   476				.tCAD_min = 45000,
   477				.tCAH_min = 2500,
   478				.tCALH_min = 2500,
   479				.tCALS_min = 2500,
   480				.tCAS_min = 2500,
   481				.tCEH_min = 20000,
   482				.tCH_min = 2500,
   483				.tCK_min = 12000,
   484				.tCS_min = 15000,
   485				.tDH_min = 1100,
   486				.tDQSCK_min = 3000,
   487				.tDQSCK_max = 25000,
   488				.tDQSD_min = 0,
   489				.tDQSD_max = 18000,
   490				.tDQSHZ_max = 20000,
   491				.tDQSQ_max = 1000,
   492				.tDS_min = 1100,
   493				.tDSC_min = 12000,
   494				.tFEAT_max = 1000000,
   495				.tITC_max = 1000000,
   496				.tQHS_max = 1200,
   497				.tRHW_min = 100000,
   498				.tRR_min = 20000,
   499				.tRST_max = 500000000,
   500				.tWB_max = 100000,
   501				.tWHR_min = 80000,
   502				.tWRCK_min = 20000,
   503				.tWW_min = 100000,
   504			},
   505		},
   506		/* Mode 5 */
   507		{
   508			.type = NAND_NVDDR_IFACE,
   509			.timings.mode = 5,
   510			.timings.nvddr = {
   511				.tCCS_min = 500000,
   512				.tR_max = 200000000,
   513				.tPROG_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   514				.tBERS_max = 1000000ULL * ONFI_DYN_TIMING_MAX,
   515				.tAC_min = 3000,
   516				.tAC_max = 25000,
   517				.tADL_min = 400000,
   518				.tCAD_min = 45000,
   519				.tCAH_min = 2000,
   520				.tCALH_min = 2000,
   521				.tCALS_min = 2000,
   522				.tCAS_min = 2000,
   523				.tCEH_min = 20000,
   524				.tCH_min = 2000,
   525				.tCK_min = 10000,
   526				.tCS_min = 15000,
   527				.tDH_min = 900,
   528				.tDQSCK_min = 3000,
   529				.tDQSCK_max = 25000,
   530				.tDQSD_min = 0,
   531				.tDQSD_max = 18000,
   532				.tDQSHZ_max = 20000,
   533				.tDQSQ_max = 850,
   534				.tDS_min = 900,
   535				.tDSC_min = 10000,
   536				.tFEAT_max = 1000000,
   537				.tITC_max = 1000000,
   538				.tQHS_max = 1000,
   539				.tRHW_min = 100000,
   540				.tRR_min = 20000,
   541				.tRST_max = 500000000,
   542				.tWB_max = 100000,
   543				.tWHR_min = 80000,
   544				.tWRCK_min = 20000,
   545				.tWW_min = 100000,
   546			},
   547		},
   548	};
   549	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
