Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89960530C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiEWICV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiEWICK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:02:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80DC15FEC
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:02:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653292925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CRkn76HSRm0LvvrT2eLrQwPCnwqEQAVXdT04LYIvyRc=;
        b=PQqEBik2eAG9cqorSEOwYUjl1oBpCbx8v+QYrf8Tpp8fMBWbdY+O+VKyVkUjs8ua22emk0
        DSsvgl6Wecr4PC+0DsT2ZaPEsJhh/G8kzVAatFFiHGe9w+CsfmUhVLdRvQKM2YWANskmNy
        8GKrbK8sipBUCL2VWLImzY+A5pkX0hciivoR75YHix/TibxJu1rIfbjmTIX8YgSjJtL/XT
        zg4MQlL9MTxtpeKZn67+NYq+SnD5oHw5d9Db1/hkyFVfiAdQv7zJMd8FD6T69W6NS8m+Dm
        2Mj9++MCSk1OVkMolHUcw7andBsm9TQHKenrxzzydrhY3647Vf02aEgieRgXTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653292925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CRkn76HSRm0LvvrT2eLrQwPCnwqEQAVXdT04LYIvyRc=;
        b=FW9z6201MXJjY9y8xyxOXoV2STqeutGWt4xJjWMC5GLoZkd+9MmyKYrRkTBMhXOqPoUBmD
        TSJJebqBdpjsepAA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for 5.19-rc1
References: <165329267741.3801280.534077656528571075.tglx@xen13>
Message-ID: <165329267901.3801280.12353140398221832966.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 23 May 2022 10:02:05 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/debugobjects branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobject=
s-2022-05-23

up to:  9e4a51ad8eee: debugobjects: Convert to SPDX license identifier


Trivial licensing cleanup in debugobjects

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      debugobjects: Convert to SPDX license identifier


 lib/debugobjects.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 6946f8e204e3..337d797a7141 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic infrastructure for lifetime debugging of objects.
  *
- * Started by Thomas Gleixner
- *
  * Copyright (C) 2008, Thomas Gleixner <tglx@linutronix.de>
- *
- * For licencing details see kernel-base/COPYING
  */
=20
 #define pr_fmt(fmt) "ODEBUG: " fmt

