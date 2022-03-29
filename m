Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC74EAC8F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiC2LrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbiC2LrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:47:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429B16C481
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:45:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r13so34549296ejd.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j1x0lkzEnz6Ag44boIJpxEzXaCp1e5GyDI+ZSQvxZtE=;
        b=J38b0s4L1M9EoJm3AoZIhtKKxJc5xiO3PZs9l7XK4JKx+6X0mIIS+yQF/WSkclBfoD
         /tNa2dX49JQAdTDdCmS+yvySa0CNgsm0Xu+Wp/ViSqaUA2hJ2gt8rV2+CjmES1qeqaGE
         w9SdDucCp94NRMpHBdOHefy0Vbp01P5h2pe5wQ09Xfv5MmaPLeXURIwuQ7vIJesy3b2Z
         KDUhJt52NB486vqv+LInhLiTKq3joUmbAQdd7K5MUnFC7asMPxQWJK+zIUSw1G5CQZBH
         tNYXAANyVGBirRKEu5z/sUEzPKxwSzCN8Jhp91p9IPDZYdufjQe7FmyVgxqEQQD7GfAR
         LFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j1x0lkzEnz6Ag44boIJpxEzXaCp1e5GyDI+ZSQvxZtE=;
        b=f+8+9+C332DeqySRAPNe4G1RcxHzxVTuDAlAFaFJMZiHAWjG648bLnasIzlageGdr9
         3GjYMoKaLEuWX1noc10XZ0bB8GuuF39eQ0X0gdUNyz24uee60mjNJc41XKFTVgCGB/qZ
         CLPc1wl0vgWpae63HC1qLdqrIoIZ0McJUJnwY9nk9E9QaxlpiZbz3Q3UXYcDXsNxinnp
         roxiTEnlffKeETFxGESg2nmQ2k9rXITqDTwsUdWXau54/tO947UIdfVFsyaUi1Gm4FYE
         AksnnKc+jvdvZkQWV9ikBpZslamBCmgytXeNCnyeRNgfxUnb+4nVMAc8wsag0OBhPaVN
         EVtA==
X-Gm-Message-State: AOAM532n4T/QqnlM8ozvAt+ySMG81OAPInzMfjfKPgfCyPfn+ZSzImZ6
        xN9sWoOyqjHrXUtUMhOEBHCtHQ==
X-Google-Smtp-Source: ABdhPJxo/IibVl8TCMJ3rirN0I5mcKTdxml5fi0IRvVtodGPnTfjiczC0H5+KUVS1X1GtE9CD0kVYA==
X-Received: by 2002:a17:906:66cb:b0:6cf:e4f7:9504 with SMTP id k11-20020a17090666cb00b006cfe4f79504mr34474024ejp.142.1648554322817;
        Tue, 29 Mar 2022 04:45:22 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id jg15-20020a170907970f00b006e0466dcc42sm6991145ejc.134.2022.03.29.04.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 04:45:22 -0700 (PDT)
Message-ID: <1ff5682f-3f59-8635-631f-d648e604044f@linaro.org>
Date:   Tue, 29 Mar 2022 13:45:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] dt-bindings: phy: uniphier-ahci: Fix missing
 reset-names
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648433152-23126-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648433152-23126-4-git-send-email-hayashi.kunihiko@socionext.com>
 <2e0be70f-f800-e3f8-363e-6598468fa091@linaro.org>
 <54a88acd-49ed-01f6-4108-b74bc653a612@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <54a88acd-49ed-01f6-4108-b74bc653a612@socionext.com>
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

On 29/03/2022 12:55, Kunihiko Hayashi wrote:
> Hi Krzysztof,
> 
> Thank you for reviewing.
> 
> On 2022/03/29 3:58, Krzysztof Kozlowski wrote:
>> On 28/03/2022 04:05, Kunihiko Hayashi wrote:
>>> Add missing "phy" reset-names to fix the following warning:
>>>
>>>    uniphier-pro4-ace.dtb: ahci-phy@10: resets: [[26, 28], [26, 12], [26,
>>> 30], [36, 0], [36, 1], [36, 2]] is too long
>>>        From schema:
>>> Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>>    uniphier-pro4-ace.dtb: ahci-phy@10: reset-names: 'oneOf' conditional
>>> failed, one must be fixed:
>>>        ['link', 'gio', 'phy', 'pm', 'tx', 'rx'] is too long
>>>        From schema:
>>> Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>
>> There is no ahci-phy in current sources...
> 
> Oops, I'm going to add ahci controller to the existing devicetree,
> but not yet. I shouldn't write the future warning in the commit message,
> so I'll fix it.
> 
>>>
>>> Fixes: 34f92b67621f ("dt-bindings: phy: uniphier-ahci: Add bindings for
>>> Pro4 SoC")
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> ---
>>>   .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml   | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>> index 3b400a85b44a..14f7579e7daa 100644
>>> ---
>>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>> +++
>>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
>>> @@ -43,13 +43,14 @@ properties:
>>>
>>>     resets:
>>>       minItems: 2
>>> -    maxItems: 5
>>> +    maxItems: 6
>>>
>>>     reset-names:
>>>       oneOf:
>>
>> As a separate commit, this oneOf should be converted into allOf:if:then:
>> cases which will enforce the resets per compatible.
>>
>> Can you do that as well?
> 
> Ok, I've found some examples using "allOf:if:them:" cases,
> so I'll try to convert it with another commit.
> 

For an example, you can take a look at (linux-next):
Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml

and clocks/clock-names properties.


Best regards,
Krzysztof
