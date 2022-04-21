Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C366F509BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387069AbiDUJBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343846AbiDUJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:00:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1584820F74;
        Thu, 21 Apr 2022 01:58:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE77F1F753;
        Thu, 21 Apr 2022 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650531489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wzZUTuBtyPsQ+iclIg/UNt2jl8gZkTXcVgn1Y308ks=;
        b=3A3ZCOPCDr74vNou9vHHYNcqZGH62bqcXd1iPFqFqcsirSMRzElsxN3Ekra1vnKBuTG6zZ
        R3cNr4zBo4s8ycmTp4YRtNUOLxpSY91SKyqX2z72e5NXFaq++eLbOg094SfcBdnFXd5jgf
        WitM4Jznzca3I/ge2u0E2iUdA0Ik0LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650531489;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wzZUTuBtyPsQ+iclIg/UNt2jl8gZkTXcVgn1Y308ks=;
        b=QzGP14PUO9QGpwpgeESvqJCUEGXMekIuGmgoMjyE0EgRrC+M391ZpmOPCjlnWOqDETGes7
        5ehuLeq8S9zbv7Dg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8B9582C145;
        Thu, 21 Apr 2022 08:58:09 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/10] serial: icom: remove ICOM_VERSION_STR macro
Date:   Thu, 21 Apr 2022 10:57:59 +0200
Message-Id: <20220421085808.24152-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421085808.24152-1-jslaby@suse.cz>
References: <20220421085808.24152-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unused, so remove the macro.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/icom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 02b375ba2f07..142257809e37 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -46,7 +46,6 @@
 /*#define ICOM_TRACE		 enable port trace capabilities */
 
 #define ICOM_DRIVER_NAME "icom"
-#define ICOM_VERSION_STR "1.3.1"
 #define NR_PORTS	       128
 #define ICOM_PORT ((struct icom_port *)port)
 #define to_icom_adapter(d) container_of(d, struct icom_adapter, kref)
-- 
2.36.0

