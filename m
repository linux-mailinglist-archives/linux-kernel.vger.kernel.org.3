Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4956B2DE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbiGHGme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbiGHGmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:42:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150632F39F;
        Thu,  7 Jul 2022 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657262553; x=1688798553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o2koQnFr51eUN7ewniZDTy/mrRdv+JNwkyO1OQJmSPM=;
  b=blQt7iZz6IiDJKtkoc3r214qv07iY/3B6xGzLTsAO+fwITxy6x4ABkil
   2O1/+MW8EPx/vUxf3IDSImhGb1aOunKYvQToPz9yC8/fycyGOZbWhkTr8
   T/+0oHP6ZDKKjLeRsY3V+G9nEWRe3b3ActfkKmdJzk+yi3O2gECBtGFcU
   iBJ9j6qs1mDkroMbrS+hcRys/u6j5UpRC//98cgmW0hEtAJODyD7q27tA
   rJZc02gY6kba+m8ia3LtLUsBwEc4es+vF5kdz4gyWMQqXxuuG7FWFKd24
   Te3qlIgxzeCBdym2rExPGz0iDBFvn5vLlaZYD6fm2+4UnnZMLkazEV/7b
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="345894344"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="345894344"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 23:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="621099895"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2022 23:42:30 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9hh7-000N3K-C9;
        Fri, 08 Jul 2022 06:42:29 +0000
Date:   Fri, 8 Jul 2022 14:41:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atif Ofluoglu <Atif.Ofluoglu@analog.com>, linux@roeck-us.net
Cc:     kbuild-all@lists.01.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Atif Ofluoglu <atif.ofluoglu@analog.com>
Subject: Re: [PATCH 2/2] Added documentation for Maxim Integrated max20754
 hwmon userspace sysfs.
Message-ID: <202207081439.A6GFlbPu-lkp@intel.com>
References: <a8d037609be3e6f81bc15e2a6c24cb7809e3226b.1657204859.git.atif.ofluoglu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d037609be3e6f81bc15e2a6c24cb7809e3226b.1657204859.git.atif.ofluoglu@analog.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atif,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Atif-Ofluoglu/Adding-MAX20754-support/20220707-233249
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/hwmon/max20754.rst: WARNING: document isn't included in any toctree
>> Documentation/hwmon/max20754.rst:49: WARNING: Malformed table.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
