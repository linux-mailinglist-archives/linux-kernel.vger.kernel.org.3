Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F65C55739A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiFWHKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiFWHKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:10:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDCE45534
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:10:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h23so39022680ejj.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tuAsDh6ucKESxsdiSZcdIthCGQnzlk9mmfrcHG2iA/A=;
        b=k4AdahiduJwbRRrlLYnDkTBxnXPULU8EsSsKDgjM192KdUz1q79NbQlx67tncTv9WR
         dJyAIlhWCepdwRz4igjrMh35uNeXgRCAWwiyWmth/8hLfwb3ZTBSsqfgy5r04qDRK9CH
         Gh6g0JM+Fyv59eDifA6RFPsoMfkoI+f/4Sx7HgiPQDZVafOtyu0uzVXTw5XDaVrgY8A/
         H0YdGhDxorkrMyTmpVTOquKodh24xUvWNKggOKObQK1UyZd/Idl/6S51Oz8TIni/SYdm
         iimCazHC2XGt0gxuQ7IHrDKEayFCNL7oqSaQe5TllniqP/31FG6V0/8ijYtS06KH3JzT
         gj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tuAsDh6ucKESxsdiSZcdIthCGQnzlk9mmfrcHG2iA/A=;
        b=P+5tCMZufDHqtVYg9ofn1QSdxsqO17jTeZmjIcCLfLrDkPO+Wigp54dipudPEKXPV8
         u+sSg0JyRZ8Hc/BkQ450Mx7C9GLz/3zORXjFTzDx5cqsWxMKvZrGLD02cwReL8YOKESb
         3ltC8T90RDDdFhvKzzUiGbeEDxMRGQHktBePICUAtPGSB9tcx59pa2Rw1HzRZP44mmhj
         NafhWXcqKVOSCIrnRjfllEAGjOdk+1RbFJCVogZFHus12fk89OJT+/XyPWK0o0e5sW8/
         USCEv3V5LPVWU4mPIO2iqTPAjiDXe9wkwT5f274946ypKUGIYS08D3dXyTChhabzwsyO
         x7Gg==
X-Gm-Message-State: AJIora+Er4Juba2HUgbp/QsWu0nQQsoEDbjDq99rsbUJJ0O6v+oF5g5b
        Eoj0worzUhFsGPs3BN7z9hqTjg==
X-Google-Smtp-Source: AGRyM1u7ecil3twaUG0Avny7RVyJxwjRhiEYGdWWNHrbEmPYuywGZuvfO1PXd4QE2NXFsLZ9uc0qrQ==
X-Received: by 2002:a17:907:c26:b0:711:ca03:ab3c with SMTP id ga38-20020a1709070c2600b00711ca03ab3cmr6967550ejc.654.1655968235516;
        Thu, 23 Jun 2022 00:10:35 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b006fec8e8eff6sm2286606eja.176.2022.06.23.00.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:10:35 -0700 (PDT)
Message-ID: <bd070c5d-4765-092d-8f10-fefd0361f65e@linaro.org>
Date:   Thu, 23 Jun 2022 09:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/7] dt-bindings: arm: aspeed: document board compatibles
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        David Wang <David_Wang6097@jabil.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Steven Lee <steven_lee@aspeedtech.com>,
        Ken Chen <chen.kenyy@inventec.com>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-2-krzysztof.kozlowski@linaro.org>
 <0207c2fe-7c01-7852-3cd1-74297cd4857d@linaro.org>
 <CACPK8Xc=dmaJtLXGsQa8bBdWDnSbwyW3f_yaQr4HqT0WvyScRg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACPK8Xc=dmaJtLXGsQa8bBdWDnSbwyW3f_yaQr4HqT0WvyScRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2022 07:36, Joel Stanley wrote:
> On Mon, 20 Jun 2022 at 11:06, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 29/05/2022 12:49, Krzysztof Kozlowski wrote:
>>> Document all compatibles used in existing upstreamed Aspeed AST2400,
>>> AST2500 and AST2600 based boards.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  .../bindings/arm/aspeed/aspeed.yaml           | 83 +++++++++++++++++++
>>>  MAINTAINERS                                   |  1 +
>>>  2 files changed, 84 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>>
>> Joel, Andrew,
>>
>> Any comments on the series? Rob applied only patch 1, so the rest is
>> supposed through Aspeed tree. Shall I pick them up and send to arm-soc?
> 
> I will take a look at them when it's time to send patches for the next
> kernel release.

But that's not how the next development works. Patches, if proper/good,
should be applied in some reasonable amount of time and then sit in
maintainers tree. This way the patches will be in linux-next, assuming
that maintainer correctly added it to linux-next. All other people can
then easily base their work on linux-next or maintainer's tree and
continue their development.

Waiting with the patches till time to intreract with arm-soc (usually
some late in the cycle, like rc5-rc6), not providing review, does not
allow other people to see accepted contributions and base the work on them.

Really, there is no single reason to hold on patches till there is time
to send them to arm-soc. It's the first time I hear something like this
about SoC or any other tree.

> 
> They should go through the aspeed tree like the rest of the aspeed
> device tree patches.

Of course, but somehow they were not going...

Best regards,
Krzysztof
