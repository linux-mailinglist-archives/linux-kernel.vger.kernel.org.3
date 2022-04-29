Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA36D5155C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380857AbiD2UkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380845AbiD2UkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:40:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1C98301E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:36:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4e758e54bso84984347b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iDcj9a5wJ6KF8f+uE+XRRsjEqScwcRIl55nWoICQltk=;
        b=VW+j5ZfVSptad3iPsruCkmIS1Tj3Z+za8DnZQ9e2AKAAU1hwwE3U6zANtt1LiP1k70
         PzjE1z73jFzrB112joxauNMQ7A45H0tJGDuSlPSbAkkgl0e3ZEPQRiNEWDP5Rl25Bosg
         1Jbc55usRzrGRJ7TH0UHTB1o1NoYAtnTmNJbDf2m0fTX0WGg1OWpottuVKIyom9vgc2G
         g02UrUWiCKRLI2CBIhG7xcec/Rqdm4RcaOPKyUBUFZ58TP/nP+2EaksYUAjCuWA25uKS
         PSlCtU+tZy+9cCncww3S1LgNuV6zJgQ9j1nbp0AQ0N6x7+2QXFSR9dTOjLrDfk8eMVkq
         RopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iDcj9a5wJ6KF8f+uE+XRRsjEqScwcRIl55nWoICQltk=;
        b=jLTWUw1WV4/jQ6JkMRWJFpIPQd26mHky6md4ku3VOHWaYjxzbGAAShNU5r2GCpZ2Kj
         9auzmGpKQc7YzXzQY657mGsvlUWzlVV3tJK7SP5XC3bZbExbKYYogPtWwjoqi/AY3Boz
         d671jts/TPUWJLaBBYsTHIw6JnY8jL6xpfGpExsWWcVpp7zm0INa65km56w42MWooKIz
         TlLNQIsCbWMRLo1Vcbt470wf3Hs80MNGFM+VuhWL8NdnyzTSQnFG2LfzaIMZeJiHwh+5
         oSSRQbiNLzjsSxaOWgZSwPg5h3tkIcpvryIke5tZb8P3Qyqd0+RnMlEvi4+nDufSKJcw
         ooUw==
X-Gm-Message-State: AOAM5324fYN2pttl9Kys+iepaugw6Fj8eQbGhRL2Z4abBp7Rl5fnbKRB
        +cK28LZestcs2rGqXFBlb8ONXlGBO2CXwc8WJUEaeiuASOgZ5t1QsCl+fTGfJO33mqb0xkRqLZ4
        XUA9YOPDbPT3rfiYeKFb2DqTCbV5/MgK3sbC4XMifQeo0f6MRC7/9TURKnv8keEWgkUJRcMq1K3
        45GTdX6crz7g==
X-Google-Smtp-Source: ABdhPJzA35JbNRKDKaxDQaRXbam70YWDIDvwSLWyFMqWNAxB9wR20Jtx/sX3avgqy+VoqLJBj9AK8KPqLrHXIWBAEoM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a25:8391:0:b0:648:b50e:3702 with SMTP
 id t17-20020a258391000000b00648b50e3702mr1249824ybk.551.1651264609911; Fri,
 29 Apr 2022 13:36:49 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:24 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; h=from:subject;
 bh=bTBRIvqJN0r4QxW0Fiqjtc1SR+oznSS8ydEfQr7tcSo=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExVtkZEXF4lWFd0quNeiDzZL9e1AigoAzh9F8Ek
 vYmOPRaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVQAKCRBMtfaEi7xW7t1EC/
 47sHOPPMx1FdEmLi3pxA8b6kFaGgSF4qhS4uCyWFckVJ1yyehiGk20aNGPxlvFyGac+BdaOuQipIxN
 Ou37XvXH8DIf8oJjUTCr3v2DLhnVRSN/mHuBi+0o2xQq7uCIiEZwujO3w2ajffL/L2OmGR5bDM7bFi
 31QqrHChTCaYmswmWq4i7BibuTh0EsIkGnG+BrI/myJEKtebWiQxmcSLIYIXs/e+GF9i0JnhVAvOkb
 W2ercajsgf4zDhfp2PAml/n3V7kt3BjFjuqMp/JmrWBc3QUcYAZ7zDZ8QWB2G8lFAFr3JkRdDJSWF6
 8nv0nx0ZHKmGMIz6sZfts+c7m+x26Y2JJqqPSv0Jtr6TyxPYTiudk/LobE+R7VCoRJSRE0QMhBBIu1
 PqRy883di9Kp8Gj8kY8K3M7eGw9RUG9pDPQIN1eBqV3wbn6G3Baw7odJCOA0x3TWGsuJHKPCHNlKdf
 FfFz1EMuWGs4NAUh0tqYXIeUXTD6w3yAqsj1M54wU9ryQ=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 01/21] efi/libstub: Filter out CC_FLAGS_CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly filter out CC_FLAGS_CFI in preparation for the flags being
removed from CC_FLAGS_LTO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..234fb2910622 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -39,6 +39,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable CFI
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
-- 
2.36.0.464.gb9c8b46e94-goog

