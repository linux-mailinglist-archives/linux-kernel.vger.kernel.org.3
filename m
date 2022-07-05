Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B856A567219
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiGEPIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiGEPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:08:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15DCA22BC8;
        Tue,  5 Jul 2022 08:05:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3AE7152B;
        Tue,  5 Jul 2022 08:05:21 -0700 (PDT)
Received: from e127744.cambridge.arm.com (e127744.cambridge.arm.com [10.1.26.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E9833F66F;
        Tue,  5 Jul 2022 08:05:18 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com
Cc:     German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v2 0/1] perf test: Add test for branch stack sampling
Date:   Tue,  5 Jul 2022 16:05:10 +0100
Message-Id: <20220705150511.473919-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
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

Hi,

While testing Anshuman Khandual's branch stack sampling ABI, and BRBE
driver ([1] and [2] respectively) I've been using this test to check the
consistency between arches (x86 and Arm64).

We will extend it with Arm64-specific tests once the BRBE driver has
been reviewed and merged, but for now I think this is generic enough to
also be useful for x86.

Thanks,
German

[1] https://lore.kernel.org/linux-arm-kernel/20220610035101.424112-1-anshuman.khandual@arm.com/
[2] https://lore.kernel.org/all/20220613100119.684673-1-anshuman.khandual@arm.com/

---

v2
  - (Ian Rogers) Include C test program in the shell script.
  - Drop references to Anshuman's ABI ext (FAULT_DATA and FAULT_INST).
    We will track and update this later if necessary.

German Gomez (1):
  perf test: Add test for branch stack sampling

 tools/perf/tests/shell/test_brstack.sh | 114 +++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_brstack.sh

-- 
2.25.1

