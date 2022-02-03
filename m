Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7594A8BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353612AbiBCSy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239754AbiBCSy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:54:56 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EFEC061714;
        Thu,  3 Feb 2022 10:54:56 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id t199so5463872oie.10;
        Thu, 03 Feb 2022 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WI5QVyMMZg/rsawgsyyanPke7qQMFGqBxarFxknUvL8=;
        b=f2US5qcesmFkC+HiaKk3b/B4AnIYEqSlfFFJAEajY5huXquw2t0/VUIVyx+rl7M4bl
         xASrKzqF/8dcF0GD8Z3TIGCKZs1xehbJiS9BdGwbm4DiGBTYgscLwrhDerSN+20M1e0T
         lLemMm/Rie0uO5Bebg68wyAGdYL0iu4q76QeP7001jsmOduOOgTNjnuoYjXULKVKWXph
         E7HKOmSMZtL9On+9Oqw5PjatOePK62U1uA/K9A/Tud6bdX33FqtCmsFxy78HnADbZHQJ
         /XGdogXeMaSjpqH+IvaLpq8rOf3K3UK5bTIMaalMVzLaBhcfXxnNKHHCwwNdQXhF4kSI
         HmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WI5QVyMMZg/rsawgsyyanPke7qQMFGqBxarFxknUvL8=;
        b=qZ4iPQgeY9mCjTGC1r+eyDMNn3f1yoNV2HPQuVjYsJkK+ke6t0DhPlZmxoK4uoK9+x
         CrxWL7nB+YxOPObxz3qkFlXfiGOAVRzty78ozBm7JU/sg4jaBAXNQFpQ56zjrplIDAp8
         Y3yfJlhTOeBVJD+1Gpl5U0PXTtHQkvYMW0lD7thaANPKbMsbAxLOCjL41FuKZBX6Ww0b
         lqZ2K1t50lbEOZ380SuCTsslsqiGg5QlXd9jc7quyHey2p7Er0Q/nzuyOp42AsUA9H6o
         AlXlkd6Wlaz9LtXau4pBcR8vxOhx24jDcHNFpy1dwNOaXGRThyojGAcrtys7bz/dSL2A
         /iEA==
X-Gm-Message-State: AOAM531FIfikFSHjJEipEoBA8CFZ42OSn6sTRFXi+w7S7cjJHuv08w32
        hJ28qAKCVMAh76a51Pud9fI=
X-Google-Smtp-Source: ABdhPJyRuuDsqTci68HC0lRLhYxn96IE6sNm3wlk17dVaZI94Ph5bpukW7RLVRSUt+qOYmAykV3J+Q==
X-Received: by 2002:a05:6808:124f:: with SMTP id o15mr8786233oiv.101.1643914496244;
        Thu, 03 Feb 2022 10:54:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b7sm19107608ooq.30.2022.02.03.10.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 10:54:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <13a9d0fd-1b2c-b9c1-24a7-ff4fc5f4b8cc@roeck-us.net>
Date:   Thu, 3 Feb 2022 10:54:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [ASUS EC Sensors v8 0/3]
Content-Language: en-US
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
 <7c8f311f-a2e4-584f-eb29-7f0d2a335e8f@roeck-us.net>
 <CAB95QARyz_sp9MoMsakfAK+PRBnVVnyOQzm2ZwJwwLE5vvAUFg@mail.gmail.com>
 <8022383.T7Z3S40VBb@natalenko.name>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <8022383.T7Z3S40VBb@natalenko.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 23:09, Oleksandr Natalenko wrote:
> Hello.
> 
> On čtvrtek 3. února 2022 4:48:53 CET Eugene Shalygin wrote:
>>>> Oleksandr sent an informal one already.
>>>>
>>>
>>> He wrote:
>>>
>>> "Given minor changes against v7, I think my "Tested-by:" should have been preserved."
>>>
>>> which doesn't mean he tested again, only that in his opinion
>>> the tags should have been preserved.
> 
> This is not what I meant, but my wording could be better, yes.
> 
> BTW, the changes were not of that kind to drop Tested-by: tag, really.
> 
>> Oleksandre, could you, please, let us know did you actually test the
>> v8 code and if so provide us with the Tested-by: tag?
> 
> Yes, I do run this version now, and it works fine for me.
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> 

Ok, based on that I'll apply the series on top of hwmon-next with your
Tested-by:.

Guenter

>>> That means that I am left with either accepting the series without any
>>> Tested-by: and/or Reviewed-by: tags, or I have to wait for some. I guess
>>> you are telling me that I won't get any additional tags, so I'll have to
>>> go in myself and have a closer look. I'll try to do that in the next week
>>> or two.
>>
>> Thank you, I understand now. If Oleksandr does not reply in a few days
>> I will send the update with another board
>> (fully duplicating information for its base variant), tested by a
>> Libre Hardware Monitor user.
> 
> Thanks.
> 
>> Best regards,
>> Eugene
>>
> 

