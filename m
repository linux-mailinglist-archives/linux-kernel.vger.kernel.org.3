Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3696C59103B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbiHLLnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbiHLLm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:42:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD21AF0E3;
        Fri, 12 Aug 2022 04:42:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A545338E44;
        Fri, 12 Aug 2022 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660304576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=P/Jodv0aOgQoc4P/PYAfGCSrSQBPBP9PZ9VWQqXrkAI=;
        b=mW7ChpQAh+wMZ0PNPkWSTaqlMzZgRn7PeTCq38n5dOkz7VuNJJ6cGbRfNmm40U4ppHHyoK
        x1WLp0/HuI4C+X/mpa2nT0c2+ikd9/X3sE4TMUdxsPrP6ZJ7Anc/2Hz7SIifVy5oPchQt0
        EB/XYdS5k3z8lA4NdA2XfkazCbAWQto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660304576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=P/Jodv0aOgQoc4P/PYAfGCSrSQBPBP9PZ9VWQqXrkAI=;
        b=1usvA9pNxgLdanBz4zsr497Va9Yhr02Uy5HheyBL4Kr17XN8SFoVDRWm/2DyzhjL0Gif4a
        eTAq4PfpbpQo6oBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E55C13AAE;
        Fri, 12 Aug 2022 11:42:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iDXOHcA89mJifAAAMHmgww
        (envelope-from <mliska@suse.cz>); Fri, 12 Aug 2022 11:42:56 +0000
Message-ID: <2983e2e0-6850-ad59-79d8-efe83b22cffe@suse.cz>
Date:   Fri, 12 Aug 2022 13:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: [PATCH] perf: fix coding style in build-id.c
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Language: en-US
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs instead of 8 spaces for the indentation.

Signed-off-by: Martin Liska <mliska@suse.cz>
---
 tools/perf/util/build-id.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 9e176146eb10..0cc68cdd84c8 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -652,17 +652,17 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
 	nsinfo__mountns_exit(&nsc);
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
-        if (realname == NULL) {
-                debuginfod_client* c = debuginfod_begin();
-                if (c != NULL) {
-                        int fd = debuginfod_find_debuginfo(c,
-                                                           (const unsigned char*)sbuild_id, 0,
-                                                           &realname);
-                        if (fd >= 0)
-                                close(fd); /* retaining reference by realname */
-                        debuginfod_end(c);
-                }
-        }
+	if (realname == NULL) {
+		debuginfod_client* c = debuginfod_begin();
+		if (c != NULL) {
+			int fd = debuginfod_find_debuginfo(c,
+					(const unsigned char*)sbuild_id, 0,
+					&realname);
+			if (fd >= 0)
+				close(fd); /* retaining reference by realname */
+			debuginfod_end(c);
+		}
+	}
 #endif
 
 out:
-- 
2.37.1

