Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F1D537887
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiE3KEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiE3KEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:04:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E1C6108A;
        Mon, 30 May 2022 03:04:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2385E113E;
        Mon, 30 May 2022 03:04:38 -0700 (PDT)
Received: from pierre123.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9E4A3F73D;
        Mon, 30 May 2022 03:04:35 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     zhangshaokun@hisilicon.com, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com, Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 0/1] cpufreq: CPPC: Fix unused-function warning
Date:   Mon, 30 May 2022 12:04:23 +0200
Message-Id: <20220530100424.103301-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Put the Energy Model related functions inside specific guards
  instead of using the '__maybe_unused' flag.

A warning was reported when the cppc_cpufreq driver is built
with CONFIG_ENERGY_MODEL=n at:
https://lore.kernel.org/all/626c99d3-edaf-4544-7e64-5b3653591086@hisilicon.com/

The patch should be applied on top of:
https://lore.kernel.org/all/20220521032438.2504155-1-zhengbin13@huawei.com/

Pierre Gondois (1):
  cpufreq: CPPC: Fix unused-function warning

 drivers/cpufreq/cppc_cpufreq.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.25.1

