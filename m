Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69BA4AB63F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiBGHuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiBGHtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:49:46 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C3DC043181;
        Sun,  6 Feb 2022 23:49:44 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y5so10650937pfe.4;
        Sun, 06 Feb 2022 23:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oU5ncEXdMFxNgqDy4IwbNOWzOoow/zpeoEpdu4GP4I=;
        b=W1hgCNStVDUedeFAYqqJBQyE2xtxw832/zsGUibtipNhm5ixvJWjgy+5LRjZRTyS6g
         zIqUftUcLa59Fx0LRRsJ/qIMUbOXhMxECLJ1Q/G6RIPChNqcJ4Z438pWc6++au3/FpwQ
         95YudWRWC+1QWK6yQgUSqIdMjsaOrOn967GHGEATaGfY+FySfoxc7sa6Pu1qehfayGq+
         715rJLodZFo2h1KwTa7bFA5TWDAAW+55WTjL/81ysCz6C/Z091TsVFgiIw0VnJOMMZmm
         bYSjnBEvXRs/euTTqlVoiC4BcG6U2DH6NbxoIhoYoSxb75CLdIPjryR/hHNym4YeRX8Q
         MDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oU5ncEXdMFxNgqDy4IwbNOWzOoow/zpeoEpdu4GP4I=;
        b=g3okEwQM8xu9LW3ubYkJ26ctshxBxWeg90nY0S5lmQqbMHL3J6gK7kyE5Y8uvLdJgq
         oRWJUUXEcjEvObbZToJBwbRzB+CKGkaj8ocI9VcWpW5FYBv8T0KMIBc2o4+D+Ubwq63k
         9z2ET93ajbSV1hCx/ZqPJTEIXClSwdiTu0vJ9xOQRm1XN1N2bDDLrgRx8/No5l1sy68v
         SjPGPhFBPfTmBOJ46TUaVJeabc+dCJcmLYxKrNrfZqBwrfX8ydwEofxrKtRq2uGLfD94
         I+UDkjw78AxOm7it7JHgIU0j1HypEose0blhvNt17CmF1FwuNfA9ObFGwy1S3thREKxb
         oKdw==
X-Gm-Message-State: AOAM530DQRV89TIvmdOre2DnVZcUXsoTrgK4XMSFoZ5ykirx9aAOrcgW
        C1sN0mh5unwfcuop4gEqUbK/vigfPrY=
X-Google-Smtp-Source: ABdhPJylQMnS2QgdUOKSow1Xti1v91XMF7AVxGnLPgsFik9RoHHINvGgjbLIQziRGXy9rtsSU1CaGg==
X-Received: by 2002:a05:6a02:20c:: with SMTP id bh12mr8421109pgb.308.1644220184063;
        Sun, 06 Feb 2022 23:49:44 -0800 (PST)
Received: from baohua-VirtualBox.localdomain (47-72-151-34.dsl.dyn.ihug.co.nz. [47.72.151.34])
        by smtp.gmail.com with ESMTPSA id g18sm20259518pju.7.2022.02.06.23.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 23:49:43 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <song.bao.hua@hisilicon.com>
To:     axboe@kernel.dk, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] docs: block: biodoc.rst: Drop the obsolete and incorrect content
Date:   Mon,  7 Feb 2022 15:49:31 +0800
Message-Id: <20220207074931.20067-1-song.bao.hua@hisilicon.com>
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

Since commit 7eaceaccab5f ("block: remove per-queue plugging"), kernel
has removed blk_run_address_space(), blk_unplug() and sync_buffer(),
and moved to on-stack plugging. The document has been obsolete for
years.
Given that there is no obvious counterparts in the new mechinism to
replace old APIs, this patch drops the content directly.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/block/biodoc.rst | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/block/biodoc.rst b/Documentation/block/biodoc.rst
index 2098477851a4..9df0c9cf6090 100644
--- a/Documentation/block/biodoc.rst
+++ b/Documentation/block/biodoc.rst
@@ -970,11 +970,7 @@ till it fills up with a few more requests, before starting to service
 the requests. This provides an opportunity to merge/sort the requests before
 passing them down to the device. There are various conditions when the queue is
 unplugged (to open up the flow again), either through a scheduled task or
-could be on demand. For example wait_on_buffer sets the unplugging going
-through sync_buffer() running blk_run_address_space(mapping). Or the caller
-can do it explicity through blk_unplug(bdev). So in the read case,
-the queue gets explicitly unplugged as part of waiting for completion on that
-buffer.
+could be on demand.
 
 Aside:
   This is kind of controversial territory, as it's not clear if plugging is
-- 
2.25.1

