Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987D94FC51D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349651AbiDKT2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349663AbiDKT1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:27:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573DD19006
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649705129; x=1681241129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qVII6WCIx6urEHUvPWa41zc/m5lMhoAb+7gCWYfPbVg=;
  b=iz/7QqgIyQEIKy8GDiUTvMaBZFR6HuWqQlKXe6qeZ+dYbLfQQHDq1PeO
   x6Gyh+agUfytdUm7R4Kh6jAfE8SDq+rpNZEn83gFyaZJlL/E4rs2Ub3mU
   FQilVWNXy7W50f4hqDSHgT5zR86gxYoTJQPPtepSFKbixWkCF3Lv0qhuu
   9SlmpCQ5pqCeanCiHMXe/XB43FzjeGIQzB1iA3p8v9UlyQ8FZFjhCJlGo
   aHM1QaYALXj2K1YB+oJcgdywIf9O/ZgK91tDk3Davg21fCCGsthBv5+yK
   wAHOfe84WUS6DeADux2uXUh0IYev+D9UpdrV0VPAQ59c2bu/KBINYZFpH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261636842"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261636842"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 12:25:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="507235347"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2022 12:25:27 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndzfC-00026s-U1;
        Mon, 11 Apr 2022 19:25:26 +0000
Date:   Tue, 12 Apr 2022 03:24:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RFC PATCH jsarha] BACKPORT: FROMGIT: nvme-pci: nvme_dev_pm_ops can
 be static
Message-ID: <YlSAffL1A6Q6BCZ0@efd45e54f7c9>
References: <202204120348.5EvqQlqc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204120348.5EvqQlqc-lkp@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/nvme/host/pci.c:2705:25: warning: symbol 'nvme_dev_pm_ops' was not declared. Should it be static?

Fixes: bc7304877066 ("BACKPORT: FROMGIT: nvme-pci: Use host managed power state for suspend")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 drivers/nvme/host/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 23f999fef88bcb..a33a32e6787799 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2702,7 +2702,7 @@ static int nvme_suspend(struct device *dev)
 		nvme_simple_suspend(dev) : nvme_deep_state(ndev);
 }
 
-const struct dev_pm_ops nvme_dev_pm_ops = {
+static const struct dev_pm_ops nvme_dev_pm_ops = {
 	.suspend = nvme_suspend,
 	.resume = nvme_resume,
 	.freeze = nvme_simple_suspend,
