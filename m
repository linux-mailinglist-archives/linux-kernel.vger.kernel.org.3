Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34434508CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376809AbiDTQIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354875AbiDTQIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:08:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6AA15813;
        Wed, 20 Apr 2022 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650470749; x=1682006749;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hf08b4QE9XkawxK/fJrYihK5N3GRLc2QBMxwYiBXxXQ=;
  b=I09BkyEzhiUK4exWkucxPkoD6rbWGtLOlfTiM+9e2xJgJX4ZGPxZR2/4
   +f52fK+wpJUwGp+TwsELcRr4TkN3FH6e3WteA1hnfdmCJh2oVJaXEzj7b
   r5SwaLFB8fmjfNzYj71aoMIncE28H6JxYzz5eqd60enSOMJoIbwjmKChH
   plXZuW2npmCWoiPqiPEHn9TuCDOwg73cnQK9BCRdPW4O9e/aAdlLWnRAl
   TC0CCISff4iirxgwMvTSHnKcN/DCVecI+URLt4UmoomnSnCGsydixM+Df
   nJDp3ZVltVaEcY3YZyCU9mFaJKrPp9Yi/3N7JliH64Z4PkYpna8C64sNW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="324509606"
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="324509606"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 08:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,276,1643702400"; 
   d="scan'208";a="658110872"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2022 08:56:22 -0700
Received: from debox1-desk4.lan (unknown [10.212.213.71])
        by linux.intel.com (Postfix) with ESMTP id B423158088F;
        Wed, 20 Apr 2022 08:56:22 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] platform/x86/intel/sdsi: Fixes for 5.18
Date:   Wed, 20 Apr 2022 08:56:19 -0700
Message-Id: <20220420155622.1763633-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches provide fixes for the Intel SDSi driver based on
firmware updates and for one driver bug.

David E. Box (3):
  platform/x86/intel/sdsi: Handle leaky bucket
  platform/x86/intel/sdsi: Poll on ready bit for writes
  platform/x86/intel/sdsi: Fix bug in multi packet reads

 drivers/platform/x86/intel/sdsi.c | 44 +++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 14 deletions(-)


base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.25.1

