Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07D546322F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbhK3LWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:22:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238708AbhK3LWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638271137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8StU74rOzS6uUZ+msBZh+ui9wYjXSzs0fR8p0dc/LVI=;
        b=MZKK4RpgR/MZ0UvliXkOtO4vjDgHctXjiScCFzFni01xUVYZtQ31qpLeR7vqT52ezuGX3J
        n/0P1bdd+JfegxgF8yuk5U2BPWbmM1e32SQyYNHA6NjPMLiCaeTaJCoNL9IlpMvUvEY4PR
        4nYB81+6qSp2sWMetk+eIQohauiFobk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-2Tefnm82P9eD880zOE1i_g-1; Tue, 30 Nov 2021 06:18:54 -0500
X-MC-Unique: 2Tefnm82P9eD880zOE1i_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 803231006AA0;
        Tue, 30 Nov 2021 11:18:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B24B9100E125;
        Tue, 30 Nov 2021 11:18:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211130175119.63d0e7aa@canb.auug.org.au>
References: <20211130175119.63d0e7aa@canb.auug.org.au> <20211130162311.105fcfa5@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the fscache tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <429851.1638271126.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 30 Nov 2021 11:18:46 +0000
Message-ID: <429852.1638271126@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Documentation/filesystems/netfs_library.rst:518: WARNING: Inline emphasi=
s start-string without end-string.
> Documentation/filesystems/netfs_library.rst:518: WARNING: Inline emphasi=
s start-string without end-string.

Ah...  I worked out what that's about.  It's not actually on the line
specified, but rather later in the same paragraph:

   the write.  *_start and *_len indicate the region to be written; the re=
gion

with the two asterisks.  I guess wrapping them like:

   the write.  ``*_start`` and ``*_len`` indicate the region to be written=
; the

might be the right thing to do.

David

