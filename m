Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5E04BEB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiBUUAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:00:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiBUUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:00:50 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBCA22B29
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 12:00:26 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645473621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UEgZk+MgRHk684sVFoVv1lT5V41pFpKEa57z70CLTnI=;
        b=uUXt5/TOLFhwlAE8t2Xmu2Yibgg49DYIbnyf5BAXKu1my9YJeXEnP0P6qvsyfjhqGds8TR
        XbwjwsfydxC/Cy3dwP/r4o6Q+sokgwh7vJYN4VAzgxXiNNjsagRug+kMc/ZeXk8TDboD97
        4zcP/3f2IdMMYwPj07tC2urQW8EgQi8=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH] mailmap: update Roman Gushchin's email
Date:   Mon, 21 Feb 2022 12:00:06 -0800
Message-Id: <20220221200006.416377-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm moving to a @linux.dev account. Map my old addresses.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 11b5809daf8e..29a45c106dfb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -334,6 +334,9 @@ Rémi Denis-Courmont <rdenis@simphalempin.com>
 Ricardo Ribalda <ribalda@kernel.org> <ricardo@ribalda.com>
 Ricardo Ribalda <ribalda@kernel.org> Ricardo Ribalda Delgado <ribalda@kernel.org>
 Ricardo Ribalda <ribalda@kernel.org> <ricardo.ribalda@gmail.com>
+Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
+Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>
+Roman Gushchin <roman.gushchin@linux.dev> <klamm@yandex-team.ru>
 Ross Zwisler <zwisler@kernel.org> <ross.zwisler@linux.intel.com>
 Rudolf Marek <R.Marek@sh.cvut.cz>
 Rui Saraiva <rmps@joel.ist.utl.pt>
-- 
2.35.1

