Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B65B2535
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIHRzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIHRzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:55:47 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E46052469;
        Thu,  8 Sep 2022 10:55:41 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id m9so11197674qvv.7;
        Thu, 08 Sep 2022 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Jc/8Lp023IQBBSQa2E724PJ0qO0q2fz2v7I9F5uTSBw=;
        b=EfkANUpCcMUO1P/+tSFa4nOco6Wxf4pznC1d5Yn8dc8IQzR82MxG9tifUggMv2NywZ
         fiB8O8A4mxg+Z5Tdw80tKhs2hm8o1QKBgMimlk2UM8Sf37ZIaxR9NbuBaKMfYTZt4soZ
         Os6byjigbsTPqs2nzXdwG78ns7oesl4p6vnKWLcOucRl4m5ozvl6FNekx67Ur3rtV6qk
         wn1PJ3uw8U0LG7tjusqN/HGK/s2qg5N5zTrMWS16P78gVo0Hx0XBeOoqjvPtXy0Ok+Fu
         flISZA33CBF7SO7kZXoF0WVgirGi/0skf362aMPIml331dNTRlroD0wvvnS0wDMQZ4Bn
         LYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Jc/8Lp023IQBBSQa2E724PJ0qO0q2fz2v7I9F5uTSBw=;
        b=J5lVxxIpjRhEdWy94l87s+iiu6LS/VYaPr5BmLMNE8sOHDuNW15HPFzthH0b3F6sb2
         1uhnaVgslL5e+amblooQinEKwtxU0aRmPeBWvD3uieXmlLZR4KNwFiu8xDjSTeB6eTiw
         AILfhc0vpe2fScLh5dlu6LZEebV/ZwTQhvEmPdVwvzKo6R8UcTzxzOyVqq0I/8yoWXb8
         Q0fgyb1v4z9V2qFsvO8Zq73ZbeNKpvFNOT5LgE5o8vrfThD2uwZQjED9w1vFq/j+fcCk
         QqQT02y5sJoDUtdN2bs+cC8StFr2YJlkRZ5LNtiu00vxOKYyDjvSn1iTQkeUAa8BSos+
         1RhQ==
X-Gm-Message-State: ACgBeo2D91dfYhh6/TFV9oXVT3qApcjiyJZxwQnSF6W3LhA3u+gvkBuy
        auTTMsXMqvZ0OA4h4eBieqjjhE8qkOs=
X-Google-Smtp-Source: AA6agR6SZcGlEsAHpsKTCGUg2ePzkv6zzCj/ZzoKQy+UOvvKn8mKRGVkVHzZJoMqnpYLE+i0YX7Ljg==
X-Received: by 2002:a05:6214:20e5:b0:4aa:b01f:471f with SMTP id 5-20020a05621420e500b004aab01f471fmr8494242qvk.38.1662659740566;
        Thu, 08 Sep 2022 10:55:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:e04f:ce6d:5ddb:39bc? ([2600:1700:2442:6db0:e04f:ce6d:5ddb:39bc])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a268700b006cbb8ca04f8sm3364199qkp.40.2022.09.08.10.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 10:55:39 -0700 (PDT)
Message-ID: <c0c66918-f55e-83e4-edea-b2d32fdb27a7@gmail.com>
Date:   Thu, 8 Sep 2022 12:55:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
Content-Language: en-US
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907230709.271889-1-danielwa@cisco.com>
 <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
 <20220908003510.GE4320@zorba>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220908003510.GE4320@zorba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 19:35, Daniel Walker wrote:
> On Wed, Sep 07, 2022 at 06:54:02PM -0500, Frank Rowand wrote:
>> On 9/7/22 18:07, Daniel Walker wrote:
>>> This warning message shows by default on the vast majority of overlays
>>> applied. Despite the text identifying this as a warning it is marked
>>> with the loglevel for error. At Cisco we filter the loglevels to only
>>> show error messages. We end up seeing this message but it's not really
>>> an error.
>>>
>>> For this reason it makes sense to demote the message to the warning
>>> loglevel.
>>>
>>> Cc: xe-linux-external@cisco.com
>>> Signed-off-by: Daniel Walker <danielwa@cisco.com>
>>> ---
>>>  drivers/of/overlay.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>>> index bd8ff4df723d..4ae276ed9a65 100644
>>> --- a/drivers/of/overlay.c
>>> +++ b/drivers/of/overlay.c
>>> @@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>>  	}
>>>  
>>>  	if (!of_node_check_flag(target->np, OF_OVERLAY))
>>> -		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>>> +		pr_warn("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>>>  		       target->np, new_prop->name);
>>>  
>>>  	if (ret) {
>>
>> NACK
>>
>> This is showing a real problem with the overlay.
> 
> What's the real problem ?
> 
> Daniel

A memory leak when the overlay is removed.

I'll send a patch to update the overlay file in Documumentation/devicetree/ to provide
more information about this.  If you don't see a patch by tomorrow, feel free to
ping me.

-Frank
