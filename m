Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2038461B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343858AbhK2P70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:59:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343739AbhK2P5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638201247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NyMz49YpyRjIvMNfqragUD+9C341q72Tn7207BRRxk8=;
        b=Maxoausp3/Pks4+BCEKLLlH2PuAyfHTcPgJe2HwDk6FZI0zibD5ykLW9Ymoeitc/ZO/WmC
        KdOHX4HpLhQQ2ormx030FscfbhTaf1lcvD4jJ7qWXv2IiAFElEHqyw/b1gcNhyKlXuYkiD
        c0PpliVC2r2vuKxYz7IPFnwV2mzJ6Jo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-72-NY3FghBDOVOQQVDO7HnjaQ-1; Mon, 29 Nov 2021 10:54:06 -0500
X-MC-Unique: NY3FghBDOVOQQVDO7HnjaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 625BE1006AA8;
        Mon, 29 Nov 2021 15:54:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AF3C5BAE2;
        Mon, 29 Nov 2021 15:54:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211125192727.74360e85@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211125192727.74360e85@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <163776465314.1844202.9057900281265187616.stgit@warthog.procyon.org.uk>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dhowells@redhat.com, Eiichi Tsukata <eiichi.tsukata@nutanix.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rxrpc: Fix rxrpc_peer leak in rxrpc_look_up_bundle()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <227190.1638201239.1@warthog.procyon.org.uk>
Date:   Mon, 29 Nov 2021 15:53:59 +0000
Message-ID: <227191.1638201239@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

> Are these supposed to go to net? They are addressed To: the author.

I've posted a new set to netdev that has the Acks from Marc added for you to
pick up.

David

