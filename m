Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23E049B8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbiAYQcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:32:32 -0500
Received: from foss.arm.com ([217.140.110.172]:54028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233590AbiAYQZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:25:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BFF71FB;
        Tue, 25 Jan 2022 08:25:43 -0800 (PST)
Received: from e127744.arm.com (unknown [10.57.88.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 38F633F766;
        Tue, 25 Jan 2022 08:25:41 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 0/1] perf test: Add branch stack sampling tests for ARM64
Date:   Tue, 25 Jan 2022 16:25:08 +0000
Message-Id: <20220125162510.2860932-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds testing of branch stack sampling on ARM64. Branch stack sampling is
supported by the Branch Record Buffer Extension (BRBE). In order to run
the tests, the Kernel must have BRBE support enabled.

At the time of writing, BRBE support in the Kernel is provided by the
patches in RFC [1]. If BRBE support is not detected, the tests will be
skipped.

Information about BRBE can be found in [2].

[1]: https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/
[2]: https://developer.arm.com/documentation/ddi0608/latest

German Gomez (1):
  perf test: Add branch stack sampling tests for ARM64

 .../perf/tests/shell/test_arm_brbe_kernel.sh  | 42 ++++++++++
 .../tests/shell/test_arm_brbe_userspace.sh    | 80 +++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_arm_brbe_kernel.sh
 create mode 100755 tools/perf/tests/shell/test_arm_brbe_userspace.sh

-- 
2.25.1

