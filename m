Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DBA4CD36F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbiCDLad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiCDLac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:30:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D338C1533AD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 03:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646393384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mjtVuXTIEMRPnIHBxbw/i3cDC6+m0A+9mG3tKwB8B5M=;
        b=CeiIXbTvCHVzEcX9VKehgkmPI0pbiUU1gYvQ1qu4YRRznURAd6SPeDHaeYGUEh9kehd4fe
        vrtgI2b3IBj4dKpFrP93WLhcc8P3rmMkYGQz6FThVKQ3Fy3XvtVr65hv7PLU3QlliMJ84i
        AF9+S3U4sUi52WOog0chQmW1Lpr9T8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-CiZnDm1JPNGtglIV-4JI7w-1; Fri, 04 Mar 2022 06:29:40 -0500
X-MC-Unique: CiZnDm1JPNGtglIV-4JI7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15F921854E21;
        Fri,  4 Mar 2022 11:29:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35AE07554E;
        Fri,  4 Mar 2022 11:29:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220304062526.336853-1-wanjiabing@vivo.com>
References: <20220304062526.336853-1-wanjiabing@vivo.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     dhowells@redhat.com, Jonathan Corbet <corbet@lwn.net>,
        Jeff Layton <jlayton@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rohith Surabattula <rohiths@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kael_w@qq.com
Subject: Re: [PATCH] netfs: rename read_helper.c to io.c in netfs_library.rst
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7713.1646393376.1@warthog.procyon.org.uk>
Date:   Fri, 04 Mar 2022 11:29:36 +0000
Message-ID: <7714.1646393376@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wan Jiabing <wanjiabing@vivo.com> wrote:

> -.. kernel-doc:: fs/netfs/read_helper.c
> +.. kernel-doc:: fs/netfs/io.c

Already done, thanks.

David

