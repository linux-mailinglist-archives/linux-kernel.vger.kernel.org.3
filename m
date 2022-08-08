Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D9558C8E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbiHHNAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbiHHNAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:00:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AC911C1D;
        Mon,  8 Aug 2022 05:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659963569; x=1691499569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SM3M98v9UuODC8UzTTQHTkKNyrbmYERVbOpPcEz1zWg=;
  b=PR6gRuDHFGq/VG7m4OWtVi9aiehPa3fD+2y5S+ZaZSBd2DIFz5e6oTYG
   MLO1D5cMRBlo+c7z4fFZI9gChtcUuZOKBkv7PLuoTfjlDTAHCLqeymPm1
   yR3fQkxBkET5BFB1yZ6hBFa4zcXnAH+9jJSCIkkHm8kotC+CdSErXlbD9
   6qelw7cnqzcaMkpfRK3UT9e2UZ2wVKVRxOBW83WoYUD6hmlackoSQqbTS
   DOw/RPabib/D0yLWbhVs/FVbFqESBYCD5KC0rfps/59mUfEuQ6sxEMZZ8
   S0aWoY6X2ygr0cfQq2JA6Ug8jAO+GLV/gdU93nFn2N+/MVq7gwosJqUtP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="270358281"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="270358281"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 05:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="554911922"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2022 05:59:24 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oL2Lr-000MHx-2l;
        Mon, 08 Aug 2022 12:59:23 +0000
Date:   Mon, 8 Aug 2022 20:58:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>
Subject: Re: [PATCH v4 2/4] docs/perf: Add documentation for the Amlogic G12
 DDR PMU
Message-ID: <202208082004.zjwtaGvN-lkp@intel.com>
References: <20220805071426.2598818-2-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805071426.2598818-2-jiucheng.xu@amlogic.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiucheng,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm/for-next arm64/for-next/core clk/clk-next kvmarm/next rockchip/for-next shawnguo/for-next soc/for-next linus/master v5.19 next-20220808]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiucheng-Xu/perf-amlogic-Add-support-for-Amlogic-meson-G12-SoC-DDR-PMU-driver/20220805-151704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/perf/meson-ddr-pmu.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.

vim +2 Documentation/admin-guide/perf/meson-ddr-pmu.rst

   > 2	===========================================================
     3	Amlogic SoC DDR Bandwidth Performance Monitoring Unit (PMU)
     4	===========================================================
     5	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
