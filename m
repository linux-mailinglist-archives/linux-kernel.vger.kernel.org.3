Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C4D573585
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiGMLfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbiGMLfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:35:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445C110209C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657712098; x=1689248098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ssM2K5wY4oMd1Lhe12G6JmXXhxpujMRJ6fCVET3IGvc=;
  b=dyPcVqroSMdoQ/VLuZx4x2XVmyMBaFMcYg8HKoRwwfazX3NQ/XXiWL81
   TtsnxgUv+Y+e185JfvrU3KYN+H5VQwqPP3sz4TNwQ9vIxGL2kzVYaOGv3
   bv0lEK/2l9oIU+lEk5zoOoD7iAyTf3C9s5ZVGsOj2RSEWi+NZ61KHh8PT
   VUUfazv5wr/dbRDxH8VEMg82LDeftf8pKg3Avn+Qpa9LYO9MSGemZxjTI
   G5xdZ0m82lz8AMjYRTttKdefVXbPyBDR84pLiQWNyJs0vq7HXU6cLD2F1
   l8hZJ2jOYz5z9QtksygATbUcKBTL3YRkGpZf/mxTTIe0MlPMGt7FtevLf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="282738661"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="282738661"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 04:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="622906534"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2022 04:34:56 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBads-0003QR-0g;
        Wed, 13 Jul 2022 11:34:56 +0000
Date:   Wed, 13 Jul 2022 19:34:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     kbuild-all@lists.01.org, Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: [cilium:pr/meta5 4/4] dev.c:undefined reference to
 `__qdisc_calculate_pkt_len'
Message-ID: <202207131924.bavS51zw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/cilium/linux.git pr/meta5
head:   3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5
commit: 3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5 [4/4] bpf: Add fd-based API to attach tc BPF programs
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220713/202207131924.bavS51zw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/cilium/linux/commit/3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5
        git remote add cilium https://github.com/cilium/linux.git
        git fetch --no-tags cilium pr/meta5
        git checkout 3dd186e5096ad47e2a3e6a5d00dd9d67513a95e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/core/dev.o: in function `__dev_xmit_skb':
>> dev.c:(.text+0x7ce0): undefined reference to `__qdisc_calculate_pkt_len'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
