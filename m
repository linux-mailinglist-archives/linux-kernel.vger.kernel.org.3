Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CC847950E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbhLQTrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236529AbhLQTrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639770437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lZtC7sKetzLAlHd0oWhOPRrSKs6/cTgcJrwypq2TYeE=;
        b=OfkRjgo9GNr0SNa1cXLaj2+GDFK8kFIcDOrS/JwfvDw9MviiSkZGSPfx5TpX4p9Owa/MUR
        vGsXeH/PeuI/yPFgNdObL9DjqGswLiGRebQTNuzbAdnta0dm7oLmoB7vDr0c5c9iXnFGa3
        zzy+EnrbNo11B7n8HyNAUPAjdb9lKek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-yYcKRRAOPjSQpKqeACnZUw-1; Fri, 17 Dec 2021 14:47:13 -0500
X-MC-Unique: yYcKRRAOPjSQpKqeACnZUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E42181CCB5;
        Fri, 17 Dec 2021 19:47:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1E165DF21;
        Fri, 17 Dec 2021 19:47:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5muO9aTksvqD9v+sOQ2z-Xp3Rzbi9mPtfc0ad57jZG5aFw@mail.gmail.com>
References: <CAH2r5muO9aTksvqD9v+sOQ2z-Xp3Rzbi9mPtfc0ad57jZG5aFw@mail.gmail.com> <20211216124317.4143405-1-broonie@kernel.org>
To:     Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com, broonie@kernel.org,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: linux-next: manual merge of the cifs tree with the fscache tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2038158.1639770430.1@warthog.procyon.org.uk>
Date:   Fri, 17 Dec 2021 19:47:10 +0000
Message-ID: <2038159.1639770430@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> This cifs fscache fix should be upstream soon, so you should be able
> to update the fscache series ontop of updated kernel soon

Thanks.

David

