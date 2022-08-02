Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1225879F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiHBJiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiHBJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:38:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055830F55
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659433095; x=1690969095;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ie4Jq9mgsEueKi7uEc4UpOi63+HLX+ENhEZmYkMZXn4=;
  b=QcEVDba3x6iF4AsGJvnJ9WmwddJ3q2FKzSx7847MUAhH+mbjeQVkZlcM
   1PAcxME/R9Utx8CHwM3Ua8MPGfdtQYCgAO3eFWiXjOF1NxlDBMGZ3ytjI
   NEHAmvk14HdUybCAapBiROxgwDK0Nx3F9KeFw6eyQWk3XrRxtkobj2Xqu
   ruOLcaX6g6rUo7VAjVvYqfP455h23fwaCgmpXP3NznnYUUwW8nN1VTzsL
   jyskRlwize6ACoHYAqGencKZpOuRoNlpsnZYdxbzG6U8/m5/hWCU1EzOI
   y/dXwg/kJM4O9l6eUAebO7yMyDMxiBMxAgFtvibqV3u2B9ZiG6yOnfhHy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="272413009"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="272413009"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 02:38:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="744606969"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2022 02:38:13 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIoLs-000Ful-1R;
        Tue, 02 Aug 2022 09:38:12 +0000
Date:   Tue, 2 Aug 2022 17:37:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Farzad Farshchi <farzadfr@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [esmil:visionfive 41/45] drivers/nvdla/engine.c:86:9: sparse:
 sparse: symbol 'bdma_grp_sts' was not declared. Should it be static?
Message-ID: <202208021719.D3UpRJ0t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   d02aa65a24f3cd0d7771349c8812b63482a2bce6
commit: d33164ce8bcd550cd4c8bd902aacfb5f1c971ba6 [41/45] nvdla: add NVDLA driver
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220802/202208021719.D3UpRJ0t-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/esmil/linux/commit/d33164ce8bcd550cd4c8bd902aacfb5f1c971ba6
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout d33164ce8bcd550cd4c8bd902aacfb5f1c971ba6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvdla/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/nvdla/engine.c:86:9: sparse: sparse: symbol 'bdma_grp_sts' was not declared. Should it be static?
>> drivers/nvdla/engine.c:91:21: sparse: sparse: symbol 'roi_desc' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
