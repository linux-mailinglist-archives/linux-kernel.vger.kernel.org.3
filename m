Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02235966CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbiHQBcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiHQBcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:32:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE3C93505;
        Tue, 16 Aug 2022 18:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660699929; x=1692235929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/GuSDADkL//P5o9gnAx2aaAgwKPGm1Gd8VUSvZfA1HI=;
  b=Y1ZUSZIMtriWQBPqG/BL3iCd3bZHDkpNBwUBVUrvbUm5DcJo49Nhhnvm
   OD7DaoHHG8HaMn4UZG3XWi/vKuknFZXx+Op3gUZQ4Hvth1A3S9IFJsIHz
   ZsX4Z4HZksM3/rFZrO3cYlvsoQ6IxoyY6LleL0v937utcDCFSVgHV4l9S
   bQWnJWJrDj4ekhmvw2NluhiadURQxv8/sDaw+tTRpZN+6YcDiPVpFnNL+
   BObXS3ATu7xs3Q9Yv4ZBgShnI6bYmkfMkpN3RX/FT48aYSGeEc+Cv2onk
   WNhtGPwgtu2JQdjpDjnCqMtEqFl1kPvLHf5md5rY1AS6LqrBt6KRguDpy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="354119399"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="354119399"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 18:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="935150138"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2022 18:32:06 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO7ug-0000Qm-0V;
        Wed, 17 Aug 2022 01:32:06 +0000
Date:   Wed, 17 Aug 2022 09:31:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: soc: renesas: Move renesas.yaml from arm to
 soc
Message-ID: <202208170950.T1F2Y7HC-lkp@intel.com>
References: <20220815111708.22302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815111708.22302-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

I love your patch! Perhaps something to improve:

[auto build test WARNING on geert-renesas-devel/next]
[also build test WARNING on linus/master v6.0-rc1 next-20220816]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lad-Prabhakar/dt-bindings-soc-renesas-Move-renesas-yaml-from-arm-to-soc/20220815-191822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/arm/renesas.yaml

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
