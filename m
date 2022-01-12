Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715A548C114
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352108AbiALJfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:35:07 -0500
Received: from foss.arm.com ([217.140.110.172]:57310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238079AbiALJfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:35:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0B90D6E;
        Wed, 12 Jan 2022 01:35:05 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 246D23F766;
        Wed, 12 Jan 2022 01:35:02 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] coresight: trbe: Update existing errata for Cortex-X2
Date:   Wed, 12 Jan 2022 15:04:57 +0530
Message-Id: <1641980099-20315-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Errata ARM64_ERRATUM_[2119858|2224489] also affect some Cortex-X2 ranges as
well. This series updates the errata definition and detection as required.
This series applies on v5.16.

Relevant identification document can be found here.

https://developer.arm.com/documentation/101803/0200/AArch64-system-registers/
AArch64-identification-register-summary/MIDR-EL1--Main-ID-Register

Relevant errata document can be found here.

https://developer.arm.com/documentation/SDEN1775100

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  arm64: Add Cortex-X2 CPU part definition
  arm64: errata: Update ARM64_ERRATUM_[2119858|2224489] with Cortex-X2 ranges

 arch/arm64/Kconfig               | 12 ++++++------
 arch/arm64/include/asm/cputype.h |  2 ++
 arch/arm64/kernel/cpu_errata.c   |  2 ++
 3 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.20.1

