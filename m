Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B433857E521
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiGVROv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiGVROt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:14:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D84558F2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:14:48 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a10so6183983ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eJgi1GW66h7gj18ZlW88+UsGgeLNT88IMnndIh1ADtw=;
        b=XsajXIe50to+kZLYwUSITaq6YT4n5G6Tf/9xNjIOHAWzqSKs5BWDtVyC99h2Nx3Lac
         BeRwAK+BnZj1DGSJPa0v4Y9YGMWv6GbJ3SgGifmb3h7L/scJi7G3KrzRr/o/rvmbvlHI
         MlN/fPATnf6aeCELo8MqPCnxrfjya2pXGCBvrU8ioFHiUz3wkKMUNXkDdHhwRo5Dwps9
         Z2F6YXOrYEvM8UGmdXoFVWEjsgjR19Q9TR4lWBXyHs2K6f78jQ7YFw9jUun0U0DNZCXJ
         X6oNfo2E79wvcaebDeeZmWEHyrBAKn7Ylpbrzq26PvAXOcOB3nZGo4wsFPzU1jdjFIZ4
         bXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eJgi1GW66h7gj18ZlW88+UsGgeLNT88IMnndIh1ADtw=;
        b=CuF3kJclpW5IRtRdqiOkXbi7EaBtiryBdAiRixXmOX3bTyuWrEu53FfjntLXdVoOZv
         cUFAAEfHNQtlIkc6NdEkSnOoNe+HBDRmV89vq/XnA73ZSvG4GdlpRujLKiOvkBu9FeKz
         fd4uj5UA+8jgyDoKv6NEG+KyuMqdHM4Af5riuFxj30dQShKy48kbBjpyaq0KdlKDvCVo
         jRe/tEniS0cHoKD0nR7A9I9V29z8EsTrYeg4bkFnmqcMWt/WY9R6OO6Ln6tGQtJJ1gr/
         9kVo6Q+lYfCD6xY0leARPfwMamsWBSDJeHpBvNO33agRQqVE+PET7wR97VjiGXw278h0
         tNbg==
X-Gm-Message-State: AJIora9NYN+9dHOn9NFGF7ctuYLHQWPbzmgxtjDeGGQBO8h9Q9DOtJIK
        EbLSb8jkCffl57NRe/h7ZeROVw==
X-Google-Smtp-Source: AGRyM1vSZ/7qOlEqVHlCdCJ7FX/JYgnEXy9wXEJbBqZyZ3+GcBqsDsx7UOjeEBLDfw/XOHH9DsK49Q==
X-Received: by 2002:a2e:9ed1:0:b0:25d:527e:28e4 with SMTP id h17-20020a2e9ed1000000b0025d527e28e4mr368867ljk.478.1658510086302;
        Fri, 22 Jul 2022 10:14:46 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id s14-20020a056512214e00b0048110fd06c4sm1156566lfr.53.2022.07.22.10.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:14:45 -0700 (PDT)
Message-ID: <8a4999b9-862e-f698-28b9-42d26f680367@linaro.org>
Date:   Fri, 22 Jul 2022 19:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: qcom: Document additional sku6
 for sc7180 pazquel
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220721033918.v3.1.I10519ca1bf88233702a90e296088808d18cdc7b1@changeid>
 <20220721033918.v3.2.I7ecbb7eeb58c5e6a33e32a3abf4d6874e6cb725c@changeid>
 <CAD=FV=WSBgupLFMCZgianck6uTkAyqrG0WK2ChSbNbJdhOPdLA@mail.gmail.com>
 <4b2fe9d0-f590-0fac-79fa-bb05da1d61df@linaro.org>
 <CAD=FV=XmaNdc9k98vAwbcN-sm0w_WeqhRsK_AUm3h4LZ5-egmQ@mail.gmail.com>
 <c2b03863-2249-13e6-98e0-731c1b40d0a9@linaro.org>
 <CAD=FV=XKC_fbBzna8TgiPRmPH_=AQ3ckv2EEjoNvayKQ83Uciw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=XKC_fbBzna8TgiPRmPH_=AQ3ckv2EEjoNvayKQ83Uciw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 20:29, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jul 21, 2022 at 9:52 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 21/07/2022 18:43, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Thu, Jul 21, 2022 at 9:33 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 21/07/2022 15:37, Doug Anderson wrote:
>>>>>
>>>>> Not worth sending a new version for, but normally I expect the
>>>>> bindings to be patch #1 and the dts change to be patch #2. In any
>>>>> case:
>>>>>
>>>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>>>
>>>> I would say worth v4, because otherwise patches is not bisectable.
>>>
>>> You're saying because `dtbs_check` will fail between the two?
>>
>> Yes
> 
> OK. Then I assume you agree that reversing the order of the patches
> won't help, only combining the two patches into one.
> 
> 
>>> How does
>>> flipping the order help? If `dtbs_check` needs to be bisectable then
>>> these two need to be one patch, but I was always under the impression
>>> that we wanted bindings patches separate from dts patches.
>>
>> I don't think anyone said that bindings patches must be separate from
>> DTS. The only restriction is DTS cannot go with drivers.
> 
> I have always heard that best practice is to have bindings in a patch
> by themselves. 

Yes, bindings must be separate patch, no one here objects this. You said
they cannot go together via one maintainer tree or I misunderstood?

> If I've misunderstood and/or folks have changed their
> minds, that's fine, but historically I've been told to keep them
> separate.

Nothing changed. Bindings must be separate. They will be applied by
maintainer and, if correctly ordered, this is bisectable.
> 
> 
>> Bindings for boards go pretty often with DTS (subarch). This is exactly
>> what maintainers do, e.g.:
>> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=arm64-for-5.20
>> Bindings for hardware should go via subsystem maintainer (drivers).
> 
> OK, fair that in this case both the bindings and the yaml will land
> through the Qualcomm tree. I guess it's really up to Bjorn and whether
> he'd prefer "make dtbs_check" to be bisectable or whether he'd prefer
> the bindings and dts change to be in separate patches from each other.

??? The patches must be separate commits and if properly ordered in one
branch they are bisectable.


Best regards,
Krzysztof
