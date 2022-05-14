Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD50526F1F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiENC6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiENC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:57:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EC6300EE4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652492824; x=1684028824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XbwqW8vSlHbl+VRBpjcHQ0sS7eNwoXn7JqpMKEUCRQ8=;
  b=Lyd3KiEc30gC9qTFaah9sF9FJjZ8NKm7CpwKtqrj928E3ujAVpG5BcsV
   C+nNqQ6z1whMa0JCGg0I/EO2eUj1cj5sMB1obNeWwUpNqCPBtvEbfn0n+
   6WPG5joEKBjkQlJ1BKXwTdqifk0DJKaEdIpplX3s1hr/Qr3RVTU9g2aLa
   KW9eNThy7lOwc830hXxxa47F1TEC2JrcUWpsf/jW29kjxSZc7T0CLzZEO
   yKH2Pk3T5qdhLPkKmxrTjYAfHyFZ03pjvWX4ev7+eALhws690lWglvgSh
   zpvdNmhV+JTqdtEM7htC6pqyHTh0PLKUUbR3fPPwv8fw2oyoqbB3JMGSz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270126976"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270126976"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 18:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="712630812"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:46:58 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/7] KVM: x86: Remove unnecessary include
Date:   Sat, 14 May 2022 09:43:20 +0800
Message-Id: <20220514014322.2927339-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intel-iommu.h is not needed in kvm/x86 anymore. Remove its include.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 arch/x86/kvm/x86.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4790f0d7d40b..fdf6ce5855d9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -41,7 +41,6 @@
 #include <linux/mman.h>
 #include <linux/highmem.h>
 #include <linux/iommu.h>
-#include <linux/intel-iommu.h>
 #include <linux/cpufreq.h>
 #include <linux/user-return-notifier.h>
 #include <linux/srcu.h>
-- 
2.25.1

