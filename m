Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2D569A20
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiGGF6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiGGF62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:58:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C676247;
        Wed,  6 Jul 2022 22:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657173507; x=1688709507;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GTgy+TZ5gk/9Ni3R/3rUDmoUhBqx28jO50GTF6JZTZ8=;
  b=Ev0nhGED95VrWQTUAT2wf3h3sn4oZTO5b1c6GGEDmGWCImui6cj5LhZh
   /mxYHUzClk0FOCtaxHxXwUQIZ4ngLnD1RohATPoPNEAKIAThzfFl2vDbA
   hoTPa4FigYPdWD1CMyOVvb+UN/9YqbXJ8/LHbo7W6+P9ihwPKGNdUCRUO
   YEesvrrh1SdGk6ziVaw+pcbrwu8ybLsJSrelWIUGIKqQmuHM9z9ecrGgo
   WzrJ2CVDHdFo0SPEfaYMOimUpRNS72l5HHu8KDyjQ0iJitt+18qyp13xm
   NWrEz0yLmtblI+lI8sIOLLC3zaPDe1I7H9+mdsDveVUl0iJeWfqdSnLtM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="284679285"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="284679285"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 22:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="543692990"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2022 22:58:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9KWu-000LcS-SC;
        Thu, 07 Jul 2022 05:58:24 +0000
Date:   Thu, 7 Jul 2022 13:57:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guangbin Huang <huangguangbin2@huawei.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-doc@vger.kernel.org
Subject: [ammarfaizi2-block:arm64/linux/for-next/perf 11/12] htmldocs:
 Documentation/admin-guide/perf/hns3-pmu.rst: WARNING: document isn't
 included in any toctree
Message-ID: <202207071326.3lzL9bUM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/for-next/perf
head:   66637ab137b44914356a9dc7a9b3f8ebcf0b0695
commit: 39915b6b5fc209c9262b32ec754b3838550f2a1f [11/12] drivers/perf: hisi: Add description for HNS3 PMU driver
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/perf/hns3-pmu.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
