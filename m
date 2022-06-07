Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677C754000B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbiFGNa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243578AbiFGNaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:30:14 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7468D02B1;
        Tue,  7 Jun 2022 06:30:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D9553734;
        Tue,  7 Jun 2022 13:30:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D9553734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1654608611; bh=W2u9aQQxO6SJYdrSFguVYAqIAT5m7QQHBXjd99OlvaM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XCwh4byadNPKxwGQ4Z72Xncd/IpBCxr6MbggoHG3k23a2wOk8ndNdQtD/hVLf+c7Y
         BteHa4QzB2kO//6nORtmYqRMfzs5N/XA947IpwXe+uaxPDZnC+3tnJc5knLjf0s8WE
         TCE9WVm5Qh9i9RF8Lrhpn/Krc/BbW4MCCR+LSET92B+ccebrjQOsf+lNzcI84p2/5H
         RlKIvsU9b0tNXk9xARgYQmpm3Mbw9KK/beLlYrPbVZj2jlYhZBuXZhvUz+4cEmDN4+
         +FU3VBLQhbKmtWxRWBlgD7f45nWy/qSK6CAlzZdP7XBS5SADahny2czjx5/1sk5qqf
         I8sKF5qzpdfhQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v2] Documentation/security-bugs: overhaul
In-Reply-To: <nycvar.YFH.7.76.2206062326230.10851@cbobk.fhfr.pm>
References: <20220606194850.26122-1-vegard.nossum@oracle.com>
 <nycvar.YFH.7.76.2206062326230.10851@cbobk.fhfr.pm>
Date:   Tue, 07 Jun 2022 07:30:10 -0600
Message-ID: <87o7z4fvod.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina <jikos@kernel.org> writes:

> - what sense does it make to have embargoed-hardware-issues.rst and 
>   security-bugs.rst live in different Documentation/ subdirectories 
>   (admin-guide/ vs process/)? It'd seem to make sense to me to have them 
>   in one common place?

Yes, I think that would make sense...a lot of stuff got sorted out into
the various guides quickly, and it didn't all land in the right place.
I'd be in favor of moving this over to the process guide, and perhaps
making a security-specific section there.

Thanks,

jon
