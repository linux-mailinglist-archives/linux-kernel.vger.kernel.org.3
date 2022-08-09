Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F90658DF06
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbiHIS3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347180AbiHIS06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:26:58 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989363337F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:09:45 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id B542A308D14;
        Tue,  9 Aug 2022 20:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660068557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GlwIJOS1mMHl8Ark2H9mL6uLPeWSFOOW6h0gHl0P9GY=;
        b=dSdXX+ZiUXZ6ggjmBj/1G0NSkCYhE0H7NnYxr1fneLYOZfgbHDq/cMtheCREng4fEqSQ00
        J66ZjZA6Z8sT2TxQm/b+kz3kUUd+io46yrYuAAcrz4fB+iIavhtDqz8GUafhezhAX0qYKk
        lb9KLHRjuUeqNXy5RVT1zkzxoJ+G8D0qniCC5bH4H9YpoQkdhCu4KdAld03zZXRJ8pURCx
        0qon4/By6qlYgNZRsjJqpUPR64+34FnV/RNwxbW4fogEsaeKHGyHfcQR0/buvweAfvWoML
        mHf6ER0RjD9GgqY4ujpNSDkrTO6/KgAR3wh48Q9bHhobbxPpHAlA3B3ADqXU/w==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        David Gow <davidgow@google.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 5/5] lib/cpumask_kunit: add tests file to MAINTAINERS
Date:   Tue,  9 Aug 2022 20:08:55 +0200
Message-Id: <7de8103cab9ef218e0216a66ab002a84ab66f9cc.1660068429.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660068429.git.sander@svanheule.net>
References: <cover.1660068429.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask related files are listed under the BITMAP API section, so file
with the tests for cpumask should be added to that list.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 868bbf31603d..21ff272c2c10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3601,6 +3601,7 @@ F:	include/linux/find.h
 F:	include/linux/nodemask.h
 F:	lib/bitmap.c
 F:	lib/cpumask.c
+F:	lib/cpumask_kunit.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
 F:	lib/test_bitmap.c
-- 
2.37.1

