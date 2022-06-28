Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7B255E81F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347256AbiF1P0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347190AbiF1P0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:26:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ABF2DAA3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:26:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i25so12706625wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vHL7KLG7cNuB7LCeGAkW01vH5AeHqBrHUv1IstKU05Q=;
        b=G/lrcJnISuX92SQ+iq8Fv8dYzQO9R72BfpagBmEOi8ngHAQNAOTDrcoKNScmK3DnOz
         io06T+YiFAkKhPc42RDQ/rqHyaC/yVa8sAFk2QkjQvwUydzOBgZHXQwZuIJIN13kDgG5
         iPO3AVOjd+v78xfoUsPuMADZA5UzKM/CbJ2xX59v9oHhi4s+uXSJeVPYqF2kNRW3GgXI
         MYXT0+vM7agOcZ1esrJPUW9n785ddjsPA/l4m0EOsA/sTqvgmLiOOOcn9S8E+70BcOJr
         NmBhkNE5lxe4xbdCDWtgtpiX71HiRSjXuZifF6LnjV42gVazBha68w/qzjKIzhJNzpBg
         ciRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vHL7KLG7cNuB7LCeGAkW01vH5AeHqBrHUv1IstKU05Q=;
        b=flZEA8izaoF18nLTfE1tOwJROfrj+6HbAv0sM5w86igqHasgXh4kq1aCSHti6kFcyN
         1Vl/oTQTUB+oTyTFLLuIK3kGwXQ2HoshMnA1qkLZSdtKnxpMtobVfSLg7gjf7x5Rh4lh
         CbFducPCDFbqhGrWIELuOdrzmOOiBQtgDvOrSMVtYzFW9pEI1Hz3KQgj/k/5WON+dY1Y
         kJcdm1OlSgh6xQ2a7Ya8qFxeoZjFuLLMgwrj63kSpAKTn81aEkZ/f7mWmrBS9zPt4NfJ
         v82XWoWsbnObz4bfbhvYs8LIMFErukLo7HouijETb2zKSv8DgGJUpfi1SCY5SB6KLE3V
         ulng==
X-Gm-Message-State: AJIora9epMF8XCC2gS5sdVydiGs4yq2jHEHU+9VOlQ1DUNkOF/5fC5jM
        BQJs1fPunD/wWw/iknARNcgGdA==
X-Google-Smtp-Source: AGRyM1uImHgo1CFyv3j+ARJwngGN5DnquV/SQpht6gc3qTPcHnrSKpRMhocjL0T1LMvu/CHIwwBECw==
X-Received: by 2002:a5d:6da9:0:b0:21b:bf88:1ab0 with SMTP id u9-20020a5d6da9000000b0021bbf881ab0mr16293580wrs.66.1656429967115;
        Tue, 28 Jun 2022 08:26:07 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g13-20020adffc8d000000b0021b99efceb6sm14057462wrr.22.2022.06.28.08.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 08:26:06 -0700 (PDT)
Message-ID: <0603d0e5-df0b-f47c-4391-b0860b07c13a@linaro.org>
Date:   Tue, 28 Jun 2022 17:26:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] thermal/sysfs: Remove cooling device sysfs statistics
Content-Language: en-US
To:     Wei Wang <wvw@google.com>, linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org
References: <20220601151441.9128-1-daniel.lezcano@linaro.org>
 <20220601151441.9128-3-daniel.lezcano@linaro.org>
 <be8395e3-98d7-7a8f-7153-c491b22d4463@arm.com>
 <cb35e356-bc90-2a67-6983-1a4c3a0ea62d@linaro.org>
 <eada018c-b857-7946-ae4b-2532e6866a45@arm.com>
 <CAHRSSEz9ExOgvByycztKYf1ncxCKeoy3uHuyQcnUC1r5nujc2w@mail.gmail.com>
 <0ca654c0-d7b4-b955-7e9b-542452659694@linaro.org>
 <CAGXk5yqCNUpGpHkecVP8U=ys9NF6dJAMu6R0E+jpgvcSVFN+Ug@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAGXk5yqCNUpGpHkecVP8U=ys9NF6dJAMu6R0E+jpgvcSVFN+Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2022 08:02, Wei Wang wrote:
> On Fri, Jun 3, 2022 at 4:04 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Todd,
>>
>> [adding Wei]
>>
>> On 02/06/2022 21:02, Todd Kjos wrote:
>>> On Thu, Jun 2, 2022 at 2:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> [ ... ]
>>
>>>> I see, it makes sense. Let's see if Todd and Android folks don't
>>>> use this thermal sysfs stats, so we could remove them.
>>>
>>> Android HALs do use the thermal sysfs stats. debugfs isn't a viable
>>> replacement since debugfs must not be mounted during normal operation.
>>
>> Thanks for your answer.
>>
>> I'm curious, what is the purpose of getting the statistics, especially
>> the transitions stats from normal operation?
>>
>> There were some complains about systems having a high number of cooling
>> devices with a lot of states. The state transitions are represented as a
>> matrix and result in up to hundred of megabytes of memory wasted.
>>
>> Moreover, sysfs being limited a page size, the output is often truncated.
>>
>> As it is automatically enabled for GKI, this waste of memory which is
>> not negligible for system with low memory can not be avoided.
>>
>> I went through the thermal HAL but did not find an usage of these
>> statistics, do you have a pointer to the code using them ?
>>
>> Thanks
>>
>>     -- Daniel
>>
>>
> 
> Sorry for the late reply, trying to catch up on emails after sick
> recovery. We use it for stats collection to understand thermal
> residency, and it is not in the HAL code, we don't use the transition
> table heavily though. Are some of the devices having too many cooling
> devices? Can we have a config to enable stats for a given cooling
> device?


The stats table is bogus. As soon as the combination of the states leads 
to a size greater than a page size, then the result is truncated.

As the cooling devices is also abused to mimic power capping capable 
device, we are ending up to 1024 states sometimes.

Moreover, having the option set also create tables which take MB of 
memory for nothing.

The option only enables the stats for all the cooling device stats.

As you mentioned, it seems to you are using the stats for debugging 
purpose. The debugfs provides the same information, except it does only 
show the transitions would actually happened and we are no longer 
limited to a page size.

Would it be acceptable to remove the sysfs stats ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
