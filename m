Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE0D523609
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiEKOqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245048AbiEKOqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:46:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 734462AFB;
        Wed, 11 May 2022 07:46:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49093ED1;
        Wed, 11 May 2022 07:46:07 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.2.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 86D403F66F;
        Wed, 11 May 2022 07:46:05 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, mike.leach@linaro.org
Cc:     leo.yan@linaro.com, James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] coresight: Add config flag to enable branch broadcast
Date:   Wed, 11 May 2022 15:45:57 +0100
Message-Id: <20220511144601.2257870-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the delay.

Changes since v2:

 * Pick up some of Mike's review tags
 * Add a comment explaining rationale for not opening the event when BB isn't
   supported
 * Extend docs to say that Perf doesn't support decode when binaries are
   modified
 * Drop Perf side patches that were already merged

Thanks
James

James Clark (4):
  coresight: Add config flag to enable branch broadcast
  Documentation: coresight: Turn numbered subsections into real
    subsections
  Documentation: coresight: Link config options to existing
    documentation
  Documentation: coresight: Expand branch broadcast documentation

 .../coresight/coresight-etm4x-reference.rst   | 17 +++++-
 Documentation/trace/coresight/coresight.rst   | 56 +++++++++++++++++--
 .../hwtracing/coresight/coresight-etm-perf.c  |  2 +
 .../coresight/coresight-etm4x-core.c          | 14 +++++
 include/linux/coresight-pmu.h                 |  2 +
 5 files changed, 85 insertions(+), 6 deletions(-)

-- 
2.28.0

