Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECECD4F15A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350057AbiDDNRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiDDNRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:17:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EB33CA50
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649078118; x=1680614118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jyno+71uMNvzItMSpJwzUu5zgCnNx8cVzGKNKx4RoF4=;
  b=Xa+azfaJUJzpaTvTs2asIOhAOR4/LHLuWNAPLrKDH8IsYZpLGUKexgwS
   yLF6MSyzr9JHQHuo4USqg7KQXpCVCffookoScHFzdyEm30SLHzMJcjXE1
   4YwkhY8Hn0AFE+ii23O9NCD6sgy+3I23SVv1loaMAjrRo81EGalUM23r7
   N2KW/TzwDQ4KEuZR4kPzLVBMP3+g9bEifazCs2o1BmjFtdQ4zAb5gDKkm
   2V3vyiZ7fzO5tIe8GuN0Oc/+9GbterLfQMULxAlmKD3KnZ3Oc98Lk4ttc
   uenZcUh3skNO/ubvruD/kbtuYvDvat7hBaAlBd+i0bvTxZlVltx+zUbF7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="260208644"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="260208644"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:15:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="696566617"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2022 06:15:15 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbMY6-00024p-BP;
        Mon, 04 Apr 2022 13:15:14 +0000
Date:   Mon, 4 Apr 2022 21:14:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yusuf Khan <yusisamerican@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, gregkh@linuxfoundation.org,
        javier@javigon.com, arnd@arndb.de, will@kernel.org,
        axboe@kernel.dk, Yusuf Khan <yusisamerican@gmail.com>,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>
Subject: Re: [PATCH v10 1/3] drivers: ddcci: add drivers for DDCCI
Message-ID: <202204042140.TxY1fuSX-lkp@intel.com>
References: <20220403230850.2986-2-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403230850.2986-2-yusisamerican@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yusuf,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linus/master lee-backlight/for-backlight-next linux/master v5.18-rc1 next-20220404]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Yusuf-Khan/drivers-ddcci-add-drivers-for-DDCCI/20220404-080905
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 37fd83916da2e4cae03d350015c82a67b1b334c4
config: i386-randconfig-c003-20220404 (https://download.01.org/0day-ci/archive/20220404/202204042140.TxY1fuSX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/char/ddcci.c:1721:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
