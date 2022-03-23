Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53744E5425
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244716AbiCWOVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiCWOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:21:27 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E937CDC4;
        Wed, 23 Mar 2022 07:19:58 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id d10so3118011eje.10;
        Wed, 23 Mar 2022 07:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=LCtVktgE+tM1dwB6vvs9xAHGeA+uCrA5P8a3RwuF97c=;
        b=Jr9QgDWM3710HQkVcJXK1tKtYWZIXXVIfdGSajSBNV43nKq2oaUtckQFJW4UzfaMOm
         a+JAU6jmR3rcQ8YvFDbddte/Z0Bu+2M5jiRrD9T7IsPRfwsLAgCkUW5QcLYs0ZW+4NkQ
         tuquJ0v+5eb9STV38Nan7uZj7td3gqM/6SOJzvUZq+/dG/teByf9WOiKQYiaIVznGaQ1
         v4VoNJNEQL2CTtHuFiwvUWCsAUuxLKaa0gVToLMvrtDdobJveWtVilkLG5xRiGrLPYMJ
         6xIB0HL0yrqEQM2fuSplWBVj/tdJRsIKS33xR6usLsIFceYsw6Lj0e1DuOKOz1A4xQ/b
         Ss9w==
X-Gm-Message-State: AOAM532pfBFlwHHOZy6ozypUUJIyW/i4q6CratebLYW9256HkDyOdusd
        VlB+C8JP0mQ7O5HnylDjs5ct2lC6QJc7TA==
X-Google-Smtp-Source: ABdhPJy6qkIrAOliQ88WXgP2REqzU/lsvhMnM1TlyKzJ/52Top/TQDHtwKvBnMjc/PumEPXeyMjfdA==
X-Received: by 2002:a17:907:a422:b0:6e0:238c:4f44 with SMTP id sg34-20020a170907a42200b006e0238c4f44mr152721ejc.257.1648045196681;
        Wed, 23 Mar 2022 07:19:56 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id e10-20020a170906748a00b006dfaff31e88sm4639ejl.125.2022.03.23.07.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 07:19:56 -0700 (PDT)
Message-ID: <1d3e9846-f092-09c6-e4ef-7a52d61613f1@kernel.org>
Date:   Wed, 23 Mar 2022 15:19:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 17/18] dt-bindings: arm: msm: Convert kpss-gcc driver
 Documentation to yaml
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-18-ansuelsmth@gmail.com>
 <e832516d-277d-6a0b-4588-b32a085185c8@kernel.org>
 <YjnOdYMS+P85pqvF@Ansuel-xps.localdomain>
 <f13fdc4b-8f45-b09f-5d58-8d2a565e2c18@kernel.org>
 <Yjr+nHBFqNqMV+v0@Ansuel-xps.localdomain>
In-Reply-To: <Yjr+nHBFqNqMV+v0@Ansuel-xps.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 12:03, Ansuel Smith wrote:
>>>
>>> If you notice the changes across the different patch, it's very minimal
>>> and 99% of it has not changed. Nothing silent just me addressing warning
>>> from the bot. About the trust issue...
>>> Is it really a syscon addition that bad? Again the original
>>> Documentation was just bad so why should we care to have a 100% 1:1
>>> conversion if it should have been not accepted in the first place.
>>
>> Does not have to be 100% but deviations should be either expected or
>> explained. Bindings are used also outside of Linux kernel.
>>
>>> The addition of this new syscon is because in the current dtsi it's
>>> there and I assume it's there as this is a global accessor and probably
>>> other driver would access the same regs (so it's also a syscon)
>>
>> If these are assumptions, then they need to be checked. If these were
>> new bindings, we would discuss/check the need of syscon. Now we do not
>> question existing properties, because they were accepted. But syscon
>> compatible was not accepted, so putting it here requires our acknowledgment.
>>
> 
> About this I have a question. If the dts already have some binding and
> the Documentation doesn't have them. Should the dts have priority or the
> Documentation?

Depends, usually yes, if the DTS is being actually used. There might be
some exceptions, though. The priority is for the ones which are correct.

Judging by current DTS, the syscon is indeed used in DTS and documented
in bindings. It might be deprecated, because one binding is saying that
mailboxes can be used instead.

Here your call to add syscon looks correct. Just please document it in
commit msg, why it has to be added (there are real users of it: Qualcomm
RPM).

> In the case where we can't prove that syscon is needed (for example), can
> we remove it from dts (and accept to have inconsistency while the dts
> changes are merged) or we should add the extra binding to the
> Documentation putting some comments about it and discussing the
> inclusion? 
> 
>> The bindings are probably pure junk, so this is not merely a conversion
>> how you wrote in commit msg. This is rework of the bindings. Don't hide
>> rework under "conversion". Conversion is TXT->YAML without any changes...
>>
> 
> Ok, thanks for the clarification. I still think should be handled with
> conversion + additional commit to add the missing part so I have to fix
> my wrong commits.
> 
>> I asked about this before and the only part you added to commit msg was
>> "clock-cells". And now I see syscon - so isn't it a bit surprising?
>>
> 
> You are right... I will just do the 1:1 conversion and put all these
> addition to a separate commit to make them clear.
> 
>>>
>>> I understand the complain about putting too much revision... But NAK
>>> this cause I'm trying to fix all this mess just because more and more
>>> problems are coming up and I'm trying to fix them. It's a bit sad.
>>
>> Why you cannot test your changes and fix them all before sending sixth
>> version? Why the bot has to test your code, not you?
>>
> 
> I'm aksed Rob if there is a quicker way to test single Documenation and
> dts but it's my fault anyway.

make -j8 dt_binding_check DT_SCHEMA_FILES="qcom-kpss"

make defconfig (or allyesconfig etc)
make -j8 dtbs_check DT_SCHEMA_FILES="qcom-kpss"


Best regards,
Krzysztof
