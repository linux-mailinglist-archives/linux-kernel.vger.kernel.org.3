Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6820B583878
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiG1GLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiG1GLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:11:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0AF32471;
        Wed, 27 Jul 2022 23:11:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7825034E38;
        Thu, 28 Jul 2022 06:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658988657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4q2YLQGouekfy4oOOVYRESJKLkvT16ir/T2A9ZdcqRo=;
        b=v8Kt1Q6MD6zQltNlJjd/wpPuB9jWbp6SEF+Q160+WtgNTYN2lqgkFSGvXpShVzACh1B+JM
        Gm9GX1zoKCttSEHMzdj4OFyOmReAQp+YnRA4AEmlu4+/pidpPfLg8tF4+4SpmJN4HzAUh4
        vdMCKILwuuPo2qcxOuf3BUQa/47papw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658988657;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4q2YLQGouekfy4oOOVYRESJKLkvT16ir/T2A9ZdcqRo=;
        b=vKgoEU7osz62vusnS4Q2KkAjhb9LfWNTTrvdy/8NdtThkDB+zli3UUqQXhOSUy0FiGZcwj
        lBHE9v1Cuwkp0ACg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 853102C142;
        Thu, 28 Jul 2022 06:10:57 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/6] Documentation: serial: link uart_ops properly
Date:   Thu, 28 Jul 2022 08:10:54 +0200
Message-Id: <20220728061056.20799-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728061056.20799-1-jslaby@suse.cz>
References: <20220728061056.20799-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syntax to reference a struct in text is "struct XY". So reference
uart_ops properly, so that hyperlinks work.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/driver.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index cae280f39189..13b580e887b4 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -39,7 +39,7 @@ Locking
 
 It is the responsibility of the low level hardware driver to perform the
 necessary locking using port->lock.  There are some exceptions (which
-are described in the uart_ops listing below.)
+are described in the struct uart_ops listing below.)
 
 There are two locks.  A per-port spinlock, and an overall semaphore.
 
-- 
2.37.1

