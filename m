Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6D74623BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhK2Vwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:52:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231268AbhK2Vu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638222431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKWEfPAaTGSd6GIvVOGiefK11BQmc7X6t2OcMCJAFtA=;
        b=RVRycsrBJvTy7nX/yrQgk67A62Mw/kzRaJe1grJeNilq3BqLVNgK/LzYO9q4RUBovX6FCX
        Ck7ksZnC0lxCDwCXDI0gmde1vI7LQ4KaAWrQ/PaNrY0l2DG5cuQI9dkhHw5mLswG9udO0m
        ZDC6UOGNQfS9hUT6fvpryCyu9eOo8Sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-LzK8ijvxMuqM2qFilC9xdw-1; Mon, 29 Nov 2021 16:47:07 -0500
X-MC-Unique: LzK8ijvxMuqM2qFilC9xdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBF6781EE60;
        Mon, 29 Nov 2021 21:47:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A7D760BF1;
        Mon, 29 Nov 2021 21:47:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211130074449.0ec314a2@canb.auug.org.au>
References: <20211130074449.0ec314a2@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the fscache tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303886.1638222425.1@warthog.procyon.org.uk>
Date:   Mon, 29 Nov 2021 21:47:05 +0000
Message-ID: <303887.1638222425@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Commit
> 
>   f022918cb360 ("cachefiles: Add security derivation")
> 
> is missing a Signed-off-by from its author and committer.
> 
> It looks like the whole body of the commit message has gone missing?

I think I forgot to write that one.  I've posted it in a reply to that
particular mail and also updated my git branches with it.  No code changes
were made.

David

