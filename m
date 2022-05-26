Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A875356DE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349739AbiEZX6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347693AbiEZX5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:57:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B566F494;
        Thu, 26 May 2022 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653609358; x=1685145358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nQEJaHG8k6S1lXXUL8V60WZIpumXMsXIVVaf05mLypc=;
  b=LcVPCR4BeadXdPKUlqXfiBlaJOZcGmKYbQO8sfX86FFk6/0ZOxDWExQi
   kcxnYXvbUq8Ume+tuIgv86jm7k0Jk1Gps7VgUswk4uwC6/Fxmg0K+UuDm
   hr0JPi43fC4S/+o1S2yfOaU/RhH+6u3vJd4TXKMRH12b8pu3RzpuG67iK
   SaWJkZAfi+tYIgPthLLnZ12BpTFob4eid22HmxAhcsna8fpBE2PDiVAND
   +AfrMy4PEPU1TbgI5btVHbSqhK6ttW7STWQHhnlk/XiHS0vXs1+HFE/8D
   HJGWJxI8GqZiBesc3V3KRVfQ7SSGq3NTiQqceco39D7wR43izs7tlX6Ol
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="337376603"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="337376603"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 16:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="704830947"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 May 2022 16:55:56 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuNKd-0004Fq-F8;
        Thu, 26 May 2022 23:55:55 +0000
Date:   Fri, 27 May 2022 07:55:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     kbuild-all@lists.01.org, Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] HID: surface-hid: Add support for hot-removal
Message-ID: <202205270727.ZHBcTahI-lkp@intel.com>
References: <20220520183422.7185-7-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520183422.7185-7-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maximilian,

I love your patch! Yet something to improve:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on hid/for-next linus/master v5.18 next-20220526]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Maximilian-Luz/platform-surface-aggregator-Add-support-for-client-hot-removal/20220521-024312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: i386-randconfig-r014-20220516 (https://download.01.org/0day-ci/archive/20220527/202205270727.ZHBcTahI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/314a7da4f5af820a0475695017585a83226b05b5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Maximilian-Luz/platform-surface-aggregator-Add-support-for-client-hot-removal/20220521-024312
        git checkout 314a7da4f5af820a0475695017585a83226b05b5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/hid/surface-hid/surface_hid_core.o: in function `surface_hid_is_hot_removed.isra.0':
>> surface_hid_core.c:(.text+0x1e9): undefined reference to `ssam_device_type'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
