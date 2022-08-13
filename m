Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9495917C9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 02:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiHMA2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 20:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHMA2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 20:28:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7B69F773;
        Fri, 12 Aug 2022 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660350485; x=1691886485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=frBjoWGV9rUb+TpkBoZ5wYyBHHGTi0Jle2u0kUeBPvM=;
  b=oJU1k7BSj6niYjg243IXxltcPiSTgu+8jJXpgkQ5Kx2AZyKXdXyUvyPz
   it3rklqR4upx7BrgUaFlBrmMTlXbcgGt9ukSzzhTIpSJSMud89Q71QAL+
   GR3yA8T7NfbxUe3KNUS3KrOK6/+YBo3eSK9C3HpXwzqvBzo8rvt192Zm5
   vfAqJBjPfxYxWhyEBLaYHJFibqqKWk2p5DFMdP40G7xTXENtNsYs9Av10
   /KPHrZmJWEZ23qhtTapPe80xYIqHEOgj0X1yQrDiON2+oGNHhvtjrxqSR
   2eKgYiPR9W/Z503yXbzMVIUrpj01bpbzDqpP1k1gsHbcJtXAi6BO/NS3z
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292508101"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292508101"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 17:28:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="639075429"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2022 17:28:01 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMf0S-00016Z-1T;
        Sat, 13 Aug 2022 00:28:00 +0000
Date:   Sat, 13 Aug 2022 08:27:00 +0800
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
Message-ID: <202208130847.EyX7NzAD-lkp@intel.com>
References: <20220805071426.2598818-2-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805071426.2598818-2-jiucheng.xu@amlogic.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiucheng,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm/for-next arm64/for-next/core clk/clk-next kvmarm/next rockchip/for-next shawnguo/for-next soc/for-next linus/master v5.19 next-20220812]
[cannot apply to xilinx-xlnx/master keystone/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiucheng-Xu/perf-amlogic-Add-support-for-Amlogic-meson-G12-SoC-DDR-PMU-driver/20220805-151704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/perf/meson-ddr-pmu.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
