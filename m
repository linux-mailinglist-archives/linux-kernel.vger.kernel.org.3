Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D4857FCAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiGYJtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGYJtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:49:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4943E167E0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658742553; x=1690278553;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yc2IwfO234HVEdSYGqjS9OHWZNlHN8ag2FS4W7zgU3A=;
  b=GssvQOaW/uUAaYHF9HlTteNJ/D/fmyoNNI8eFI50WoRmCV83pnUp4FJR
   uTckPvJfwx7+U2LxRxJf4kqZ7bwLRfDhbbyzP8kP04fv2FXu2lIZanyk4
   iuLbHLRE9mdIamHN3PkcnE0SV/8cI+/HKGXyC8h+H9hQykIqoXkirVQl6
   4oSwB1DXiK6jq5F6DtOqW06Cos7ld4dV1NFcf1FLIUX93ouKDupbxPpaz
   uoA/iakVz7L3o8c6Ih5ssjgJj64CyCpNcxkYrVBHx8bYwGDyl9aKkNVkb
   yqCdl57Nztd9qpXy90Nvr/yvFeAvxf84g+AnaQ7GYxwkPlxr/tXaLyFGr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288843771"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="288843771"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 02:49:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="627385857"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2022 02:49:11 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFui7-0004vh-0J;
        Mon, 25 Jul 2022 09:49:11 +0000
Date:   Mon, 25 Jul 2022 17:48:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:sc8280xp-next-20220714 10/11] qcom_tee.c:undefined reference
 to `qcom_scm_call'
Message-ID: <202207251717.Z6tTRx8w-lkp@intel.com>
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

tree:   https://github.com/steev/linux sc8280xp-next-20220714
head:   c31ad66577ce26a1414d843c526244ddb75283bf
commit: 83d2fed55d3f7504dc2af5dbc73768d3aaff2618 [10/11] wip! firmware: Add support for Qualcomm UEFI Secure Application
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220725/202207251717.Z6tTRx8w-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/steev/linux/commit/83d2fed55d3f7504dc2af5dbc73768d3aaff2618
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev sc8280xp-next-20220714
        git checkout 83d2fed55d3f7504dc2af5dbc73768d3aaff2618
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/firmware/qcom_tee.o: in function `qctee_os_scm_call':
>> qcom_tee.c:(.text+0x34): undefined reference to `qcom_scm_call'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for QCOM_TEE
   Depends on QCOM_SCM
   Selected by
   - QCOM_TEE_UEFISECAPP && EFI

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
