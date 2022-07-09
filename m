Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C256C565
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiGIAY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 20:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiGIAYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 20:24:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8606F13FAD;
        Fri,  8 Jul 2022 17:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657326264; x=1688862264;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6SqVKPmRN/v6MFlX5XJxKFRHFcCpA9ZlSG59sA3+r58=;
  b=KqTajhC5sfB7p8+An5BTMlG4AysRzRjYP02AAsCHhScPQOHH3LGBVl7K
   CY5CBJkWkIKyeOthEB+9CzVHbIKJlQqRi44NQHgl7Ihs+hYVc6CwyO+o2
   n8ySI1hm3CMl+k1oqPSr0fl41XgjcZnRRnVYww0x7JKsd8ki/KwSdvdhT
   Yi1U6DbLyjCZyyh19j+2N1p/2wiott3UG2km2E3NJOyeUtOCOzU6ELxVC
   cV92fBVtUPLCSj/gEiKC7z0DgRfhYz6ndSmC3n8riwGFRz2WNIni99ZeR
   bNBIQ5FHIwhffG9NK153RM3fc8gi7Is/nDj1vExjf+kU3qTMXY5JnVk7w
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="267432501"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="267432501"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 17:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="683824903"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2022 17:24:14 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9yGb-000O5X-BM;
        Sat, 09 Jul 2022 00:24:13 +0000
Date:   Sat, 9 Jul 2022 08:23:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Vladis Dronov <vdronov@redhat.com>, linux-doc@vger.kernel.org
Subject: [ammarfaizi2-block:herbert/cryptodev-2.6/master 45/53] htmldocs:
 Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected
 indentation.
Message-ID: <202207090803.TEGI95qw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block herbert/cryptodev-2.6/master
head:   79e6e2f3f3ff345947075341781e900e4f70db81
commit: d4cfb144f60551d80732c93c892fe76fc8df860d [45/53] crypto: qat - expose device config through sysfs for 4xxx
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentation.

vim +24 Documentation/ABI/testing/sysfs-driver-qat

  > 24	Date:		June 2022

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
