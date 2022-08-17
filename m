Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72356596AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiHQHtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHQHtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:49:10 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E8167C89
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:49:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 73so11332634pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DNiQd09UafzK11FBkwcs+iSGy+8QGplgYWkm+nS++S0=;
        b=fj7UGrTDJkbe4FoWiYArk+SAIZwBIpOJ3w5z2iz5JNOUtWcHb2r3IvrOOq338ytPo4
         mL9IX54+RP2R5Yrq0rHXROHF39LMDOtiWAx3vrEgr+q8R+Vd7ctvJgALho5IoPZ/PQ6a
         /1bQIoUFBmlFR/5RKc/xOfICfR2SYgfJBw2hFk0qBAU1B2BR6DywKDtUK3zkIjsf6TxK
         G0+JOE1ux1SC+iqIof0qxj+SxF6vafmOVvllp98ElKt/z3eilm9+dGeiAnkkzSIymD2R
         T2icDVH+2Q9u17KY2yi5QZbN0pkGaaTAkz4QOb2upf1r19YyEdz91stc1zCJe1hZj4kQ
         cK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DNiQd09UafzK11FBkwcs+iSGy+8QGplgYWkm+nS++S0=;
        b=Lru8S7cvQvvSx2LxQKDD+3j0mZgyCvau38tVO1YoaRWZeafyPlwtUw+wI0sojrOFlt
         EzgVvRhou3sK6Smq9NlVcOUScg+nz9PIEZ0tEGneIabpSUkaAVewxxM96AaQvYXgq/g+
         6/jlPnA3TTMrmhLviaTUzwyn82jA79AYSZYPc2BiNcUG2lQ+NbqFk0IbKjjG5c/g4aVL
         Ofn5wEqYO147m3oo4BgNcmYOX/EsCAXsXEX/G4rw8p1pKQEgjCSvdWXmP6DQSnVOp4yn
         ejaTf8Qd+BULwhsisEND8lGzFxd6CawBrHY4LZTjUil/eTteLtRCQufr2bXvSpJPtTwy
         AuGA==
X-Gm-Message-State: ACgBeo1trIt7l0wAG0HWvwVgaGtu41eI4WrOOEYz9SZCg967p/NLU60o
        OY5FS+StAQKDYNkytixi6lk=
X-Google-Smtp-Source: AA6agR4vHtGkmizUZ/tTkNHmlQg+RREpiDotcib74icakxpdWZ1be5OldVWCoVxw1rPgpIsSgCXIvg==
X-Received: by 2002:a63:8b43:0:b0:41c:cb91:2c47 with SMTP id j64-20020a638b43000000b0041ccb912c47mr20548848pge.609.1660722549845;
        Wed, 17 Aug 2022 00:49:09 -0700 (PDT)
Received: from fedora.. ([103.230.104.51])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00172a2a41064sm427208plk.298.2022.08.17.00.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:49:09 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Khalid Masum <khalid.masum.92@gmail.com>
Subject: [PATCH v3 linux-next] soundwire: intel: Remove unnecessary TODO
Date:   Wed, 17 Aug 2022 13:48:59 +0600
Message-Id: <20220817074859.4759-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The capabilities enabled for multi-link are required as part of the
programming sequences, even when a stream uses a single link we still
use the syncArm/syncGo sequences. Therefore the TODO is no longer
necessary.

Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
Previous discussions:
- v2 Link: https://lore.kernel.org/lkml/20220816175954.5259-1-khalid.masum.92@gmail.com/
- v1 Link: https://lore.kernel.org/lkml/20220814080416.7531-1-khalid.masum.92@gmail.com/

Changes since v2:
- Update commit title.

Changes since v1:
- Remove the todo, leave rest of the code as is.
- Update commit message.

 drivers/soundwire/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 8d4000664fa3..18158825a6d8 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -75,7 +75,6 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
 
 	/*
 	 * Initialize multi_link flag
-	 * TODO: populate this flag by reading property from FW node
 	 */
 	bus->multi_link = false;
 	if (bus->ops->read_prop) {
-- 
2.37.1

