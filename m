Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD6D566FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiGENxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiGENxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD23B24F3F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657027830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8R5IwFHI2kEGiHm1i7FP4vN79WRln2DlxQq0OHsfos=;
        b=QUoUPrsipJIRby8IE0hSq4tmuU6QnqDQZoQnERRtx7VLJ4UdidkBtOxIgvQ8T9C9iAfXf2
        jxXs3rOjZYtT1WquQu2nLiXYyCZSXykpDuC+UwFvB27/vNLShlfHfPwsT4N93moAzjOt8X
        DqWrsFocR/3jWScgZL0yWY7+7lqXRFo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-8FnWRd3SMPWsB1OpEJLVdg-1; Tue, 05 Jul 2022 09:30:29 -0400
X-MC-Unique: 8FnWRd3SMPWsB1OpEJLVdg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14DE029ABA32;
        Tue,  5 Jul 2022 13:30:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15B221121315;
        Tue,  5 Jul 2022 13:30:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220704023739.3523-1-zeming@nfschina.com>
References: <20220704023739.3523-1-zeming@nfschina.com>
To:     Li zeming <zeming@nfschina.com>
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com
Subject: Re: [PATCH] afs/_enter: Fix typo in string
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2212718.1657027827.1@warthog.procyon.org.uk>
Date:   Tue, 05 Jul 2022 14:30:27 +0100
Message-ID: <2212719.1657027827@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li zeming <zeming@nfschina.com> wrote:

> -	_enter("{%s,%u},%s,%u,,%llu,%u",
> +	_enter("{%s,%u},%s,%u,%llu,%u",

It's not a typo.  The fpos argument isn't printed.

> -	_enter("{%s,%u},%s,%u,,%llu,%u",
> +	_enter("{%s,%u},%s,%u,%llu,%u",

Ditto.

David

