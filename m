Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530ED531492
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiEWOuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbiEWOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:50:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 132FD58E62;
        Mon, 23 May 2022 07:50:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C795E139F;
        Mon, 23 May 2022 07:50:02 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 181AD3F70D;
        Mon, 23 May 2022 07:50:00 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     james.clark@arm.com, leo.yan@linaro.org,
        German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH 0/1] perf test cs-etm: Add end-to-end tests for CoreSight decoding
Date:   Mon, 23 May 2022 15:49:51 +0100
Message-Id: <20220523144952.364370-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
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

Hi

While discussing running more tests for CoreSight, we thought it might
be a good idea to upstream some EndToEnd tests for CoreSight decoding in
order to lock down the behaviour. I am sending this as RFC to get some
feedback from the community first.

The test relies on pre-geneated perf.data files that are downloaded
during the test. I'm not sure it's a good idea to commit those files to
the Linux repository, so they would have to live in an external source
and be downloaded during the test.

For this RFC, the files are stored in a Github repository [1]. As an
idea, I think we could store them in a new repo in the ARM-software
namespace. Any hosting suggestions are very welcome.

Thanks,
German

[1] https://github.com/ARM-software/data/tree/984cde8fb0bb22591e284826a80b338bb79c3655/perf/coresight

German Gomez (1):
  perf test cs-etm: Add end-to-end tests for CoreSight decoding

 tools/perf/tests/shell/lib/arm_auxtrace.sh    | 21 +++++++
 .../tests/shell/test_arm_coresight_decoder.sh | 57 +++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/arm_auxtrace.sh
 create mode 100755 tools/perf/tests/shell/test_arm_coresight_decoder.sh

-- 
2.25.1

