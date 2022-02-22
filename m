Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD134BF5DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiBVKcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiBVKcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:32:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30B61598FE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:31:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6171B1F43E;
        Tue, 22 Feb 2022 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645525910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qqkcQJVhi4mzQvuwd9aG53kpS3X7TOhUy3dWnkQuXwQ=;
        b=ZpOBaLrJv/FYMGI2sZj0ta89NP7joBZ8b+QKBjWXdDkx2UpFgOAEmVGZOZ6Y/eDFH4dFus
        zD2bOaHRr2OQImsV5L3hGgz+H093kUPXtXsKFmSTS4Plz+Zqw8HLX9rYPo913oA8iPZMYX
        KCMML42BvAjM6pAqID98N8TVIwE3gVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645525910;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qqkcQJVhi4mzQvuwd9aG53kpS3X7TOhUy3dWnkQuXwQ=;
        b=iNBpfdppU5u+KuwSQ+Az6ToGrNleLavO1rKv9+dfo6W4Yn2FGF8olG+t00Jdw2K/pXLzgS
        nE+73JYSHvjLiWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AE4F13C99;
        Tue, 22 Feb 2022 10:31:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yiujDZa7FGIpfgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 22 Feb 2022 10:31:50 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] MAINTAINERS, SLAB: Add Roman as reviewer, git tree
Date:   Tue, 22 Feb 2022 11:31:04 +0100
Message-Id: <20220222103104.13241-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; h=from:subject; bh=IwK/UKIMgzNUgo9X5ifJGXwOReRorivAdTzRSiyIiwM=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBiFLtnD/1nv4ok5JQwwWtllV7rk4Vtnf+BP+Flp7w0 10LO552JATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYhS7ZwAKCRDgIcpz8YmpEBxaB/ oCAZZ4hmQUSxlerPu/FGYZMWwSfKyuE82RMCdChzFmU6Y0tKGj8mxJ8IBLnFfJKwmxIsKHoVs/wBYD RQP2uEfwb6EC7NYvJABJ+UNSbo0fUmDnanIdfCXU9+AKp3tXdjKqU1eDry6qlCtjhdDeyOGWDLud+M SXGYcTpoJr6zqCDzup2Vz7MSx3F/Iy7Pa6u/UznMAPfRzhPfpPqgnG4LcK83g1aiyJnSndFOGmI9PH DNFTTW/I5ja/1kjrRYxQZwyL3bAgey6PwkkOQ+29rzZ5mjAHaXmB0GMz6XshKyziv4rj2ra/5vjM47 T4eHqHo26sO6BwLanE9qAPkMgi3VWW
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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

The slab code has an overlap with kmem accounting, where Roman has done
a lot of work recently and it would be useful to make sure he's CC'd on
patches that potentially affect it. Thus add him as a reviewer for the
SLAB subsystem.

Also while at it, add the link to slab git tree.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fca970a46e77..5ddd45450fdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17764,8 +17764,10 @@ M:	David Rientjes <rientjes@google.com>
 M:	Joonsoo Kim <iamjoonsoo.kim@lge.com>
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Vlastimil Babka <vbabka@suse.cz>
+R:	Roman Gushchin <roman.gushchin@linux.dev>
 L:	linux-mm@kvack.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
 F:	include/linux/sl?b*.h
 F:	mm/sl?b*
 
-- 
2.35.1

