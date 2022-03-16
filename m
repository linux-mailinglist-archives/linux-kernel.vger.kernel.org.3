Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C504DBAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbiCPXXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiCPXX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:23:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC3F5FA2;
        Wed, 16 Mar 2022 16:22:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t11so5063374wrm.5;
        Wed, 16 Mar 2022 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Hob55agbEQWMJNUeGjeMBfRorgvcr+IN4knR4IXoNY=;
        b=Bc/adMSzOhM0b4D1ubehhQTrMAaY+fHFRE51WZW9qzn84EuDJN3CQEoIjrPoqu+IiM
         W74Wny1E2p42e6+MU93pnl27NKGuv+3rurgmSWs9HTKU8/3myOj5tvdwC3DuyOOnkARP
         61hNPeQYosS3+XB9a17nfHCT+8Qa7wIG0fHh/TzLfA7D5/UyOQgVKC4SZYMP8z006KpF
         cAfCCir7pFFvfqzLQ8g46P368gh7AxUgLRIlN2WoENU9Zm0g+6HsgytuurMgZvumIhqJ
         DdE7i2PawtpCRL32LCret6y7fo8PWqu6Y+bsZQ3M9oO1raC3dAM3n2RzjEbqjvaYn8/X
         Wiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Hob55agbEQWMJNUeGjeMBfRorgvcr+IN4knR4IXoNY=;
        b=V67PM1ltxM6aud5xnLKJbNJj+lsLOJlL2bJZmOLn+bfn4ZFJ90CLjxCy9nr6JMg1+E
         6FlNrBAbpFSzpZbJvij3avQW6toMkhnzWxJYJiAHz+DJp+wlvpmH1JtflRqA7/4WrpyT
         pN97bTQU/p9MdP4sjIT9UVxa/ZiqbJ7aVBOoNp5lOI13pjIAm4HBato0qS4e+4GuoMZw
         lmJvrbd8X+y80qCFMtXGUmrbbJ0APsyy1LTh2fa39bZR+9IKeMhbpSJv0fZSxZH3wEsv
         ESMira8cco6qYOgyazHvLWcEA61jOUvm0C0tjEY9T6JFTSBOFLktEzhv9MtoDxZtec1g
         SD4A==
X-Gm-Message-State: AOAM530mHPJHSvnH2mf1cmN4NtPCdgSM7d+r1l/sDTYG3rocKIwPKYeZ
        Ar5UMe9wjsY+jKxq52boyCI=
X-Google-Smtp-Source: ABdhPJxuhTbJTDMoQcYuDjT5tXomqDAAKl8zm4BWr2qZ25NCQl67tMuVD9Yl1KA0E7BRCRw8eO6QHA==
X-Received: by 2002:a5d:5846:0:b0:203:6b34:37af with SMTP id i6-20020a5d5846000000b002036b3437afmr1835017wrf.58.1647472933097;
        Wed, 16 Mar 2022 16:22:13 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r186-20020a1c2bc3000000b0037bdd94a4e5sm2835526wmr.39.2022.03.16.16.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 16:22:12 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf header: Fix spelling mistake "could't" -> "couldn't"
Date:   Wed, 16 Mar 2022 23:22:11 +0000
Message-Id: <20220316232212.52820-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a pr_debug2 message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 6da12e522edc..4a44a0740f43 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1335,7 +1335,7 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 
 	dir = opendir(path);
 	if (!dir) {
-		pr_debug2("%s: could't read %s, does this arch have topology information?\n",
+		pr_debug2("%s: couldn't read %s, does this arch have topology information?\n",
 			  __func__, path);
 		return -1;
 	}
-- 
2.35.1

