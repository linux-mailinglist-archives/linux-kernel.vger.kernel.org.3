Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743B64FBA69
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbiDKLEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244029AbiDKLD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:03:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2DF54;
        Mon, 11 Apr 2022 04:01:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8F1E91F38D;
        Mon, 11 Apr 2022 11:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649674904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WwcSwEoRIsYo08Smc2ynJx4QiZ1jV+4uaiirsM9T5s=;
        b=ExG9hubBsJJFmIK6G1QJObJ0+zPMZBZoLwo2PwegofraJMASsfUGDLRaFvY4J2xpGqWnJD
        cByEd6t1LCLCE4+eZr7NGZNZinDYE4s2gDb2AaHgJSZ3GLmp8/YLmoCbxR6tM1LB3apeq7
        vcKOBnn7GjngfE4rMbcrAHrVfxWAfhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649674904;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8WwcSwEoRIsYo08Smc2ynJx4QiZ1jV+4uaiirsM9T5s=;
        b=zrBWr4OjkkbRwyf76IM0xFzEB6geK1lDI6BvvjrSxL3TjzBT2thRAoB4bpKiF+exQSlUVI
        sybRUcQsL2+5vtAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4F2BFA3B87;
        Mon, 11 Apr 2022 11:01:44 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/6] Documentation: tty: introduce "Other Documentation"
Date:   Mon, 11 Apr 2022 13:01:39 +0200
Message-Id: <20220411110143.10019-3-jslaby@suse.cz>
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

So far only n_tty belongs here, but in the next patches, more will come.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/tty/index.rst | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/tty/index.rst b/Documentation/driver-api/tty/index.rst
index 2240e52203d6..e6a7f717a9a5 100644
--- a/Documentation/driver-api/tty/index.rst
+++ b/Documentation/driver-api/tty/index.rst
@@ -36,7 +36,6 @@ In-detail description of the named TTY structures is in separate documents:
    tty_struct
    tty_ldisc
    tty_buffer
-   n_tty
    tty_internals
 
 Writing TTY Driver
@@ -60,3 +59,13 @@ A *typical* sequence a TTY driver performs is as follows:
 Steps regarding driver, i.e. 1., 3., and 5. are described in detail in
 :doc:`tty_driver`. For the other two (devices handling), look into
 :doc:`tty_port`.
+
+Other Documentation
+===================
+
+Miscellaneous documentation can be further found in these documents:
+
+.. toctree::
+   :maxdepth: 2
+
+   n_tty
-- 
2.35.1

