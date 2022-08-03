Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C29D5885DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiHCCj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiHCCj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:39:57 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48823BC83
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thepaulodoom.com;
        s=mail; t=1659494393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=CFrfupiQ+AG6pqv/VnxtvDcCQjqOVWDVDgyabjPTzA0=;
        b=hGHlojy7rJnGaE2AtfuCL0yAb9q+wxZK20pqBFXG9xuYv9Lm5WvG5ET5SsYB9qV+uumw95
        gSHTt3H5h+NPqQYt7gYXCjuEZurUeoJiXvTpmcptLviDk9k/F7TK1ftyygzD2+WhIVQIm9
        YwU6YCkfXbJiQ9yAOeG/usDIlNAlY/wlt3V98qcnKGlyV10UMhgGJ09rgORazfYPuSfFmp
        wT8sskBvwi2nNX+ToZQb44KG12T8AiSvTnZPJfstPV4eeunafcmoHlmsznveXt9JUG1X1I
        wlYRgZ3350wWHCwtL4aJLZzAnGiDvT4iucMYx7p6/2aXA2vt+Lv3MmiUOEoKkCQliGLC5j
        12G2grdDph4ymw78k/omB3a8O7SpqeGZq89JM+woKpWSq9MxWpcdwnxG8/qT4Ar1U6OUBm
        G4vEB3/k2B7tkh4kAy+DpKtddheJ7CqY75mlOcx9Nqpa+bdCiuTu0tjg6B3+00GtB2lBRw
        0/ykhoVzWf/3v/oKu3SH85n7nyfERZG0hxqAwRWTuYjvsI1t/lisvmoRV8jHPH9ZHTpv02
        530xilwqE2VVB9YGxkULSJmZVb4txzMs58BLZEYmq9s6n6qWx2KlwMFDMhErwNs5IS5jPG
        GDDSce4UO3i4+AxiEqK2NutpfGDYmGYxDH0SiY3zd0ql2koM6obY0=
Received: from gus-fring.localdomain (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 323867ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 Aug 2022 02:39:52 +0000 (UTC)
Date:   Tue, 2 Aug 2022 21:40:14 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: cpu: added surrounding spaces
Message-ID: <YungDkexnjydwcoG@gus-fring.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added surrounding spaces aroud assignment operator. Found with
checkpatch.

Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index bbad5e375..60978ca61 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1660,7 +1660,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.teardown.single	= NULL,
 	},
 #ifdef CONFIG_SMP
-	[CPUHP_CREATE_THREADS]= {
+	[CPUHP_CREATE_THREADS] = {
 		.name			= "threads:prepare",
 		.startup.single		= smpboot_create_threads,
 		.teardown.single	= NULL,
-- 
2.37.1

