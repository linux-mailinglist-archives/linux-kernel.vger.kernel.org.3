Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A784478BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbhLQNBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:01:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232215AbhLQNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639746089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7CGi0LxRX9LZqCJARN5efm/i1perQYI62fYUq7LxmzY=;
        b=G2z4dRyFvXw7k7U1gD+jnnXVTDC6JE9TZZMo+9T4fE6zQz5+8WhDCaqZR9mdNbozEoVFYv
        TZPEMQf9/C4WYk7vkDGdRpICgkQo9bkRU4SJo07wTw8aQTlid2gWoRbLG7W0LlVSRyfFUo
        5YbWZrFvak5XwTzac5yQfOD2Ujxnn4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-HIBy2D87My2k4kI0t5eOmg-1; Fri, 17 Dec 2021 08:01:26 -0500
X-MC-Unique: HIBy2D87My2k4kI0t5eOmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5193801B0C;
        Fri, 17 Dec 2021 13:01:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D0FA5F714;
        Fri, 17 Dec 2021 13:01:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211216094426.2083802-6-alexandre.ghiti@canonical.com>
References: <20211216094426.2083802-6-alexandre.ghiti@canonical.com> <20211216094426.2083802-1-alexandre.ghiti@canonical.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [PATCH v2 5/6] Documentation, arch, fs: Remove leftovers from fscache object list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1956455.1639746081.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 17 Dec 2021 13:01:21 +0000
Message-ID: <1956456.1639746081@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

>  Documentation/filesystems/caching/fscache.rst | 89 -------------------
> ...
>  fs/fscache/object.c                           |  3 -
>  fs/fscache/proc.c                             | 12 ---

Can you please drop all of the fscache bits?  They're dealt with by my
fscache-rewrite patchset that I'm proposing for the next merge window[1].

David

[1] https://lore.kernel.org/r/163906878733.143852.5604115678965006622.stgi=
t@warthog.procyon.org.uk/

