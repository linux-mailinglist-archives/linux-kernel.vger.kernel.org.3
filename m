Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66761515393
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379799AbiD2SY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiD2SYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:24:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC7C51E52
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651256495; x=1682792495;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ruTQkiuiIWww3FG4Asoi5D5mE4TCsmeMFfdM3HiY15I=;
  b=bMnHqWVTXIGlVaIHjRFUDMmW+ZPr7/ds3SI1rAYRr11UrQ73qDe5NmnS
   CRFk58MyM1IN8PiNXQVldYNuUlH2x1wcOrjitCyegmVY7k+dZqKu7mWmT
   8Y0FE+3KaCttlKrBorZowkHnLIQmsNOHbqz9jXYRXp9BmEe5eRezgy7RK
   vtNGBw26vGlM+8zu5MGJpKVEwCLH9fKPfyRMOn25/7fUxHMdcJua5iqR9
   wiIlbcep8qTV7I52IIsZ+SC93doYeAY6/Nq3UL0DrmMxBOeMexIkwJi5d
   SztiYZx8e6/V/kE818ZN33dzqe4aOcczjLxjDWiFOgiWq6wX45AuGjZLR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="353167246"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="353167246"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 11:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="732213521"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2022 11:21:20 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkVF1-0006YF-B0;
        Fri, 29 Apr 2022 18:21:19 +0000
Date:   Sat, 30 Apr 2022 02:20:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [ammarfaizi2-block:kvalo/ath/ath12k-bringup 29/38]
 drivers/net/wireless/ath/ath12k/hal_rx.c:404:25: warning: cast to pointer
 from integer of different size
Message-ID: <202204300256.UMWIbtD0-lkp@intel.com>
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

Hi Vasanthakumar,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/ath12k-bringup
head:   910edb5ff5fbe5ad5460c750c7a62e92c4eb0aa5
commit: f40abb4788a2a3868606a29d99583421e0874350 [29/38] ath12k: New driver for Qualcomm 11be hw family
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220430/202204300256.UMWIbtD0-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f40abb4788a2a3868606a29d99583421e0874350
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/ath12k-bringup
        git checkout f40abb4788a2a3868606a29d99583421e0874350
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/net/wireless/ath/ath12k/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/ath/ath12k/hal_rx.c: In function 'ath12k_hal_wbm_desc_parse_err':
>> drivers/net/wireless/ath/ath12k/hal_rx.c:404:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     404 |                         (struct ath12k_rx_desc_info *)((u64)wbm_cc_desc->buf_va_hi << 32 |
         |                         ^
--
   drivers/net/wireless/ath/ath12k/dp_tx.c: In function 'ath12k_dp_tx_completion_handler':
>> drivers/net/wireless/ath/ath12k/dp_tx.c:605:35: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     605 |                         tx_desc = (struct ath12k_tx_desc_info *)
         |                                   ^
   In file included from include/linux/bitops.h:6,
                    from include/linux/kernel.h:13,
                    from include/linux/interrupt.h:6,
                    from drivers/net/wireless/ath/ath12k/core.h:11,
                    from drivers/net/wireless/ath/ath12k/dp_tx.c:7:
   drivers/net/wireless/ath/ath12k/dp_tx.c: In function 'ath12k_dp_tx_htt_h2t_vdev_stats_ol_req':
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/wireless/ath/ath12k/dp.h:1921:49: note: in expansion of macro 'GENMASK'
    1921 | #define HTT_H2T_VDEV_TXRX_HI_BITMASK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/net/wireless/ath/ath12k/dp_tx.c:1074:37: note: in expansion of macro 'HTT_H2T_VDEV_TXRX_HI_BITMASK'
    1074 |                                     HTT_H2T_VDEV_TXRX_HI_BITMASK) >> 32);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/wireless/ath/ath12k/dp.h:1921:49: note: in expansion of macro 'GENMASK'
    1921 | #define HTT_H2T_VDEV_TXRX_HI_BITMASK            GENMASK(63, 32)
         |                                                 ^~~~~~~
   drivers/net/wireless/ath/ath12k/dp_tx.c:1074:37: note: in expansion of macro 'HTT_H2T_VDEV_TXRX_HI_BITMASK'
    1074 |                                     HTT_H2T_VDEV_TXRX_HI_BITMASK) >> 32);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net/wireless/ath/ath12k/dp_rx.c: In function 'ath12k_dp_process_rx':
>> drivers/net/wireless/ath/ath12k/dp_rx.c:2739:29: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    2739 |                 desc_info = (struct ath12k_rx_desc_info *)((u64)desc.buf_va_hi << 32 |
         |                             ^
   drivers/net/wireless/ath/ath12k/dp_rx.c: In function 'ath12k_dp_process_rx_err_buf':
   drivers/net/wireless/ath/ath12k/dp_rx.c:3413:21: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
    3413 |         desc_info = (struct ath12k_rx_desc_info *)((u64)desc.buf_va_hi << 32 |
         |                     ^


vim +404 drivers/net/wireless/ath/ath12k/hal_rx.c

   352	
   353	int ath12k_hal_wbm_desc_parse_err(struct ath12k_base *ab, void *desc,
   354					  struct hal_rx_wbm_rel_info *rel_info)
   355	{
   356		struct hal_wbm_release_ring *wbm_desc = desc;
   357		struct hal_wbm_release_ring_cc_rx *wbm_cc_desc = desc;
   358		enum hal_wbm_rel_desc_type type;
   359		enum hal_wbm_rel_src_module rel_src;
   360		bool hw_cc_done;
   361	
   362		type = FIELD_GET(HAL_WBM_RELEASE_INFO0_DESC_TYPE,
   363				 wbm_desc->info0);
   364		/* We expect only WBM_REL buffer type */
   365		if (type != HAL_WBM_REL_DESC_TYPE_REL_MSDU) {
   366			WARN_ON(1);
   367			return -EINVAL;
   368		}
   369	
   370		rel_src = FIELD_GET(HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE,
   371				    wbm_desc->info0);
   372		if (rel_src != HAL_WBM_REL_SRC_MODULE_RXDMA &&
   373		    rel_src != HAL_WBM_REL_SRC_MODULE_REO)
   374			return -EINVAL;
   375	
   376		/* The format of wbm rel ring desc changes based on the
   377		 * hw cookie conversion status
   378		 */
   379		hw_cc_done = FIELD_GET(HAL_WBM_RELEASE_RX_INFO0_CC_STATUS,
   380				       wbm_desc->info0);
   381	
   382		if (!hw_cc_done) {
   383			if (FIELD_GET(BUFFER_ADDR_INFO1_RET_BUF_MGR,
   384				      wbm_desc->buf_addr_info.info1) != HAL_RX_BUF_RBM_SW3_BM) {
   385				ab->soc_stats.invalid_rbm++;
   386				return -EINVAL;
   387			}
   388	
   389			rel_info->cookie = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
   390						     wbm_desc->buf_addr_info.info1);
   391	
   392			rel_info->rx_desc = NULL;
   393		} else {
   394			if (FIELD_GET(HAL_WBM_RELEASE_RX_CC_INFO0_RBM,
   395				      wbm_cc_desc->info0) != HAL_RX_BUF_RBM_SW3_BM) {
   396				ab->soc_stats.invalid_rbm++;
   397				return -EINVAL;
   398			}
   399	
   400			rel_info->cookie = FIELD_GET(HAL_WBM_RELEASE_RX_CC_INFO1_COOKIE,
   401						     wbm_cc_desc->info1);
   402	
   403			rel_info->rx_desc =
 > 404				(struct ath12k_rx_desc_info *)((u64)wbm_cc_desc->buf_va_hi << 32 |
   405					wbm_cc_desc->buf_va_lo);
   406		}
   407	
   408		rel_info->err_rel_src = rel_src;
   409		rel_info->hw_cc_done = hw_cc_done;
   410	
   411		if (rel_info->err_rel_src == HAL_WBM_REL_SRC_MODULE_REO) {
   412			rel_info->push_reason =
   413				FIELD_GET(HAL_WBM_RELEASE_INFO0_REO_PUSH_REASON,
   414					  wbm_desc->info0);
   415			rel_info->err_code =
   416				FIELD_GET(HAL_WBM_RELEASE_INFO0_REO_ERROR_CODE,
   417					  wbm_desc->info0);
   418		} else {
   419			rel_info->push_reason =
   420				FIELD_GET(HAL_WBM_RELEASE_INFO0_RXDMA_PUSH_REASON,
   421					  wbm_desc->info0);
   422			rel_info->err_code =
   423				FIELD_GET(HAL_WBM_RELEASE_INFO0_RXDMA_ERROR_CODE,
   424					  wbm_desc->info0);
   425		}
   426	
   427		return 0;
   428	}
   429	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
