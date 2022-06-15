Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0AA54C03A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbiFODiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbiFODiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:38:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E915E4D9D7;
        Tue, 14 Jun 2022 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655264293; x=1686800293;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=evmhs1bJHee9t8mg6rhaqYm/Qy7e9on13QRZSb5sx+Q=;
  b=C5iGGf6Z/QnCWqLarVD/IpJJry/IHV75ZKwUmpTrez/NAprQz80ceV7T
   77hc6vvhKgHk6JWGzEQ/r9yvoE12DFDN51jLqYrwzgqZmMspU1076FFc3
   FzGzT10oAl9OfQ7/q8jwgvBbMEtjdITOtlTMxZInPBd/nHeL44LxqS1Xv
   6cZ3NQSyCpzvAvDCIDEAtP1OnIL57if00ZGH2t5CR5uF/adRsWUlpGGQ7
   4Kvso348rcV8DiuHw8JStfTH/DTvhCiizaT2XoVRlHk5yLwUn3HBkvtPH
   uIhiqckYjQ7zup+pNEvFSBP6AtaXCYLuFbgDnwBkzmnnati98pg7gJVT2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279862433"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="279862433"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 20:38:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640750403"
Received: from avogale-mobl1.amr.corp.intel.com (HELO guptapa-desk) ([10.212.205.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 20:38:01 -0700
Date:   Tue, 14 Jun 2022 20:37:59 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@suse.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, tony.luck@intel.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Clarify the affected CPUs list for Processor
 MMIO Stale Data
Message-ID: <442705df67230c7cab00ac6647a68d6e73b6835c.1655243963.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clarifying text that list of affected processors is limited to the
processors that are within the support window.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 .../admin-guide/hw-vuln/processor_mmio_stale_data.rst          | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
index 9393c50b5afc..49c30ae53894 100644
--- a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
+++ b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
@@ -80,7 +80,8 @@ Not all the CPUs are affected by all the variants. For instance, most
 processors for the server market (excluding Intel Xeon E3 processors) are
 impacted by only Device Register Partial Write (DRPW).
 
-Below is the list of affected Intel processors [#f1]_:
+Below is the list of affected Intel processors within the support window at the
+time of disclosure [#f1]_:
 
    ===================  ============  =========
    Common name          Family_Model  Steppings
-- 
2.35.3

