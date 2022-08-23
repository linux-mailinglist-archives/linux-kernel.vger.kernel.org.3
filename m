Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9C59EA73
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiHWSCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHWSBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:01:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 910E0DC5D6;
        Tue, 23 Aug 2022 09:07:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7C05113E;
        Tue, 23 Aug 2022 09:07:10 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.14.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D21C3F718;
        Tue, 23 Aug 2022 09:07:04 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 0/2] coresight: etm4x: Expose default timestamp source in sysfs
Date:   Tue, 23 Aug 2022 17:06:48 +0100
Message-Id: <20220823160650.455823-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've taken over this one from German because he's moved to a different
team. I gave it a quick check and bumped the version number in the docs
for the next release, but the month is an estimate.

Thanks

Changes since v2:

  * Rebased onto coresight/next (b99ee26a1a)
  * Bumped release version to 6.1

Changes since v1:

  * Inline etmv4_to_ts_source() function.
  * Collect review tag from Leo.

German Gomez (2):
  coresight: etm4x: Expose default timestamp source in sysfs
  coresight: etm4x: docs: Add documentation for 'ts_source' sysfs
    interface

 .../testing/sysfs-bus-coresight-devices-etm4x |  8 +++++
 .../coresight/coresight-etm4x-reference.rst   | 14 +++++++++
 arch/arm64/include/asm/sysreg.h               |  1 +
 .../coresight/coresight-etm4x-sysfs.c         | 29 +++++++++++++++++++
 4 files changed, 52 insertions(+)

-- 
2.28.0

