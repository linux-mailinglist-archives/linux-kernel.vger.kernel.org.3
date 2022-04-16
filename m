Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40694503560
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiDPIwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiDPIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:52:27 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A299F6E8;
        Sat, 16 Apr 2022 01:49:56 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BD9202CC;
        Sat, 16 Apr 2022 08:49:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BD9202CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650098995; bh=4dWL/I1aLMHTi0A6a9JPUmXHoDlp+6ZAjF2wqhO9xfI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FvfShgNKtlOCDXG86BVrxCG3dgUcSNa1CxjujVAzqRea77H9jb8dJIQ7mV//Jp+Dr
         NBO7BZqNUisWnoCSLJrTTjmsH9nhAldXwUQtQ0RXguZQlKVV0m+P2N5FpTcaCeMRos
         UtpzmpufaUOycnRvq/cnDpxogFvwoqylrMc1E3g5Xa/7yA5gz3K0kkmmgnoXOeGTV9
         0UcEMn684V4hhw5NzhpFshZeJJv6KRnuL4GR307vMW6oszAemvzlwj+rAdhcwy45pT
         VyiB5bDKJIpDSqKSYVaF452nuBwMHbEYSz+Kq95Ovbfh5OawYe9Wq2vMXoChqeUk9z
         mIeRa3g6ifEWA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-ia64@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3 v3] Documentation: kernel-parameters: alphabetize
 and misc. fixes
In-Reply-To: <20220403054822.16868-1-rdunlap@infradead.org>
References: <20220403054822.16868-1-rdunlap@infradead.org>
Date:   Sat, 16 Apr 2022 02:49:52 -0600
Message-ID: <87r15x2z0v.fsf@meer.lwn.net>
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

Randy Dunlap <rdunlap@infradead.org> writes:

> Alphabetize parts of kernel-parameters.txt. Alphabetize the "legends"
> in kernel-parameters.rst. Add a few and drop a few outdated legends.
>
>
>  [PATCH 1/3 v3] Docs: admin/kernel-parameters: edit a few boot options
>  [PATCH 2/3 v3] Docs/admin: alphabetize some kernel-parameters (part 1)
>  [PATCH 3/3 v3] docs/admin: alphabetize parts of kernel-parameters.txt (part 2)
>
>  Documentation/admin-guide/kernel-parameters.rst |   11 
>  Documentation/admin-guide/kernel-parameters.txt |  326 +++++++-------
>  2 files changed, 180 insertions(+), 157 deletions(-)

Series applied, thanks.

jon
