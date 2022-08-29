Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B995A52C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiH2RKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiH2RKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:10:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7433A4F6A4;
        Mon, 29 Aug 2022 10:10:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 78BFD2E0;
        Mon, 29 Aug 2022 17:10:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 78BFD2E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661793028; bh=6RcwsS4OrANagoYHogQySR2/On902/U+jByX/Y83jHM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iwwgebhZGE8Y//Z8xiIjQHD2CvwzGZKIc2kfO5RWCTXXLGkcs/9jAKQ0zJ3Q0n1se
         rT8lY+gjbJ37vPzEJl5JtbE7lSGiR+kCZ71MMpsGEwykvgFUCmYckwC3HjCv/ECFX6
         IGlIsA8aL7afumMMWJ8RG79PYHKE+B1Z2AOWRBrgm3r5ODMjJqvtyleYkJlggRpzta
         N10H1mMa1TJMj50R76kb14HL54isbjFgn45N5mappruTUc+C2N48+CGH6e6U4VB/2R
         DecFAdWM3i69/Smh9GGHI1k0bfcDHcoWUv3uEjXVgzyMavdXKoBuYM+xUpq7TLnB1+
         cTBt9wGUcOhGA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [RFC PATCH 0/2] Rework the kernel's README.rst
In-Reply-To: <87czdpb598.fsf@meer.lwn.net>
References: <20220720041325.15693-1-lukas.bulwahn@gmail.com>
 <87czdpb598.fsf@meer.lwn.net>
Date:   Mon, 29 Aug 2022 11:10:27 -0600
Message-ID: <871qszou0s.fsf@meer.lwn.net>
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

Jonathan Corbet <corbet@lwn.net> writes:

> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
>
>> As far as I see, the README.rst file in Documentation/admin-guide/ covers
>> three rather outdated (or subsumed) aspects:
>>
>>   1. mentioning that it is possible to "run a.out user programs with this kernel"
>>
>>   2. how to report a kernel bug
>>
>>   3. the explanations around the use of LILO as a boot loader
>>
>> This patch series addressed the first two aspects; the third one simply
>> first needs some more experimenting/experience on my side to update
>> the description of the setup with a GRUB boot loader.
>>
>> I am happy if anyone else contributes or helps with this rework task on
>> the third aspect.
>>
>> I am also adding Linus as recipient, as he seems to be the original author,
>> i.e., in the text, 'me' refers to Linus.
>>
>> Please let me know if you are generally fine with this approach, and
>> if there is something on the other documentation to be done to get this
>> patch accepted.
>
> The changes seem fine to me; I'll apply them after the merge window if
> nobody objects.

I guess I've given people enough time to object :)

Patches are applied, sorry for taking so long.

Thanks,

jon
