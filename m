Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3618506FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbiDSOP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343586AbiDSOP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:15:57 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AF3396B5;
        Tue, 19 Apr 2022 07:13:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id j70so3178642pgd.4;
        Tue, 19 Apr 2022 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3c9VdvftnzoWdGwuqhCOC9bUI0K0J9rSYfyqiSN2afM=;
        b=fWAd8cl2jmc/Bxdi9Zu2be0CuLUL9Twfu6ZbRyece8VrA16qVxDeN4WorJTOLDxRHv
         f55IZWiXayAarCHp+k6nOtsgqBUBuLvDqV03Nh1GkfyQJvmok2Wzn8eJ2rSO+kcu0mkQ
         4VDKmuFPvNsDgluNSSOk+3RTmurL9esBNangjumoCJ0CJgTFFxKYq0nratBxtPAPXDxN
         et45b8xJijJvlFwJlCEcKxa8uF77Y+83rx/ldn6eCAZPbTbqcRoWTqfLX3HheCtSvnq0
         8qN2B2/ii09PuSyWDNVbn1KRKv3jC3AEe+YFUhCIK0ZxEpCil8u4anKKPdiK9Gd5s+92
         O+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3c9VdvftnzoWdGwuqhCOC9bUI0K0J9rSYfyqiSN2afM=;
        b=5Ods7e+mPFti1r4u7SCvosU06MxXnPiGZiLqaOiImnOS1P+/0ELD37qpUiwYL/bciJ
         zom1yo2WbEqmvQFGe8ZegXkjTwa2G6woUYoBuyfn475TadOhmAp/sZ8BcB8N2btJyYmI
         MiawvCW7FVb7R0a/Y+bAu/qSnFKU5X9nL3pxmb9O62kUCUEWNQffFxYZIR0U1tF1HkUh
         MaoS6jEFZXvTBzJoJMxJd7NAU+o3j91E/JLZivIfAnqcGRUnipa1D6fPsbxp+Gc1gBAN
         kU2HyfeMz86ZgW304B2oN2eFN0b8Sa7Q5WOtTLDUqzPnvnn2eN44tbby5kKgVAaU5qxO
         i13w==
X-Gm-Message-State: AOAM532xmi5kNUUl4VKgfmvVYg3raMk69YnqlXDdS6hk+yymOOuQF535
        ESYCazySSfhD7dV9w95PFJ4=
X-Google-Smtp-Source: ABdhPJxot1TBDIfRbsfd75H0bwlDvRcfvNxXqtVyDCqz6F5Ft5Xdy7QKmrK0yznwSFhj17EppqbR7Q==
X-Received: by 2002:a63:e315:0:b0:3a9:efa0:18a with SMTP id f21-20020a63e315000000b003a9efa0018amr9306970pgh.33.1650377592324;
        Tue, 19 Apr 2022 07:13:12 -0700 (PDT)
Received: from ?IPV6:240b:12:16e1:e200:9658:2d0f:e000:a321? ([240b:12:16e1:e200:9658:2d0f:e000:a321])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm18093287pfj.152.2022.04.19.07.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 07:13:11 -0700 (PDT)
Message-ID: <67dca8f3-318b-808e-fac1-e9e69b87a027@gmail.com>
Date:   Tue, 19 Apr 2022 23:13:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] docs/ja_JP/index: update section title in Japanese
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org,
        Tsugikazu Shibata <shibata@linuxfoundation.org>
References: <20220419081813.6838-1-fujimotokosuke0@gmail.com>
 <5a9c77ab-8627-b8e2-67bc-e7bd260654de@gmail.com>
From:   Kosuke Fujimoto <fujimotokosuke0@gmail.com>
In-Reply-To: <5a9c77ab-8627-b8e2-67bc-e7bd260654de@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yokosawa-san,

On 2022/04/19 20:52, Akira Yokosawa wrote:
> [+Cc: Shibata-san, who originally picked the English title]
>
> Hi,
>
> On Tue, 19 Apr 2022 17:18:13 +0900,
> Kosuke Fujimoto wrote:
>> Update section title "Japanese Translation" in Japanese instead of English
> Please explain _why_ do you think Japanese title is better.
>
> I think you want it to be consistent with other translations.
Yes, this is to keep consistency with others. I will add the reason to 
comment.
>> Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Akira Yokosawa <akiyks@gmail.com>
>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> Cc: linux-doc@vger.kernel.org
>> ---
>>   Documentation/translations/ja_JP/index.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/translations/ja_JP/index.rst b/Documentation/translations/ja_JP/index.rst
>> index 20738c931d02..558a1f5642b0 100644
>> --- a/Documentation/translations/ja_JP/index.rst
>> +++ b/Documentation/translations/ja_JP/index.rst
>> @@ -5,7 +5,7 @@
>>   	\kerneldocCJKon
>>   	\kerneldocBeginJP{
>>   
>> -Japanese translations
>> +日本語翻訳
> "日本語翻訳" sounds a little bit redundant to me.  I'd say "日本語訳".
> What do you think?
Yes, it sounds better to me as well.
>          Thanks, Akira
>
>>   =====================>
>>   .. toctree::

Thanks,

Kosuke

