Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7A579FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiGSN3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiGSN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:28:53 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6208985D65;
        Tue, 19 Jul 2022 05:44:48 -0700 (PDT)
X-QQ-mid: bizesmtp74t1658234519tv0i67c6
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:41:57 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000C00A0000000
X-QQ-FEAT: ZckECEo/G3XkGMSIvSFZtH5zDde/uBO91twW/L+wKehhGrdm09CWGXolFXYt0
        NPfhd450IrP+dx0y5VdYgRyJNJJ+PsoN2Yaq/m1EW+eRScp3aGLGbHp9zmZxVGbJyxdzD5F
        ACKYAHA8w+3Ly1dgoUQ8Zlr0pwsrKNuBFLjb+3SIM0G+kXqt+/tlEwDQj0udbvljUFBxR3M
        isSEAYbc/f9ApcjDRJ2tmK8vPkjahy2NIIPfNieF33vKzwtCPI/nqy20Qc+YSEsTCwhl8SN
        zShe8N5CS0RnSSXVanx3DDdflvJiFEWAFpkuZN9WGsdPz6F9+XfAhZPPOPYaVNwCh3v8ytr
        jrObOezpVRkT3wH81eC0B3dwkrhD3UbQQS0/qewVqf7uYcpTgDi9wa0NxTz3vblcFBfLrHE
        JJMbzeplf5E=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     alexander.shishkin@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        mhiramat@kernel.org, yangjihong1@huawei.com, irogers@google.com,
        chenzechuan1@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] perf probe: Fix comment typo
Date:   Sat, 16 Jul 2022 12:39:57 +0800
Message-Id: <20220716043957.42829-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 tools/perf/util/probe-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 062b5cbe67af..67c12d5303e7 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1349,7 +1349,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 				/*
 				 * Adjust the number of lines here.
 				 * If the number of lines == 1, the
-				 * the end of line should be equal to
+				 * end of line should be equal to
 				 * the start of line.
 				 */
 				lr->end--;
-- 
2.35.1

