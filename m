Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7155571BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiGLOBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiGLN6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:58:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D7ED28A;
        Tue, 12 Jul 2022 06:58:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 061FC1596;
        Tue, 12 Jul 2022 06:58:41 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.72.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 656063F73D;
        Tue, 12 Jul 2022 06:58:39 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH 13/14] perf test: Add git ignore for tmp and output files of CoreSight tests
Date:   Tue, 12 Jul 2022 14:57:49 +0100
Message-Id: <20220712135750.2212005-14-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
References: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
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

From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>

Ignore other output files of the new CoreSight tests so they don't
fill git status with noise we don't need or want.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 tools/perf/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index faa23b5d32f5..a653311d9693 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -22,6 +22,7 @@ perf-archive
 perf-iostat
 tags
 TAGS
+stats-*.csv
 cscope*
 config.mak
 config.mak.autogen
@@ -29,6 +30,7 @@ config.mak.autogen
 *-flex.*
 *.pyc
 *.pyo
+*.stdout
 .config-detected
 util/intel-pt-decoder/inat-tables.c
 arch/*/include/generated/
-- 
2.32.0

