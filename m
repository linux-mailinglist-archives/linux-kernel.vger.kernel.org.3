Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7C4A68B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbiBAXqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:46:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:5117 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbiBAXqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643759182; x=1675295182;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=O3WDTuHdqFSLin30keUQ1rtRXj1aZQRFqDOAtWcg+Vc=;
  b=F//aQyru2cJ0VJm7/Tg+WEdvQzx7sfXMrTdCV2TckUHvv0NXkACm4vkE
   lKBpBQ9JsdqO+6czenVepsEZn5/8+uTVWxy2fvM1NGEzMURrH+Geuwl2Y
   +PwX9JOD1194GB3m1eCMbX+8aBVYgqgXcJA9Z2Nsw20lAipEU6qqcos9G
   qFTyWtmM9O6/ZIZbFnVW/zXXUee3y5fnaP6yu3Wav6t2EoDBVbiP/UKkE
   mTRj8KC5Zu2S9bPNiXkp9lYAKHhZ7b8L+ONuIktEHJtN+Lo4eUolKzZx2
   gUZJ710Ew2yLeiLlEIPyI9YVUWsXCtBGr2Yx+GucZV8cDYbE9qmjfbnvW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="272301894"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="272301894"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 15:46:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="769112050"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2022 15:46:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nF2qo-000TqZ-EU; Tue, 01 Feb 2022 23:46:18 +0000
Date:   Wed, 2 Feb 2022 07:45:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Kalle Valo <quic_kvalo@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [ammarfaizi2-block:kvalo/ath/ath12k-bringup 275/275]
 drivers/net/wireless/ath/ath12k/hal_rx.c:404:25: warning: cast to pointer
 from integer of different size
Message-ID: <202202020753.GUB2VYGh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block kvalo/ath/ath12k-bringup
head:   f40abb4788a2a3868606a29d99583421e0874350
commit: f40abb4788a2a3868606a29d99583421e0874350 [275/275] ath12k: New driver for Qualcomm 11be hw family
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20220202/202202020753.GUB2VYGh-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f40abb4788a2a3868606a29d99583421e0874350
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block kvalo/ath/ath12k-bringup
        git checkout f40abb4788a2a3868606a29d99583421e0874350
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/net/wireless/ath/ath12k/

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
--
   drivers/net/wireless/ath/ath12k/dp_mon.c: In function 'ath12k_dp_mon_tx_parse_status_tlv':
>> drivers/net/wireless/ath/ath12k/dp_mon.c:1902:32: warning: implicit conversion from 'enum hal_rx_mon_status' to 'enum hal_tx_tlv_status' [-Wenum-conversion]
    1902 |                         return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/ath12k/dp_mon.c:1924:32: warning: implicit conversion from 'enum hal_rx_mon_status' to 'enum hal_tx_tlv_status' [-Wenum-conversion]
    1924 |                         return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
