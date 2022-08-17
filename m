Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6F5966CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiHQBfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbiHQBfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:35:02 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE7B9412C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thepaulodoom.com;
        s=mail; t=1660700097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=PRIxhRp342E9Fh0YzwotaxEqI48AIO34zvWyces/vgk=;
        b=dfK5kY98Aau6Jx0gJGjoSOCk1ElG/6qoAF6J/dk4fdP8WyjFRXIwN1nEmUW4j7Dkmja4Fk
        djYt6du8j7VR+bjaY4I063c5MRimwRZ8fcSsOGCRL8khaO3TdxGT7QSZWvAZAl/R+sweUi
        VwEcsAFQV3+xFp23f2pN7qle3ID/fHu7Ywk4vPKyTZNmCTVj56qz6PJjkOhCNZ6SZgEUMX
        r7O94Jg59kGAOQRkQJzUFplyzvfNp5h9Wv/glVYTlrXFCW+3FFcCIRf7y9xJ+CnXs3Yie+
        9M3eomAyQPeaGzo+B8aI/+OPA2AaBdl8hxUmPbeaEEZBY/SXN0OMrX8Ma3s1XT5bUWzaCJ
        ZNjklTUgfALGJMFNrYnfAVP3uqcMyQHKHjtQKBmzHNkB97o+aX/DJbTN9neyEGUTDXEjBN
        1xCUIjcb1tSlnKTMtj4YgVleX//XAjeFqlIhEKVqI/MW7rwvOlgD3NHa6EHgHnce6UMP0O
        V4GsURihyuouhBY8DepXV7cTrfxdOXfYrPwu9LoJJFMAHrFY664gIOY87GlfKwiq/h9PBu
        G30BjMkm12+NJFEqwALM/MaIDvCu4QTsJc7BlVeVVH7WKNrMCBcz/maXpN4jpWU5v7Xz5g
        xQT+6ZNl4ISRCH3kSSR+U3CrlnuKI2Jobv3Uy8HL5gQYEjz1pvMWg=
Received: from gus-fring.localdomain (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 47e3838b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 17 Aug 2022 01:34:56 +0000 (UTC)
Date:   Tue, 16 Aug 2022 20:35:31 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: char: mem: changed 'unsigned' to 'unsigned int'
Message-ID: <YvxF0yn07ztg9r4A@gus-fring.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Bot: notify
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

found with checkpatch.pl

Signed-off-by: Paul Lemmermann <thepaulodoom@thepaulodoom.com>
---
 drivers/char/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 84ca98ed1..be9d7043b 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -329,13 +329,13 @@ static unsigned long get_unmapped_area_mem(struct file *file,
 }
 
 /* permit direct mmap, for read, write or exec */
-static unsigned memory_mmap_capabilities(struct file *file)
+static unsigned int memory_mmap_capabilities(struct file *file)
 {
 	return NOMMU_MAP_DIRECT |
 		NOMMU_MAP_READ | NOMMU_MAP_WRITE | NOMMU_MAP_EXEC;
 }
 
-static unsigned zero_mmap_capabilities(struct file *file)
+static unsigned int zero_mmap_capabilities(struct file *file)
 {
 	return NOMMU_MAP_COPY;
 }
-- 
2.37.1

