Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EE856763D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiGESOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGESOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:14:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFE413F32
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:13:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bu42so2090116lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FPRBABzcy3/6j/H39EHsr5gxtbkpnqGjLMhqvBz/Czo=;
        b=djx0pAkFwqxgWa5my5EzUkiQpqLhNheKKV64f2/fsqX5W5FB9RS3ZDox4NcIcDRGdG
         Ya17IYQfDClXXzbe0qmpqiwE7hXOqKYLNcmVh0TpCknQWeRXvE6/VooRJ+5cpYDLs64C
         3pOh7GzWZGtvvEQFtJWTKUCt+lP5053ywVdpnfyANA8N9JX6cPv63LmrBikzmvX/ctUs
         +MTl5ghz2d374ToKZosd3eCN47RfGFZGg6spPpUATZVlurK0HleOV+uKRvyIKU1xuItK
         LqAKhCG5SEkeqcFJk3KifIBaw+wWi51JTYmsNGlFORvviG6RJvJmqR/JKwpniA/ddYMn
         sbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FPRBABzcy3/6j/H39EHsr5gxtbkpnqGjLMhqvBz/Czo=;
        b=GnYPUizxAJSnppXl7vU1CAxJEZZRF4DDqnE+d508a5JekARXjiEkw9R3vy/3ZvgNEe
         ER8ramaSbek0L7ccbP8t/b11FrewjZE+0xo3Vpglw+9cxbOAuvwL7p8sLz4og8sKTfa2
         DX8N8/iZcvyB+hR30WggPWuZnE3NC+D9HX8sPbNHebeD5Qt/eEwWWx7SvE0QcOtaZtra
         oUA5qbDXi/+i43usRI5sCJlre1tmfRXvRpv3utGGhq7QJrWWW/Ng6svqSFme/RKE+GjM
         rHTQ2GiQ6Cj76APWOql5acSZQ4Acs62X1m5wPV+GsVOrXL1CDkSnAzNptWFftPp9I7eL
         mxpg==
X-Gm-Message-State: AJIora9NNzCHfFMP1SZCgz4D6jx5rI7rbZ6k1vaguFC9ZLHd3Tm8kdnR
        u3WJtQfNg9ZHidwzUFPJyHNQJw==
X-Google-Smtp-Source: AGRyM1uBmRSnQOgKHceCWdDFKVuwOgtjkU/PRVtuYm24BdlUqxq1ppyibaQTEX/6mCzvVwBuEDOkWQ==
X-Received: by 2002:a05:6512:acb:b0:481:cce:3c22 with SMTP id n11-20020a0565120acb00b004810cce3c22mr22671522lfu.45.1657044837333;
        Tue, 05 Jul 2022 11:13:57 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s14-20020a19770e000000b0047f68d77008sm5812103lfc.178.2022.07.05.11.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 11:13:56 -0700 (PDT)
Message-ID: <5b6f5e15-f3fd-badb-3ada-eb2f58053857@linaro.org>
Date:   Tue, 5 Jul 2022 20:13:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 16/43] dt-bindings: phy: qcom,qmp-pcie: drop unused
 vddp-ref-clk supply
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-17-johan+linaro@kernel.org>
 <d3a49c05-0fd0-920e-bd0a-f821e8e27b8b@linaro.org>
 <YsQkmUVla9+CDYly@hovoldconsulting.com>
 <8d739c84-ba61-a030-ea8a-63a3f45c642c@linaro.org>
 <YsQx1SMEsMnmoQ2d@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YsQx1SMEsMnmoQ2d@hovoldconsulting.com>
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

On 05/07/2022 14:43, Johan Hovold wrote:
> On Tue, Jul 05, 2022 at 01:59:26PM +0200, Krzysztof Kozlowski wrote:
>> On 05/07/2022 13:46, Johan Hovold wrote:
>>>> It's okay to copy existing bindings which are applicable and then in
>>>> separate patch deprecate things or remove pieces which are not correct.
>>>> But all this in assumption that the first copy already selected only
>>>> applicable parts.
>>>
>>> But how would you be able to tell what parts I left out from the
>>> original copy 
>>
>> They are obvious and immediately visible. I see old bindings and new
>> bindings - no troubles to compare. I review new bindings - everything in
>> place.
> 
> Heh, with all these conditionals in place that may be harder than it
> sounds.

True and your patchset split does not make it easier.

> 
>> I don't want to review old code, inapplicable code. The patch I am
>> reviewing (the one doing the split) must bring correct bindings, except
>> these few differences like deprecated stuff.
> 
> Sure, I get that. But this very patch is an example of why I tried to
> remove things explicitly instead folding this into the original patch
> and risking it not being noticed.
> 
> It's not always obvious what is applicable and what is not, especially
> when the old schema is in the state it is.

Unless bindings are very precise, usually it's not visible what is
applicable or not, so there is just no benefit in multi-step approach in
split from old bindings. The same as with conversion of bindings, the
assumption is that original file was not correct, so we review the final
file.

> 
>>> unless I first do the split and then explicitly remove
>>> things that were presumably *never* applicable and just happened to be
>>> added because all bindings where combined in one large mess of a schema?
> 
> So you suggest we keep this regulator for all PHY variants even though
> it was probably only needed for UFS on some older SoCs?

No. I commented only that reason is not a good one. The proper reason
could be: there is or there is no such pin in the device or the history
tells that adding it for all variants was a mistake.

Best regards,
Krzysztof
