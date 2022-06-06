Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDCA53E968
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiFFMcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 08:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbiFFMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 08:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FD6924091
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654518727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=od0IzxEHlRLIxAPHSHU26K5ts6TWDmeD0CotDfSkrvk=;
        b=HjtBy5jVM47L/+fetj5ErQ6A9RMe83dI5B2DxpkqvV9xSb9SBp12W6jh90Q/vim7SKapKu
        NKKOqDDBOdpF6Bzaws8CnelzVttBd7nO84N5vqcviT7b579/yN3r9/2D9OVRe20cGK/m4y
        3ATOU0jCQjRxOcMRIOrW6RuY18zt+5A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-aRAT3_QfNLWUTD_pjSy1eQ-1; Mon, 06 Jun 2022 08:32:01 -0400
X-MC-Unique: aRAT3_QfNLWUTD_pjSy1eQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 578461C13940;
        Mon,  6 Jun 2022 12:32:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 623BC40CF8EA;
        Mon,  6 Jun 2022 12:32:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] certs: Convert spaces in certs/Makefile to a tab
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        dhowells@redhat.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Jun 2022 13:31:59 +0100
Message-ID: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a rule in certs/Makefile for which the command begins with eight
spaces.  This results in:

	../certs/Makefile:21: FORCE prerequisite is missing
	../certs/Makefile:21: *** missing separator.  Stop.

Fix this by turning the spaces into a tab.

Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are valid")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Mickaël Salaün <mic@linux.microsoft.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: keyrings@vger.kernel.org
---

 certs/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/Makefile b/certs/Makefile
index bb904f90f139..cb1a9da3fc58 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -18,7 +18,7 @@ CFLAGS_blacklist_hashes.o += -I$(srctree)
 
 targets += blacklist_hashes_checked
 $(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FORCE
-       $(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
+	$(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
 else
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o


