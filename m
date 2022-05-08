Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83F951EBF2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 07:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiEHGCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 02:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiEHGC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 02:02:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD06D38A6;
        Sat,  7 May 2022 22:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bFSxAYYpp++FHtMPzNFg1UxWCvGU+jPPSRgrVSDgdYc=; b=HO8PM132n6bOrB7zdJxcEz5dpy
        Ssh0Pr9LibvtGFxdXuxrQvXEY8Sld8NFhBecG3PXfq7jWHwRSVbOJn249nwa+C5b8RrM+461EFO4A
        ELAsZ+6ftiWZADoibbuCrYk/cufGzbaD4iGLDVDlKQGxQ4Y8zRQOyRbSmnImQQWXXjeDVeIv7xmHP
        5H6Xte/o6G5WJA8GWJeHgNWszWIRd/rHaOOyUaHees6Sp17aIuLe0NIpUEnxTzt6KchJN6qgES8M8
        W5ftfNHXxSR5C2jMCNG5OXJ+KnobPfIzIVmmvqM3HicfkqBY4NORl0BX1Mc62JwX2dfagq4vanz4f
        ctoNHQuA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnZvo-00CBc8-W2; Sun, 08 May 2022 05:58:13 +0000
Message-ID: <e15e9717-a9a3-426e-b395-45ba871f7ffd@infradead.org>
Date:   Sat, 7 May 2022 22:58:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] alpha: Fix comment typo
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, Jason Wang <wangborong@cdjrlc.com>,
        rth@twiddle.net
Cc:     ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220508030029.123056-1-wangborong@cdjrlc.com>
 <a18ecdef2efc0a5c23a85cc2a6dc17cf6e7d94c9.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <a18ecdef2efc0a5c23a85cc2a6dc17cf6e7d94c9.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/22 21:30, Joe Perches wrote:
> On Sun, 2022-05-08 at 11:00 +0800, Jason Wang wrote:
>> Remove one of the repeated 'and' in comment line 150.
> []
>> diff --git a/arch/alpha/kernel/irq_i8259.c b/arch/alpha/kernel/irq_i8259.c
> []
>> @@ -147,7 +147,7 @@ isa_no_iack_sc_device_interrupt(unsigned long vector)
>>  	 */
>>  	/* 
>>  	 *  The first read of gives you *all* interrupting lines.
>> -	 *  Therefore, read the mask register and and out those lines
>> +	 *  Therefore, read the mask register and out those lines

Looks to me like:                             and mask out those lines
> 
> Not really a repeated word but
> perhaps s/and and/then and/
> 
>>  	 *  not enabled.  Note that some documentation has 21 and a1 
>>  	 *  write only.  This is not true.
>>  	 */
> 
> 

-- 
~Randy
