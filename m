Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1659849EC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344075AbiA0UlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:41:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:45677 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238844AbiA0UlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643316080; x=1674852080;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LG+hS2VdrRD35YyOdC7esEnbEaYkmVRKyYKMmjYwd/4=;
  b=RVM5I1j7mlVHKLOL8juG9LLUcvXG8qIEsozn0Xso8MZad/uFsslWvMza
   asDSxBTIk1YW1gqUviPZMRr0sC0u5eSW+3DPu/X0bRt1h+bJCGc1vJiUo
   rf6IYyr6Xd+IcnqGm3JDlkNxWuJDGE53W8fIDQ5DzAlaSx9KnouesRN4Q
   4rGAKmfGUQTDbIEapdbREh4Un5baRx2EvZyfXopKvvCDXL4HxosjCITOl
   5VNRfCKQdKUsXWIdC7JrA19LQQ5bTg+T4sqgWdkx33So7xKLYzt33nim9
   iBPXo80gvD6DQXYauETA0iGtGhbc26hwVBHW82DeoekACUh+x/dKW3CNb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="310272931"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="310272931"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 12:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="628838017"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2022 12:41:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDBa0-000N1X-D4; Thu, 27 Jan 2022 20:41:16 +0000
Date:   Fri, 28 Jan 2022 04:40:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/wireless/ath/ath10k/htt.h:1677:2: warning: field  within
 'struct htt_tx_fetch_ind' is less aligned than 'union
 htt_tx_fetch_ind::(anonymous at
 drivers/net/wireless/ath/ath10k/htt.h:1677:2)' and is usually due to 'struct
 htt_tx_fetch_ind' being...
Message-ID: <202201280415.ofyFUB4M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   626b2dda7651a7c766108db4cdc0825db05b980d
commit: fa7845cfd53f3b1d3f60efa55db89805595bc045 treewide: Replace open-coded flex arrays in unions
date:   3 months ago
config: arm-buildonly-randconfig-r002-20220127 (https://download.01.org/0day-ci/archive/20220128/202201280415.ofyFUB4M-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f400a6012c668dfaa73462caf067ceb074e66c47)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa7845cfd53f3b1d3f60efa55db89805595bc045
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fa7845cfd53f3b1d3f60efa55db89805595bc045
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/wireless/ath/ath10k/ drivers/pci/controller/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/wireless/ath/ath10k/mac.c:8:
   In file included from drivers/net/wireless/ath/ath10k/mac.h:11:
   In file included from drivers/net/wireless/ath/ath10k/core.h:18:
   drivers/net/wireless/ath/ath10k/htt.h:721:34: warning: field prefix within 'struct htt_rx_indication' is less aligned than 'struct htt_rx_indication_prefix' and is usually due to 'struct htt_rx_indication' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           struct htt_rx_indication_prefix prefix;
                                           ^
   drivers/net/wireless/ath/ath10k/htt.h:742:34: warning: field prefix within 'struct htt_rx_indication_hl' is less aligned than 'struct htt_rx_indication_prefix' and is usually due to 'struct htt_rx_indication_hl' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           struct htt_rx_indication_prefix prefix;
                                           ^
>> drivers/net/wireless/ath/ath10k/htt.h:1677:2: warning: field  within 'struct htt_tx_fetch_ind' is less aligned than 'union htt_tx_fetch_ind::(anonymous at drivers/net/wireless/ath/ath10k/htt.h:1677:2)' and is usually due to 'struct htt_tx_fetch_ind' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   drivers/net/wireless/ath/ath10k/htt.h:1815:2: warning: field  within 'struct htt_resp' is less aligned than 'union htt_resp::(anonymous at drivers/net/wireless/ath/ath10k/htt.h:1815:2)' and is usually due to 'struct htt_resp' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   drivers/net/wireless/ath/ath10k/mac.c:5942:22: warning: parameter 'changed_flags' set but not used [-Wunused-but-set-parameter]
                                       unsigned int changed_flags,
                                                    ^
   5 warnings generated.
--
   In file included from drivers/net/wireless/ath/ath10k/debug.c:14:
   In file included from drivers/net/wireless/ath/ath10k/core.h:18:
   drivers/net/wireless/ath/ath10k/htt.h:721:34: warning: field prefix within 'struct htt_rx_indication' is less aligned than 'struct htt_rx_indication_prefix' and is usually due to 'struct htt_rx_indication' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           struct htt_rx_indication_prefix prefix;
                                           ^
   drivers/net/wireless/ath/ath10k/htt.h:742:34: warning: field prefix within 'struct htt_rx_indication_hl' is less aligned than 'struct htt_rx_indication_prefix' and is usually due to 'struct htt_rx_indication_hl' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           struct htt_rx_indication_prefix prefix;
                                           ^
>> drivers/net/wireless/ath/ath10k/htt.h:1677:2: warning: field  within 'struct htt_tx_fetch_ind' is less aligned than 'union htt_tx_fetch_ind::(anonymous at drivers/net/wireless/ath/ath10k/htt.h:1677:2)' and is usually due to 'struct htt_tx_fetch_ind' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   drivers/net/wireless/ath/ath10k/htt.h:1815:2: warning: field  within 'struct htt_resp' is less aligned than 'union htt_resp::(anonymous at drivers/net/wireless/ath/ath10k/htt.h:1815:2)' and is usually due to 'struct htt_resp' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   4 warnings generated.
--
   In file included from drivers/net/wireless/ath/ath10k/ce.c:8:
   In file included from drivers/net/wireless/ath/ath10k/hif.h:11:
   In file included from drivers/net/wireless/ath/ath10k/core.h:18:
   drivers/net/wireless/ath/ath10k/htt.h:721:34: warning: field prefix within 'struct htt_rx_indication' is less aligned than 'struct htt_rx_indication_prefix' and is usually due to 'struct htt_rx_indication' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           struct htt_rx_indication_prefix prefix;
                                           ^
   drivers/net/wireless/ath/ath10k/htt.h:742:34: warning: field prefix within 'struct htt_rx_indication_hl' is less aligned than 'struct htt_rx_indication_prefix' and is usually due to 'struct htt_rx_indication_hl' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           struct htt_rx_indication_prefix prefix;
                                           ^
>> drivers/net/wireless/ath/ath10k/htt.h:1677:2: warning: field  within 'struct htt_tx_fetch_ind' is less aligned than 'union htt_tx_fetch_ind::(anonymous at drivers/net/wireless/ath/ath10k/htt.h:1677:2)' and is usually due to 'struct htt_tx_fetch_ind' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   drivers/net/wireless/ath/ath10k/htt.h:1815:2: warning: field  within 'struct htt_resp' is less aligned than 'union htt_resp::(anonymous at drivers/net/wireless/ath/ath10k/htt.h:1815:2)' and is usually due to 'struct htt_resp' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   drivers/net/wireless/ath/ath10k/ce.c:127:1: warning: unused function 'ath10k_get_ring_byte' [-Wunused-function]
   ath10k_get_ring_byte(unsigned int offset,
   ^
   drivers/net/wireless/ath/ath10k/ce.c:212:1: warning: unused function 'ath10k_ce_shadow_dest_ring_write_index_set' [-Wunused-function]
   ath10k_ce_shadow_dest_ring_write_index_set(struct ath10k *ar,
   ^
   drivers/net/wireless/ath/ath10k/ce.c:449:20: warning: unused function 'ath10k_ce_error_intr_enable' [-Wunused-function]
   static inline void ath10k_ce_error_intr_enable(struct ath10k *ar,
                      ^
   7 warnings generated.


vim +1677 drivers/net/wireless/ath/ath10k/htt.h

  1670	
  1671	struct htt_tx_fetch_ind {
  1672		u8 pad0;
  1673		__le16 fetch_seq_num;
  1674		__le32 token;
  1675		__le16 num_resp_ids;
  1676		__le16 num_records;
> 1677		union {
  1678			/* ath10k_htt_get_tx_fetch_ind_resp_ids() */
  1679			DECLARE_FLEX_ARRAY(__le32, resp_ids);
  1680			DECLARE_FLEX_ARRAY(struct htt_tx_fetch_record, records);
  1681		};
  1682	} __packed;
  1683	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
