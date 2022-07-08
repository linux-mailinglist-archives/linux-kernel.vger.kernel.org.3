Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2CA56C1EC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbiGHTnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239896AbiGHTnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:43:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A79617E;
        Fri,  8 Jul 2022 12:43:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e12so37949289lfr.6;
        Fri, 08 Jul 2022 12:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BHFGKFejsr5X03hcfdP6B3GzZdhUa/GbrDRD409NVG0=;
        b=RPymnQZpGvFyqmFQ+7I7f6bbjZTxw5dJDK183PAqgcVfOipGvS9nyMwovUZmo8TA13
         uJWSV8itByJIvkZTOz+f5sPAhz+m01YiwUqmz574+8LlwujjK1FC8wQQCSSETgN6VbT4
         DIwWPzul5uiujNBpcehgntKrwoYCwOmRTFzgEoooSV/35K84ZWM4nihpdQclcwTmDIHF
         kLFFXyuxUFFIdUtEsePpgnPJ1R/qqt9ZkbZfuIL7iNsqDQQ8lxs0GT6VIAiXIPlhNROH
         TR5RBs0lzIsQXqofk2agGMI8TUI5PlgdM0/2PaoEfhwT0a/5b2eLgAEDv8WQRDK4PQID
         NgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BHFGKFejsr5X03hcfdP6B3GzZdhUa/GbrDRD409NVG0=;
        b=YJygxxV0MK61dntAJFwwykyOyO0mAfwKBKbT70p6o1LksmdyZN/cFoRzgLc8x5Uj5K
         h5sA7bg/UjhFgh4uuCJB/smpNFa9EoHrq4a2I9pojvgcOcfem4wEN5uKc4knrzLcTQV5
         RjWJ1dbvhV5Ld+e7DnbeCatX1qbkkwUkLyE1sRZN6CzRlQ3jMdga8Jpd+wKu0391+1Ac
         +BFF/dg9hOHwBlyafpdieUqpnIiyh4hVJEvzTFLy5LItzkn09eenmcnH5GsDnP+Qcd/d
         K9hopbPJrtPTxRuRJKU5kVCkj4RwICXDOdvdohBW/snvj4cdm7/wZT4Krt2t4Z7ESCC2
         KR+w==
X-Gm-Message-State: AJIora8eE4EiM6jp1STOXTdJVAn9SLwK0qxk6FzRMf4LMK1Ytuo2c8Ww
        kvul/bp9Szp9sHHiOQusi5U=
X-Google-Smtp-Source: AGRyM1sjwX3r5gjS5tg353B+hub3z95RPDfQo0yr1WwutP31zSJbDOR2bF+pknGYdiCO+CP0hwQpyg==
X-Received: by 2002:a05:6512:1195:b0:481:1675:f358 with SMTP id g21-20020a056512119500b004811675f358mr3615071lfr.235.1657309423217;
        Fri, 08 Jul 2022 12:43:43 -0700 (PDT)
Received: from [192.168.0.251] (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id v20-20020a05651203b400b0047255d210e4sm7592506lfp.19.2022.07.08.12.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 12:43:42 -0700 (PDT)
Message-ID: <9a925f87-a78b-0164-bdaf-99e14dc943cd@gmail.com>
Date:   Fri, 8 Jul 2022 22:43:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2,1/5] pinctrl: qcom: spmi-gpio: Add pm8226 compatibility
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dominik Kobinski <dominikkobinski314@gmail.com>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
References: <20211125213451.62010-1-dominikkobinski314@gmail.com>
 <20211125215310.62371-1-dominikkobinski314@gmail.com>
 <CACRpkdau+wHpoWa1JrLt35dnCHJejs8HZkkzZCrrcnRCx3SinQ@mail.gmail.com>
From:   =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>
In-Reply-To: <CACRpkdau+wHpoWa1JrLt35dnCHJejs8HZkkzZCrrcnRCx3SinQ@mail.gmail.com>
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

On 26.11.2021 2.49, Linus Walleij wrote:
> On Thu, Nov 25, 2021 at 10:53 PM Dominik Kobinski
> <dominikkobinski314@gmail.com> wrote:
> 
>> Add support for pm8226 SPMI GPIOs. The PMIC features
>> 8 GPIOs, with no holes inbetween.
>>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Suggested-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
>> Signed-off-by: Dominik Kobinski <dominikkobinski314@gmail.com>
> 
> I applied this to the pinctrl tree.
> 
> Is there anything else I should be applying?
> 
> Yours,
> Linus Walleij

I noticed that this patch was never applied into kernel while the other 
patches such as the device tree documentation were applied. Maybe it was 
missed accidentally? I checked also the pinctrl tree and didn't find the 
commit there either in the branches for the upcoming releases.

-Matti
