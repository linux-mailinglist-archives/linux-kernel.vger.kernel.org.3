Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5654FE1D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 22:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiFQUKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiFQUKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:10:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD261AD8D;
        Fri, 17 Jun 2022 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655496599; x=1687032599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xb2qKksZtxth+AQPUIEOHoGSTsD3UILWaYW3YtMLhHU=;
  b=j0BHY+acxGmVyZZcvoCDZgI9ZcwfvJzdMxmleqTKP2Xe5qI9zB0Sq3Wt
   IWmsci0vce6PVugkI25hXODJ9kLkEditKacNYnogJBP6wBk7sM0dw3HoC
   L4LcNuwrjHrW2A0D1JfLO6gLc1/EYi/iIqqlPHBVahvbYDdf9md3zQacP
   yi8QtdANC3iMNKnxWs7usz00BhJS5JpUUlnsxH333m5i1FekOB96ELG0m
   fBgv2RueHS/6+joh3XZXYVv4VVz4exfyEvl09UjU/QdEEdBMmhAppSzEj
   VZLEh2vRQzl7MD9uWFnDq5W5+jW8qsWH9N4BRflGfKKWua3wqijpmEP+s
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277127484"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277127484"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 13:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536942462"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Jun 2022 13:09:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2IHx-000Pj7-Un;
        Fri, 17 Jun 2022 20:09:53 +0000
Date:   Sat, 18 Jun 2022 04:09:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild-all@lists.01.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update DW 8250 UART maintainership
Message-ID: <202206180451.ZfYLcA43-lkp@intel.com>
References: <be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be58b398-71ff-7c12-1bf1-a09181d9c80@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Ilpo,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ilpo-J-rvinen/MAINTAINERS-Update-DW-8250-UART-maintainership/20220617-174145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 47700948a4abb4a5ae13ef943ff682a7f327547a
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> 'utf-8' codec can't decode byte 0xe4 in position 1396: invalid continuation byte

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
