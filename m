Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEF14700CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbhLJMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:41:36 -0500
Received: from foss.arm.com ([217.140.110.172]:41480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241071AbhLJMlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:41:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7A9D12FC;
        Fri, 10 Dec 2021 04:38:00 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.35.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49DCE3F5A1;
        Fri, 10 Dec 2021 04:37:58 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] perf vendor events: Rename arm64 arch std event files
Date:   Fri, 10 Dec 2021 12:37:05 +0000
Message-Id: <20211210123706.7490-3-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211210123706.7490-1-andrew.kilroy@arm.com>
References: <20211210123706.7490-1-andrew.kilroy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous commit adds pmu events into the files

  armv8-common-and-microarch.json
  armv8-recommended.json

that are actually specified in an armv9 reference supplement, not armv8.
As such, naming the files with the armv8 prefix seems artificial.

This patch renames the files to reflect that these two files are for
arch std events regardless of whether they are defined in armv8 or
armv9.

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 ...{armv8-common-and-microarch.json => common-and-microarch.json} | 0
 .../arch/arm64/{armv8-recommended.json => recommended.json}       | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename tools/perf/pmu-events/arch/arm64/{armv8-common-and-microarch.json => common-and-microarch.json} (100%)
 rename tools/perf/pmu-events/arch/arm64/{armv8-recommended.json => recommended.json} (100%)

diff --git a/tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
rename to tools/perf/pmu-events/arch/arm64/common-and-microarch.json
diff --git a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json b/tools/perf/pmu-events/arch/arm64/recommended.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/armv8-recommended.json
rename to tools/perf/pmu-events/arch/arm64/recommended.json
-- 
2.17.1

