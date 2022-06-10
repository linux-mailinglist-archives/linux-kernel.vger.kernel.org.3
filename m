Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31BE546C93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350255AbiFJSgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350390AbiFJSgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3C8B3FD8C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654886160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1vmTWMZvDmE1FO6rs2zTYe37OspeJHlTiBA08DM86zY=;
        b=G2+AuxqKTy57hjDCg9sP2KLjVb2QBktASVcge/Vmcp+PYO4y0jOrsLgkxWy9l9M0UOKRcu
        TQmMq68ZQLDEBWL/PJxMovf+pEO8fbJd+vvBrGIfrCWc3N3LruHKqydPto1nce5jcHcufm
        9jNQ9/rT+1JRy7HFZMl1utueaXX19aE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-wA5lDc8MNm2qOJza1114VQ-1; Fri, 10 Jun 2022 14:35:57 -0400
X-MC-Unique: wA5lDc8MNm2qOJza1114VQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1780218A0711;
        Fri, 10 Jun 2022 18:35:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 073A61121314;
        Fri, 10 Jun 2022 18:35:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        keyrings@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] certs: Convert spaces in certs/Makefile to a tab
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 10 Jun 2022 19:35:55 +0100
Message-ID: <662080.1654886155@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you apply this please?  It fixes a build error that can crop up
occasionally due to a Makefile error.

Thanks,
David
---
certs: Convert spaces in certs/Makefile to a tab

There's a rule in certs/Makefile for which the command begins with eight
spaces.  This results in:

        ../certs/Makefile:21: FORCE prerequisite is missing
        ../certs/Makefile:21: *** missing separator.  Stop.

Fix this by turning the spaces into a tab.

Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are valid")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
cc: keyrings@vger.kernel.org
Link: https://lore.kernel.org/r/486b1b80-9932-aab6-138d-434c541c934a@digiko=
d.net/ # v1
---
 certs/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/Makefile b/certs/Makefile
index bb904f90f139..cb1a9da3fc58 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -18,7 +18,7 @@ CFLAGS_blacklist_hashes.o +=3D -I$(srctree)
=20
 targets +=3D blacklist_hashes_checked
 $(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(=
SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FOR=
CE
-       $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LI=
ST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
+	$(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRC=
PREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_hashes.o
 else
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) +=3D blacklist_nohashes.o

