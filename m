Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48F2503686
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiDPMJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 08:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDPMJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 08:09:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20674D9CC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650110817; x=1681646817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N6O3WAqflFvUaurGVy2ANhSTC+TytRBU/esQzdWhthI=;
  b=TGOElUmm5dm09GremIBzxEjaagqC8Y1df2OQTHNMMH5Zf/C1qcmtN2Sh
   0OwNE9+6OnEFZZKrFSpx8OOWE0FmdneUWtvvsO4ZaYYe3pqV48iE2tgn/
   FJRqp3irMKkNs04U2an4oVrtb6S/RASRyiNGqn+3gAQzAw0CLhWwagGcg
   8hI0UlGs6/eYSLhCTJ3tuP762Yz3X0hdBr04fDvsiK1431WFrjvzTxEwU
   LuAZRrdFsQCmbAa5asgyrwFM+c8ufnU/gdEY3ysaU9lvzcmpnADu4gNir
   Lw2L2m//kjc+zFf+5Tt0ZGW2unnoZWOoCXhkJXmrcFoz7SrXTJ20iC4oo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349738706"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="349738706"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 05:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="701329034"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:06:56 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/2] iommu/vt-d: Minor cleanups
Date:   Sat, 16 Apr 2022 20:04:21 +0800
Message-Id: <20220416120423.879552-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This series include some minor cleanups for the VT-d drivers. No
intentional functional impact.

Best regards,
baolu

Change log:

v1: initial post
 - https://lore.kernel.org/linux-iommu/20220409133006.3953129-1-baolu.lu@linux.intel.com/

v2:
 - Add a new patch to fold dmar_insert_one_dev_info() into its caller.

Lu Baolu (2):
  iommu/vt-d: Change return type of dmar_insert_one_dev_info()
  iommu/vt-d: Fold dmar_insert_one_dev_info() into its caller

 drivers/iommu/intel/iommu.c | 111 ++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 62 deletions(-)

-- 
2.25.1

