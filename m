Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A192B5879D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiHBJbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiHBJbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:31:22 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D42127B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:31:21 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z4so337812ljn.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 02:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=llhXJQ27JBRkaJ7mTp2oTjZTws3d5YdyWPAWGDeFIGQ=;
        b=I7ycrZvFC8iS/NqiYZ2HwNIORSrUnj7fC9Rba5NC3ho1/ph9QlIIBggRb245nb3f1C
         l0x3baVTllKnbrKtuhaSpYJW2Q7OLEqmssHiPoh1JfO7eR+1m4FktOugJQS8NiSOHqWN
         Zb9o47jgoJfGxkOqx00xdntBdABR4o0ufh8nZhBU6pisSbHvxB3nVrKNbyOo+gl5M3eh
         +E9f9/NDpDFcyFMxDu302EFY2uoZf4+/kuqtW/QexRefwQKSyJc2suS7no00WtGDbfeV
         mMTfYMQ5UF+7N4cu8D/9yxbd2OtJBveB0+CDSGH+XUbUb09gEobjJu5GpfD2iVVCmIMt
         J3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=llhXJQ27JBRkaJ7mTp2oTjZTws3d5YdyWPAWGDeFIGQ=;
        b=bbe3YDsBbXDzzr3YTmIPtOKfvFEosBnUIfiXrJx5HAUlGwTt+ug4xUcfdh4DiO5MLQ
         zfWu0CBVlKTYZAxH7d41POcnJF2Ud5cgH4FCemTQ3QXX6oSFiwg7gRrqg9CxOdYvM7S6
         WA00WwmnfrSewx5pQqOndSm1sheSGtXTmnrSbtSR2pe5OhvXuLQD0ryec4hvGI1L04QK
         UBaBqNmC3PYDHcviz0Usrt32A6YaCy3JJTCbjHcxpP6RwwHv3gzDQjwYdGAjpT7R4GmM
         lx0xEAMkEH/6NnBdbYeT94bxptPlPG9P67QclGcT54xUHsV44L/U9jsnelDaHm1P/M4i
         nIdg==
X-Gm-Message-State: AJIora8Rmy9iO4rniADOpMwFF+zZlToES+XJbZbw6sgrBeokFp+TNWei
        8J6Nd4uDtjFxEbhWZIBihgYsmQ==
X-Google-Smtp-Source: AGRyM1sJjhQZ5KaPvUC6FJ+AhlR6FB9ldEUHvJ6aemu5UQMOlq2N/xqBOuM9Z1i02ng+bJLQN56ZUQ==
X-Received: by 2002:a05:651c:12cb:b0:25b:fa3f:c3f with SMTP id 11-20020a05651c12cb00b0025bfa3f0c3fmr6711160lje.364.1659432679272;
        Tue, 02 Aug 2022 02:31:19 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id e12-20020ac24e0c000000b0048a8fc05b0asm1075027lfr.117.2022.08.02.02.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 02:31:18 -0700 (PDT)
Message-ID: <b2205507-6e36-fd83-d345-781604a0b979@linaro.org>
Date:   Tue, 2 Aug 2022 11:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] ASoC: dt-bindings: fsl,sai: Convert format to
 json-schema
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1659060632-4880-1-git-send-email-shengjiu.wang@nxp.com>
 <ba6bc0e8-8b64-aa7f-241e-1e88dd9cfaa5@linaro.org>
 <CAA+D8AOfxbv74xoeQ3TP7NkUeduRu=Ez983MDw-KNDBuu=5yxw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA+D8AOfxbv74xoeQ3TP7NkUeduRu=Ez983MDw-KNDBuu=5yxw@mail.gmail.com>
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

On 02/08/2022 11:21, Shengjiu Wang wrote:
>
>>> +  lsb-first:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description: |
>>> +      Configures whether the LSB or the MSB is transmitted
>>> +      first for the fifo data. If this property is absent,
>>> +      the MSB is transmitted first as default, or the LSB
>>> +      is transmitted first.
>>> +    type: boolean
>>
>> The type: boolean goes instead of $ref, not additionally to it. Just
>> like below...
>>
>>
> Does this mean that I should remove the $ref  for all the boolean flags?
> like fsl,sai-synchronous-rx...

Yes.



Best regards,
Krzysztof
