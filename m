Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA5C4FBA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbiDKLEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244759AbiDKLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:03:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDFFDFF0;
        Mon, 11 Apr 2022 04:01:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0EE45215FF;
        Mon, 11 Apr 2022 11:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649674905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HjBCQSJ4uTLjNNwO70mwC7ZNwPn5J6Ok7kqKWemP1Es=;
        b=qkkxXKtJkTQpHV2GwbruZ8VUtFkpOXN8R+wLmtz5EH2I9qFpP6t+ncXpP/MBcW5LlhCprT
        g26bucq481XuTvmIsTNk3546unIfq91n7xAR100+kdYc3BVvFkE4l01xTpRA2NmvbGr+Ou
        tv5mt1gBgwNIVQFq8CkK6na5d/ipBtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649674905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HjBCQSJ4uTLjNNwO70mwC7ZNwPn5J6Ok7kqKWemP1Es=;
        b=qgVgWD65/0boCjaxgwOnwTbu0Qj/v7MGKdjzib99jXdrbnjgpkUce4vGnc60HzfyrEmtcM
        lxCFqa8GjepF+6Cg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DC492A3B87;
        Mon, 11 Apr 2022 11:01:44 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/6] Documentation: tty: move moxa-smartio.rst to tty
Date:   Mon, 11 Apr 2022 13:01:41 +0200
Message-Id: <20220411110143.10019-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411110143.10019-1-jslaby@suse.cz>
References: <20220411110143.10019-1-jslaby@suse.cz>
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

It is a tty_driver, not serial -- uart_driver. So move it to the tty
docs dir too. (The same as the driver itself.)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/index.rst                 | 1 -
 Documentation/driver-api/tty/index.rst                    | 1 +
 Documentation/driver-api/{serial => tty}/moxa-smartio.rst | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/driver-api/{serial => tty}/moxa-smartio.rst (100%)

diff --git a/Documentation/driver-api/serial/index.rst b/Documentation/driver-api/serial/index.rst
index 4ebdb86cd6b6..03a55b987a1d 100644
--- a/Documentation/driver-api/serial/index.rst
+++ b/Documentation/driver-api/serial/index.rst
@@ -16,7 +16,6 @@ Serial drivers
 .. toctree::
     :maxdepth: 1
 
-    moxa-smartio
     serial-iso7816
     serial-rs485
 
diff --git a/Documentation/driver-api/tty/index.rst b/Documentation/driver-api/tty/index.rst
index 85eaac76a971..2d32606a4278 100644
--- a/Documentation/driver-api/tty/index.rst
+++ b/Documentation/driver-api/tty/index.rst
@@ -68,5 +68,6 @@ Miscellaneous documentation can be further found in these documents:
 .. toctree::
    :maxdepth: 2
 
+   moxa-smartio
    n_gsm
    n_tty
diff --git a/Documentation/driver-api/serial/moxa-smartio.rst b/Documentation/driver-api/tty/moxa-smartio.rst
similarity index 100%
rename from Documentation/driver-api/serial/moxa-smartio.rst
rename to Documentation/driver-api/tty/moxa-smartio.rst
-- 
2.35.1

