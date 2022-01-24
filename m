Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59387498357
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbiAXPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:14:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240722AbiAXPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643037277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dk5kGxRxi565EfcpOZ1yuslQdkFqELh0PiM92UCiGmo=;
        b=I1ufN6GFfpbntpWSV8KZWDpx3RLgPdX8bFDescGMhpRkIfwOTRV5i2pKsJ2KqM4bC37YqZ
        KXdJHxKXZkJboDM2Bi2Zq5IOq+iIurup1dL0SMTLO/YI12rxWBdoGNotgyDUBWix9CYdIq
        BsLpmQNL/0tEp7pt/SQMbKcpU30zROo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-474-1jTLhPTUMECjJhSHFDmUAA-1; Mon, 24 Jan 2022 10:14:33 -0500
X-MC-Unique: 1jTLhPTUMECjJhSHFDmUAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0916D8519E0;
        Mon, 24 Jan 2022 15:14:33 +0000 (UTC)
Received: from agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (agk-cloud1.hosts.prod.upshift.rdu2.redhat.com [10.0.13.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2B7E7E2F4;
        Mon, 24 Jan 2022 15:14:32 +0000 (UTC)
Received: by agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (Postfix, from userid 3883)
        id 1EDD0424F088; Mon, 24 Jan 2022 15:14:34 +0000 (GMT)
Date:   Mon, 24 Jan 2022 15:14:34 +0000
From:   Alasdair G Kergon <agk@redhat.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm: introduce a no open flag for deferred remove
Message-ID: <20220124151434.GB20331@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Mail-Followup-To: Brian Geffon <bgeffon@google.com>,
        Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <20220124150209.22202-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124150209.22202-1-bgeffon@google.com>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
 03798903. Registered Office: Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 07:02:09AM -0800, Brian Geffon wrote:
> When a device is being removed with deferred remove it's
> still possible to open and use the device. This change
> introduces a flag called DM_DEFERRED_REMOVE_NO_OPEN_FLAG
> which when used with DM_DEFERRED_REMOVE will cause any
> new opens to fail with -ENXIO.
 
What is the need for this?
Does it break any semantics assumed by userspace?

Alasdair

