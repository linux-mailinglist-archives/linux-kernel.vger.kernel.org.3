Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A756C473
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbiGHTjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiGHTjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:39:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA63264;
        Fri,  8 Jul 2022 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657309154; x=1688845154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LpoDI14rXdWMtl4+x5dyiQKRVxSqj32tjZgTDJN6bu8=;
  b=PN4bpZJykrRj/+kj2wkTatzHsV8bA8ENTbOJZoV6ABCVdAYZsXe4fFpi
   3nxUds9T/ClYX+R31NFxU16D82LUc9g2hbWr9LTKwxtIOWCp10fjdwBuJ
   miN0lErIqxTF55Pg4MDBtGFrc47i1TpzxhVMxF0Dv1T/yNK6iTchQY4Vp
   c5PudI22vUN9JHHIB4WX47wtB2kCbcq75D/47BgW6BUc1uWbSZ9192Kvs
   sFSn7mRHSMF0cQJwq57vKbta6bxrHAfjARjAeQJDtmCWDJJ/cR1YXP5WZ
   Q9uI/5gYbvtGJ3RUjDg2F1xH7VFKfInM0e4mXGSJM5G+cgtKBkejBImFy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="264764071"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="264764071"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 12:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="661876727"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jul 2022 12:39:09 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9toe-000Nqg-0N;
        Fri, 08 Jul 2022 19:39:04 +0000
Date:   Sat, 9 Jul 2022 03:38:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tanmay Shah <tanmay.shah@amd.com>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        ben.levinsky@xilinx.com, tanmay.shah@xilinx.com,
        michal.simek@amd.com
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: Re: [PATCH v9 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Message-ID: <202207090358.SyMJbHIZ-lkp@intel.com>
References: <20220708013955.2340449-7-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708013955.2340449-7-tanmay.shah@amd.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on c6a669485125145afd22230df6e0e6c37f19ad41]

url:    https://github.com/intel-lab-lkp/linux/commits/Tanmay-Shah/Add-Xilinx-RPU-subsystem-support/20220708-094221
base:   c6a669485125145afd22230df6e0e6c37f19ad41
config: (https://download.01.org/0day-ci/archive/20220709/202207090358.SyMJbHIZ-lkp@intel.com/config)
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/77a934574239ba990778a8007045b8c43955d9f5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tanmay-Shah/Add-Xilinx-RPU-subsystem-support/20220708-094221
        git checkout 77a934574239ba990778a8007045b8c43955d9f5
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_ZYNQMP_IPI_MBOX --selectors CONFIG_XLNX_R5_REMOTEPROC -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for ZYNQMP_IPI_MBOX when selected by XLNX_R5_REMOTEPROC
   
   WARNING: unmet direct dependencies detected for ZYNQMP_IPI_MBOX
     Depends on [n]: MAILBOX [=n] && ARCH_ZYNQMP [=y] && OF [=y]
     Selected by [y]:
     - XLNX_R5_REMOTEPROC [=y] && REMOTEPROC [=y] && PM [=y] && ARCH_ZYNQMP [=y] && ZYNQMP_FIRMWARE [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
