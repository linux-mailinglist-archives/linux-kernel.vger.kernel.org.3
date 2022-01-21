Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F44959BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378622AbiAUGGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:06:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:25357 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348084AbiAUGGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642745197; x=1674281197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e/8uyym0uhWCi8SRLUHjGGsGS5s34qYC/OWRPWJ7tec=;
  b=M94M+gT2XOlL2YUehndnVPSGfLHn55S7uwIAjui+9aIWdaUBRZw1R78I
   BEnN2LLWXY+5Xrf1P/ZuChoBVgxGL89vOtqZOFEEXeRvtw+RbGoyEKhvI
   G/TWWkOZRoxh+Vn8NVyKIEsqoN35Tnkx0CzCcvyo13zVfMtkXoZ/i7F0M
   ln7BgrdOPTNmtVL3LIFxTRvg+CsTX4ZrIegkYGgS3/TLwSIzvDJuux22B
   9c5k6MZKTwZL6gAalTPO9zg+QV56PHFLk3z301qIle25VOSUr9kCtMDYf
   RaJAyPQUjzxGJUkQFSSRjbt+nGoolrBDUTGrDKYuRLrhvY2jxhAMHgDlt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="245360952"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="245360952"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 22:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="561753487"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Jan 2022 22:06:34 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAn4D-000Ez6-Do; Fri, 21 Jan 2022 06:06:33 +0000
Date:   Fri, 21 Jan 2022 14:06:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/dw-edma/dw-edma-v0-regs.h:37:4: warning: field sar
 within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed
 union at drivers/dma/dw-edma/dw-edma-v0-regs.h:31:2)' and is usually due to
 'struct dw_edma_v0_ch_regs' being packed, wh...
Message-ID: <202201211416.lYF8kJns-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2c271fe77d52a0555161926c232cd5bc07178b39
commit: 04e0a39fc10f82a71b84af73351333b184cee578 dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures
date:   10 months ago
config: arm-randconfig-r001-20220120 (https://download.01.org/0day-ci/archive/20220121/202201211416.lYF8kJns-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d4baf3b1322b84816aa623d8e8cb45a49cb68b84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04e0a39fc10f82a71b84af73351333b184cee578
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 04e0a39fc10f82a71b84af73351333b184cee578
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/dma/dw-edma/dw-edma-v0-core.c:13:
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:37:4: warning: field sar within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:31:2)' and is usually due to 'struct dw_edma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } sar;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:44:4: warning: field dar within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:38:2)' and is usually due to 'struct dw_edma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } dar;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:51:4: warning: field llp within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:45:2)' and is usually due to 'struct dw_edma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } llp;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:172:4: warning: field rd_err_status within 'struct dw_edma_v0_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:166:2)' and is usually due to 'struct dw_edma_v0_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } rd_err_status;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:182:4: warning: field rd_done_imwr within 'struct dw_edma_v0_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:176:2)' and is usually due to 'struct dw_edma_v0_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } rd_done_imwr;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:189:4: warning: field rd_abort_imwr within 'struct dw_edma_v0_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:183:2)' and is usually due to 'struct dw_edma_v0_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } rd_abort_imwr;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:71:4: warning: field wr_engine_hshake_cnt within 'struct dw_edma_v0_unroll' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:65:2)' and is usually due to 'struct dw_edma_v0_unroll' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } wr_engine_hshake_cnt;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:79:4: warning: field rd_engine_hshake_cnt within 'struct dw_edma_v0_unroll' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:73:2)' and is usually due to 'struct dw_edma_v0_unroll' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } rd_engine_hshake_cnt;
             ^
   8 warnings generated.


vim +37 drivers/dma/dw-edma/dw-edma-v0-regs.h

    26	
    27	struct dw_edma_v0_ch_regs {
    28		u32 ch_control1;				/* 0x000 */
    29		u32 ch_control2;				/* 0x004 */
    30		u32 transfer_size;				/* 0x008 */
    31		union {
    32			u64 reg;				/* 0x00c..0x010 */
    33			struct {
    34				u32 lsb;			/* 0x00c */
    35				u32 msb;			/* 0x010 */
    36			};
  > 37		} sar;
    38		union {
    39			u64 reg;				/* 0x014..0x018 */
    40			struct {
    41				u32 lsb;			/* 0x014 */
    42				u32 msb;			/* 0x018 */
    43			};
  > 44		} dar;
    45		union {
    46			u64 reg;				/* 0x01c..0x020 */
    47			struct {
    48				u32 lsb;			/* 0x01c */
    49				u32 msb;			/* 0x020 */
    50			};
  > 51		} llp;
    52	} __packed;
    53	
    54	struct dw_edma_v0_ch {
    55		struct dw_edma_v0_ch_regs wr;			/* 0x200 */
    56		u32 padding_1[55];				/* [0x224..0x2fc] */
    57		struct dw_edma_v0_ch_regs rd;			/* 0x300 */
    58		u32 padding_2[55];				/* [0x324..0x3fc] */
    59	} __packed;
    60	
    61	struct dw_edma_v0_unroll {
    62		u32 padding_1;					/* 0x0f8 */
    63		u32 wr_engine_chgroup;				/* 0x100 */
    64		u32 rd_engine_chgroup;				/* 0x104 */
    65		union {
    66			u64 reg;				/* 0x108..0x10c */
    67			struct {
    68				u32 lsb;			/* 0x108 */
    69				u32 msb;			/* 0x10c */
    70			};
  > 71		} wr_engine_hshake_cnt;
    72		u32 padding_2[2];				/* [0x110..0x114] */
    73		union {
    74			u64 reg;				/* 0x120..0x124 */
    75			struct {
    76				u32 lsb;			/* 0x120 */
    77				u32 msb;			/* 0x124 */
    78			};
  > 79		} rd_engine_hshake_cnt;
    80		u32 padding_3[2];				/* [0x120..0x124] */
    81		u32 wr_ch0_pwr_en;				/* 0x128 */
    82		u32 wr_ch1_pwr_en;				/* 0x12c */
    83		u32 wr_ch2_pwr_en;				/* 0x130 */
    84		u32 wr_ch3_pwr_en;				/* 0x134 */
    85		u32 wr_ch4_pwr_en;				/* 0x138 */
    86		u32 wr_ch5_pwr_en;				/* 0x13c */
    87		u32 wr_ch6_pwr_en;				/* 0x140 */
    88		u32 wr_ch7_pwr_en;				/* 0x144 */
    89		u32 padding_4[8];				/* [0x148..0x164] */
    90		u32 rd_ch0_pwr_en;				/* 0x168 */
    91		u32 rd_ch1_pwr_en;				/* 0x16c */
    92		u32 rd_ch2_pwr_en;				/* 0x170 */
    93		u32 rd_ch3_pwr_en;				/* 0x174 */
    94		u32 rd_ch4_pwr_en;				/* 0x178 */
    95		u32 rd_ch5_pwr_en;				/* 0x18c */
    96		u32 rd_ch6_pwr_en;				/* 0x180 */
    97		u32 rd_ch7_pwr_en;				/* 0x184 */
    98		u32 padding_5[30];				/* [0x188..0x1fc] */
    99		struct dw_edma_v0_ch ch[EDMA_V0_MAX_NR_CH];	/* [0x200..0x1120] */
   100	} __packed;
   101	
   102	struct dw_edma_v0_legacy {
   103		u32 viewport_sel;				/* 0x0f8 */
   104		struct dw_edma_v0_ch_regs ch;			/* [0x100..0x120] */
   105	} __packed;
   106	
   107	struct dw_edma_v0_regs {
   108		/* eDMA global registers */
   109		u32 ctrl_data_arb_prior;			/* 0x000 */
   110		u32 padding_1;					/* 0x004 */
   111		u32 ctrl;					/* 0x008 */
   112		u32 wr_engine_en;				/* 0x00c */
   113		u32 wr_doorbell;				/* 0x010 */
   114		u32 padding_2;					/* 0x014 */
   115		union {
   116			u64 reg;				/* 0x018..0x01c */
   117			struct {
   118				u32 lsb;			/* 0x018 */
   119				u32 msb;			/* 0x01c */
   120			};
   121		} wr_ch_arb_weight;
   122		u32 padding_3[3];				/* [0x020..0x028] */
   123		u32 rd_engine_en;				/* 0x02c */
   124		u32 rd_doorbell;				/* 0x030 */
   125		u32 padding_4;					/* 0x034 */
   126		union {
   127			u64 reg;				/* 0x038..0x03c */
   128			struct {
   129				u32 lsb;			/* 0x038 */
   130				u32 msb;			/* 0x03c */
   131			};
   132		} rd_ch_arb_weight;
   133		u32 padding_5[3];				/* [0x040..0x048] */
   134		/* eDMA interrupts registers */
   135		u32 wr_int_status;				/* 0x04c */
   136		u32 padding_6;					/* 0x050 */
   137		u32 wr_int_mask;				/* 0x054 */
   138		u32 wr_int_clear;				/* 0x058 */
   139		u32 wr_err_status;				/* 0x05c */
   140		union {
   141			u64 reg;				/* 0x060..0x064 */
   142			struct {
   143				u32 lsb;			/* 0x060 */
   144				u32 msb;			/* 0x064 */
   145			};
   146		} wr_done_imwr;
   147		union {
   148			u64 reg;				/* 0x068..0x06c */
   149			struct {
   150				u32 lsb;			/* 0x068 */
   151				u32 msb;			/* 0x06c */
   152			};
   153		} wr_abort_imwr;
   154		u32 wr_ch01_imwr_data;				/* 0x070 */
   155		u32 wr_ch23_imwr_data;				/* 0x074 */
   156		u32 wr_ch45_imwr_data;				/* 0x078 */
   157		u32 wr_ch67_imwr_data;				/* 0x07c */
   158		u32 padding_7[4];				/* [0x080..0x08c] */
   159		u32 wr_linked_list_err_en;			/* 0x090 */
   160		u32 padding_8[3];				/* [0x094..0x09c] */
   161		u32 rd_int_status;				/* 0x0a0 */
   162		u32 padding_9;					/* 0x0a4 */
   163		u32 rd_int_mask;				/* 0x0a8 */
   164		u32 rd_int_clear;				/* 0x0ac */
   165		u32 padding_10;					/* 0x0b0 */
   166		union {
   167			u64 reg;				/* 0x0b4..0x0b8 */
   168			struct {
   169				u32 lsb;			/* 0x0b4 */
   170				u32 msb;			/* 0x0b8 */
   171			};
 > 172		} rd_err_status;
   173		u32 padding_11[2];				/* [0x0bc..0x0c0] */
   174		u32 rd_linked_list_err_en;			/* 0x0c4 */
   175		u32 padding_12;					/* 0x0c8 */
   176		union {
   177			u64 reg;				/* 0x0cc..0x0d0 */
   178			struct {
   179				u32 lsb;			/* 0x0cc */
   180				u32 msb;			/* 0x0d0 */
   181			};
 > 182		} rd_done_imwr;
   183		union {
   184			u64 reg;				/* 0x0d4..0x0d8 */
   185			struct {
   186				u32 lsb;			/* 0x0d4 */
   187				u32 msb;			/* 0x0d8 */
   188			};
 > 189		} rd_abort_imwr;
   190		u32 rd_ch01_imwr_data;				/* 0x0dc */
   191		u32 rd_ch23_imwr_data;				/* 0x0e0 */
   192		u32 rd_ch45_imwr_data;				/* 0x0e4 */
   193		u32 rd_ch67_imwr_data;				/* 0x0e8 */
   194		u32 padding_13[4];				/* [0x0ec..0x0f8] */
   195		/* eDMA channel context grouping */
   196		union dw_edma_v0_type {
   197			struct dw_edma_v0_legacy legacy;	/* [0x0f8..0x120] */
   198			struct dw_edma_v0_unroll unroll;	/* [0x0f8..0x1120] */
   199		} type;
   200	} __packed;
   201	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
