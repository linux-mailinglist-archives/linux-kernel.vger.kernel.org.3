Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFBF4F0DFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 06:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377087AbiDDEZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 00:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiDDEZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:25:06 -0400
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.146.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316AF2C676
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 21:23:10 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 9C10F1989F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:23:09 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id bEFBn8A2Db6UBbEFBn5we4; Sun, 03 Apr 2022 23:23:09 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CgLJGJBzJnPgbiyezytbODN5GX3z41tdhpJwDoaReLw=; b=iGIiOuyxI81cbv1cHNavG9rMsP
        W0YrrPh2OFLRUYt+dBve9N5xoqkV6EzT2Jk+uotHWnr0TFpTiEhL8kgkioq/mHFRhfgmp3Z77eqRM
        sYPvvyTnc1Vn66xQP3TrNja48OYk+QQ7KZn4DlclCZxHEej6fTEz4arepQf+Df1SZ29dYFMIu4x9+
        T2cyJ3U2xdEsRdG6BpsgTUh20MXY69gHIRiaPU8XmNW6ePK0HPdCjQXF4wllLv/j3r77bjYSQRh0g
        5F2zOynF4roZnPjWxhRFvXnVfvG3y9GcoeVrxsFVmPb+bqruNboyVbicXkRn5mDJfjf+vSEQk7ABd
        rXMyNEMg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54712)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbEFB-002kTA-6t; Mon, 04 Apr 2022 04:23:09 +0000
Message-ID: <aba387bd-9799-e0b5-40e3-1bcb552ac74c@roeck-us.net>
Date:   Sun, 3 Apr 2022 21:23:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Oded Gabbay <ogabbay@kernel.org>, Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404022239.GA1186352@roeck-us.net>
 <CAHk-=wimc7V9mi=P+6p2nnctPYtSM55OSPVERUeJor7fkD_EVg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.18-rc1
In-Reply-To: <CAHk-=wimc7V9mi=P+6p2nnctPYtSM55OSPVERUeJor7fkD_EVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbEFB-002kTA-6t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54712
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 20:29, Linus Torvalds wrote:
> On Sun, Apr 3, 2022 at 7:22 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> In function '__nat25_add_pppoe_tag',
>>      inlined from 'nat25_db_handle' at drivers/staging/r8188eu/core/rtw_br_ext.c:479:11:
>> arch/alpha/include/asm/string.h:22:16: error: '__builtin_memcpy' forming offset [40, 2051] is out of the bounds [0, 40] of object 'tag_buf' with type 'unsigned char[40]'
>>
>> Exposed by commit e6148767825c ("Makefile: Enable -Warray-bounds").
>> Fix at https://lore.kernel.org/lkml/20220403123628.3113382-1-linux@roeck-us.net/
> 
> Funky. Apparently nobody else does that pppoe_tag thing, and this
> driver does it wrong on little-endian, which is the common thing to
> test.
> 
> Your email that you point to is a bit confused, though, in how it says
> "when building the driver on a big endian system such as alpha".
> 
> Alpha is little-endian, not big-endian.
> 

Oops. Sorry, I thought it was big endian. No idea why. I'll update
subject and description and resend.

> Now, why it apparently only warns on alpha, I have absolutely no idea.
> It should warn on other things too afaik, since that
> 
>          tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
> 
> should be visible not just on alpha.
> 
Maybe htons() and ntohs() are modeled differently on other architectures,
and the compiler doesn't see the context ?

> Weird. But your patch looks correct.
> 
>> Building arm:allmodconfig ... failed
>> Building csky:allmodconfig ... failed
>> Building i386:allyesconfig ... failed
>> Building mips:allmodconfig ... failed
>> Building parisc:allmodconfig ... failed
>> Building powerpc:ppc32_allmodconfig ... failed
>> Building xtensa:allmodconfig ... failed
>> --------------
>> Error log:
>> drivers/misc/habanalabs/common/memory.c: In function 'alloc_device_memory':
>> drivers/misc/habanalabs/common/memory.c:153:49: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>>    153 |                                                 (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
>>
>> Fix at https://lore.kernel.org/lkml/20220401151450.3414694-1-linux@roeck-us.net/
> 
> Gaah - both of those "(u64)" look pointless.
> 
> Either the thing is a pointer, in which case that (uinptr_t) - or just
> (unsigned long) - is the right thing to do, or it's already an integer
> type, in which case castring it to (u64) just do do that
> 
>          phys_pg_pack->pages[i] =  ...
> 
> assignment seems entirely pointless.
> 
> So I think the patch should also remove those pointless (u64) casts.
> 
> Yes, yes, the pages[] array in 'struct hl_vm_phys_pg_pack' 'pages[]'
> is of u64's, but casting integers like that is just silly.
> 

Double casts are quite common, though. Try 'git grep "(u64)(uintptr_t)"'.
But I think you are right, a cast to (uintptr_t) should be sufficient here.
I'll resend that patch as well.

Guenter
