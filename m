Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D94B2E79
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbiBKUeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:34:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiBKUeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:34:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C335CE7;
        Fri, 11 Feb 2022 12:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644611650; x=1676147650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sdvyQq1aWWNmYf5/EoZtpb75vjci2pQlXk9QshG3H0I=;
  b=MOPrNctbYhaawqWO9zLnRPcMcyDHORLop5pfdGn+J49r3G5eeW+WJoU/
   NDr7gUJv20w0hsJGuimWKEDRjItKwHfCd8dXXlRtzGcWZXRKnjUnT4Dr5
   sK5N2EAgwTdZmUb5lSNo5iW/vRF+UwKvZUxIvWVVklvRx6CMmJgYnNzK3
   dgL59JM5Rsny0H5FzhAmp0h0f4OoGvRKDaAHIm5NrHxm+dEfmh3S8lD+c
   dUANtMC8tfUunebPG5a1jdNJwfVI7cxcc1bJ28GGYpQWZaOuIEEQLTgc4
   7+9e7vURX6ruCzBX6sry3pfUn8joKu3mOO4nOmiuueuE7a2Xzu9l8Qw9A
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="248636665"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="248636665"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 12:34:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="527090889"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2022 12:34:07 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIccJ-00059x-18; Fri, 11 Feb 2022 20:34:07 +0000
Date:   Sat, 12 Feb 2022 04:33:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     kbuild-all@lists.01.org,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [PATCH v2 3/3] spi: amd: Add support for version AMDI0062
Message-ID: <202202120443.4SkWShjA-lkp@intel.com>
References: <20220211143155.75513-4-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211143155.75513-4-andrealmeid@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "André,

I love your patch! Yet something to improve:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on v5.17-rc3 next-20220211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andr-Almeida/spi-amd-Add-support-for-new-controller-version/20220211-223438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: arc-randconfig-r043-20220211 (https://download.01.org/0day-ci/archive/20220212/202202120443.4SkWShjA-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f9ba9fa1166540cf4dbf3ffbddb96b55699479b5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andr-Almeida/spi-amd-Add-support-for-new-controller-version/20220211-223438
        git checkout f9ba9fa1166540cf4dbf3ffbddb96b55699479b5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/spi/spi-amd.c:333:37: error: 'spi_acpi_match' undeclared here (not in a function)
     333 |                 .acpi_match_table = spi_acpi_match,
         |                                     ^~~~~~~~~~~~~~


vim +/spi_acpi_match +333 drivers/spi/spi-amd.c

   329	
   330	static struct platform_driver amd_spi_driver = {
   331		.driver = {
   332			.name = "amd_spi",
 > 333			.acpi_match_table = spi_acpi_match,
   334		},
   335		.probe = amd_spi_probe,
   336	};
   337	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
