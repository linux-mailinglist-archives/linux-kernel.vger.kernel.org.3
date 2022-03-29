Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E243D4EAAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiC2KDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiC2KC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:02:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3734C7AE;
        Tue, 29 Mar 2022 03:01:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i4so5175834wrb.5;
        Tue, 29 Mar 2022 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m4FFYC8lGa0e93GEJjlQ3+QnjPXNWGNWcnEAZzCv3sM=;
        b=jzmwQJqPkQjtYfqpaahPYRUlFjFgaqh7YzFgssx0NHXJTapk2V8SYRsKVYC9G/h49H
         HfULIJdloYL6DUiwFsRGc8Uy57P61i0CsSGjglbAYxfutxhv1rUxpZQ4GlCah/F89GUO
         fHMLYxAAlLEE8wwPybLM4RluCyfcfdW6y5V3xkifbbeFP0ZZiT3GkHHmDkdaYTVwys/+
         Bk4yFgvnIVTsQL+9XEAMwotecAivJ4JcyyhbYajW9Q6u2wSeRQKvVR9evne+8eHx4Mzf
         7RhAcdfqACvmIiVDyT6Eg013w+YGid733dW8LFdAFP1cP6JfHS9cjwOOGw1eSqgLu1iG
         U9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m4FFYC8lGa0e93GEJjlQ3+QnjPXNWGNWcnEAZzCv3sM=;
        b=0UlwpLlqUKJaNt17ZT74XaP/UiLwhzf69UMj9dAPvlCdqBWUFGbjDstLAdGobU6VzO
         vSsYZwUGF4TrTpZ8cVozAtihQ2ZJ49jwzB6N0DTzhu/DwfUQY2xuLGJ0z0FlLRkvruj9
         EQIS59DDr9sj9F6eErbkZSuflsA3XmyJx0y/iDDx4mt4p3JCLFQxMoSrO6s3UiNY+jC9
         BoLV4ssxI3PCCuIEJCpHWQpS9iKnXffoEodet5otmkGZ99uErHRM0VV1WRid9tPlzKao
         sLqdnKKyWvkeo95C1/Pfi4ArixvkXo3Xqcw8H2KJcyPWJD25uhILDPbDhe2NaQ4utTKo
         rN0A==
X-Gm-Message-State: AOAM532dgPwm+xqxbwUmG+K3YkZ8zT8dlqz/BFj8qHf0IS1CoCOjtwT3
        3W+Lbe+uObGO0IzRwgV4l7Q=
X-Google-Smtp-Source: ABdhPJzC16Ey35nHO2vMO312+0ONaIEcW00CaKl7lSRzySNcL2ia+eHDyeaf5+/WYV/KFiwFKrKiWA==
X-Received: by 2002:adf:efd2:0:b0:203:db42:c56c with SMTP id i18-20020adfefd2000000b00203db42c56cmr29329158wrp.698.1648548073504;
        Tue, 29 Mar 2022 03:01:13 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v1-20020adf9e41000000b00205c3d212easm4214242wre.51.2022.03.29.03.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 03:01:12 -0700 (PDT)
Message-ID: <c2ae5400-5a5e-2aa7-c282-6132ba332200@gmail.com>
Date:   Tue, 29 Mar 2022 12:01:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 17/22] arm64: dts: mt8192: Add dpi node
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
 <20220318144534.17996-18-allen-kh.cheng@mediatek.com>
 <019b1a59-7531-75cf-3b86-d2798ca9823a@gmail.com>
 <e4edbb8d599fe202aa89f4dea88e6addfbeb4e0d.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <e4edbb8d599fe202aa89f4dea88e6addfbeb4e0d.camel@mediatek.com>
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



On 29/03/2022 09:45, allen-kh.cheng wrote:
> Hi Matthias,
> 
> On Fri, 2022-03-25 at 16:24 +0100, Matthias Brugger wrote:
>>
>> On 18/03/2022 15:45, Allen-KH Cheng wrote:
>>> Add dpi node for mt8192 SoC.
>>>
>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8192.dtsi | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index 71ad3adeed51..a77d405dd508 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -1236,6 +1236,17 @@
>>>    			power-domains = <&spm
>>> MT8192_POWER_DOMAIN_DISP>;
>>>    		};
>>>    
>>> +		dpi0: dpi@14016000 {
>>> +			compatible = "mediatek,mt8192-dpi";
>>> +			reg = <0 0x14016000 0 0x1000>;
>>> +			interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH
>>> 0>;
>>> +			clocks = <&mmsys CLK_MM_DPI_DPI0>,
>>> +				 <&mmsys CLK_MM_DISP_DPI0>,
>>> +				 <&apmixedsys CLK_APMIXED_TVDPLL>;
>>> +			clock-names = "pixel", "engine", "pll";
>>> +			status = "disabled";
>>
>> We are missing the output port node here.
>>
>> Regards,
>> Matthias
>>
> 
> We will add output port in mt8192-asurada.dtsi (inlude mt8192.dtsi) for
> board level.
> 

Got it, patch now applied.

> Do we need to add any futher information in binding?
> 

Hm, probably we should mark the output port as optional? Can you check how other 
bindings manage that?

Thanks,
Matthias

> Thanks,
> Allen
> 
>>> +		};
>>> +
>>>    		iommu0: m4u@1401d000 {
>>>    			compatible = "mediatek,mt8192-m4u";
>>>    			reg = <0 0x1401d000 0 0x1000>;
> 
