Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC17548F2F6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiANXYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:24:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:33182 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbiANXYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642202686; x=1673738686;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s+BxWp+X6xZeEVbe0S0JfnHYK9j6NUZ7f3Weed9iDtw=;
  b=Bh/T0+zbYG4ZQaQ/LFflMSMIzxtizSPgMiLoXpqNlONESgKQLkw9gNmM
   fLSFgqbZThMg1zM3Hxe3LiQrC6t/JLztskE+dlURh3wmOjOsuBN1B28VP
   Jl0wuDzs+0rOI8ebEHIx2oBNW2YeMuTFlmZSknxji72i1rafA5xMz2CQD
   pqx9JW13vjubZWiOOTQ0Jzqoy2KSIowqWEE14MN7n7rRClQyX8oHmArxm
   nd4uvTA9c6ZWH6HKdEkVyvrfvwm3mlINqkjKJ8TgNmO17PsA0aDyNnek/
   5yVRG6FcmQBhUbTZmKWKrqvNxX6TTomfoVEGVcI+LB3qD4cxEGcFvtHqQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="268718347"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="268718347"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 15:24:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="491682053"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2022 15:24:46 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, amitk@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] DPTF IDs for Raptor Lake
Date:   Fri, 14 Jan 2022 15:24:32 -0800
Message-Id: <20220114232435.448340-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI and PCI device ids for Raptor Lake DPTF support.

Srinivas Pandruvada (3):
  ACPI: DPTF: Support Raptor Lake
  thermal: int340x: Support Raptor Lake
  thermal: int340x: Add Raptor Lake PCI device id

 drivers/acpi/dptf/dptf_pch_fivr.c                           | 1 +
 drivers/acpi/dptf/dptf_power.c                              | 2 ++
 drivers/acpi/dptf/int340x_thermal.c                         | 6 ++++++
 drivers/acpi/fan.h                                          | 1 +
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c     | 1 +
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c     | 1 +
 .../intel/int340x_thermal/processor_thermal_device.h        | 1 +
 .../intel/int340x_thermal/processor_thermal_device_pci.c    | 1 +
 8 files changed, 14 insertions(+)

-- 
2.34.1

