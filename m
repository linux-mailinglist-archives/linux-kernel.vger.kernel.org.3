Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E35553F59B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 07:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiFGFmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 01:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiFGFm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:42:28 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E22033E39;
        Mon,  6 Jun 2022 22:42:24 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id m20so32875686ejj.10;
        Mon, 06 Jun 2022 22:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jG5R0zb9PynKCeHbyahXy5XvhO7UDwbT1uGHecSuYDM=;
        b=VwJZXtgjbVR7y96yPTdRFEvDP+LErWOBvYUW8CkY7tV/64yo1dqe5YckNhGU0U0+4m
         IokucpmsOhx2hAJwgupLzRvZRquxyASzlgUZkoOu8PC51/X7TV5WcZ0fYOFAf1+GzSNl
         DGjM3+8WSM+QhSzLLT2WFcgURouoA8ji5SA2MympMjaAPiVLsSHOyJAAm1Wuo7BR7lhr
         72SYXlFIK8HR4mTUtRPGBKAVJph+jGwaMseUnZcxi9tH7tmFPPt+3BnIwArrlDr2CeYA
         8887kRXoMLID5eY52DW96wyYM/N5Jv4AcjjyzmGplhoru/N1RMZla3CZS54Wx2hNO47u
         JoPQ==
X-Gm-Message-State: AOAM533ep7rCLU+Tb5JXIrA3etIK+TN90VE7k52qJs5AYg4D0TmAjINx
        RtVHt/fT+jUQpEqvHBhMOE+na/I4+5w=
X-Google-Smtp-Source: ABdhPJy5ogW8XnqElq0MJ4+csXjtuj6bo+OfXlM8WKgh1aJYJhrSOdGrMCWgL8a/7ihPyHouzrBI4A==
X-Received: by 2002:a17:907:971f:b0:6ff:2d30:4b37 with SMTP id jg31-20020a170907971f00b006ff2d304b37mr24700997ejc.7.1654580542441;
        Mon, 06 Jun 2022 22:42:22 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id x11-20020a056402414b00b0043158c608e4sm2976559eda.27.2022.06.06.22.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 22:42:21 -0700 (PDT)
Message-ID: <4d4549ef-f8f8-d0cb-6d27-e6200aa14048@kernel.org>
Date:   Tue, 7 Jun 2022 07:42:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] tty/vt: Makefile, add --unicode for loadkeys
 invocation
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220602083128.22540-1-jslaby@suse.cz>
 <20220602083128.22540-2-jslaby@suse.cz>
 <CAHp75VfsR6sVwO9iF6RA0bhVjMF1jC1_JEkv106TubPgL_m8YA@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAHp75VfsR6sVwO9iF6RA0bhVjMF1jC1_JEkv106TubPgL_m8YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 06. 22, 16:35, Andy Shevchenko wrote:
> On Thu, Jun 2, 2022 at 12:30 PM Jiri Slaby <jslaby@suse.cz> wrote:
>>
>> For a long time, we generate unicode tables using loadkeys. So fix
>> Makefile to use that flag too.
> 
> generated

We still do, but I didn't even know there is even a rule for that ;).

> Does it make sense to add the Fixes tag?

I don't think so -- I don't think anyone ran the rule in the past decade 
:P. I.e. it'd be pre-git anyway.

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>   drivers/tty/vt/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/vt/Makefile b/drivers/tty/vt/Makefile
>> index fe30ce512819..b3dfe9d5717e 100644
>> --- a/drivers/tty/vt/Makefile
>> +++ b/drivers/tty/vt/Makefile
>> @@ -30,6 +30,6 @@ $(obj)/defkeymap.o:  $(obj)/defkeymap.c
>>   ifdef GENERATE_KEYMAP
>>
>>   $(obj)/defkeymap.c: $(obj)/%.c: $(src)/%.map
>> -       loadkeys --mktable $< > $@
>> +       loadkeys --mktable --unicode $< > $@
>>
>>   endif
>> --
>> 2.36.1
>>
> 
> 

thanks,
-- 
js
suse labs
