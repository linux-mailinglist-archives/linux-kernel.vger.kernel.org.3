Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E162859F9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbiHXMXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiHXMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC88B2F0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661343801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t3WTpz1ar/Qn+iZH1OQNw0mBDPLfHOW3HHjeRsWTnIg=;
        b=QS4QVXZ0mtYRBc0TAvZyN+q8/Ehb52ijjRDSVyg33jnpiWw0ixDQXRiSWsMFcuP1C8AlSp
        l5KeAwKL8FPtza77qO+njv5kZ8oiZm8a8UdXRFBr7Y/3I0vJi34BIQ80kpK1dKnHXWUzIQ
        SUMSFeuUvWJFZvBkxSqh14Ajh1ya/9o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-XPsORhrhMiSG7PIMsjViCg-1; Wed, 24 Aug 2022 08:23:17 -0400
X-MC-Unique: XPsORhrhMiSG7PIMsjViCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71899101E9B6;
        Wed, 24 Aug 2022 12:23:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BC7AC15BB3;
        Wed, 24 Aug 2022 12:23:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <000000000000d082f105e6f93705@google.com>
References: <000000000000d082f105e6f93705@google.com>
To:     syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
Cc:     dhowells@redhat.com, linux-cachefs-bounces@redhat.com,
        linux-cachefs-owner@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, mudongliangabcd@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4020340.1661343794.1@warthog.procyon.org.uk>
Date:   Wed, 24 Aug 2022 13:23:14 +0100
Message-ID: <4020341.1661343794@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com> wrote:

> This bug is marked as fixed by commit:
> fscache: fix GPF in fscache_free_cookie

The code that was buggy got entirely removed and rewritten, so the fix is
obsolete.  How do I communicate that to syzbot?

David

