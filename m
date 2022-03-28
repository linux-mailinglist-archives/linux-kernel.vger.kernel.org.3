Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044EC4E928D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbiC1KgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiC1KgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E03F113F1B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648463664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qL7jAD+hqMfuv8LtWCyhM0pklB+Nyp6EIiCs/KXhXss=;
        b=WodJUHYoi10fY3Zs3ST2JiLHn/txi0Le8MvW9KzryB2/mhsdFryLZY5ZyLieVM6V+jqiON
        I5IDsmlhNdBZY37rbHerJRdtcYvpgUvL9CdjtKNWKn4ZOUKnuScDPeYTZ5l5dZ03GC7TOz
        CSIKgDLEb2ILS926XUrioRyhuPGJDKI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-0jxMKX5bM6aHmqY2qorA_A-1; Mon, 28 Mar 2022 06:34:22 -0400
X-MC-Unique: 0jxMKX5bM6aHmqY2qorA_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EB793800E80;
        Mon, 28 Mar 2022 10:34:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A26CC15D40;
        Mon, 28 Mar 2022 10:34:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220322004654.618274-1-eric.dumazet@gmail.com>
References: <20220322004654.618274-1-eric.dumazet@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     dhowells@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] watch_queue: Free the page array when watch_queue is dismantled
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2572769.1648463660.1@warthog.procyon.org.uk>
Date:   Mon, 28 Mar 2022 11:34:20 +0100
Message-ID: <2572770.1648463660@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Reported-by: syzbot <syzkaller@googlegroups.com>

Should this be the following?

	Reported-by: syzbot+25ea042ae28f3888727a@syzkaller.appspotmail.com

David

