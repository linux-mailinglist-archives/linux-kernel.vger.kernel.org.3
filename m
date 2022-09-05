Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF425AD856
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiIERWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiIERWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:22:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D180252FD0;
        Mon,  5 Sep 2022 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662398563; x=1693934563;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VHH0iXPIX4RQv5nKag2XfhZJ5wpVhFh6hH2lnW4mlUg=;
  b=ZCkP9EdtphARuBBK/XzrJSC3BQZz9cJ5Ib9u0477YdnRN7a+fFoZIbVe
   p+7C6P84fY0sEpeaHp/lRnaXDhVnAvR5BiZj1TzQva4CsqE8AAJYFzGYF
   TgUxbFSwLwHdcDKaocGGSP4xnHS3eccoHBvrpc+d38f6uaGiQXqdKk40x
   JbBv3AFivuO4TWo0/CDaS1aWybQ4joWCpThdzLZxtmKeWLxa8zVS6nRqP
   L1VjmKH7YKyNPA1vaWc4Zf0c1LSaFckvX7drBjWSc87CEPNZoxykqwv/c
   qTKVGw9zMEznlkUZzGDsW5lFGhCnNYsm6TxsyVihkpFWqbwC5H8x4p8cd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276823629"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="276823629"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 10:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="646965566"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2022 10:22:41 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVFo0-0004NV-1n;
        Mon, 05 Sep 2022 17:22:40 +0000
Date:   Tue, 6 Sep 2022 01:22:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: drivers/dma/ppc4xx/adma.c:1329: warning: expecting prototype for
 ppc440spe_adma_device_estimate(). Prototype was for
 ppc440spe_adma_estimate() instead
Message-ID: <202209060123.uhjAWgYf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e18e42e4b280c85b76967a9106a13ca61c16179
commit: 52042e2db45290f6a512d525518488b7bf143531 scripts: kernel-doc: validate kernel-doc markup with the actual names
date:   1 year, 8 months ago
config: powerpc-randconfig-r012-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060123.uhjAWgYf-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=52042e2db45290f6a512d525518488b7bf143531
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 52042e2db45290f6a512d525518488b7bf143531
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/dma/ppc4xx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/dma/ppc4xx/adma.c:233: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_init_interrupt'
   drivers/dma/ppc4xx/adma.c:233: warning: Function parameter or member 'chan' not described in 'ppc440spe_desc_init_interrupt'
   drivers/dma/ppc4xx/adma.c:261: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_init_null_xor'
   drivers/dma/ppc4xx/adma.c:273: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_init_xor'
   drivers/dma/ppc4xx/adma.c:273: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_desc_init_xor'
   drivers/dma/ppc4xx/adma.c:273: warning: Function parameter or member 'flags' not described in 'ppc440spe_desc_init_xor'
   drivers/dma/ppc4xx/adma.c:293: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_init_dma2pq'
   drivers/dma/ppc4xx/adma.c:293: warning: Function parameter or member 'dst_cnt' not described in 'ppc440spe_desc_init_dma2pq'
   drivers/dma/ppc4xx/adma.c:293: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_desc_init_dma2pq'
   drivers/dma/ppc4xx/adma.c:293: warning: Function parameter or member 'flags' not described in 'ppc440spe_desc_init_dma2pq'
   drivers/dma/ppc4xx/adma.c:320: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_init_dma01pq'
   drivers/dma/ppc4xx/adma.c:320: warning: Function parameter or member 'dst_cnt' not described in 'ppc440spe_desc_init_dma01pq'
   drivers/dma/ppc4xx/adma.c:320: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_desc_init_dma01pq'
   drivers/dma/ppc4xx/adma.c:320: warning: Function parameter or member 'flags' not described in 'ppc440spe_desc_init_dma01pq'
   drivers/dma/ppc4xx/adma.c:320: warning: Function parameter or member 'op' not described in 'ppc440spe_desc_init_dma01pq'
   drivers/dma/ppc4xx/adma.c:433: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_init_dma01pqzero_sum'
   drivers/dma/ppc4xx/adma.c:433: warning: Function parameter or member 'dst_cnt' not described in 'ppc440spe_desc_init_dma01pqzero_sum'
   drivers/dma/ppc4xx/adma.c:433: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_desc_init_dma01pqzero_sum'
   drivers/dma/ppc4xx/adma.c:503: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_init_memcpy'
   drivers/dma/ppc4xx/adma.c:503: warning: Function parameter or member 'flags' not described in 'ppc440spe_desc_init_memcpy'
   drivers/dma/ppc4xx/adma.c:526: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_set_src_addr'
   drivers/dma/ppc4xx/adma.c:526: warning: Function parameter or member 'chan' not described in 'ppc440spe_desc_set_src_addr'
   drivers/dma/ppc4xx/adma.c:526: warning: Function parameter or member 'src_idx' not described in 'ppc440spe_desc_set_src_addr'
   drivers/dma/ppc4xx/adma.c:526: warning: Function parameter or member 'addrh' not described in 'ppc440spe_desc_set_src_addr'
   drivers/dma/ppc4xx/adma.c:526: warning: Function parameter or member 'addrl' not described in 'ppc440spe_desc_set_src_addr'
   drivers/dma/ppc4xx/adma.c:560: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_set_src_mult'
   drivers/dma/ppc4xx/adma.c:560: warning: Function parameter or member 'chan' not described in 'ppc440spe_desc_set_src_mult'
   drivers/dma/ppc4xx/adma.c:560: warning: Function parameter or member 'mult_index' not described in 'ppc440spe_desc_set_src_mult'
   drivers/dma/ppc4xx/adma.c:560: warning: Function parameter or member 'sg_index' not described in 'ppc440spe_desc_set_src_mult'
   drivers/dma/ppc4xx/adma.c:560: warning: Function parameter or member 'mult_value' not described in 'ppc440spe_desc_set_src_mult'
   drivers/dma/ppc4xx/adma.c:605: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_set_dest_addr'
   drivers/dma/ppc4xx/adma.c:605: warning: Function parameter or member 'chan' not described in 'ppc440spe_desc_set_dest_addr'
   drivers/dma/ppc4xx/adma.c:605: warning: Function parameter or member 'addrh' not described in 'ppc440spe_desc_set_dest_addr'
   drivers/dma/ppc4xx/adma.c:605: warning: Function parameter or member 'addrl' not described in 'ppc440spe_desc_set_dest_addr'
   drivers/dma/ppc4xx/adma.c:605: warning: Function parameter or member 'dst_idx' not described in 'ppc440spe_desc_set_dest_addr'
   drivers/dma/ppc4xx/adma.c:645: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_set_byte_count'
   drivers/dma/ppc4xx/adma.c:645: warning: Function parameter or member 'chan' not described in 'ppc440spe_desc_set_byte_count'
   drivers/dma/ppc4xx/adma.c:645: warning: Function parameter or member 'byte_count' not described in 'ppc440spe_desc_set_byte_count'
   drivers/dma/ppc4xx/adma.c:666: warning: Function parameter or member 'byte_count' not described in 'ppc440spe_desc_set_rxor_block_size'
   drivers/dma/ppc4xx/adma.c:679: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_set_dcheck'
   drivers/dma/ppc4xx/adma.c:679: warning: Function parameter or member 'chan' not described in 'ppc440spe_desc_set_dcheck'
   drivers/dma/ppc4xx/adma.c:679: warning: Function parameter or member 'qword' not described in 'ppc440spe_desc_set_dcheck'
   drivers/dma/ppc4xx/adma.c:701: warning: Function parameter or member 'prev_desc' not described in 'ppc440spe_xor_set_link'
   drivers/dma/ppc4xx/adma.c:701: warning: Function parameter or member 'next_desc' not described in 'ppc440spe_xor_set_link'
   drivers/dma/ppc4xx/adma.c:724: warning: Function parameter or member 'chan' not described in 'ppc440spe_desc_set_link'
   drivers/dma/ppc4xx/adma.c:724: warning: Function parameter or member 'prev_desc' not described in 'ppc440spe_desc_set_link'
   drivers/dma/ppc4xx/adma.c:724: warning: Function parameter or member 'next_desc' not described in 'ppc440spe_desc_set_link'
   drivers/dma/ppc4xx/adma.c:771: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_get_link'
   drivers/dma/ppc4xx/adma.c:771: warning: Function parameter or member 'chan' not described in 'ppc440spe_desc_get_link'
   drivers/dma/ppc4xx/adma.c:783: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_is_aligned'
   drivers/dma/ppc4xx/adma.c:783: warning: Function parameter or member 'num_slots' not described in 'ppc440spe_desc_is_aligned'
   drivers/dma/ppc4xx/adma.c:793: warning: Function parameter or member 'len' not described in 'ppc440spe_chan_xor_slot_count'
   drivers/dma/ppc4xx/adma.c:793: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_chan_xor_slot_count'
   drivers/dma/ppc4xx/adma.c:793: warning: Function parameter or member 'slots_per_op' not described in 'ppc440spe_chan_xor_slot_count'
   drivers/dma/ppc4xx/adma.c:814: warning: Function parameter or member 'srcs' not described in 'ppc440spe_dma2_pq_slot_count'
   drivers/dma/ppc4xx/adma.c:814: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_dma2_pq_slot_count'
   drivers/dma/ppc4xx/adma.c:814: warning: Function parameter or member 'len' not described in 'ppc440spe_dma2_pq_slot_count'
   drivers/dma/ppc4xx/adma.c:898: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_device_clear_eot_status'
   drivers/dma/ppc4xx/adma.c:1017: warning: Function parameter or member 'chan' not described in 'ppc440spe_chan_is_busy'
   drivers/dma/ppc4xx/adma.c:1050: warning: Function parameter or member 'chan' not described in 'ppc440spe_chan_set_first_xor_descriptor'
   drivers/dma/ppc4xx/adma.c:1050: warning: Function parameter or member 'next_desc' not described in 'ppc440spe_chan_set_first_xor_descriptor'
   drivers/dma/ppc4xx/adma.c:1076: warning: Function parameter or member 'chan' not described in 'ppc440spe_dma_put_desc'
   drivers/dma/ppc4xx/adma.c:1076: warning: Function parameter or member 'desc' not described in 'ppc440spe_dma_put_desc'
   drivers/dma/ppc4xx/adma.c:1095: warning: Function parameter or member 'chan' not described in 'ppc440spe_chan_append'
   drivers/dma/ppc4xx/adma.c:1174: warning: Function parameter or member 'chan' not described in 'ppc440spe_chan_get_current_descriptor'
   drivers/dma/ppc4xx/adma.c:1198: warning: Function parameter or member 'chan' not described in 'ppc440spe_chan_run'
   drivers/dma/ppc4xx/adma.c:1252: warning: Function parameter or member 'srcs' not described in 'ppc440spe_can_rxor'
   drivers/dma/ppc4xx/adma.c:1252: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_can_rxor'
   drivers/dma/ppc4xx/adma.c:1252: warning: Function parameter or member 'len' not described in 'ppc440spe_can_rxor'
>> drivers/dma/ppc4xx/adma.c:1329: warning: expecting prototype for ppc440spe_adma_device_estimate(). Prototype was for ppc440spe_adma_estimate() instead
   drivers/dma/ppc4xx/adma.c:1422: warning: Function parameter or member 'entry_idx' not described in 'ppc440spe_get_group_entry'
   drivers/dma/ppc4xx/adma.c:1446: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_free_slots'
   drivers/dma/ppc4xx/adma.c:1465: warning: Function parameter or member 'desc' not described in 'ppc440spe_adma_run_tx_complete_actions'
   drivers/dma/ppc4xx/adma.c:1465: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_run_tx_complete_actions'
   drivers/dma/ppc4xx/adma.c:1465: warning: Function parameter or member 'cookie' not described in 'ppc440spe_adma_run_tx_complete_actions'
   drivers/dma/ppc4xx/adma.c:1489: warning: Function parameter or member 'desc' not described in 'ppc440spe_adma_clean_slot'
   drivers/dma/ppc4xx/adma.c:1489: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_clean_slot'
   drivers/dma/ppc4xx/adma.c:1534: warning: Function parameter or member 'chan' not described in '__ppc440spe_adma_slot_cleanup'
   drivers/dma/ppc4xx/adma.c:1662: warning: Function parameter or member 't' not described in 'ppc440spe_adma_tasklet'
   drivers/dma/ppc4xx/adma.c:1674: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_slot_cleanup'
   drivers/dma/ppc4xx/adma.c:1686: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_alloc_slots'
   drivers/dma/ppc4xx/adma.c:1686: warning: Function parameter or member 'num_slots' not described in 'ppc440spe_adma_alloc_slots'
   drivers/dma/ppc4xx/adma.c:1686: warning: Function parameter or member 'slots_per_op' not described in 'ppc440spe_adma_alloc_slots'
   drivers/dma/ppc4xx/adma.c:1765: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_alloc_chan_resources'
   drivers/dma/ppc4xx/adma.c:1846: warning: Function parameter or member 'desc' not described in 'ppc440spe_rxor_set_region'
   drivers/dma/ppc4xx/adma.c:1846: warning: Function parameter or member 'xor_arg_no' not described in 'ppc440spe_rxor_set_region'
   drivers/dma/ppc4xx/adma.c:1846: warning: Function parameter or member 'mask' not described in 'ppc440spe_rxor_set_region'
>> drivers/dma/ppc4xx/adma.c:1846: warning: expecting prototype for ppc440spe_rxor_set_region_data(). Prototype was for ppc440spe_rxor_set_region() instead
   drivers/dma/ppc4xx/adma.c:1857: warning: Function parameter or member 'desc' not described in 'ppc440spe_rxor_set_src'
   drivers/dma/ppc4xx/adma.c:1857: warning: Function parameter or member 'xor_arg_no' not described in 'ppc440spe_rxor_set_src'
   drivers/dma/ppc4xx/adma.c:1857: warning: Function parameter or member 'addr' not described in 'ppc440spe_rxor_set_src'
   drivers/dma/ppc4xx/adma.c:1869: warning: Function parameter or member 'desc' not described in 'ppc440spe_rxor_set_mult'
   drivers/dma/ppc4xx/adma.c:1869: warning: Function parameter or member 'xor_arg_no' not described in 'ppc440spe_rxor_set_mult'
   drivers/dma/ppc4xx/adma.c:1869: warning: Function parameter or member 'idx' not described in 'ppc440spe_rxor_set_mult'
   drivers/dma/ppc4xx/adma.c:1869: warning: Function parameter or member 'mult' not described in 'ppc440spe_rxor_set_mult'
   drivers/dma/ppc4xx/adma.c:1880: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_check_threshold'
   drivers/dma/ppc4xx/adma.c:1896: warning: Function parameter or member 'tx' not described in 'ppc440spe_adma_tx_submit'
   drivers/dma/ppc4xx/adma.c:1946: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_prep_dma_interrupt'
   drivers/dma/ppc4xx/adma.c:1946: warning: Function parameter or member 'flags' not described in 'ppc440spe_adma_prep_dma_interrupt'
   drivers/dma/ppc4xx/adma.c:1978: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_prep_dma_memcpy'
   drivers/dma/ppc4xx/adma.c:1978: warning: Function parameter or member 'dma_dest' not described in 'ppc440spe_adma_prep_dma_memcpy'
   drivers/dma/ppc4xx/adma.c:1978: warning: Function parameter or member 'dma_src' not described in 'ppc440spe_adma_prep_dma_memcpy'
   drivers/dma/ppc4xx/adma.c:1978: warning: Function parameter or member 'len' not described in 'ppc440spe_adma_prep_dma_memcpy'
   drivers/dma/ppc4xx/adma.c:1978: warning: Function parameter or member 'flags' not described in 'ppc440spe_adma_prep_dma_memcpy'
   drivers/dma/ppc4xx/adma.c:2020: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_prep_dma_xor'
   drivers/dma/ppc4xx/adma.c:2020: warning: Function parameter or member 'dma_dest' not described in 'ppc440spe_adma_prep_dma_xor'
   drivers/dma/ppc4xx/adma.c:2020: warning: Function parameter or member 'dma_src' not described in 'ppc440spe_adma_prep_dma_xor'
   drivers/dma/ppc4xx/adma.c:2020: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_adma_prep_dma_xor'
   drivers/dma/ppc4xx/adma.c:2020: warning: Function parameter or member 'len' not described in 'ppc440spe_adma_prep_dma_xor'
   drivers/dma/ppc4xx/adma.c:2020: warning: Function parameter or member 'flags' not described in 'ppc440spe_adma_prep_dma_xor'
   drivers/dma/ppc4xx/adma.c:2069: warning: Function parameter or member 'desc' not described in 'ppc440spe_adma_init_dma2rxor_slot'
   drivers/dma/ppc4xx/adma.c:2069: warning: Function parameter or member 'src' not described in 'ppc440spe_adma_init_dma2rxor_slot'
   drivers/dma/ppc4xx/adma.c:2069: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_adma_init_dma2rxor_slot'
   drivers/dma/ppc4xx/adma.c:2087: warning: Function parameter or member 'ppc440spe_chan' not described in 'ppc440spe_dma01_prep_mult'
   drivers/dma/ppc4xx/adma.c:2087: warning: Function parameter or member 'dst' not described in 'ppc440spe_dma01_prep_mult'
   drivers/dma/ppc4xx/adma.c:2087: warning: Function parameter or member 'dst_cnt' not described in 'ppc440spe_dma01_prep_mult'
   drivers/dma/ppc4xx/adma.c:2087: warning: Function parameter or member 'src' not described in 'ppc440spe_dma01_prep_mult'
   drivers/dma/ppc4xx/adma.c:2087: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_dma01_prep_mult'
   drivers/dma/ppc4xx/adma.c:2087: warning: Function parameter or member 'scf' not described in 'ppc440spe_dma01_prep_mult'
   drivers/dma/ppc4xx/adma.c:2087: warning: Function parameter or member 'len' not described in 'ppc440spe_dma01_prep_mult'
   drivers/dma/ppc4xx/adma.c:2087: warning: Function parameter or member 'flags' not described in 'ppc440spe_dma01_prep_mult'
   drivers/dma/ppc4xx/adma.c:2173: warning: Function parameter or member 'ppc440spe_chan' not described in 'ppc440spe_dma01_prep_sum_product'
   drivers/dma/ppc4xx/adma.c:2173: warning: Function parameter or member 'dst' not described in 'ppc440spe_dma01_prep_sum_product'
   drivers/dma/ppc4xx/adma.c:2173: warning: Function parameter or member 'src' not described in 'ppc440spe_dma01_prep_sum_product'
   drivers/dma/ppc4xx/adma.c:2173: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_dma01_prep_sum_product'
   drivers/dma/ppc4xx/adma.c:2173: warning: Function parameter or member 'scf' not described in 'ppc440spe_dma01_prep_sum_product'
   drivers/dma/ppc4xx/adma.c:2173: warning: Function parameter or member 'len' not described in 'ppc440spe_dma01_prep_sum_product'
   drivers/dma/ppc4xx/adma.c:2173: warning: Function parameter or member 'flags' not described in 'ppc440spe_dma01_prep_sum_product'
   drivers/dma/ppc4xx/adma.c:2511: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_prep_dma_pq'
   drivers/dma/ppc4xx/adma.c:2511: warning: Function parameter or member 'dst' not described in 'ppc440spe_adma_prep_dma_pq'
   drivers/dma/ppc4xx/adma.c:2511: warning: Function parameter or member 'src' not described in 'ppc440spe_adma_prep_dma_pq'
   drivers/dma/ppc4xx/adma.c:2511: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_adma_prep_dma_pq'
   drivers/dma/ppc4xx/adma.c:2511: warning: Function parameter or member 'scf' not described in 'ppc440spe_adma_prep_dma_pq'
   drivers/dma/ppc4xx/adma.c:2511: warning: Function parameter or member 'len' not described in 'ppc440spe_adma_prep_dma_pq'
   drivers/dma/ppc4xx/adma.c:2511: warning: Function parameter or member 'flags' not described in 'ppc440spe_adma_prep_dma_pq'
   drivers/dma/ppc4xx/adma.c:2587: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_prep_dma_pqzero_sum'
   drivers/dma/ppc4xx/adma.c:2587: warning: Function parameter or member 'pq' not described in 'ppc440spe_adma_prep_dma_pqzero_sum'
   drivers/dma/ppc4xx/adma.c:2587: warning: Function parameter or member 'src' not described in 'ppc440spe_adma_prep_dma_pqzero_sum'
   drivers/dma/ppc4xx/adma.c:2587: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_adma_prep_dma_pqzero_sum'
   drivers/dma/ppc4xx/adma.c:2587: warning: Function parameter or member 'scf' not described in 'ppc440spe_adma_prep_dma_pqzero_sum'
   drivers/dma/ppc4xx/adma.c:2587: warning: Function parameter or member 'len' not described in 'ppc440spe_adma_prep_dma_pqzero_sum'
   drivers/dma/ppc4xx/adma.c:2587: warning: Function parameter or member 'pqres' not described in 'ppc440spe_adma_prep_dma_pqzero_sum'
   drivers/dma/ppc4xx/adma.c:2587: warning: Function parameter or member 'flags' not described in 'ppc440spe_adma_prep_dma_pqzero_sum'
   drivers/dma/ppc4xx/adma.c:2765: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_prep_dma_xor_zero_sum'
   drivers/dma/ppc4xx/adma.c:2765: warning: Function parameter or member 'src' not described in 'ppc440spe_adma_prep_dma_xor_zero_sum'
   drivers/dma/ppc4xx/adma.c:2765: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_adma_prep_dma_xor_zero_sum'
   drivers/dma/ppc4xx/adma.c:2765: warning: Function parameter or member 'len' not described in 'ppc440spe_adma_prep_dma_xor_zero_sum'
   drivers/dma/ppc4xx/adma.c:2765: warning: Function parameter or member 'result' not described in 'ppc440spe_adma_prep_dma_xor_zero_sum'
   drivers/dma/ppc4xx/adma.c:2765: warning: Function parameter or member 'flags' not described in 'ppc440spe_adma_prep_dma_xor_zero_sum'
   drivers/dma/ppc4xx/adma.c:2785: warning: Function parameter or member 'sw_desc' not described in 'ppc440spe_adma_set_dest'
   drivers/dma/ppc4xx/adma.c:2785: warning: Function parameter or member 'addr' not described in 'ppc440spe_adma_set_dest'
   drivers/dma/ppc4xx/adma.c:2785: warning: Function parameter or member 'index' not described in 'ppc440spe_adma_set_dest'
   drivers/dma/ppc4xx/adma.c:2832: warning: Function parameter or member 'sw_desc' not described in 'ppc440spe_adma_pq_set_dest'
   drivers/dma/ppc4xx/adma.c:2832: warning: Function parameter or member 'addrs' not described in 'ppc440spe_adma_pq_set_dest'
   drivers/dma/ppc4xx/adma.c:2832: warning: Function parameter or member 'flags' not described in 'ppc440spe_adma_pq_set_dest'
   drivers/dma/ppc4xx/adma.c:3022: warning: Function parameter or member 'sw_desc' not described in 'ppc440spe_adma_pqzero_sum_set_dest'
   drivers/dma/ppc4xx/adma.c:3022: warning: Function parameter or member 'paddr' not described in 'ppc440spe_adma_pqzero_sum_set_dest'
   drivers/dma/ppc4xx/adma.c:3022: warning: Function parameter or member 'qaddr' not described in 'ppc440spe_adma_pqzero_sum_set_dest'
>> drivers/dma/ppc4xx/adma.c:3022: warning: expecting prototype for ppc440spe_adma_pq_zero_sum_set_dest(). Prototype was for ppc440spe_adma_pqzero_sum_set_dest() instead
   drivers/dma/ppc4xx/adma.c:3086: warning: Function parameter or member 'desc' not described in 'ppc440spe_desc_set_xor_src_cnt'
   drivers/dma/ppc4xx/adma.c:3086: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_desc_set_xor_src_cnt'
   drivers/dma/ppc4xx/adma.c:3098: warning: Function parameter or member 'sw_desc' not described in 'ppc440spe_adma_pq_set_src'
   drivers/dma/ppc4xx/adma.c:3098: warning: Function parameter or member 'addr' not described in 'ppc440spe_adma_pq_set_src'
   drivers/dma/ppc4xx/adma.c:3098: warning: Function parameter or member 'index' not described in 'ppc440spe_adma_pq_set_src'
   drivers/dma/ppc4xx/adma.c:3208: warning: Function parameter or member 'sw_desc' not described in 'ppc440spe_adma_memcpy_xor_set_src'
   drivers/dma/ppc4xx/adma.c:3208: warning: Function parameter or member 'addr' not described in 'ppc440spe_adma_memcpy_xor_set_src'
   drivers/dma/ppc4xx/adma.c:3208: warning: Function parameter or member 'index' not described in 'ppc440spe_adma_memcpy_xor_set_src'
   drivers/dma/ppc4xx/adma.c:3224: warning: Function parameter or member 'desc' not described in 'ppc440spe_adma_dma2rxor_inc_addr'
   drivers/dma/ppc4xx/adma.c:3224: warning: Function parameter or member 'cursor' not described in 'ppc440spe_adma_dma2rxor_inc_addr'
   drivers/dma/ppc4xx/adma.c:3224: warning: Function parameter or member 'index' not described in 'ppc440spe_adma_dma2rxor_inc_addr'
   drivers/dma/ppc4xx/adma.c:3224: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_adma_dma2rxor_inc_addr'
   drivers/dma/ppc4xx/adma.c:3242: warning: Function parameter or member 'hdesc' not described in 'ppc440spe_adma_dma2rxor_prep_src'
   drivers/dma/ppc4xx/adma.c:3242: warning: Function parameter or member 'cursor' not described in 'ppc440spe_adma_dma2rxor_prep_src'
   drivers/dma/ppc4xx/adma.c:3242: warning: Function parameter or member 'index' not described in 'ppc440spe_adma_dma2rxor_prep_src'
   drivers/dma/ppc4xx/adma.c:3242: warning: Function parameter or member 'src_cnt' not described in 'ppc440spe_adma_dma2rxor_prep_src'
   drivers/dma/ppc4xx/adma.c:3242: warning: Function parameter or member 'addr' not described in 'ppc440spe_adma_dma2rxor_prep_src'
   drivers/dma/ppc4xx/adma.c:3361: warning: Function parameter or member 'desc' not described in 'ppc440spe_adma_dma2rxor_set_src'
   drivers/dma/ppc4xx/adma.c:3361: warning: Function parameter or member 'index' not described in 'ppc440spe_adma_dma2rxor_set_src'
   drivers/dma/ppc4xx/adma.c:3361: warning: Function parameter or member 'addr' not described in 'ppc440spe_adma_dma2rxor_set_src'
   drivers/dma/ppc4xx/adma.c:3402: warning: Function parameter or member 'desc' not described in 'ppc440spe_adma_dma2rxor_set_mult'
   drivers/dma/ppc4xx/adma.c:3402: warning: Function parameter or member 'index' not described in 'ppc440spe_adma_dma2rxor_set_mult'
   drivers/dma/ppc4xx/adma.c:3402: warning: Function parameter or member 'mult' not described in 'ppc440spe_adma_dma2rxor_set_mult'
   drivers/dma/ppc4xx/adma.c:3438: warning: Function parameter or member 'cursor' not described in 'ppc440spe_init_rxor_cursor'
   drivers/dma/ppc4xx/adma.c:3450: warning: Function parameter or member 'sw_desc' not described in 'ppc440spe_adma_pq_set_src_mult'
   drivers/dma/ppc4xx/adma.c:3450: warning: Function parameter or member 'mult' not described in 'ppc440spe_adma_pq_set_src_mult'
   drivers/dma/ppc4xx/adma.c:3450: warning: Function parameter or member 'index' not described in 'ppc440spe_adma_pq_set_src_mult'
   drivers/dma/ppc4xx/adma.c:3450: warning: Function parameter or member 'dst_pos' not described in 'ppc440spe_adma_pq_set_src_mult'
   drivers/dma/ppc4xx/adma.c:3534: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_free_chan_resources'
   drivers/dma/ppc4xx/adma.c:3594: warning: Function parameter or member 'irq' not described in 'ppc440spe_adma_eot_handler'
   drivers/dma/ppc4xx/adma.c:3594: warning: Function parameter or member 'data' not described in 'ppc440spe_adma_eot_handler'
   drivers/dma/ppc4xx/adma.c:3611: warning: Function parameter or member 'irq' not described in 'ppc440spe_adma_err_handler'
   drivers/dma/ppc4xx/adma.c:3611: warning: Function parameter or member 'data' not described in 'ppc440spe_adma_err_handler'
   drivers/dma/ppc4xx/adma.c:3627: warning: Function parameter or member 'unused' not described in 'ppc440spe_test_callback'
   drivers/dma/ppc4xx/adma.c:3635: warning: Function parameter or member 'chan' not described in 'ppc440spe_adma_issue_pending'
   drivers/dma/ppc4xx/adma.c:3655: warning: Function parameter or member 'chan' not described in 'ppc440spe_chan_start_null_xor'
   drivers/dma/ppc4xx/adma.c:3701: warning: Function parameter or member 'chan' not described in 'ppc440spe_test_raid6'
   drivers/dma/ppc4xx/adma.c:4006: warning: Function parameter or member 'ofdev' not described in 'ppc440spe_adma_probe'
   drivers/dma/ppc4xx/adma.c:4235: warning: Function parameter or member 'ofdev' not described in 'ppc440spe_adma_remove'


vim +1329 drivers/dma/ppc4xx/adma.c

12458ea06efd7b Anatolij Gustschin 2009-12-11  1313  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1314  /**
12458ea06efd7b Anatolij Gustschin 2009-12-11  1315   * ppc440spe_adma_device_estimate - estimate the efficiency of processing
12458ea06efd7b Anatolij Gustschin 2009-12-11  1316   *	the operation given on this channel. It's assumed that 'chan' is
12458ea06efd7b Anatolij Gustschin 2009-12-11  1317   *	capable to process 'cap' type of operation.
12458ea06efd7b Anatolij Gustschin 2009-12-11  1318   * @chan: channel to use
12458ea06efd7b Anatolij Gustschin 2009-12-11  1319   * @cap: type of transaction
12458ea06efd7b Anatolij Gustschin 2009-12-11  1320   * @dst_lst: array of destination pointers
12458ea06efd7b Anatolij Gustschin 2009-12-11  1321   * @dst_cnt: number of destination operands
12458ea06efd7b Anatolij Gustschin 2009-12-11  1322   * @src_lst: array of source pointers
12458ea06efd7b Anatolij Gustschin 2009-12-11  1323   * @src_cnt: number of source operands
12458ea06efd7b Anatolij Gustschin 2009-12-11  1324   * @src_sz: size of each source operand
12458ea06efd7b Anatolij Gustschin 2009-12-11  1325   */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1326  static int ppc440spe_adma_estimate(struct dma_chan *chan,
12458ea06efd7b Anatolij Gustschin 2009-12-11  1327  	enum dma_transaction_type cap, struct page **dst_lst, int dst_cnt,
12458ea06efd7b Anatolij Gustschin 2009-12-11  1328  	struct page **src_lst, int src_cnt, size_t src_sz)
12458ea06efd7b Anatolij Gustschin 2009-12-11 @1329  {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1330  	int ef = 1;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1331  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1332  	if (cap == DMA_PQ || cap == DMA_PQ_VAL) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1333  		/* If RAID-6 capabilities were not activated don't try
12458ea06efd7b Anatolij Gustschin 2009-12-11  1334  		 * to use them
12458ea06efd7b Anatolij Gustschin 2009-12-11  1335  		 */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1336  		if (unlikely(!ppc440spe_r6_enabled))
12458ea06efd7b Anatolij Gustschin 2009-12-11  1337  			return -1;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1338  	}
12458ea06efd7b Anatolij Gustschin 2009-12-11  1339  	/*  In the current implementation of ppc440spe ADMA driver it
12458ea06efd7b Anatolij Gustschin 2009-12-11  1340  	 * makes sense to pick out only pq case, because it may be
12458ea06efd7b Anatolij Gustschin 2009-12-11  1341  	 * processed:
12458ea06efd7b Anatolij Gustschin 2009-12-11  1342  	 * (1) either using Biskup method on DMA2;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1343  	 * (2) or on DMA0/1.
12458ea06efd7b Anatolij Gustschin 2009-12-11  1344  	 *  Thus we give a favour to (1) if the sources are suitable;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1345  	 * else let it be processed on one of the DMA0/1 engines.
12458ea06efd7b Anatolij Gustschin 2009-12-11  1346  	 *  In the sum_product case where destination is also the
12458ea06efd7b Anatolij Gustschin 2009-12-11  1347  	 * source process it on DMA0/1 only.
12458ea06efd7b Anatolij Gustschin 2009-12-11  1348  	 */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1349  	if (cap == DMA_PQ && chan->chan_id == PPC440SPE_XOR_ID) {
12458ea06efd7b Anatolij Gustschin 2009-12-11  1350  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1351  		if (dst_cnt == 1 && src_cnt == 2 && dst_lst[0] == src_lst[1])
12458ea06efd7b Anatolij Gustschin 2009-12-11  1352  			ef = 0; /* sum_product case, process on DMA0/1 */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1353  		else if (ppc440spe_can_rxor(src_lst, src_cnt, src_sz))
12458ea06efd7b Anatolij Gustschin 2009-12-11  1354  			ef = 3; /* override (DMA0/1 + idle) */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1355  		else
12458ea06efd7b Anatolij Gustschin 2009-12-11  1356  			ef = 0; /* can't process on DMA2 if !rxor */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1357  	}
12458ea06efd7b Anatolij Gustschin 2009-12-11  1358  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1359  	/* channel idleness increases the priority */
12458ea06efd7b Anatolij Gustschin 2009-12-11  1360  	if (likely(ef) &&
12458ea06efd7b Anatolij Gustschin 2009-12-11  1361  	    !ppc440spe_chan_is_busy(to_ppc440spe_adma_chan(chan)))
12458ea06efd7b Anatolij Gustschin 2009-12-11  1362  		ef++;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1363  
12458ea06efd7b Anatolij Gustschin 2009-12-11  1364  	return ef;
12458ea06efd7b Anatolij Gustschin 2009-12-11  1365  }
12458ea06efd7b Anatolij Gustschin 2009-12-11  1366  

:::::: The code at line 1329 was first introduced by commit
:::::: 12458ea06efd7b44281e68fe59c950ec7d59c649 ppc440spe-adma: adds updated ppc440spe adma driver

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
