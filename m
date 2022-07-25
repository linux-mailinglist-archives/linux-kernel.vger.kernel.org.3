Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613035800D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbiGYOek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiGYOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:34:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D8E15A1B;
        Mon, 25 Jul 2022 07:34:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5477634980;
        Mon, 25 Jul 2022 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658759675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=VKIwIxSvZed0EmGDVjgi1syZjsDw4biaoB/aoz8wtqk=;
        b=Oikiv5VshcYpBWp/Mlge9tpM32Y3b7dG2D+TQTG1bZY73f43D5bg1RLsLcQIl+egs1rztq
        HJ5rdQFsqiDhR9AKkT+x1BpTDjbc+jIfCTgLehG7fWNGKwiZhVkraHR8V9J8vmXTYRyzVA
        JcG/KYGj3spsbyvYaT4sOZYbC/5hFq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658759675;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=VKIwIxSvZed0EmGDVjgi1syZjsDw4biaoB/aoz8wtqk=;
        b=zL/UlUFGjGlMJ9W7gv+UiAQadgWOjj292h2kXrBke0cbDYons5d9k+JHTd7zbgO4rrSBD6
        eh0P+QQCkQAHhxDA==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 4A6BE2C153;
        Mon, 25 Jul 2022 14:34:35 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id EFF53444B2F; Mon, 25 Jul 2022 16:34:34 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [PATCH] rtla: Define syscall numbers for riscv
CC:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Yow:  Hold the MAYO & pass the COSMIC AWARENESS...
Date:   Mon, 25 Jul 2022 16:34:34 +0200
Message-ID: <mvmr129l0qt.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 tools/tracing/rtla/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 5352167a1e75..147921356e02 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -224,7 +224,7 @@ long parse_ns_duration(char *val)
 #elif __arm__
 # define __NR_sched_setattr	380
 # define __NR_sched_getattr	381
-#elif __aarch64__
+#elif __aarch64__ || __riscv
 # define __NR_sched_setattr	274
 # define __NR_sched_getattr	275
 #elif __powerpc__
-- 
2.37.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
