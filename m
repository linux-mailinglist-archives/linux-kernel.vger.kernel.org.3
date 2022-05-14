Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9825273CD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiENTnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 15:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiENTnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 15:43:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F71CB3E
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 12:43:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u23so19769228lfc.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YRR6yhBfuheeT6DyI955DtiAlr7j0ElPFuCgNZYtHe8=;
        b=cKNIPFv+kmdiZtoUh+ilefEdVpogdHAJmcT8j48WcUZ4vegvYOZtd81BetdPhY+ZTT
         m44El5SxsdbLJA3LzxXu4+DV1KZI/OD0vWWgYx6H2FKUdnFwK8MF3NdBh3XgHBG/+Vyx
         zltpjtOPjYgJ4vHqa6mtZ88jhhhWYVqUSc7Duns8w5dB/WWUxvCHpq8ksWTiNPXt8QNd
         95Y0vDTJCAB3M/QgOR3ZYfGxBDQxLbmT7N8HYdJqJCHFUVoXKpFclXpGNUpxJJBzWec3
         oXPNBOqZzERKyLh5uTbamDg4MWl8LnuADSg8vHTRjWwvxRle7wCtAMj1bWtvuJriNSwq
         FwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YRR6yhBfuheeT6DyI955DtiAlr7j0ElPFuCgNZYtHe8=;
        b=0T8a47naTkXNNj9Kbr6aREGfW4Fv9lEBu9a6HEyYL4J+7khyimaNwAko8Wl26rMe3j
         8/IPGK7c4AU6RbGfYynMq/9t4o31/QhL9gA2OEQDx0j7B4Wqo0rfjQl5CSnr7AQLjVEE
         j31uA0j2f/XodiLBHCna0A34DI7wC7vQisxLUveVOFvDZ2di10sLwP2XYmTo3cHugkmf
         Zcf/lk82af4m8Wk5pXrSBsFihN2ln85YQUWHSwOvwCRaCmx4OpA3mVGCi44jeX5Uajc9
         U6Ucd1zcl+M0ywPOfmHVEmB3DTE612Xg0c6BDgpbmt3fJt18xUrurF3zjNMpiUOhhLrE
         if7g==
X-Gm-Message-State: AOAM531PjYs0V2PWkB6PLdsGr3gCwf2IJt3+XkvHhVlYolDj9RM81A8q
        MA5cKng4hsGOqr4TKBm8ccp5eegdJSMm2u8S
X-Google-Smtp-Source: ABdhPJzPDjic1LB5uI2Zj+l6OnpED29tQ//hzw+X+Be1bnNDtHxlH98OblI1rxfODJrXGXJJhJ8K9w==
X-Received: by 2002:a05:6512:1693:b0:474:35c:8c11 with SMTP id bu19-20020a056512169300b00474035c8c11mr7472603lfb.19.1652557379515;
        Sat, 14 May 2022 12:42:59 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p2-20020a2ea4c2000000b0024f3d1daebbsm904127ljm.67.2022.05.14.12.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 12:42:59 -0700 (PDT)
Message-ID: <00059695-44a5-8842-0fbd-e89221f28d03@linaro.org>
Date:   Sat, 14 May 2022 21:42:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: qcom,pmic-gpio: add
 'gpio-reserved-ranges'
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20220508135932.132378-1-krzysztof.kozlowski@linaro.org>
 <20220508135932.132378-2-krzysztof.kozlowski@linaro.org>
 <CACRpkdZLsw7rU113x88MKxTUEPgueLHf+7Pu4FevCAQLP2jBqg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkdZLsw7rU113x88MKxTUEPgueLHf+7Pu4FevCAQLP2jBqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2022 01:18, Linus Walleij wrote:
> On Sun, May 8, 2022 at 3:59 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
>> 'gpio-reserved-ranges' property is already used and supported by common pinctrl
>> bindings, so add it also here to fix warnings like:
>>
>>   qrb5165-rb5.dtb: gpio@c000: 'gpio-reserved-ranges' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> This does not apply on top of pinctrl's devel branch, am I doing
> something wrong?

Hi Linus,

Sorry for any confusion. This is on top of my previous patchset:
https://lore.kernel.org/all/20220508135932.132378-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof
