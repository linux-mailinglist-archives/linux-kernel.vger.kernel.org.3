Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F485679D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiGEWCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiGEWCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:02:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529F519284
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657058519; x=1688594519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EZmfVqf6PraevQrVcvWr9a2R2JtMKZUjmFrK2SMJD58=;
  b=NjIaMkQDYqy6Z7w21g/V1FMUiQCFPXrgZPrr0iPENWFLoaCnp3f6YL4L
   AQWuLy2TlVwe3YHa2RxHr9XEbaU8jPBgwby0pxw8TYOlD3ZypNGb0WaF1
   +P5bkLdQnByqDWj4HTeDm3hclLVtOdY6pdTZYwo/iEL1kuCYOGoX7qtlv
   HTzBSZ0zx3Hk5+D1gZMusjdTuMcHtJU1MwIwK6iWeqXgc/NY079I+QV1b
   PoQQvSB1mUQZBOnuCB1Ofalylq3xgsIY5tu+oyn0MmeeePhL8ZQA2SeGN
   Y3riXqqCPGYwUun2CQfjalhhpZoFw7EBxBmxHUK85eVL/OJrAKMS0qE2Q
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266558872"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266558872"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 15:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="839280084"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2022 15:01:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8qcG-000JdI-W0;
        Tue, 05 Jul 2022 22:01:56 +0000
Date:   Wed, 6 Jul 2022 06:01:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     kbuild-all@lists.01.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [device-mapper-dm:dm-5.20 6/7] drivers/md/dm-io-rewind.c:95:39:
 error: 'struct bio' has no member named 'bi_crypt_context'
Message-ID: <202207060517.Wb6x2AW3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git dm-5.20
head:   e08bc02c4a6c7cdcbe85ce84db9307203de01926
commit: fa88c146eb6b5d9c2c0946e39a4b19ade94b47a0 [6/7] dm: move bio_rewind local to DM core
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220706/202207060517.Wb6x2AW3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?id=fa88c146eb6b5d9c2c0946e39a4b19ade94b47a0
        git remote add device-mapper-dm https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
        git fetch --no-tags device-mapper-dm dm-5.20
        git checkout fa88c146eb6b5d9c2c0946e39a4b19ade94b47a0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/md/dm-io-rewind.c: In function '__bio_crypt_rewind':
>> drivers/md/dm-io-rewind.c:95:39: error: 'struct bio' has no member named 'bi_crypt_context'
      95 |         struct bio_crypt_ctx *bc = bio->bi_crypt_context;
         |                                       ^~


vim +95 drivers/md/dm-io-rewind.c

    92	
    93	static void __bio_crypt_rewind(struct bio *bio, unsigned int bytes)
    94	{
  > 95		struct bio_crypt_ctx *bc = bio->bi_crypt_context;
    96	
    97		bio_crypt_dun_decrement(bc->bc_dun,
    98					bytes >> bc->bc_key->data_unit_size_bits);
    99	}
   100	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
