Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A756F4BABB1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245060AbiBQV0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:26:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbiBQV0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:26:10 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E4980227;
        Thu, 17 Feb 2022 13:25:55 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b35so6045013qkp.6;
        Thu, 17 Feb 2022 13:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KMFuxuk03fCSFsGh1kSJQRwXBhWVHJQbdI9sh3/6j9A=;
        b=OQLFMrEDM/2zBL1GhNQX7Ep77Dbfysoac5IcRFB9mdiPAWf9JMAu/S5fyCEXS58JeP
         bv1RxMBwbzaefx+B1mFnYlZ2WuIfY/LTb4xlPVA6rMn+4trOHclwqCDWMnQgwOjdz0AP
         SefWRfxcFOAfBZtOGQsv+D2F7EDtF6U5l9hjay3hskdY7fU7M2k7w1rtRr++72lSKVYg
         +nGhlyA+qY3WM0oDvGNeNS53hS2UJTplbuwYgZxIDMDvqRt6OyEg+69zy+m0k8pA1R9J
         Odm7UEYI0bTKup6Ibta55MZV/RWnSyyxhc4r3i1xof88S28vdOzBm1q/q2qkzfTTGt94
         v53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KMFuxuk03fCSFsGh1kSJQRwXBhWVHJQbdI9sh3/6j9A=;
        b=f5mCr3TKab0us3ExgooykhDllGt3/Xv6Gp1zfUV8gX8MV7pr3TOVPsFHHhp5ZHvmXV
         2yhwLCOJWolwprzKqQdAQN6v1ZfqeuUnkrTDqcPzemlG8ml6TtWHSzyi5xP+ssQOfeEb
         FaGUAH2N2/s7cA3fioCWAb0Xr1poqggWRBaLLIX6iSJrxSpoBATJWyYGTyyMXd8PyVAx
         yuEvfFsjiykmW3t50MVJ47UNkOd0NXUs8ZThrkkUqXJT0u+zhfNJrLeqAhpYLGHKDSrC
         VaeCRYb5Da1EquYBSTCVeYxSF9C1dmy7mzI4u/wz9YRC6k/EGlFKdvH68P/iklAITPOK
         iaOw==
X-Gm-Message-State: AOAM531jkO3J0RUS2VQoKffhTCAaH7W+lMl83rdfItYL6gVcSEXcUyvu
        ffkUDZHBn52KPppsJM9sKvE=
X-Google-Smtp-Source: ABdhPJwSKzgs8mdR8C62N3+17pK2x3y1iAvtl94tQ+1L+wNkegVQus1Avu2yhcfRczcDHv9KhLRuUA==
X-Received: by 2002:a05:620a:d4c:b0:47d:b38e:7a8f with SMTP id o12-20020a05620a0d4c00b0047db38e7a8fmr2894989qkl.48.1645133154947;
        Thu, 17 Feb 2022 13:25:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g20sm21525559qko.27.2022.02.17.13.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 13:25:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <791af285-ad53-625a-8d3a-2be8d0022c75@roeck-us.net>
Date:   Thu, 17 Feb 2022 13:25:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) do not print from .probe()
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220217072340.2472987-1-eugene.shalygin@gmail.com>
 <bf18f96a-b9ee-43f0-8b53-fc7d4aa6cf39@roeck-us.net>
 <CAB95QASiF=mXcUoBsOwKvtZ8KmVYgNd1bP-5+e0WYifcEzK55w@mail.gmail.com>
 <a8e9e6f1-e7a0-d40d-8065-b72f60c72a32@roeck-us.net>
 <CAB95QATVnZMQLCU_eTr7=ASVmJ+aYayQGJ0xZ=OtowdhPZQKSw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAB95QATVnZMQLCU_eTr7=ASVmJ+aYayQGJ0xZ=OtowdhPZQKSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 11:49, Eugene Shalygin wrote:
> On Thu, 17 Feb 2022 at 20:33, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 2/17/22 10:43, Eugene Shalygin wrote:
>>> On Thu, 17 Feb 2022 at 19:26, Guenter Roeck <linux@roeck-us.net> wrote:
>>>> Looks like you did not run checkpatch.
>>>
>>> I did (0 errors/warnings/checks). What needs to be corrected?
>>>
>>
>> Interesting. It appears that the continuation line in the declaration
>> confuses it. Otherwise you would get:
>>
>> WARNING: Missing a blank line after declarations
> 
> Added in v2, thank you!
> 
>>>> Either case, I think you should just drop this function In probe:
>>>
>>> Yes, currently that function is tiny, but some tests with motherboards
>>> from other families are done by users and if I add other families, the
>>> information required for each board model will grow and in that case
>>> I'd switch from dmi_system_id array to a custom struct to define all
>>> the board-related data at at the same place, and to save some space in
>>> the module binary, as unused parts of the dmi_system_id array already
>>> take a quarter of the total binary size. So, the function will likely
>>> get some more code soon.
>>>
>>
>> Hmm, ok. Wouldn't you still need some kind of dmi match ?
> 
> Of course, just not via dmi_first_match():
> https://github.com/zeule/asus-ec-sensors/blob/feature/prime-x470-pro-no-dmi/asus-ec-sensors.c#L787
> 

!strcmp(), and, yes, dmi functions can return NULL.

Guenter
