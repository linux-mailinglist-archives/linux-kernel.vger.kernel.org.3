Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A3146C66F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhLGVQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:16:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229812AbhLGVQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638911551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tijy8IJRnUTNbj2S9eoX8mcwYCPBzJ5p8C6oGn1r/G0=;
        b=X67xRP641rOkkYZUh2rIODPCyOtPteUvc9Xu55CWojfHse3Xtc/X6aHghPK8fIiAUy7HRc
        61MYZ1EWf1esrAXrJaDswYCbr70dDeWYXGtCRPGj/0TVxQJnZrPS2QPnVVGyI+6HQKwFVk
        2iBXP7nxQGl/4aQOTiwzTrgogNHPmHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-MPYj1MoTMGiNUIxROE_svQ-1; Tue, 07 Dec 2021 16:12:28 -0500
X-MC-Unique: MPYj1MoTMGiNUIxROE_svQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C731B3E746;
        Tue,  7 Dec 2021 21:12:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EE345D9C0;
        Tue,  7 Dec 2021 21:12:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20211206085650.09dcb11e@canb.auug.org.au>
References: <20211206085650.09dcb11e@canb.auug.org.au> <20211203094139.059541cd@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com, Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: linux-next: manual merge of the cifs tree with the fscache tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2419229.1638911544.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 07 Dec 2021 21:12:24 +0000
Message-ID: <2419230.1638911544@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

> >   9d0245fc6a2e ("cifs: wait for tcon resource_id before getting fscach=
e super")
> >   c148f8eb032f ("cifs: add server conn_id to fscache client cookie")
> >   b1f962ba272b ("cifs: avoid use of dstaddr as key for fscache client =
cookie")

I've rebased onto -rc4 to pick up these and another patch.

David

