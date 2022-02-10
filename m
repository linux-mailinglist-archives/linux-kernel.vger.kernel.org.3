Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279C34B0282
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiBJB5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:57:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiBJB4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:56:08 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B4D2B6B4;
        Wed,  9 Feb 2022 17:45:51 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 82BA42C1;
        Thu, 10 Feb 2022 00:29:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 82BA42C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1644452995; bh=JeAPbfW2n6bSXcS12/5ZU0UMBn33nmdtlOjKnwSEXYI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rXNFe172Tnb8y40rzYS6eEF0rqWLAAs96fxoear4HGMmRX1ZnNk9UqCglGOg+3lZ+
         8v16sbsGVmIHRmPvvH+hKOnaGVSrrrn5XxKfcqVjUZYiM6gL4qjZofPWQTshjY5A8P
         Zkd513+59JDe3owTC8qSwSsZgC5xJ/wF7otnIT1Bn5yvQFRXV9Fo9K9+G6Z58ixzU9
         i24IKei5rs7g5Vp/7o8g8UXWdydMVlesWkD76QLmX7LNuF2cG1h7CQD1i4ZY4ALUsj
         djOxGFWQeD7JM3NQ48IZhaHxOcl9R6GNsgATL7HfqDGl0C0o6EAmp8Edr+J0Sc7Nmz
         WildtHoiciIaw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2 0/4] docs: sphinx/kfigure.py: Improve conversion to PDF
In-Reply-To: <3cfe6cb0-67c7-bd12-0a3c-a609f5341a32@gmail.com>
References: <e01fe9f9-f600-c2fc-c6b3-ef6395655ffe@gmail.com>
 <e545803a-8f09-f0e7-4ca0-16b673ef1796@gmail.com>
 <20220114094535.5bb9ba94@coco.lan>
 <e03de287-4eef-8a68-89f3-8614db66a74b@gmail.com>
 <87bl0c7l79.fsf@meer.lwn.net>
 <3cfe6cb0-67c7-bd12-0a3c-a609f5341a32@gmail.com>
Date:   Wed, 09 Feb 2022 17:30:38 -0700
Message-ID: <874k57ef69.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> On Sat, 15 Jan 2022 14:17:30 -0700,
> Jonathan Corbet wrote:
>> Akira Yokosawa <akiyks@gmail.com> writes:
>> 
>>> We are in the middle of the v5.17 merge window, and I think of this
>>> series as a v5.18 material.
>>> Which means it won't be merged into doc-next until v5.17-rc5 or -rc6
>>> (mid March or so), unless Jon thinks otherwise.
>> 
>> I'd rather merge it rather sooner than that if possible; 5.18 stuff will
>> start going into docs-next shortly.
>
> Jon,
>
> Hearing no objection since mid January, I think it is time for you to
> merge this series into docs-next.

That has been done - thanks for your work on this!

Since you seem to have a reasonably good understanding of the
PDF-generation side of things...I noted as I was testing this work that
we are still getting the "restricted \write18 enabled" messages.  I
asked about this years ago, and nobody seemed to have a clue of what was
enabling it.  I'd *really* like to turn that off if possible; do you
have any idea what's going on there?

Thanks,

jon
