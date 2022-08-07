Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED5458BA2A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiHGIHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiHGIHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:07:07 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8506545;
        Sun,  7 Aug 2022 01:07:04 -0700 (PDT)
X-QQ-mid: bizesmtp78t1659859609t1ddzsoc
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 07 Aug 2022 16:06:43 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: QityeSR92A2QG2XRkv+WpTMTtZazY39ZAzCbbSnbcs6zHNkA1IvtOMXjtlgx8
        udPsYVxDkFS0cnCHRbO6zl5udpTcQh+f+XvveKa8cOJi+bWdoQaNljRgRQx3u6i7x7pK/qM
        vviqKQU73G4EP4EjumDdpxhyqFTjXJNnVSV89ykJWx1PuiGxUDB0z1HkbIshSVcbn56ED6b
        /KjXkd9J2fgVE+zCK0XhNgJShprXh7YIEyV5C9ZFNuK07lbGkcMGpc02k/G3g2bBpSHjR4y
        oP2t6dtCwdbcL497o9zRx38azLXdmTYBW8ZcjubnnYa4fpXix/TPoSgNXFVV7vtGzqZEVJl
        ew3ltymojXDmI3Knw2Ft/tLBOYfApHKsZLvBdoA9X/dXMSzEgQUTTUQRdD5Qg==
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] perf script: Delete repeated word "from"
Date:   Sun,  7 Aug 2022 04:06:42 -0400
Message-Id: <20220807080642.13004-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "from" in code.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7cf21ab16f4f..ebe5fdecdb0c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3847,7 +3847,7 @@ int cmd_script(int argc, const char **argv)
 	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
 			"Run xed disassembler on output", parse_xed),
 	OPT_CALLBACK_OPTARG(0, "call-trace", &itrace_synth_opts, NULL, NULL,
-			"Decode calls from from itrace", parse_call_trace),
+			"Decode calls from itrace", parse_call_trace),
 	OPT_CALLBACK_OPTARG(0, "call-ret-trace", &itrace_synth_opts, NULL, NULL,
 			"Decode calls and returns from itrace", parse_callret_trace),
 	OPT_STRING(0, "graph-function", &symbol_conf.graph_function, "symbol[,symbol...]",
-- 
2.35.1

