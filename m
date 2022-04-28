Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D92513A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350468AbiD1RH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348341AbiD1RHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:07:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B82127E;
        Thu, 28 Apr 2022 10:04:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c15so7526132ljr.9;
        Thu, 28 Apr 2022 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I91TlyqXAL0lIZxeDtxl1zhPi2B6n5bFVMGF/828lL8=;
        b=D4g2mDZeeVvqeSGSdh4VNllRT4CW58yTfC5D0Xu6fL5uO9eh9NqbMVQd2O/rKtctj0
         8AF82HfEeBZKPZj7NJK3WS4mSbucasu/AIeObDYkBUYrBC7ThUIVlnKc5pUe9LAatpyx
         iNdQ465pmn2Pl+aqIbbPACRaHcsg2QWfUMTeV99uG1lzY67fJXMhtqd761jFZx3aRmLp
         pLpE9XiiL/pK9ttC2dW/AlBHGOuPx6+xQeTJHln4MlAWr7PSFPsOiaJYoufl2Xj0mBsk
         XM1Y53UFUOrC9cpGdDW/SnWTiFvyS07nX7gOXp4fzYyFdFM9PsYy77v9xuzBmAmelQde
         qCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I91TlyqXAL0lIZxeDtxl1zhPi2B6n5bFVMGF/828lL8=;
        b=iNWPrtYP6zdX7Jar7QCfxJoKrUR6VNzRFiVxF6oySbd2eQJLehzA4ZqotBzzszGOKZ
         3r23m9ONgQA+i/CsiHNGBo22o6dnMVdmIOJZqG172t0BIRyPpOwSQoKjKM1VhTwxtea7
         DemKhk1QkVJQezXMWhZb2bS3iJWjWpOHw6pznrNYJen6cBV/myQNCEsOzs3hATUpGgjS
         MH/vf8lVZYHgOTnw6UMQe1CHS6qJ6qT/Ov2h/6pea59wlwY8cz3F01NUWvjt8YyZmExp
         65lpJkKzgzMKSklpyqhdw1hDd3Sia4xfJ8uqAZDL1Xrh2ollAnaxDtMp7ACG80bvwmra
         fmUA==
X-Gm-Message-State: AOAM533W6CtzEZdnICsD8MISp2YT7O7D6BNL2dK0bSNBRR0X+4dW+pLC
        qUjnKZ18LIWm5Ct5RJXctSM=
X-Google-Smtp-Source: ABdhPJzMgQsdIZyHf+YJ7kjDvoLqItRSHaMTY7aIyBImv7zXU1iC6T20ItZKbsGdp/kr6zA3XFl2VA==
X-Received: by 2002:a2e:8245:0:b0:24b:48b1:a1ab with SMTP id j5-20020a2e8245000000b0024b48b1a1abmr21873414ljh.152.1651165477272;
        Thu, 28 Apr 2022 10:04:37 -0700 (PDT)
Received: from [192.168.35.91] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id y15-20020a056512044f00b004721549b9c2sm46129lfk.219.2022.04.28.10.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 10:04:36 -0700 (PDT)
Message-ID: <5b2c429b-11ad-0d14-a106-d4b1d29d69e1@gmail.com>
Date:   Thu, 28 Apr 2022 20:04:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/5] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
References: <20220423085319.483524-1-markuss.broks@gmail.com>
 <20220423085319.483524-3-markuss.broks@gmail.com>
 <CAL_Jsq+hBtuet-WShvvLA7vfdFdpGRSmv45bcqQhoediq7a7xQ@mail.gmail.com>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <CAL_Jsq+hBtuet-WShvvLA7vfdFdpGRSmv45bcqQhoediq7a7xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 4/28/22 19:36, Rob Herring wrote:
> On Sat, Apr 23, 2022 at 3:54 AM Markuss Broks <markuss.broks@gmail.com> wrote:
>> This patch adds device-tree bindings for regulators on Silicon Mitus
>> SM5703 MFD.
>>
>> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>> ---
>>   .../siliconmitus,sm5703-regulator.yaml        | 49 +++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
>> new file mode 100644
>> index 000000000000..75ff16b58000
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/siliconmitus,sm5703-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Silicon Mitus SM5703 multi function device regulators
>> +
>> +maintainers:
>> +  - Markuss Broks <markuss.broks@gmail.com>
>> +
>> +description: |
>> +  SM5703 regulators node should be a sub node of the SM5703 MFD node. See SM5703 MFD
>> +  bindings at Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>> +  Regulator nodes should be named as USBLDO_<number>, BUCK, VBUS, LDO_<number>.
>> +  The definition for each of these nodes is defined using the standard
>> +  binding for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
>> +
>> +properties:
>> +  buck:
>> +    type: object
>> +    $ref: regulators.yaml#
> The correct file is regulator.yaml.
I was applying all the suggestions, and I thought I had somehow made a 
typo referring to a wrong file.

Do I re-send the whole series with just the s/regulators/regulator/g? A 
part of series has already been merged, do I not re-send the already 
merged patches then?

>
> That's indicated by this warning:
>
> schemas/regulator/regulators.yaml: ignoring, error parsing file
>
> It will fail worse than that once the example in the MFD file is added.
>
> Lee, Mark, I've said it before, but MFD plus child schemas need to be
> applied together. Maybe no one cares if dt_binding_check is broken on
> the MFD tree. The primary issue for me is transient failures during
> the merge window.
>
> Rob
- Markuss
