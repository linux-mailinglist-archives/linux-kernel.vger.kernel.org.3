Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF352CDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiESH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiESH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:56:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC7437A97;
        Thu, 19 May 2022 00:56:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CADF421B56;
        Thu, 19 May 2022 07:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652947014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ko0P5jBJstOddXdJBnRrlFm8vLVOFH0fdtXlTy6JMf0=;
        b=a87bNiAdEd796z/EN7LPGZgebmIU6WlYXW3K30Rbz2Rs0ADNET3McjL1UuO0ICwtpjBZfq
        Ro6SLAQuyKDbgFVuS6a5lkAbqf3Ci2ujxdC6jUPYspEf+2zSlSuy6WbK1107yx8czevZHM
        N/OoUspQNWf6XQOoon5o9TqY+OakqkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652947014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ko0P5jBJstOddXdJBnRrlFm8vLVOFH0fdtXlTy6JMf0=;
        b=iM3Dz6/NAGjkx11iSLXTwnDH+1aGFC8F1u4aRfPbc51cwH8QnR03CxPuipT2ofkCpnKDPo
        MyxR8XJ2JH1YPiDQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 903FD2C142;
        Thu, 19 May 2022 07:56:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/4] serial: pmac_zilog: remove initial print
Date:   Thu, 19 May 2022 09:56:53 +0200
Message-Id: <20220519075653.31356-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519075653.31356-1-jslaby@suse.cz>
References: <20220519075653.31356-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't report about the driver when loaded. It's unneeded and frowned
upon nowadays.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pmac_zilog.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index c6961f299f3b..3133446e806c 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -64,7 +64,6 @@
 
 #include "pmac_zilog.h"
 
-static char version[] __initdata = "pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("Driver for the Mac and PowerMac serial ports.");
 MODULE_LICENSE("GPL");
@@ -1812,7 +1811,6 @@ static struct platform_driver pmz_driver = {
 static int __init init_pmz(void)
 {
 	int rc, i;
-	printk(KERN_INFO "%s\n", version);
 
 	/* 
 	 * First, we need to do a direct OF-based probe pass. We
-- 
2.36.1

