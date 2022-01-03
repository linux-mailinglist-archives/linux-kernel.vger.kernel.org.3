Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838E6482EF3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiACIRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:17:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:16903 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbiACIRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641197857; x=1672733857;
  h=from:to:cc:subject:date:message-id;
  bh=4kBz/E2aseGMI8WyjQQwPLH8B10PXb/8bIJq1HQzaVw=;
  b=hdBXYMja2VVoKKSyczceJbX2F3VArOLujiUHAEUFjQM2F85SgyGQc/18
   IizJOucpWmwWoQPljaJeQGVZEKGyXQ8NshLIduPBxkS5Vhb7aUF09NYVv
   +4wdWN1btJgABFRw7U1z5O/82Mk3qH5t1LUwki7k68dskAsMQSsVNZyNV
   VeXADpESd9l5lLbpOWbnIBFb5vMkQb5kAqt9d4rj3BUUouRN4dw4D04+s
   n3AnTaecewbOnFJMWjgKmVNMg4jlP/Rvbr50ExJZp4kq0En3vKmBeA6Q3
   nT1Y+UCUad8XKqwmnrj5DRE3SbsNn+wZ5N1IgVzJwPe0mVCotqJbLzHHE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="266290039"
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="266290039"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 00:17:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="471581448"
Received: from inlubt0246.iind.intel.com ([10.67.198.165])
  by orsmga006.jf.intel.com with ESMTP; 03 Jan 2022 00:17:31 -0800
From:   vishakha.joshi@intel.com
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        vijayakannan.ayyathurai@intel.com, bala.senthil@intel.com,
        tamal.saha@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        vishakha.joshi@intel.com
Subject: [PATCH v1 0/2] pwm: Add count to sysfs for Intel PWM driver
Date:   Mon,  3 Jan 2022 13:46:08 +0530
Message-Id: <20220103081610.6656-1-vishakha.joshi@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vishakha Joshi <vishakha.joshi@intel.com>

Hi,

The patch 1 adds the count for PWM waveform to sysfs interface.
The patch 2 updates the count in the KeemBay PWM driver.

Please help to review these patches.

Thanks,
Vishakha Joshi

Vishakha Joshi (2):
  pwm: Add count to sysfs for Intel PWM driver
  pwm: Update the REPEAT_COUNT value

 Documentation/ABI/testing/sysfs-class-pwm |  8 ++++++
 drivers/pwm/pwm-keembay.c                 |  9 ++++--
 drivers/pwm/sysfs.c                       | 34 +++++++++++++++++++++++
 include/linux/pwm.h                       |  2 ++
 4 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.17.1

