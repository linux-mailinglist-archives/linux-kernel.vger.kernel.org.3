Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD3251598F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 03:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382001AbiD3BV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 21:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381992AbiD3BVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:21:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987BAD4442
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651281511; x=1682817511;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DFU20exKPPJr6dGL2yy1H++DH02BV33K7anFqDdK73I=;
  b=jQX2t6Gqqw8xiBQSWHbK7UyQD7+sRPhCGlrLnjQ2uER77kcfEMu761YM
   nDH4A306qjI8wKbw3aOPdP1dA9gnwV9Qf997GCd4zdpd+5GX/Gnsw52mf
   C9rUk1iEXaUWqN3ngm/nOwSE+0k8AUGypIBt7R3KItOM2vmKwDCaRZgjZ
   7MQ+/IKLC0pTct03TNwYzQuBJkS8lYUC5YpTXOXwD45z4jTgOVts4P+KB
   dRzz/5/WZRCPV6wEoPYqmC3ibVXelIo4rlzDldTofFqnnqEnrc/H6a9Lx
   d5HFzeCoh8fIjyV12xaprizQVxigVlwGnhMXtEBOXEDTrDI0woQnMIJTh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="329762713"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="329762713"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 18:18:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="515112679"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Apr 2022 18:18:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkbki-0006kV-5Y;
        Sat, 30 Apr 2022 01:18:28 +0000
Date:   Sat, 30 Apr 2022 09:17:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        George Sun <george.sun@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [hverkuil-media-tree:for-v5.19g 16/20]
 vdec_vp9_req_lat_if.c:undefined reference to `v4l2_vp9_adapt_noncoef_probs'
Message-ID: <202204300935.ih1ehcA4-lkp@intel.com>
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

tree:   git://linuxtv.org/hverkuil/media_tree.git for-v5.19g
head:   f82120aec4e7ee9f06251d36931ab36bd9ef3c42
commit: 6e2ca6ec467a572cb7896758457e77da2896701c [16/20] media: mediatek: vcodec: support stateless VP9 decoding
config: riscv-randconfig-r032-20220428 (https://download.01.org/0day-ci/archive/20220430/202204300935.ih1ehcA4-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add hverkuil-media-tree git://linuxtv.org/hverkuil/media_tree.git
        git fetch --no-tags hverkuil-media-tree for-v5.19g
        git checkout 6e2ca6ec467a572cb7896758457e77da2896701c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv32-linux-ld: drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.o: in function `.L194':
>> vdec_vp9_req_lat_if.c:(.text+0x18dc): undefined reference to `v4l2_vp9_adapt_noncoef_probs'
   riscv32-linux-ld: drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.o: in function `.L202':
   vdec_vp9_req_lat_if.c:(.text+0x1930): undefined reference to `v4l2_vp9_adapt_coef_probs'
   riscv32-linux-ld: drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.o: in function `.L193':
   vdec_vp9_req_lat_if.c:(.text+0x1942): undefined reference to `v4l2_vp9_adapt_coef_probs'
   riscv32-linux-ld: drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.o: in function `.L200':
   vdec_vp9_req_lat_if.c:(.text+0x1954): undefined reference to `v4l2_vp9_adapt_coef_probs'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
