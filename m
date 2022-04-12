Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFE74FCD72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbiDLEGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiDLEGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:06:41 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20320F7E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:04:23 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z19so18300972qtw.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J+x3SPFdGypefdXDIqiyFTr8SFo5yaCISlCMQJFopck=;
        b=x/IyGL9sWWNEgc+7aqpoOSGvBo3BrA/8tfHhrVWZlHv5Zqb6+sNfP+t1XNvlgELoyC
         tL68P2ifPMWhTeUceZ//SyqhR6E0r1uOq0OBFPpwizKLpsUzafMr4ALbioXVlzzOhFgZ
         CChwBJ24GWepEFfC1OvFF/RJE1oygWYYAUHIi4csnS3wtvBa5roOQcTi9gqU996Tn+Qx
         OyJfWaHwHDnclIB0jaE34V4WIEJsPOLrjFSeXYFnm5lp7YB9CCE8N3+kxljOG9n7hjIE
         35v78d2T8xqDg1VE1aDcRI+tlV11qeupdXuZ0L3cww33z8q0Vz+vU7C6JyY1RvDK6WOH
         4s8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J+x3SPFdGypefdXDIqiyFTr8SFo5yaCISlCMQJFopck=;
        b=TdCqstdUSafmsaTTK8OkVUUlai6Q7MEBChOFND54dKKGr5X8Q+/09YM3o6LGnL2t2g
         txLWBqJHh0JrprCXVib67up3taWtpVUvW3uxTvMRsmKez2iYh/0CuQnp6o1AaNEGkJK0
         ZaufDuZjST9xLIQeLsjIqw/v8e0jJ8WN1nmsDjIhLMhbyhF8QgFB0cN4/FUyyw0bCqqA
         atNNumoZ9KNiWv0mGUsxPr0OzYflD2lgwQXWFvE08OkwGXNWTNVql17OCzvWXk7SIrJs
         CkN023D1rp6fIAaeF4CEBMX/IY/MGw0gxorfCVC0+xO/OSde286uwL0vW7etis59KQx7
         T1cQ==
X-Gm-Message-State: AOAM532I+7d4VTvsPyZcabrqfXU8lcEZ2sNYLrRMiABXFw+RfJTGB5fZ
        ta0ehwOvF3l4gFuURY7h5jChfQ==
X-Google-Smtp-Source: ABdhPJwA2WVOHW3EXR6l/HiIz94aEB/WpqZC/ssR0ezUv3tSP+2pzRH/BbFwctn+X60WSZ9mNg2pag==
X-Received: by 2002:a05:622a:138a:b0:2e1:ea16:4fd9 with SMTP id o10-20020a05622a138a00b002e1ea164fd9mr1927029qtk.527.1649736263011;
        Mon, 11 Apr 2022 21:04:23 -0700 (PDT)
Received: from [192.168.0.189] (modemcable134.222-177-173.mc.videotron.ca. [173.177.222.134])
        by smtp.gmail.com with ESMTPSA id e15-20020a05622a110f00b002e1ed105652sm26677261qty.2.2022.04.11.21.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 21:04:22 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: delete incorrect ufs
 interconnect fields
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20220407172145.31903-1-jonathan@marek.ca>
 <e41c26c2-8aa4-cfd2-27b0-eb011f45eda0@linaro.org>
 <865ff6bc-95a2-8b39-5cf2-bb2d3f592c5a@linaro.org>
 <f1fb2d71-4adf-bcc7-76b3-c7102ab9f2e9@marek.ca>
 <YlTg7QPkWMBP4HAb@builder.lan>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <20db508c-0ccf-e4a6-87a4-17c41871703c@marek.ca>
Date:   Tue, 12 Apr 2022 00:04:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YlTg7QPkWMBP4HAb@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/22 10:16 PM, Bjorn Andersson wrote:
> On Thu 07 Apr 17:38 CDT 2022, Jonathan Marek wrote:
> 
>> On 4/7/22 5:16 PM, Krzysztof Kozlowski wrote:
>>> On 07/04/2022 21:40, Vladimir Zapolskiy wrote:
>>>> On 4/7/22 20:21, Jonathan Marek wrote:
>>>>> Upstream sm8450.dtsi has #interconnect-cells = <2>; so these are wrong.
>>>>> Ignored and undocumented with upstream UFS driver so delete for now.
>>>
>>> This is the upstream and they are documented here, although as pointed
>>> by Vladimir this was rather a reverse-documentation. The documentation
>>> might be incorrect, but then the bindings should be corrected instead of
>>> only modifying the DTS.
>>>
>>>>
>>>> Basically the description was added by a commit 462c5c0aa798 ("dt-bindings: ufs:
>>>> qcom,ufs: convert to dtschema").
>>>>
>>>> It's questionable, if an example in the new yaml file is totally correct
>>>> in connection to the discussed issue.
>>>
>>> To be honest - the example probably is not correct, because it was based
>>> on existing DTS without your patch. :)
>>>
>>> Another question is whether the interconnect properties are here correct
>>> at all. I assumed that DTS is correct because it should describe the
>>> hardware, even if driver does not use it. However maybe that was a false
>>> assumption...
>>>
>>
>> writing-bindings.rst says it is OK to document even if it isn't used by the
>> driver (seems wrong to me, at least for interconnects which are a firmware
>> abstraction and not hardware).
>>
> 
> The devicetree, and hence the binding, should describe the hardware, so
> that an implementation can make use of the hardware. So there's no
> problem expressing the interconnect in the binding/dts even though the
> driver isn't using it.
> 
> I'm not sure if I'm misunderstanding you, the interconnect paths
> described here are a description of the hardware requirements for this
> device. (I.e. it need the buses between ufs and ddr, and cpu and ufs to
> operate).
> 

This is pedantic but what if my kernel lives in imem and not ddr. Or it 
runs on adsp and not cpu? "ufs-ddr" and "cpu-ufs" are not necessarily 
hardware requirements.

(I was thinking of something else when I wrote that comment, but it 
doesn't actually matter if its firmware/hardware if a driver can 
implement the same functionality either way)

>> 462c5c0aa798 wasn't in my 5.17+ tree pulled after dts changes were merged (I
>> guess doc changes come later), so my commit message is incorrect, but I
>> think it makes more sense to have the documentation reflect the driver. Its
>> also not an important issue, so I'll let others sort it out.
>>
> 
> I believe that the correctness of the interconnect property will ensure
> that the interconnect provider doesn't hit sync_state until the ufs
> driver has probed - regardless of the driver actually implementing the
> interconnect voting. But perhaps I've misunderstood the magic involved?
> 

AFAICT, if its not used by the driver it will be ignored completely, 
unless you use OPP (which has some interconnect magic).

> Regards,
> Bjorn
> 
