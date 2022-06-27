Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223E755E079
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbiF0XBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiF0XBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:01:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0677C2126B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656370862; x=1687906862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LZ2Z6Mud2kHMPs5zp5nnFkCNGZcbtPNzvKWYSxz61aw=;
  b=XV1wRIXUzIRJKxdN4Q+jnAlsrCu6gifVYsqLzB70iYICqxShYws9YlIF
   sO7366CUVtAPvEtVss4CLT7TJip38E07reBTxLS5nlvzPC0a3jXH+x+ty
   RG/KtMrukpFY32AhsZnqVPf7fgD2h8DRV1LMePbk1otLFJID2KDJ/92vT
   C9oUdTHV56tkSMKnYpLDLCLYslm7onHajLcX3sYh16vibB8U60UbVgQ7q
   E53kRyj0RYDiT10wTG/P3+povC1M9r1RT6gddlKPpXVl3tzyNWDzNf266
   856762J1bZFzqxKMIMLcMWNADCte1OEOnYwQNHwkU1nt4mDycU1LhJ/v6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279126924"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="279126924"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 16:01:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646635990"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2022 16:00:59 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5xj0-0009Aw-JD;
        Mon, 27 Jun 2022 23:00:58 +0000
Date:   Tue, 28 Jun 2022 07:00:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:xdp_hints 5/52] net/bpf/prog_ops.c:693:6: error:
 redefinition of 'bpf_xdp_sock_is_valid_access'
Message-ID: <202206280654.HfCop1BC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux xdp_hints
head:   bb2e21053c861694b01175cc7057b0ab05db75a9
commit: 9d29d62a53069847d538390eab0b7c8fcefdd178 [5/52] net, xdp: decouple XDP code from the core networking code
config: xtensa-randconfig-r024-20220627 (https://download.01.org/0day-ci/archive/20220628/202206280654.HfCop1BC-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/alobakin/linux/commit/9d29d62a53069847d538390eab0b7c8fcefdd178
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin xdp_hints
        git checkout 9d29d62a53069847d538390eab0b7c8fcefdd178
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash net/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/bpf/prog_ops.c:693:6: error: redefinition of 'bpf_xdp_sock_is_valid_access'
     693 | bool bpf_xdp_sock_is_valid_access(int off, int size, enum bpf_access_type type,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/net/xdp_sock.h:9,
                    from net/bpf/prog_ops.c:5:
   include/linux/bpf.h:2459:20: note: previous definition of 'bpf_xdp_sock_is_valid_access' with type 'bool(int,  int,  enum bpf_access_type,  struct bpf_insn_access_aux *)' {aka '_Bool(int,  int,  enum bpf_access_type,  struct bpf_insn_access_aux *)'}
    2459 | static inline bool bpf_xdp_sock_is_valid_access(int off, int size,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/bpf/prog_ops.c:708:5: error: redefinition of 'bpf_xdp_sock_convert_ctx_access'
     708 | u32 bpf_xdp_sock_convert_ctx_access(enum bpf_access_type type,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/net/xdp_sock.h:9,
                    from net/bpf/prog_ops.c:5:
   include/linux/bpf.h:2466:19: note: previous definition of 'bpf_xdp_sock_convert_ctx_access' with type 'u32(enum bpf_access_type,  const struct bpf_insn *, struct bpf_insn *, struct bpf_prog *, u32 *)' {aka 'unsigned int(enum bpf_access_type,  const struct bpf_insn *, struct bpf_insn *, struct bpf_prog *, unsigned int *)'}
    2466 | static inline u32 bpf_xdp_sock_convert_ctx_access(enum bpf_access_type type,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_xdp_sock_is_valid_access +693 net/bpf/prog_ops.c

   692	
 > 693	bool bpf_xdp_sock_is_valid_access(int off, int size, enum bpf_access_type type,
   694					  struct bpf_insn_access_aux *info)
   695	{
   696		if (off < 0 || off >= offsetofend(struct bpf_xdp_sock, queue_id))
   697			return false;
   698	
   699		if (off % size != 0)
   700			return false;
   701	
   702		switch (off) {
   703		default:
   704			return size == sizeof(__u32);
   705		}
   706	}
   707	
 > 708	u32 bpf_xdp_sock_convert_ctx_access(enum bpf_access_type type,
   709					    const struct bpf_insn *si,
   710					    struct bpf_insn *insn_buf,
   711					    struct bpf_prog *prog, u32 *target_size)
   712	{
   713		struct bpf_insn *insn = insn_buf;
   714	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
