Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71A34C81A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiCADaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCADa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:30:28 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892026E8CD;
        Mon, 28 Feb 2022 19:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646105388; x=1677641388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sb+osfrcvZS2El/NBGqKsGRy9fYRkfIxjpOnZRPdc4M=;
  b=SIFxQ1u82fJQzdY7bc+4mcDctEoQZvectaTnrEutPSj1bq4ncnGDEzPo
   ueYYKg68SY5x/n1Zcggb7w5Fcul6hDIV2tHe6cBQi5N1VYDU2uQe5rcgd
   EpTOY/gl8t2QFoj6e1n5q1vkhVd0LgYkxSCf/LQezK96l8s7R19z9HW1l
   LhREPv3gE06i83nDGMbvaD3CYf/BI/X/SWctDkUyYRH2wI3tKIbZnxbDV
   ieAk4h3BlmLIihPfW8ekVUmMFUmCPFBa60CCalhGscZvta4fU97K/7zQZ
   F3vuDrnsib9PvTGOl557sqFTjDptenBfUodGAiptXzXnYvUFvjj3dRQc+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316261415"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="316261415"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 19:29:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="575559283"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 28 Feb 2022 19:29:46 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOtCr-00083t-LN; Tue, 01 Mar 2022 03:29:45 +0000
Date:   Tue, 1 Mar 2022 11:28:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] powercap/drivers/dtpm: dtpm_node_callback[]
 can be static
Message-ID: <20220301032854.GA65991@baa819af95e9>
References: <202203011104.TkmvSjFD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203011104.TkmvSjFD-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/powercap/dtpm.c:525:22: warning: symbol 'dtpm_node_callback' was not declared. Should it be static?

Fixes: 3759ec678e89 ("powercap/drivers/dtpm: Add hierarchy creation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 drivers/powercap/dtpm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 414826a1509b6..6d890d8cf9169 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -522,7 +522,7 @@ static struct dtpm *dtpm_setup_dt(const struct dtpm_node *hierarchy,
 
 typedef struct dtpm * (*dtpm_node_callback_t)(const struct dtpm_node *, struct dtpm *);
 
-dtpm_node_callback_t dtpm_node_callback[] = {
+static dtpm_node_callback_t dtpm_node_callback[] = {
 	[DTPM_NODE_VIRTUAL] = dtpm_setup_virtual,
 	[DTPM_NODE_DT] = dtpm_setup_dt,
 };
