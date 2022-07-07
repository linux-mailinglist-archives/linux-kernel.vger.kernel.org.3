Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F4956A314
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiGGNCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiGGNCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:02:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB3D15A0B;
        Thu,  7 Jul 2022 06:02:14 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a5so11532458wrx.12;
        Thu, 07 Jul 2022 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=XaV30yfY2MX777NwLyZ9LT1ytNc0L79CG7OYsrOikpE=;
        b=CAA7zEGg/B8eWgsrOCy2qd+dv2w6BaWSmNa5cx1jNFhJrobaQdqWq0dwV76x3Hssff
         cNkX4kAbUQX4h1kveFK0AwfDfYH/ytAFuDaQEPJFkQh4X1Gca85pXeWOOCrxuokwAqja
         Z28wQOsjQHkOYdfe7M4djt7qrt0wBTNSIHruMQHjpCX8eXAz3VTYyMl5SLU/fw3jzmLO
         onu3c3TzgiCsa5VY9Me4in1ZmpTmk+fmv8SOAcy/mWrU5dhnXs7Of7UYm84A1DL0IKne
         cg6tlOJ6dk72QX5KVtJL5aPeANgdEX8oty+NeSZ2j8DnbWv7eUOv0m4Kpen/1n74Okhg
         GowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=XaV30yfY2MX777NwLyZ9LT1ytNc0L79CG7OYsrOikpE=;
        b=2j/Ke/gCXmXKYDeN9EuQRiXepSaZod+ju8YX9L0N+oO4BasROVGpVWHpgFxptYDgJB
         kVrb8L9YUyWcmw/CNxMSWvKGtiiGIKut4r4Ujx6TIBDr6VZekZjRjy7DhIhw7R9SfDjz
         clI3txoI9yMok4UvDKsWQlZM+VmXjzzmO20rgGNStfzYubaJQxYko5PXLd6TbGh8PYV5
         hUwO+PhGjmRqbPqggHgLLJ3hyRqw1EUYsZQz8pVrfu+p+Yix80wmh/Fhz2YfVjhasvrZ
         Jt0NNdmW+sSdT3n1sTnPGSLX1JV4qCJsLqoagCNJMnUXHnKAcjKujJimRWdjlwrRrtF2
         pjVg==
X-Gm-Message-State: AJIora/NbMvLDPW6H+BU9WCke/xH0WGk3Is8u32aOiAfXbpEORvfp2GT
        tFkeokyogdfCKP+cQK7g5+I=
X-Google-Smtp-Source: AGRyM1tD7/UCBhqliXFJCFgwWHWFzMcyZ0xmXaYmCAAG5xFaBJzHgi1bGNvjXkiKigl0APxRcvEW9A==
X-Received: by 2002:a05:6000:68e:b0:21d:76e3:cc80 with SMTP id bo14-20020a056000068e00b0021d76e3cc80mr12082902wrb.327.1657198933038;
        Thu, 07 Jul 2022 06:02:13 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e10-20020a05600c4e4a00b00397402ae674sm20518878wmq.11.2022.07.07.06.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 06:02:12 -0700 (PDT)
Message-ID: <665651cb-a070-4d48-9d36-92bab1814267@gmail.com>
Date:   Thu, 7 Jul 2022 15:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-3-tinghan.shen@mediatek.com>
 <119f2a98-ef56-7b99-631f-221b737939ae@linaro.org>
 <9757b32c-c196-f7e0-3c61-1d4edae854dc@gmail.com>
 <4c3443f4-a65d-331b-851a-01f5275bbf4b@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 02/16] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
In-Reply-To: <4c3443f4-a65d-331b-851a-01f5275bbf4b@linaro.org>
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



On 06/07/2022 16:38, Krzysztof Kozlowski wrote:
> On 06/07/2022 15:48, Matthias Brugger wrote:
>>
>>
>> On 04/07/2022 14:36, Krzysztof Kozlowski wrote:
>>> On 04/07/2022 12:00, Tinghan Shen wrote:
>>>> The max clock items for the dts node with compatible
>>>> 'mediatek,mt8195-smi-sub-common' should be 3.
>>>>
>>>> However, the dtbs_check of such node will get following message,
>>>> arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0'] is too long
>>>>            From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>>>>
>>>> Remove the last 'else' checking to fix this error.
>>>
>>> Missing fixes tag.
>>>
>>
>>   From my understanding, fixes tags are for patches that fix bugs (hw is not
>> working etc) and not a warning message from dtbs_check. So my point of view
>> would be to not add a fixes tag here.
> 
> Not conforming to bindings is also a bug. Missing properties or wrong
> properties, even if hardware is working, is still a bug. If such bug is
> not visible now in Linux, might be visible later in the future or
> visible in different OS (DTS are used by other systems and pieces of
> software like bootloaders). Limiting this only to Linux and to current
> version (hardware still works) is OK for Linux drivers, but not for DTS.
> 

If a wrong DTS breaks software, then it's worth a fixes tag, especially for the 
DTS part, we could argue about the bindings part, but in that case it would be 
probably OK.

> Therefore Fixes tag in general is applicable. Of course maybe to this
> one not really, maybe this is too trivial, or whatever, so I do not
> insist. But I insist on the principle - reasonable dtbs_check warnings
> are like compiler warnings - bugs which have to be fixed.
> 

I'm not arguing that these things shouldn't be fixed, but that they are worth 
being back-ported to the stable branches.

Regards,
Matthias
