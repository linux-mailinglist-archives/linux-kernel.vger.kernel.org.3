Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764455A7DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiHaMpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiHaMpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:45:13 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EBF13D3C
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:45:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v26so9549849lfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZlvVcArzagAr4I2vvJT7UKuCAyT0vmCDIdaA8AIizLU=;
        b=O6Ejb+nYgHIBVYk0yGbYEipXFUHBDUyVoRw8f+b8olFDmd22Jc4GENZ7YaY23XdSJX
         2cSjiJqJHuHoldUy51BEvIIPSZLc5uOurcn/cgpRC/IGfx2XMViQjcF9clWHlv83E/aM
         HwVHvobQ4eTDwKZY/Pw5w85aOMNFPSTyMT3ipaskH6T4l9ri9GmrbSLglnmNvBRhwqiP
         zwuuuGT98uBBwZ5QSn01V3GnvGPA5v69934ic9ral0PBx/fPKJDBELEs56r2GxWZjESt
         +82lOvVDVgmFPigyAmk7cdhvnG3Df740QsrR7Inaf3EOhCcp6yWZD6qJT5fN01FZVuNZ
         Mfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZlvVcArzagAr4I2vvJT7UKuCAyT0vmCDIdaA8AIizLU=;
        b=Rj+HQ57xwsR0LHxOs1HBXe4Hfp+e30iQp1MN3qMlXR1mlaSBZtcDqzS52zbdeU2vi5
         lxT2tIxLxtCbedGDqLhZLvOJ3UWJl5aVblm0KVyKV6phgcdniyx/HdKASmt2RSLm3Vxo
         zKoRm/sLK1xkjNzGvSgkNFUFyDjoVVob5+X7id/+jrd5kqBpRIB04XiIGtlhBX+m8aTu
         BQJNYnuZIvpAMFxrd5Gydq/4Dedw8YxRh1X4qFyYMACm15R5Ms4r8GXLhaL7vVf8lrS4
         vtMUd2J4tSHozNKbmfyj0SBeuZ+ZDHc+r327E2acltDw0hvvjXbFXSZmtX+KcUh2HCn4
         01Lw==
X-Gm-Message-State: ACgBeo36TyyxRpj9UO+r/z/iBwi+KIU5oqFgcsUiP/kihglHImIlUirT
        enCVDzjb0IaRheHifDykv2az7Q==
X-Google-Smtp-Source: AA6agR4lSit4c8jA6r7D2/gt2shb1ogNSron5gEDfosSiRi42/FneJjLCi9q5TGEEW7UxJJqWiszEg==
X-Received: by 2002:a05:6512:2248:b0:48a:f8f9:3745 with SMTP id i8-20020a056512224800b0048af8f93745mr8537244lfu.256.1661949910192;
        Wed, 31 Aug 2022 05:45:10 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c22-20020ac25f76000000b004949761d330sm57429lfc.128.2022.08.31.05.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 05:45:09 -0700 (PDT)
Message-ID: <651930f2-37a6-4628-e232-880d41c0997c@linaro.org>
Date:   Wed, 31 Aug 2022 15:45:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/2] dt-bindings: lan9662-otpc: document Lan9662 OTPC
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, UNGLinuxDriver@microchip.com
References: <20220831064238.102267-1-horatiu.vultur@microchip.com>
 <20220831064238.102267-2-horatiu.vultur@microchip.com>
 <393933f5-9a87-4d12-2527-5adfa4aeccca@linaro.org>
 <20220831104455.2oc24fokicieyh37@soft-dev3-1.localhost>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831104455.2oc24fokicieyh37@soft-dev3-1.localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 13:44, Horatiu Vultur wrote:
> The 08/31/2022 10:28, Krzysztof Kozlowski wrote:
> 
> Hi Krzysztof,
> 
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - const: microchip,lan9662-otpc
>>> +          - const: microchip,lan9668-otpc
>>> +      - enum:
>>> +          - microchip,lan9662-otpc
>>
>> This is not what I wrote and this does not make sense. You now listed
>> twice 9662 and 9668 does not have its entry.
> 
> As you figured it out, I am quite noob at these bindings.
> The only difference between what you wrote and what I wrote is the order
> under items. So the order matters?

Yes, because it is not an enum but list. What you wrote is:
compatible = "microchip,lan9662-otpc", "microchip,lan9668-otpc"

and you would see the problems if you tested it with lan9668.

Best regards,
Krzysztof
