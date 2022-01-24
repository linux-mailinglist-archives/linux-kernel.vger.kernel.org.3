Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB2F497F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbiAXMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:17:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:10615 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241810AbiAXMQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643026580; x=1674562580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oSJpUR7qQooZpsgnfNqCcxKzq86iTJ3y0QT5ivH1Jg8=;
  b=kQ9GuXdYG2uV/TK4pn/i2+fsh4gffga6BBIUe8BPioJ8cXwyVPXIiv1k
   s68A3MFVY9vulzgh/1KGrmgKpG2b+5wvR8kx0mhlAuM66G9LogipZeMvs
   voIblaYe06LJ+jSpZlG5lyvhmJp6qRwISQIzONglUc5uzlFeoucZkyiso
   KFNkpOAJE+v5uITBZHSxgJoo6O1VJRnAlwUCtOFgUrlDqHBAa961hSnqT
   hxVAc99x/E7GTQFc/LefbZVz1y2KCeH7XGqYkgMdUKu2VimJgvdQJw6WW
   FbmDjd11Z+y8mT/iqGMjWKKJr/gBeZnywyvDUc3XsnwWG50PWVXugd3yd
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306746283"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306746283"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:14:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="479052944"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Jan 2022 04:14:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nByF5-000II4-3F; Mon, 24 Jan 2022 12:14:39 +0000
Date:   Mon, 24 Jan 2022 20:14:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kbuild-all@lists.01.org, Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/31] clk: mediatek: pll: Implement error handling in
 register API
Message-ID: <202201242043.D1yrOE9S-lkp@intel.com>
References: <20220122091731.283592-26-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122091731.283592-26-wenst@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chen-Yu-Tsai/clk-mediatek-Cleanups-and-Improvements-Part-1/20220122-172158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: h8300-randconfig-c003-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242043.D1yrOE9S-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/clk/mediatek/clk-pll.c:407:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
