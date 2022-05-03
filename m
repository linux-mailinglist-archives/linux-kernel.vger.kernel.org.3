Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417A4518265
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiECKgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiECKgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:36:46 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC461FA67;
        Tue,  3 May 2022 03:33:14 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id i62so13710238pgd.6;
        Tue, 03 May 2022 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=muzTKDXHxre739JwDPLn6W0CCP4JY3KIRqvskM6X8vM=;
        b=FBWGNVXMbpvfke8TdnuLjHwzsu+ynQgTTlyROkGSap+8QLTHjZDJmK7cIafOr0Hi1O
         dNfRvuICGuXh508Kxf5D7N5kCiO6jBN9sS350BoHpyImp/N6U4z23xV8lhdZFaSlWag3
         XmoX5yRmhNkyuPOoe4dXf1JBavuVMDXdVFPdQEQpBvVbtXcS7zsPGWvfUw8FhaAWzC9f
         jBEfZlDqtye3UEMHwLOEbV21LJZCx/hRQSDxC4vZej9r6w4K09H/NO/klSYZMw1+C69q
         RYUsPpmJf1SDLOzUJI7b+lBvPpvzuQrfslR4Y2RsaYBGfY+bkehb4ELqBCijWTEjjS2S
         FK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=muzTKDXHxre739JwDPLn6W0CCP4JY3KIRqvskM6X8vM=;
        b=gUE95QbD2yRvUg9M74ik3I4Pyn7v+OSrRkzclLzYcyZBPkaIsFH8U8Rc/UZ1knYFOJ
         xb1MhlTcuDi8UfZyo04b488vHe/QjoJ97vx1k2L5KTdnBnmeiPH70QoaGCQjgwh72Fso
         JCr4TtH4eWWvJtmigWB0/zrb87RZtlePKIhiH/APM1us7ioyr+u6qfmC6vfPp0bGXYSG
         EaXfQCgOS0uRofKL9luDSQKtmW9P7Yb6BoiBWNXa2TBC+BQgiB/VeIC5lyPUUGm3pId3
         RlO5TsR+gkqhR1c4BdPF3VBmj4BelpeEyQCJRB1D4hKvKiQnuiMSs4M5NFwRU7AZsz5y
         I52A==
X-Gm-Message-State: AOAM530IhtYbjiTKVxy58lQg2ysY8f0IWkEz1JMWArsAxxqToO91S9MG
        Eziz/B4yxKulnSs2U9XXYwzNzmiLZkU=
X-Google-Smtp-Source: ABdhPJxDy7q//uBK9EK/lcQ9h4a/dMMi9ej11sgl909BEOF+gp398rwtS4myrfXHQPjKOxB/CPx7TA==
X-Received: by 2002:a63:d2:0:b0:3c2:57a7:a11f with SMTP id 201-20020a6300d2000000b003c257a7a11fmr4966660pga.583.1651573993801;
        Tue, 03 May 2022 03:33:13 -0700 (PDT)
Received: from localhost.localdomain (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a734200b001d0ec9c93fesm1101476pjs.12.2022.05.03.03.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:33:13 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] docs/ja_JP/SubmittingPatches: Trace changes in English docs, take 1
Date:   Tue,  3 May 2022 19:24:30 +0900
Message-Id: <20220503102429.48304-1-akiyks@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Hi,

This is the first batch of updates attempting to modernize Japanese
SubmittingPatches.  Conversion to ReST will be done later when the
corresponding commit doing the conversion is reached.  Pending list
of commits is quite long (about 90) and this effort is expected to
produce dozens of series.

List of commits for English (then) SubmittingPatches:

 - f5039935ac68 ("Documentation: update GregKH links")
 - e52d2e1f25f0 ("Documentation/SubmittingPatches: suggested the use of scripts/get_maintainer.pl")
 - 755727b7fb1e ("Randy has moved")
 - 8543ae1296f6 ("checkpatch: add Suggested-by as a standard signature")
 - 0af5270324cc ("Documentation/SubmittingPatches: Request summaries for commit references")

Note: Commit db12fb833a88 ("Documentation: fix spelling error in
SubmittingPatches") does not affect Japanese translation.

        Thanks, Akira
--
Akira Yokosawa (5):
  docs/ja_JP/SubmittingPatches: Update GregKH links
  docs/ja_JP/SubmittingPatches: Suggest the use of
    scripts/get_maintainer.pl
  docs/ja_JP/SubmittingPatches: Randy has moved
  docs/ja_JP/SubmittingPatches: Add Suggested-by as a standard signature
  docs/ja_JP/SubmittingPatches: Request summaries for commit references

 .../translations/ja_JP/SubmittingPatches      | 36 ++++++++++++++-----
 1 file changed, 27 insertions(+), 9 deletions(-)


base-commit: 81c653659d34ec253fba7f5d0f430813fe0f643d
-- 
2.25.1

