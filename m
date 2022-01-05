Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E044857AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbiAERvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:51:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:29110 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242546AbiAERuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641405051; x=1672941051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PpHonwmhKdYWwGE2Kj85rE7+8+B24Ps/OyDD+RJ+PS4=;
  b=dhiYpLiPh+klDlnGr/Ffoc486S+852fb9/FLR7BjVKW2TzOQgL1kV9SI
   gIbvsQbtkBqYT3qjnLXeCOkCo1CBhZbKI1Qqr9xMrAxkaOgCZza72KSTH
   U0fssEFrpc2zlQAF+X3X84EfTBzIrtb5ffoSY5TlYtChWbn8QV0KBC8sg
   CZBD1jAMEFH/iRPiHjpA/sLa3QEC50SAc6fW3y4owuxfrodWtzmwA0soj
   puTBQ/9NsEDQF8hjhakLJSB3zCTSL442xonXCwn+2DCZ4UBki9a4kuW8m
   BiYckSC9tuWJ8/95Co69YKCEpoF6Qj0q2P/9Rtq7BccfYtxjKbqkCG/M0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229815450"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="229815450"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 09:50:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="621140591"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Jan 2022 09:50:48 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5AQx-000Gu3-Oz; Wed, 05 Jan 2022 17:50:47 +0000
Date:   Thu, 6 Jan 2022 01:50:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kbuild-all@lists.01.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] ACPI: PCC: Implement OperationRegion handler for the
 PCC Type 3 subtype
Message-ID: <202201060154.xBYcdXiV-lkp@intel.com>
References: <20220103155838.616580-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103155838.616580-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sudeep-Holla/ACPI-PCC-Implement-OperationRegion-handler-for-the-PCC-Type-3-subtype/20220104-000003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220106/202201060154.xBYcdXiV-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/1dbcdc47eadc8c55659410fc03d067f3438a386a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sudeep-Holla/ACPI-PCC-Implement-OperationRegion-handler-for-the-PCC-Type-3-subtype/20220104-000003
        git checkout 1dbcdc47eadc8c55659410fc03d067f3438a386a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/acpi_pcc.c:34:22: sparse: sparse: symbol 'pcc_ctx' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
