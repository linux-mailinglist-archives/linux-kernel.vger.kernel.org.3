Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F655840B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiG1OK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiG1OKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:10:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E6163925
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:10:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p10so3001707lfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3ZkQISkEyAXqDJZYEpQ7KC461gTyV9M43PYYTAdpW9k=;
        b=l1GF1944v4xfZOTAoyVPjRU1bI2U5o/dI5UtIc8ezqvZnf6NLuoQyXXO9lBdy/HzQ1
         +dPIJxPqqSzNPc8VsHoSd6/JlGb5zLyq4cNxNqpiXrik6qjLpqMutKXPbBF2uuYzniUG
         6uJShkWKsE4I29ZHjuhSpvH8rOew62e96DMQULj+zuFjt8FCGTlm4om7Uc7AiAOiidKo
         yWpb65M38LA7CyzuIhyA8nDHIsLZNdvpiFE+V/SdsEdF2l56AfxXsuCavlsOL4mKLLra
         F9eAhGM+agB1gTsE4kNekk0xY3vYAwuPTxec0hl0f+cn0zIY3KzN1Lj+8+ZGOYzaiidl
         WYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3ZkQISkEyAXqDJZYEpQ7KC461gTyV9M43PYYTAdpW9k=;
        b=NlG79adx2RAORK+nii8VVElUbP2nn7kAMuqc3heTDeHQoMYKA89Ws8W7moNdCUKOTw
         Rp8j4A9Re4kmkm0kb9iKrD4WHrZAm0e5If90d1Ag3yVKlgEpyUGsKIpZEPjjc4xQ4qCI
         h08SJgJpnx+/fY9E0jgNBdHZGx12eL7YmIA69kXSIYk0BsEzg5UyTCr9fIc9j560MzTe
         gCrRdtI3Z1VIpd9TYxOIX2XrtZvWMGVFDsVkzpDhtv4vKhNE/wWg9fkCKA625Hg7Ls37
         RatorUVIUe6SXlLA9wDCcVHQ8JoB4+skoGoddpbmWMZh5YZy4CruRuSm04boUXdFbo53
         cxaQ==
X-Gm-Message-State: AJIora8HyFl9EMbU12tr1Aosqj16oV87w3P6Zzz53ollE3jV42FFwhRx
        XgbszH/Og1YHgBS8fMQDtVqzQw==
X-Google-Smtp-Source: AGRyM1s6eMkW7RadgIwnMhQWUiqP2h73XK4fRJOfJ7MByx2t3fVD6PR8bOn5QnF0b3ef0tJyASGPUQ==
X-Received: by 2002:a05:6512:151c:b0:48a:9763:5d29 with SMTP id bq28-20020a056512151c00b0048a97635d29mr6347878lfb.79.1659017403706;
        Thu, 28 Jul 2022 07:10:03 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b0048a727ac440sm220929lfs.45.2022.07.28.07.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 07:10:03 -0700 (PDT)
Message-ID: <84923720-30a6-1a49-48f6-96e078a46743@linaro.org>
Date:   Thu, 28 Jul 2022 16:10:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 3/3] dt-bindings: phy: add definition for MSM8960
Content-Language: en-US
To:     Shinjo Park <peremen@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220728111740.30595-1-peremen@gmail.com>
 <aef9bae5-b72b-d520-a8e5-8f6a838775eb@linaro.org>
 <CAAs2AW7A4RfxAaKPsmJjA1s7s5_rnM2O4XAAFC=7x1Npttg5rQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAs2AW7A4RfxAaKPsmJjA1s7s5_rnM2O4XAAFC=7x1Npttg5rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 15:54, Shinjo Park wrote:
> Hello Krzysztof,
> 
> Sorry for any confusion during my first patch submission.
> 
> PATCH 1:
>>> Change the reference of sleep_clk to the same as qcom-apq8064.dtsi.
>>
>> You add label, not change something.
> 
>>> - sleep_clk {
> 
>>> + sleep_clk: sleep_clk {
> 
>>
> 
>> Since you touch the line, make the device node sleep-clk (device node
> 
>> names should not have underscores) and mention this in commit msg.
> 
> 
> I can change the line into "sleep_clk: sleep-clk". And the commit message
> would be "Change the device node of sleep_clk to sleep-clk and add a
> label"? Another problem is that in the same .dtsi file there are other
> device nodes containing underscores (cxo_board, pxo_board). Should I also
> change these in the patch?
> 
> PATCH 2:
>>> +                     phy-names = "usb-phy";
>>> +                     status = "disabled";
>>
>> status is the last property.
>>
>>> +                     #reset-cells = <1>;
> 
> I can move #reset-cells one line up and make the status last line. On the
> other hand, the same definition is also used in
> arch/arm/boot/dts/qcom-apq8064.dtsi (also the clock definition mentioned in
> PATCH 1). Shall I include another patch for that file in the next revision
> of this patch series?


Yes, you can rename them in other patch as well.

> 
> PATH 3:
>> 1. Thread your submissions.
> 
> Shall I use this thread for all follow-ups for my first and second patch?

No. One patchset, one thread.

https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/5.Posting.rst

> 
>> 2. Use subject prefix matching the file.
> 
> If I understood correctly, then this should be "dt-bindings: phy:
> qcom,usb-hs-phy:"?

Yes.


Best regards,
Krzysztof
