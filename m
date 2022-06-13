Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF645499E7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbiFMRZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbiFMRZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:25:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CE33128C3C;
        Mon, 13 Jun 2022 05:43:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E778ED6E;
        Mon, 13 Jun 2022 05:43:38 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.35.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C2A853F73B;
        Mon, 13 Jun 2022 05:43:36 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mingo@redhat.com
Subject: [PATCH v2 0/4] Thermal cpufreq & devfreq cooling minor clean-ups
Date:   Mon, 13 Jun 2022 13:43:23 +0100
Message-Id: <20220613124327.30766-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v2 of some minor clean-ups for the thermal cpufreq and devfreq
cooling code.

Changes:
v2:
- extened the cpufreq_cooling_device with private ops field, to not waste
  memory and simplify allocation/free code (Viresh)
- added devfreq_cooling clean-up to align with cpufreq cooling code
- added ACKs from Viresh for patch 2/4 and path 3/4
- added missing maintainers of tracing to CC list

Regards,
Lukasz

Lukasz Luba (4):
  thermal: cpufreq_cooling: Use private callback ops for each cooling
    device
  thermal: cpufreq_cooling : Refactor thermal_power_cpu_get_power
    tracing
  thermal: cpufreq_cooling: Update outdated comments
  thermal: devfreq_cooling: Extend the devfreq_cooling_device with ops

 drivers/thermal/cpufreq_cooling.c | 77 ++++++++++---------------------
 drivers/thermal/devfreq_cooling.c | 27 ++++-------
 include/trace/events/thermal.h    | 28 ++++-------
 3 files changed, 42 insertions(+), 90 deletions(-)

-- 
2.17.1

