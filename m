Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A522543B44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiFHSRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbiFHSOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:14:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3711A2BD3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654712086; x=1686248086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zoVhbVSww6vgXA0XEhlME76soUKAgYb99ZfQdPe51Ys=;
  b=Hs0DOlwNGZnQigsVEKcTeGmOu3VGhoe8/RtWYEtTiegiK2PQg0/fmud3
   qDJWzZVOtGFqztR8zPI6urOHhK4Jech+ie/0TIeOQm/mTF+r2rb/D8yPD
   ZlHfyyQePkCZBw8IcgvqCHI2tvtVa2KmAtLmv/TuL2sSm/e73cyCSp1b7
   mlkmfzFk0FnbIoWRe8KenEvjcgUvD4MAHoO+EN9ihE3LkT+KmVIWD4ZEb
   kSoUA0YWbFXb7Zy50AAcDqUTyy5a/oIDSdLp0CMZzd+K9ZzqKin/5CRtb
   E62K/3fUC3O3BXB5ps2s1lyM0AgAiFC6vRFudwHtJXMncXU47uxEMwfOV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="341092827"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="341092827"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 11:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="555520428"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2022 11:14:43 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz0CY-000Esz-NX;
        Wed, 08 Jun 2022 18:14:42 +0000
Date:   Thu, 9 Jun 2022 02:14:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/wireless/ath/ath10k/htt.h:1677:2: warning: field  within
 'struct htt_tx_fetch_ind' is less aligned than 'union
 htt_tx_fetch_ind::(anonymous at
 drivers/net/wireless/ath/ath10k/htt.h:1677:2)' and is usually due to 'struct
 htt_tx_fetch_ind' being...
Message-ID: <202206090102.3HEgdeVW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9886142c7a2226439c1e3f7d9b69f9c7094c3ef6
commit: fa7845cfd53f3b1d3f60efa55db89805595bc045 treewide: Replace open-coded flex arrays in unions
date:   8 months ago
config: arm-randconfig-c002-20220607 (https://download.01.org/0day-ci/archive/20220609/202206090102.3HEgdeVW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa7845cfd53f3b1d3f60efa55db89805595bc045
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fa7845cfd53f3b1d3f60efa55db89805595bc045
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/mtd/spi-nor/ drivers/net/wireless/ath/ath10k/ drivers/nfc/nfcmrvl/ fs/quota/

If you fix the issue, kindly add following tag where applicable
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
