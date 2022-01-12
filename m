Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E5048CCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350647AbiALUHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:07:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:55170 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350575AbiALUGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642018010; x=1673554010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HZa09u9oFrEepW3RlnsTTR34qux46eYE9UxSgDHjXJ8=;
  b=UYH0FH7wvgXop8Urwxh//RbptRM4+J6gXKbJ4Ib1y9pFWvZZB2rCpsFB
   wv0+zE308KdHmdP5OSsy3X884lWbBRzj5gcp3bZclygOphISP/Q0vnTWX
   r8zkbD+SJVD47mupgqVvPg7VuY2UPZX65arH+KUcjFPSuy14q4JE51OCQ
   I5VftFZhIRW13d8iXiiT5HxPN5JAezRDvW4ZYmKcUOouc0wpGOG2m+ERd
   dbfiCRO3MpqSK+rEReBvwp6NTAiHSAKhC15i+TxEDwWMDkfL7mmePBrge
   hl1tTYOTcHC+TYnwgoQCIhtLUTQzh2dd8jTKW7s1r0/UanxBtxdux6/+I
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="224535857"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="224535857"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 12:06:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="623595596"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 12 Jan 2022 12:06:11 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7jso-0006Ko-96; Wed, 12 Jan 2022 20:06:10 +0000
Date:   Thu, 13 Jan 2022 04:05:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] media: staging: tegra-vde: Support V4L stateless
 video decoder API
Message-ID: <202201130310.BFtsDEXe-lkp@intel.com>
References: <20220112153952.1291-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112153952.1291-3-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

I love your patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on next-20220112]
[cannot apply to v5.16]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Osipenko/Add-V4L-stateless-video-decoder-API-support-to-NVIDIA-Tegra-driver/20220112-234115
base:   git://linuxtv.org/media_tree.git master
config: powerpc-randconfig-s031-20220112 (https://download.01.org/0day-ci/archive/20220113/202201130310.BFtsDEXe-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/3b11791070fd9de6cd368f28578ebab731386a83
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Dmitry-Osipenko/Add-V4L-stateless-video-decoder-API-support-to-NVIDIA-Tegra-driver/20220112-234115
        git checkout 3b11791070fd9de6cd368f28578ebab731386a83
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/staging/media/tegra-vde/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/staging/media/tegra-vde/h264_reader.c:57:15: sparse: sparse: cast to restricted __be32
>> drivers/staging/media/tegra-vde/h264_reader.c:57:15: sparse: sparse: cast to restricted __be32
>> drivers/staging/media/tegra-vde/h264_reader.c:57:15: sparse: sparse: cast to restricted __be32
>> drivers/staging/media/tegra-vde/h264_reader.c:57:15: sparse: sparse: cast to restricted __be32

vim +57 drivers/staging/media/tegra-vde/h264_reader.c

    44	
    45	static inline u8 emulation_escape(struct bitstream_reader *reader, u32 offset,
    46					  u8 data, bool inc_offset, bool *escaped)
    47	{
    48		u32 seq;
    49	
    50		if (data != 0x03 || !reader->rbsp_mode)
    51			return data;
    52	
    53		if (offset < 2 || offset == reader->bitstream_end)
    54			return data;
    55	
    56		seq = *((u32 *)(reader->data_ptr + offset - 2));
  > 57		seq = be32_to_cpu(seq);
    58	
    59		switch (seq) {
    60		case 0x00000300:
    61		case 0x00000301:
    62		case 0x00000302:
    63		case 0x00000303:
    64			if (inc_offset)
    65				reader->data_offset++;
    66	
    67			if (escaped)
    68				*escaped = true;
    69	
    70			return seq & 0xFF;
    71		default:
    72			break;
    73		}
    74	
    75		return data;
    76	}
    77	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
