Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5905A256B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245583AbiHZKGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245581AbiHZKGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:06:30 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C3CC7434
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:05:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id D7C9C1B7B081
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:59:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661507990;
        bh=XhQWhavYNL+Uh2rXUw0qRiMeyxeLG34jiOSZDbo60dI=;
        h=From:To:Cc:Subject:Date;
        b=BAP447RphySbh6O8Bipu8JghtR3thrzG7bTWYYcALFT23WhHqk2UgMA5HXP5l0hze
         ZBTO6A0L4UsEYgbsfB7aDwBwEbEKh8Xv9UsMrWKiMelWgp1wEetf3HPkTar3ATtLoi
         4u4wDVEKCKSeK8fdg5kuxeIBIg3F0OXuGiPUPDGc=
Received: from fx408 (localhost [127.0.0.1])
        by fx408.security-mail.net (Postfix) with ESMTP id 89D511B7AD29
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:59:50 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <b42d.63089996.fd20.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx408.security-mail.net (Postfix) with ESMTPS id 107D51B7AC9C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:59:50 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id EBA3227E0396;
        Fri, 26 Aug 2022 11:59:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id D541A27E0392;
        Fri, 26 Aug 2022 11:59:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu D541A27E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661507989;
        bh=3uXWlXkU9zT4X7v44fSL8iK+mpCS56yK07uF8CWmMRg=;
        h=From:To:Date:Message-Id;
        b=Iaj4QY3gy1Tq1bIGXCT6n8MztUaavmTBcu0GOELDExNt4tGud/2BPyY239Ml+3wVo
         8IT+glijgGDkt5WmJutVdPUJ4KmPtgL/z8mPRz6k3F5klFxQbM4pMtoGGplM25ySlZ
         WZRIDzi34qa5FN/plbG36fKbNR3LEwuNxNVnFBTY=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HKTTExMOvv8E; Fri, 26 Aug 2022 11:59:49 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id C37BC27E02FA;
        Fri, 26 Aug 2022 11:59:49 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>
Subject: [PATCH] coccinelle/misc: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 11:52:59 +0200
Message-Id: <20220826095321.21548-2-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

CC: linux-kernel@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 scripts/coccinelle/misc/badty.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/badty.cocci b/scripts/coccinelle/misc/badty.cocci
index ed3e0b8f3b1a..e3530cade156 100644
--- a/scripts/coccinelle/misc/badty.cocci
+++ b/scripts/coccinelle/misc/badty.cocci
@@ -4,7 +4,7 @@
 //# This makes an effort to find cases where the argument to sizeof is wrong
 //# in memory allocation functions by checking the type of the allocated memory
 //# when it is a double pointer and ensuring the sizeof argument takes a pointer
-//# to the the memory being allocated. There are false positives in cases the
+//# to the memory being allocated. There are false positives in cases the
 //# sizeof argument is not used in constructing the return value. The result
 //# may need some reformatting.
 //
-- 
2.17.1

