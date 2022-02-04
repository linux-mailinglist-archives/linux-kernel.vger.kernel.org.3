Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F26A4A9864
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 12:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358384AbiBDL2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 06:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358367AbiBDL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 06:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643974088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u0FPs2CDlRW+Fb9oQ77+2A05eSpiihwC/x/mTnGeFY4=;
        b=LtT/pNFV8mnxTicr4vLWSrKqExew42ctay98j1mmVqdL8EFuquTYrFDfxuS4hx8c2XGFLg
        +UfXqNY5ybiscTKgLr6lEsNRW83/FMxHtD3ZSF41qbhWLzrer8QOm9gdlfS2Lu9JXaEgHP
        F/E+zjjHCSMi5Bl12YVEPhEC1arRSsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-efsBbjRQMauhgUaQlgaRPA-1; Fri, 04 Feb 2022 06:28:07 -0500
X-MC-Unique: efsBbjRQMauhgUaQlgaRPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3B6984BA40;
        Fri,  4 Feb 2022 11:28:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A63D7D72B;
        Fri,  4 Feb 2022 11:28:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220202024137.2516438-10-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-10-Liam.Howlett@oracle.com> <20220202024137.2516438-1-Liam.Howlett@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     dhowells@redhat.com,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 09/70] mm: Start tracking VMAs with maple tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1191620.1643974083.1@warthog.procyon.org.uk>
Date:   Fri, 04 Feb 2022 11:28:03 +0000
Message-ID: <1191621.1643974083@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liam Howlett <liam.howlett@oracle.com> wrote:

> +	maple_tree_init();

Can you move this into patch 7 please?  I would like to base my branch on
maple trees alone (ie. patches 1-8) without picking up any of the VMA changes,
but this bit is missing and the maple trees don't work without it.

Thanks,
David

