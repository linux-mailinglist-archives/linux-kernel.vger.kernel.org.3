Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72681553F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 02:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354570AbiFVATd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 20:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353519AbiFVATY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 20:19:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557E626557
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655857162; x=1687393162;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ky6m3gM8BOJn8dc2TEMVajpayNchN1A8FfFsM/dG0LU=;
  b=geTyyN/CiWs4AzVdwRmp1vhJBB8fKjLSaCsPj9IQpwxixA8ojE77TQTr
   nbwWAHZqrVaZIKiMUIA1CkdAwEd3dVQNNe8scRZuy6ciHMpP8j/XdsZz0
   2nTJHm+jDuvvRCf94g1pFzILW+lgSkZOhu94Xtw50PUVnmxuBMSJD7V41
   eogHEuMHYlONhRrXY4qc2p2aSD9yOjQHC2KcyVXQKsmGUPx4t1u9RE2lS
   a08fykddjwxCozOYpmniTOeKIu1Yq4/2/cLw3F48bYdOzwRWoaY8X9SR8
   pGEFAb706HVHeZrJe3PoOuoAFMwjYGklKWz2geG/h48sx++N6ko0PXkAQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344264150"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="344264150"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 17:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="833826160"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2022 17:19:20 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3o5X-0000bN-GQ;
        Wed, 22 Jun 2022 00:19:19 +0000
Date:   Wed, 22 Jun 2022 08:19:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [mgr:v5.19/topic/rk3568-vepu-h264-stateless-bootlin 3/4]
 drivers/staging/media/hantro/hantro_h264.c:1254:27: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202206220835.2xwbmnW9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.pengutronix.de/git/mgr/linux v5.19/topic/rk3568-vepu-h264-stateless-bootlin
head:   11fcd09bf7cbe84c3e2e322142e3aff59c5c8402
commit: a373f546c23855d80f8a6be85fc11748ed54413d [3/4] media: hantro: Add H.264 encoding support
config: riscv-randconfig-s031-20220619 (https://download.01.org/0day-ci/archive/20220622/202206220835.2xwbmnW9-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        git remote add mgr https://git.pengutronix.de/git/mgr/linux
        git fetch --no-tags mgr v5.19/topic/rk3568-vepu-h264-stateless-bootlin
        git checkout a373f546c23855d80f8a6be85fc11748ed54413d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/staging/media/hantro/hantro_h264.c:1254:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   drivers/staging/media/hantro/hantro_h264.c:1254:27: sparse:     expected unsigned long long [usertype]
   drivers/staging/media/hantro/hantro_h264.c:1254:27: sparse:     got restricted __be64 [usertype]

vim +1254 drivers/staging/media/hantro/hantro_h264.c

  1214	
  1215	static void cabac_table_init(struct hantro_aux_buf *cabac_table,
  1216				     u32 cabac_init_idc)
  1217	{
  1218		u8 *table = cabac_table->cpu;
  1219		u64 *buffer = cabac_table->cpu;
  1220		unsigned int i, j;
  1221		unsigned int size;
  1222		s32 qp;
  1223	
  1224		/* Iterate possible QP values. */
  1225		for (qp = 0; qp < 52; qp++) {
  1226			/* Iterate intra/inter modes. */
  1227			for (j = 0; j < 2; j++) {
  1228				const s32 (*context)[460][2];
  1229	
  1230				if (j == 0)
  1231					context = &h264_context_init_intra;
  1232				else
  1233					context = &h264_context_init[cabac_init_idc];
  1234	
  1235				for (i = 0; i < 460; i++) {
  1236					s32 m = (s32)(*context)[i][0];
  1237					s32 n = (s32)(*context)[i][1];
  1238	
  1239					s32 pre_ctx_st = CLIP3(((m * qp) >> 4) + n,
  1240							       1, 126);
  1241					u32 idx = qp * 464 * 2 + j * 464 + i;
  1242	
  1243					if (pre_ctx_st <= 63)
  1244						table[idx] = (u8)((63 - pre_ctx_st) << 1);
  1245					else
  1246						table[idx] = (u8)(((pre_ctx_st - 64) << 1) | 1);
  1247				}
  1248			}
  1249		}
  1250	
  1251		size = HANTRO_H264_ENC_CABAC_TABLE_SIZE / sizeof(*buffer);
  1252	
  1253		for (i = 0; i < size; i++)
> 1254			buffer[i] = cpu_to_be64(buffer[i]);
  1255	}
  1256	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
