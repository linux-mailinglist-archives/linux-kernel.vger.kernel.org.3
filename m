Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E8C4EAAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiC2KFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiC2KFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:05:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903525C650;
        Tue, 29 Mar 2022 03:03:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so945664wmb.4;
        Tue, 29 Mar 2022 03:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XP58J9nMiUBKKZ2mEHu2elDVfOboIj5PiONcCMCt6ic=;
        b=Yq4sbY+zwUknZYkTIlOVDWtB1bNtPagOZTtgT+2I2V6upHPE6NIOT3L9S27Sx3I/nz
         bio/avRpFO0w5U5XECzAzLC3az+PrWr7pSssQ/xJN88fnPTBrMKhd+6QqBjuSAIDKJ1R
         3FrFVS+HUJpZ1BT5HBH8JXJmW2OYL82dENzmIYwQUfTMCi/fAdJrxk2dD8+s+IDs5ZVi
         54z7C6/HBUWl/N3wRalHWceNxICXqSnmCSkWIqaCs+BQxR8VJDsPLfVJMEj5utTb10R3
         FgAhPK2IuYpcMppLKB9iXpS+/zIQsSefUrpWdz7iRWN4NR5I08aSY/n1y0aZoo/2OElH
         bFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XP58J9nMiUBKKZ2mEHu2elDVfOboIj5PiONcCMCt6ic=;
        b=V2kOzdoxgi9I5bGchb1BAXT8uUoCwhVQXSz3Djg5ZK5E4PaLLd8I+5bSWQ/2iSwwNf
         D1mkUwPMsX2DFhIK3dicRN3m3vVzsJfcc3N/VTuVWCLFDe7ISG0FZSfLla8x4THIXcjQ
         5TM75ynM9mgAIEY5esJ69bNdN6x0M3leNAi3L034vP9MEW3Ta1rlbFBOAatexqASzG0X
         mHft9rIgOmap4XLni7WfKc2gtXoWP+TpCqqstGuEZV+dEBkM332UIt4A0b7q1F5iFz2Z
         oNb++SKRgpY/Nw4iO11UC8Huea1WW+ifHaEH9qNdAxm20SbU43wTrefT48vHaCzRVYmS
         c0Og==
X-Gm-Message-State: AOAM533B5y4a7fqN34xTwErW/rlf8CqkJ1xdwMSzTlMWYCwWUOCVsC3o
        OeGd3CMWd+G3A4ilIybJpNMd2dII+Eq5AQ==
X-Google-Smtp-Source: ABdhPJztz045tZLfgkeJcC3u6Zv7to81fyJuQrvXjzft9fCaGBH8M6rHdf7cy+6YBfYM8gLnYA366A==
X-Received: by 2002:a05:600c:34ce:b0:38c:a579:944a with SMTP id d14-20020a05600c34ce00b0038ca579944amr5773450wmq.113.1648548228053;
        Tue, 29 Mar 2022 03:03:48 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600c4e0800b0038c6c37efc3sm1811134wmq.12.2022.03.29.03.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 03:03:47 -0700 (PDT)
Message-ID: <ea6868cc-6650-9b69-e328-6b0d31069191@gmail.com>
Date:   Tue, 29 Mar 2022 12:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 22/22] arm64: dts: mt8192: Add pwm node
Content-Language: en-US
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-23-allen-kh.cheng@mediatek.com>
 <51f8baea-6562-1d6b-c409-9c362f0b2fc5@gmail.com>
 <6ab86a35394879cf35fd9d780f8b7ab1695c931b.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <6ab86a35394879cf35fd9d780f8b7ab1695c931b.camel@mediatek.com>
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



On 29/03/2022 08:51, allen-kh.cheng wrote:
> 
> Hi Matthias,
> 
> On Mon, 2022-03-28 at 13:10 +0200, Matthias Brugger wrote:
>>
>> On 18/03/2022 15:45, Allen-KH Cheng wrote:
>>> Add pwm node for mt8192 SoC.
>>>
>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8192.dtsi | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index f0f0f067c023..ea98b2230f18 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -625,6 +625,17 @@
>>>    			status = "disabled";
>>>    		};
>>>    
>>> +		pwm0: pwm@1100e000 {
>>> +			compatible = "mediatek,mt8183-disp-pwm";
>>> +			reg = <0 0x1100e000 0 0x1000>;
>>> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH
>>> 0>;
>>
>> Binding description is missing interrupt property. Remeber that the
>> DT should
>> describe the HW, so we need to update the binding description.
>> I just wonder what the IRQ signals, as it is not used by the driver.
>> Definitely
>> a good candidate to make the commit message more sound. So please add
>> it there.
>>
>> Thanks!
>> Matthias
>>
> 
> For interrupt property, we will send anther patch to update binding
> and add some information for IRQ into commit message in next version.
> 

Thanks. Would you mind to send the dt-bindings updates in a series together with 
the patches from this series that needs changes? This way it will be easier to 
track the dependencies.

Please beware to send dt-binding patches as first of the series, so that Rob 
Herring can find the rather quick.

Thanks!
Matthias

> Thanks,
> Allen
> 
>>> +			#pwm-cells = <2>;
>>> +			clocks = <&topckgen CLK_TOP_DISP_PWM_SEL>,
>>> +				 <&infracfg CLK_INFRA_DISP_PWM>;
>>> +			clock-names = "main", "mm";
>>> +			status = "disabled";
>>> +		};
>>> +
>>>    		spi1: spi@11010000 {
>>>    			compatible = "mediatek,mt8192-spi",
>>>    				     "mediatek,mt6765-spi";
> 
