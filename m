Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7151C4E45F1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbiCVS1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbiCVS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:27:02 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF69C90246;
        Tue, 22 Mar 2022 11:24:57 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id d10so38035146eje.10;
        Tue, 22 Mar 2022 11:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Ch4dJTVoF+0WgswAjEagoD6pjUX2twqhfq32t6y2FNg=;
        b=03YAq3M7YBzGok+qLOdAqEl3PyQX1oJ1a8+nmcS9fQrKpkUh/9u/csbx6C6qaGSobN
         Ir9Z8xXPfaJ5iGIWath1HWr+dw+jVZ0JrZLx1oKZsY4u7C2dValx/bmw5x/ndoA4yhzX
         gtXDvpqkToUX4+f5lR9uW3Wxrg5U3GU+A4FjQk7jfHokqv0wYoE/nvteD3X/bd22zY1X
         lglnKKTg7jUx5jtCSNF2NYROKN4CVYH/qWx/4iVSkogJsLerwy8FNtZZAkHvjNKTeXbu
         iJyOjXUB8m7IQEaVu+gg+oT8mDVflQAarJWnhr4h3ocWmF387KKWZGwMUWdU1IczYhcj
         unSQ==
X-Gm-Message-State: AOAM532zbFp0zsOpsbhi+7Jzzc0VA7y4swwA6XBYrlzbtVfeIJ7eEgvv
        35bPnI3r1oUbGVhuLyVzs6zSTCjUV+zWqQ==
X-Google-Smtp-Source: ABdhPJwL2NYcf2QiGHS83/NbI8qe3jXBrTCPq7ILCOT4zC/SEv+zL+ze1H5U2Fk53Nuz0/Hj3GaDLQ==
X-Received: by 2002:a17:907:2cc7:b0:6df:b76d:940d with SMTP id hg7-20020a1709072cc700b006dfb76d940dmr20180783ejc.742.1647973496135;
        Tue, 22 Mar 2022 11:24:56 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id u18-20020a17090617d200b006db07a16cf5sm8685155eje.77.2022.03.22.11.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:24:55 -0700 (PDT)
Message-ID: <1096bc5a-5b0f-54a8-93aa-403c39e58283@kernel.org>
Date:   Tue, 22 Mar 2022 19:24:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [Patch v5 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, robh+dt@kernel.org,
        thierry.reding@gmail.com, digetx@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-2-amhetre@nvidia.com>
 <81aa7be7-0bfa-05e6-624a-393e6810dc61@kernel.org>
 <5259de16-6243-42f6-8252-40a23cd67798@nvidia.com>
In-Reply-To: <5259de16-6243-42f6-8252-40a23cd67798@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 19:04, Ashish Mhetre wrote:
> 
> 
> On 3/20/2022 6:01 PM, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 16/03/2022 10:25, Ashish Mhetre wrote:
>>>  From tegra186 onwards, memory controller support multiple channels.
>>> Add support for mapping address spaces of these channels.
>>> Make sure that number of channels are as expected on each SOC.
>>> During error interrupts from memory controller, appropriate registers
>>> from these channels need to be accessed for logging error info.
>>>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   drivers/memory/tegra/mc.c       |  6 ++++
>>>   drivers/memory/tegra/tegra186.c | 52 +++++++++++++++++++++++++++++++++
>>>   drivers/memory/tegra/tegra194.c |  1 +
>>>   drivers/memory/tegra/tegra234.c |  1 +
>>>   include/soc/tegra/mc.h          |  7 +++++
>>>   5 files changed, 67 insertions(+)
>>>
>>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>>> index bf3abb6d8354..3cda1d9ad32a 100644
>>> --- a/drivers/memory/tegra/mc.c
>>> +++ b/drivers/memory/tegra/mc.c
>>> @@ -749,6 +749,12 @@ static int tegra_mc_probe(struct platform_device *pdev)
>>>        if (IS_ERR(mc->regs))
>>>                return PTR_ERR(mc->regs);
>>>
>>> +     if (mc->soc->ops && mc->soc->ops->map_regs) {
>>> +             err = mc->soc->ops->map_regs(mc, pdev);
>>> +             if (err < 0)
>>> +                     return err;
>>> +     }
>>> +
>>>        mc->debugfs.root = debugfs_create_dir("mc", NULL);
>>>
>>>        if (mc->soc->ops && mc->soc->ops->probe) {
>>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>>> index 3d153881abc1..a8a45e6ff1f1 100644
>>> --- a/drivers/memory/tegra/tegra186.c
>>> +++ b/drivers/memory/tegra/tegra186.c
>>> @@ -139,11 +139,62 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
>>>        return 0;
>>>   }
>>>
>>> +static int tegra186_mc_map_regs(struct tegra_mc *mc,
>>> +                             struct platform_device *pdev)
>>> +{
>>> +     struct device_node *np = pdev->dev.parent->of_node;
>>> +     int num_dt_channels, reg_cells = 0;
>>> +     struct resource *res;
>>> +     int i, ret;
>>> +     u32 val;
>>> +
>>> +     ret = of_property_read_u32(np, "#address-cells", &val);
>>> +     if (ret) {
>>> +             dev_err(&pdev->dev, "missing #address-cells property\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     reg_cells = val;
>>> +
>>> +     ret = of_property_read_u32(np, "#size-cells", &val);
>>> +     if (ret) {
>>> +             dev_err(&pdev->dev, "missing #size-cells property\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     reg_cells += val;
>>> +
>>> +     num_dt_channels = of_property_count_elems_of_size(pdev->dev.of_node, "reg",
>>> +                                                       reg_cells * sizeof(u32));
>>> +     /*
>>> +      * On tegra186 onwards, memory controller support multiple channels.
>>> +      * Apart from regular memory controller channels, there is one broadcast
>>> +      * channel and one for stream-id registers.
>>> +      */
>>> +     if (num_dt_channels < mc->soc->num_channels + 2) {
>>> +             dev_warn(&pdev->dev, "MC channels are missing, please update\n");
>>
>> How did you address our previous comments about ABI break? I really do
>> not see it.
>>
> In v4 patch, error was returned from here and probe failed causing ABI
> break. In v5, we are checking if number of reg items in DT is as
> expected or not. If number of reg items are less then we are just
> printing warning to update DT and returning 0. So probe won't fail and
> driver will work as expected.
> Also I had tested just driver patches with existing DT and it worked
> fine.

Ah, right, thanks. I missed the return 0. Looks good, thanks for the
changes and for explanation.


Best regards,
Krzysztof
