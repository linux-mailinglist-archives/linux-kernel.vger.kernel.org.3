Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAF346FF6A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhLJLJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:09:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240281AbhLJLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639134356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXmSWdAkzvhcbRft4KQZHSQCM8y6UG3Uqza0cNxYX6M=;
        b=AJRaeSfc3HKlPTjeNcavmyCmeeKF1Ta7D8nEfBJgyAk1VcsslWbpHZ6mozkK3Em9ejx3Ii
        Z97tqLqazOXVwMj4l/rNIw5TRRZ6SJ1XRsxogIcLbcrUO5/I9hDkYzFJfImDFQHII/ntaA
        E5Z8V9IAekgGf4Bu0aykaQK+e4KnbPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-RnfZ5k-OM0e9xHj1cxvcOA-1; Fri, 10 Dec 2021 06:05:53 -0500
X-MC-Unique: RnfZ5k-OM0e9xHj1cxvcOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E67436393;
        Fri, 10 Dec 2021 11:05:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F88A60BE5;
        Fri, 10 Dec 2021 11:05:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211210073619.21667-2-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-2-jefflexu@linux.alibaba.com> <20211210073619.21667-1-jefflexu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 01/19] cachefiles: add mode command
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <269834.1639134342.1@warthog.procyon.org.uk>
Date:   Fri, 10 Dec 2021 11:05:42 +0000
Message-ID: <269835.1639134342@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> +enum cachefiles_mode {
> +	CACHEFILES_MODE_CACHE,	/* local cache for netfs (Default) */
> +	CACHEFILES_MODE_DEMAND,	/* demand read for read-only fs */
> +};
> +

I would suggest just adding a flag for the moment.

David

