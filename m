Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2A74AB9EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382168AbiBGLSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356746AbiBGLN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:13:26 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5ADC043189;
        Mon,  7 Feb 2022 03:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644232402; x=1675768402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4xNbC5qCZstZuFmtgmc8pSYf6lHMJUKirKVnXS8RvWU=;
  b=JwkmjvGoKervAdYbQ4rVD9ClJV/m6qxY+NoPiwdykovrybGfA+bR+72q
   g6dz4yzXnUKaYrplkZRO10032XVz2jzaA4MvgsNvCryt96wzo+tcHGszq
   RVZu3FaUvMGp8BrXBBeI8GVNl6ll5nFDLOM1VfckZGdqEmMMuhT0nF85y
   +WYL9ciTrKMRYPAFlS3XkPBCGo0q44pxs2Mf3m70WjrSaojUMtKFzh6bm
   dRKSDiaArWUdhlA9/0MG7zy5i7xVHDBD/7vaOn8BqhJCh3VKGqPXz4WUl
   SRvQz/iNNX0XvyWaLq4UE59zXk154p8iLZeEsAgGtUhXHp1G6M/dfax8E
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273212853"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="273212853"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 03:13:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="621513506"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Feb 2022 03:13:19 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nH1xP-0000S0-9K; Mon, 07 Feb 2022 11:13:19 +0000
Date:   Mon, 7 Feb 2022 19:12:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     kbuild-all@lists.01.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
        quic_hbandi@quicinc.com
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add bluetooth node on
 SC7280 crd board
Message-ID: <202202071900.HBQ0tQbr-lkp@intel.com>
References: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644207878-19839-1-git-send-email-quic_saluvala@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v5.17-rc3]
[cannot apply to next-20220207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sai-Teja-Aluvala/arm64-dts-qcom-sc7280-Add-bluetooth-node-on-SC7280-crd-board/20220207-141304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-s031-20220207 (https://download.01.org/0day-ci/archive/20220207/202202071900.HBQ0tQbr-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/36d7dc511b4181b7243171a2949e2f097d799d40
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sai-Teja-Aluvala/arm64-dts-qcom-sc7280-Add-bluetooth-node-on-SC7280-crd-board/20220207-141304
        git checkout 36d7dc511b4181b7243171a2949e2f097d799d40
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/sc7280-crd.dts:26.1-11 Label or path bluetooth not found
   FATAL ERROR: Syntax error parsing input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
