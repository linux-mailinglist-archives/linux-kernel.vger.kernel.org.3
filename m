Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993F64E3F07
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiCVNBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiCVNBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:01:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD4285BC4;
        Tue, 22 Mar 2022 05:59:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so2319962wmb.4;
        Tue, 22 Mar 2022 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qO/1Rt3njaG7Cco/tf6+2tDr5ALwB1QCxifmvtUKji4=;
        b=UqxL2xUbVS1QuLy5m+nvhpsu4YOvbeZnNHuSXt2w861LqKPdoD3VUd9ULsyiZde43T
         LjLRlM6kRG4U804KLzY/F4e+2ZdLhhEiSfJLARkecUXObwAA2RofhR+UIin1hoNEfkQI
         yJgrZ+1xWphWQVdhwGkESDqgG6Uw7B75KzlHFgCsu5M21chFC3WPiqDW4RiIEQDCWupz
         Zv8GTRE/wwaQ5lGIdzVgJvUZEwsiNaSJGzTA1GkJQ06K9UWV8ldRPsoz9WslixCEL6Ve
         /fIlnVkhgoXpaz8zUWqDCVIFSoMDdlXi6GAyDGggxZ3s93WiZ6erEa7UCZ6lF5Tz0Gol
         K1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qO/1Rt3njaG7Cco/tf6+2tDr5ALwB1QCxifmvtUKji4=;
        b=oPb5P9gb6XL1WCYmJMTziVopUhuvorh7xQfonvMO60eOmqm+Zes20ogurZSSsgoKZr
         PfbIs7lSXhO5NubSNIgv5bcU9+9TVlP726R3GTfpBbFXmcAgMIrtYj2cs/ae9Z4XxW1o
         b21bAQbSQpPYEYkcYgy3Xghrv6rzn7tWDwwhs8YmaJ5k3ECnzHpq8xygjBeyzpp+wA9k
         6+CqnMO3bUb1P+Tw05oEX+7P5RLHBNMYvJ/vxmMuTXq3fnagFRGQ6l660GeKzdjPRyON
         Vc5iGCoEI+DWvrXCgpVY9Z3YMqslYr0btFF36vsZrP9KrydRc8Gn6OWohJ4vsnPrOt8C
         L1uA==
X-Gm-Message-State: AOAM530uWkl3tJXAxxHcQVJzFskUHm0IZOBf/67aHXE4SAvr6G56XzQK
        Om9Q3eyO3qPZzHMUvdZLSBk=
X-Google-Smtp-Source: ABdhPJwn51IFuKX1TYbQ/ZSHl3GYWfbHAG3LmMAgE9tK5a+XKZsSVlicmx2Pr/Uz5jTvjAJO0giNpQ==
X-Received: by 2002:adf:dc92:0:b0:203:f998:7f10 with SMTP id r18-20020adfdc92000000b00203f9987f10mr15660124wrj.567.1647953986596;
        Tue, 22 Mar 2022 05:59:46 -0700 (PDT)
Received: from [10.168.10.170] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id g6-20020adfd1e6000000b0020581602ddesm6054wrd.67.2022.03.22.05.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 05:59:46 -0700 (PDT)
Message-ID: <456bc9a8-cb58-c9ef-b1b3-3671ac34a2dc@gmail.com>
Date:   Tue, 22 Mar 2022 13:59:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [patch] console_codes.4: ffix
Content-Language: en-US
To:     nick black <dankamongmen@gmail.com>
Cc:     "G. Branden Robinson" <g.branden.robinson@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
References: <YeEc2pYvKEckcAmv@schwarzgerat.orthanc>
 <CAN4uE+p-uKzHNYry2YhCMfEFBQ2jUqpDAGx=+eha01w-L4fAjg@mail.gmail.com>
 <20220320160217.gws42lklp6ishzub@localhost.localdomain>
 <fd0b3fea-4b40-ffba-442f-00908a5335a9@gmail.com>
 <Yjg3jXCAsjQVHJAi@schwarzgerat.orthanc>
 <809c40c4-068b-8296-57d9-024e6623362d@gmail.com>
 <YjnHmiYL50SqHCW/@schwarzgerat.orthanc>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <YjnHmiYL50SqHCW/@schwarzgerat.orthanc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 13:56, nick black wrote:
> Alejandro Colomar (man-pages) left as an exercise for the reader:
>> Patch applied.
>> However, it's weird:  I had to apply the following to your patch before
>> applying it with `git am`:
>>
>> /^diff --git/s, man4, a/man4,
>> /^diff --git/s, man4, b/man4,
>> /^--- man4/s, man4, a/man4,
>> /^+++ man4/s, man4, b/man4,
>>
>> I'm curious, how did you generate the patch?
> 
> i bounced this out from ~/Mail/sent, and have no idea how i
> originally created it, sorry =\. i'm assuming git email-send?
> 

Yeah, I guessed that you used git format-patch && git send-email, 
especially since there's a git version at the end of the patch.  The 
weird thing is that git always (AFAIK) writes (and needs) those a/ and 
b/ prefixes, so... I don't know.

If it repeats, I'll try to investigate the reason.

Thanks!

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
