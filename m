Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273CC589CB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbiHDNcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiHDNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:32:04 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D21E3D5AD
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659619870; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Q2ub6m9aXLeA4anYH/ssE1c1c5p5f0KYhUQW7SWGpRY5bRaCcWoLbELYckVz3zNmbVBPcRirxdPZ0IZTKi8jN+fqoGnWLkX5iVNcyw4CMN+IcNE9BTOEULiKoCbdLm0s7KzkYWMqHrvMH7pRCCn8yUWMwqddHTW0r7VFuZv4470=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659619870; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ML2EqkeHNsgj3TjKde7zyuOTBKOcYW9uCOulr/NrERw=; 
        b=VumQp9GlQJAVdZoNgv7hWqG33TBtUGfyarYgiTklkHdvx1dadwucNhF1nTa4qfvyq5L2sULKeGOu+/aRIJJgIBxiw4RFMpbZjv5K4RtUZsycwW4hVdJneTBmcSzU2w+LVMK4ImE1TZ4CM0uIiQ3ZoCJOXP5UdSuHHmj+V/TgVVA=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659619870;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=ML2EqkeHNsgj3TjKde7zyuOTBKOcYW9uCOulr/NrERw=;
        b=iOPoGrRI9AkzB0ea2/BWWElK0YYqhqfQfx3CV83lDrqlCu2P3mxYZKzMJIfE1dxQ
        7TU0bSgTnFnSkwt1g6XY/D8TuH72kyp9jzLPcPJh4eK8tMsrtto8AipTxfKWsiXCscD
        fv/P1TC/LHa/AVx6BxEogrKryFm8L8Aotdje8gsk=
Received: from localhost.localdomain (103.250.137.206 [103.250.137.206]) by mx.zoho.in
        with SMTPS id 16596198680111014.2940277369726; Thu, 4 Aug 2022 19:01:08 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Eric Biggers <ebiggers@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <6bac2d4c2b50d921eb16fa5344ffe258be90c651.1659618705.git.code@siddh.me>
Subject: [PATCH 2/3] kernel/watch_queue: Improve struct annotation formatting
Date:   Thu,  4 Aug 2022 19:00:23 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659618705.git.code@siddh.me>
References: <cover.1659618705.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve formatting struct annotations in watch_queue.h, so that they
fall in the preferred 80 character limit.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 include/linux/watch_queue.h | 96 +++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 25 deletions(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index fc6bba20273b..c99c39ec6548 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -18,57 +18,103 @@
=20
 struct cred;
=20
+/**
+ * watch_type_filter - Filter on watch type
+ *
+ * @type: Type of watch_notification
+ * @subtype_filter: Bitmask of subtypes to filter on
+ * @info_filter: Filter on watch_notification::info
+ * @info_mask: Mask of relevant bits in info_filter
+ */
 struct watch_type_filter {
 =09enum watch_notification_type type;
-=09__u32=09=09subtype_filter[1];=09/* Bitmask of subtypes to filter on */
-=09__u32=09=09info_filter;=09=09/* Filter on watch_notification::info */
-=09__u32=09=09info_mask;=09=09/* Mask of relevant bits in info_filter */
+=09__u32=09=09subtype_filter[1];
+=09__u32=09=09info_filter;
+=09__u32=09=09info_mask;
 };
=20
+/**
+ * watch_filter - Filter on watch
+ *
+ * @rcu: (union) RCU head
+ * @type_filter: (union) Bitmask of accepted types
+ * @nr_filters: Number of filters
+ * @filters: Array of watch_type_filter
+ */
 struct watch_filter {
 =09union {
 =09=09struct rcu_head=09rcu;
-=09=09/* Bitmask of accepted types */
 =09=09DECLARE_BITMAP(type_filter, WATCH_TYPE__NR);
 =09};
-=09u32=09=09=09nr_filters;=09/* Number of filters */
+=09u32=09=09=09 nr_filters;
 =09struct watch_type_filter filters[];
 };
=20
+/**
+ * watch_queue - General notification queue
+ *
+ * @rcu: RCU head
+ * @filter: Filter on watch_notification::info
+ * @pipe: The pipe we're using as a buffer.
+ * @watches: Contributory watches
+ * @notes: Preallocated notifications
+ * @notes_bitmap: Allocation bitmap for notes
+ * @usage: Object usage count
+ * @lock: Spinlock
+ * @nr_notes: Number of notes
+ * @nr_pages: Number of pages in notes[]
+ * @defunct: True when queues closed
+ */
 struct watch_queue {
 =09struct rcu_head=09=09rcu;
 =09struct watch_filter __rcu *filter;
-=09struct pipe_inode_info=09*pipe;=09=09/* The pipe we're using as a buffe=
r */
-=09struct hlist_head=09watches;=09/* Contributory watches */
-=09struct page=09=09**notes;=09/* Preallocated notifications */
-=09unsigned long=09=09*notes_bitmap;=09/* Allocation bitmap for notes */
-=09struct kref=09=09usage;=09=09/* Object usage count */
+=09struct pipe_inode_info=09*pipe;
+=09struct hlist_head=09watches;
+=09struct page=09=09**notes;
+=09unsigned long=09=09*notes_bitmap;
+=09struct kref=09=09usage;
 =09spinlock_t=09=09lock;
-=09unsigned int=09=09nr_notes;=09/* Number of notes */
-=09unsigned int=09=09nr_pages;=09/* Number of pages in notes[] */
-=09bool=09=09=09defunct;=09/* T when queues closed */
+=09unsigned int=09=09nr_notes;
+=09unsigned int=09=09nr_pages;
+=09bool=09=09=09defunct;
 };
=20
-/*
- * Representation of a watch on an object.
+/**
+ * watch - Representation of a watch on an object.
+ *
+ * @rcu: (union) RCU head
+ * @info_id: (union) ID to be OR'd in to info field
+ * @queue: Queue to post events to
+ * @queue_node: Link in queue->watches
+ * @watch_list: Link in watch_list->watchers
+ * @list_node: The list node
+ * @cred: Creds of the owner of the watch
+ * @private: Private data for the watched object
+ * @id: Internal identifier
+ * @usage: Object usage count
  */
 struct watch {
 =09union {
 =09=09struct rcu_head=09rcu;
-=09=09u32=09=09info_id;=09/* ID to be OR'd in to info field */
+=09=09u32=09=09info_id;
 =09};
-=09struct watch_queue __rcu *queue;=09/* Queue to post events to */
-=09struct hlist_node=09queue_node;=09/* Link in queue->watches */
+=09struct watch_queue __rcu *queue;
+=09struct hlist_node=09queue_node;
 =09struct watch_list __rcu=09*watch_list;
-=09struct hlist_node=09list_node;=09/* Link in watch_list->watchers */
-=09const struct cred=09*cred;=09=09/* Creds of the owner of the watch */
-=09void=09=09=09*private;=09/* Private data for the watched object */
-=09u64=09=09=09id;=09=09/* Internal identifier */
-=09struct kref=09=09usage;=09=09/* Object usage count */
+=09struct hlist_node=09list_node;
+=09const struct cred=09*cred;
+=09void=09=09=09*private;
+=09u64=09=09=09id;
+=09struct kref=09=09usage;
 };
=20
-/*
- * List of watches on an object.
+/**
+ * watch_list - List of watches on an object.
+ *
+ * @rcu: RCU head
+ * @watchers: List head
+ * @release_watch: Function to release watch
+ * @lock: Spinlock
  */
 struct watch_list {
 =09struct rcu_head=09=09rcu;
--=20
2.35.1


