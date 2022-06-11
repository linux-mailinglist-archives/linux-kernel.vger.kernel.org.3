Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BE95472FB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiFKIrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiFKIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A34383AD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654937235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJ/XB0hPB6YEke6/WY/jqhc9csftj6k56SQkV083ieI=;
        b=Vg2GM9J5FeqcQ61MOIlx+nWJcDRmLYZl5H4TEKIjGsMkR6FOu9SvqhvYjRQWUhND9mjX5Y
        xNXcjdqHGLU/bARTZJrsMc+wcvbAIutDmulmY7F0imgQduf12JNzTiBrmv6J4k+S6ZFTuV
        jtQuzY/i7kHDTUalyQlX4fCHoRCwqdE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-HFvGpZxcOb6W7lWa6yjb5Q-1; Sat, 11 Jun 2022 04:47:11 -0400
X-MC-Unique: HFvGpZxcOb6W7lWa6yjb5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C7FA185A794;
        Sat, 11 Jun 2022 08:47:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67E0218EA7;
        Sat, 11 Jun 2022 08:47:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220611183642.0a519e07@canb.auug.org.au>
References: <20220611183642.0a519e07@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the fscache tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <856785.1654937229.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Sat, 11 Jun 2022 09:47:09 +0100
Message-ID: <856786.1654937229@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Commit
> =

>   d3b63ddec3f8 ("netfs: Further cleanups after struct netfs_inode wrappe=
r introduced")
> =

> is missing a Signed-off-by from its author.

Yeah - Linus pulled it without adding his S-o-b.  I'll drop the patches fr=
om
my fscache-next branch.

David

