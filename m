Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DFA4694D2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbhLFLQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242244AbhLFLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638789188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8s5rbDd6q7mBa+Fmra38DlYZzESfhQe+iIf1iuu9d3c=;
        b=YNxtqqqA8r4bDikW5/M73hliQyZxzZ1bcoI4EmjJlglevMmSGc8HX95e7VbeiJne37HLrr
        GrLDm8HEe9+y85xW7vWh4bX2pZXMvHhVSMg1N6Yv7FYoBfvPtNCCLf8q+bqQLmKRKq4xob
        68+Dk6x8sQv2AcLiIr031rjmM/DyYCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-8rX0lnSLP0WotG-6qpzbcw-1; Mon, 06 Dec 2021 06:13:05 -0500
X-MC-Unique: 8rX0lnSLP0WotG-6qpzbcw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55FC781EE62;
        Mon,  6 Dec 2021 11:13:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E12804ABA6;
        Mon,  6 Dec 2021 11:12:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211129162907.149445-3-jlayton@kernel.org>
References: <20211129162907.149445-3-jlayton@kernel.org> <20211129162907.149445-1-jlayton@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, ceph-devel@vger.kernel.org,
        idryomov@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ceph: add fscache writeback support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1223233.1638789167.1@warthog.procyon.org.uk>
Date:   Mon, 06 Dec 2021 11:12:47 +0000
Message-ID: <1223234.1638789167@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> +	if (caching)
> +		ceph_set_page_fscache(page);

I suggest moving this test into ceph_set_page_fscache().

David

