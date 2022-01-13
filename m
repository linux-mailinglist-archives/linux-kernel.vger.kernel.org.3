Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9352748DD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbiAMRmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:42:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:45201 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbiAMRmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642095744; x=1673631744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5drOxuCpnu6NcqTrQ54+q8TNEj3JwEJ/XfBKw8Jw7Pc=;
  b=Ra526i+tEpMgwEWwjmoGPQ12yHJWdGAN5dzijKjldnBdOm/MM39neMdG
   0vAfnMiIShpE2flSZKeKqAVtdwx6AJjOnEetTANnsEd65LxHh4AT0GpK/
   Cj6tWGku7G2VCqmLqfiK8mWPUzefhLqMixJcpqlA6FTGMuuORBDoM1uzQ
   u9ZxyuRFOvV9WXzODmpCIV36MitU3kQ06amCSQja+hUbDJxETj3WldpNA
   kOuNcTt3rlTan3ZvorfVIjcy5bz1TRuNdAkwsgGrgBB5P0wVRDAXp8urw
   dtnuYpTVIlL3pAwP+57+XAs9sKN/hQNe6mjZifM9mfzdImRGha6QxMSZa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="231419497"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="231419497"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 09:42:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="473288535"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Jan 2022 09:41:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n846o-0007VH-Fx; Thu, 13 Jan 2022 17:41:58 +0000
Date:   Fri, 14 Jan 2022 01:41:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:40:17: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <202201140142.b2CYChpW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   455e73a07f6e288b0061dfcf4fcf54fa9fe06458
commit: 57cbdbe65e5f9ba9bfd67b66bc3ce24ef1c54643 drm/nouveau/kms/nv140-: Use hard-coded wndws or core channel for CRC channel
date:   9 weeks ago
config: sparc64-randconfig-s032-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140142.b2CYChpW-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57cbdbe65e5f9ba9bfd67b66bc3ce24ef1c54643
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 57cbdbe65e5f9ba9bfd67b66bc3ce24ef1c54643
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:40:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:40:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:41:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:41:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:43:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:43:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:44:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/dispnv50/crcc57d.c:44:17: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +40 drivers/gpu/drm/nouveau/dispnv50/crcc57d.c

    12	
    13	static int crcc57d_set_src(struct nv50_head *head, int or, enum nv50_crc_source_type source,
    14				   struct nv50_crc_notifier_ctx *ctx)
    15	{
    16		struct nvif_push *push = nv50_disp(head->base.base.dev)->core->chan.push;
    17		const int i = head->base.index;
    18		u32 crc_args = NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, CONTROLLING_CHANNEL, CORE) |
    19			       NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, EXPECT_BUFFER_COLLAPSE, FALSE) |
    20			       NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, SECONDARY_CRC, NONE) |
    21			       NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, CRC_DURING_SNOOZE, DISABLE);
    22		int ret;
    23	
    24		switch (source) {
    25		case NV50_CRC_SOURCE_TYPE_SOR:
    26			crc_args |= NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, PRIMARY_CRC, SOR(or));
    27			break;
    28		case NV50_CRC_SOURCE_TYPE_SF:
    29			crc_args |= NVDEF(NVC57D, HEAD_SET_CRC_CONTROL, PRIMARY_CRC, SF);
    30			break;
    31		default:
    32			break;
    33		}
    34	
    35		ret = PUSH_WAIT(push, 4);
    36		if (ret)
    37			return ret;
    38	
    39		if (source) {
  > 40			PUSH_MTHD(push, NVC57D, HEAD_SET_CONTEXT_DMA_CRC(i), ctx->ntfy.handle);
    41			PUSH_MTHD(push, NVC57D, HEAD_SET_CRC_CONTROL(i), crc_args);
    42		} else {
    43			PUSH_MTHD(push, NVC57D, HEAD_SET_CRC_CONTROL(i), 0);
    44			PUSH_MTHD(push, NVC57D, HEAD_SET_CONTEXT_DMA_CRC(i), 0);
    45		}
    46	
    47		return 0;
    48	}
    49	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
