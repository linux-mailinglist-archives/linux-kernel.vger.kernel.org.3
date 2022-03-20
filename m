Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335444E1ABA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 09:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbiCTIDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 04:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiCTIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 04:03:48 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC165AED8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 01:02:25 -0700 (PDT)
Message-ID: <4d388304-ad4d-3341-f129-72b919e26c8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647763343; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HN2H8NFrDnmtCi5Xm0QbCRnITcDffxzFEAo6OfrDIX4=;
        b=SZLiHXarMcOdG9sloZDS/0kOHQVJmTPJZv0iWQOJ4U6H9z6fLyh3107AlqPTJXmdsYNJDT
        0qRJXUd0tpKxNtEsypMSgTyuG//0/YNf9vzSR3oTpau8xF+iL5w516TWf07ErL4DTavdM5
        3d6aYmbBTYCfBe/6O0UHjGrkK4A24ro=
Date:   Sun, 20 Mar 2022 11:02:22 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: [PATCH] mailmap: update Vasily Averin's email address
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org
Reply-To: vasily.averin@linux.dev
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm moving to a @linux.dev account. Map my old addresses.

Signed-off-by: Vasily Averin <vasily.averin@linux.dev>
---
  .mailmap | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index 97ccdf147111..d3a8eea4ac0c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -389,6 +389,10 @@ Uwe Kleine-König <ukleinek@strlen.de>
  Uwe Kleine-König <ukl@pengutronix.de>
  Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>
  Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
+Vasily Averin <vasily.averin@linux.dev> <vvs@virtuozzo.com>
+Vasily Averin <vasily.averin@linux.dev> <vvs@openvz.org>
+Vasily Averin <vasily.averin@linux.dev> <vvs@parallels.com>
+Vasily Averin <vasily.averin@linux.dev> <vvs@sw.ru>
  Vinod Koul <vkoul@kernel.org> <vinod.koul@intel.com>
  Vinod Koul <vkoul@kernel.org> <vinod.koul@linux.intel.com>
  Vinod Koul <vkoul@kernel.org> <vkoul@infradead.org>
-- 
2.25.1

