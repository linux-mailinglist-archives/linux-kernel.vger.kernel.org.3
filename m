Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77C5522F09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiEKJM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiEKJMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:12:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2B274862
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:12:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w24so1776309edx.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iSM4KiWX5xiHYNImgQ6cDdJf0LCKtuaDlzcLfop++Jc=;
        b=FM/vJ5D6P9x5+MqRB5GdGmrNf9cYDyJXebGhlNhF2u1A7m2Q+A93DNdO8nK1CBEXer
         zqeo1Rkj7fSn7aO7BsPCAjVkbeq1WnvazQSNJeLEGXJzEr9BrC6MptVVEkqRqLDGqy9R
         ctQbLtbuvZ0bdkBsXU1A1mkJ5FBorUWEZZI9KYJiL/koaHgU+0cm2wnXhQV0KSO0mq5O
         rAQnl9p0rTja6EPjoI73YbS2GoLZZ5fKSQBQMDLQRaSLpVa3lHf6+czUrqLjcSkyzkfy
         90h3XmzZ9y/bIriHXMRqYwCUCiUTbZMVemBEwuFENyHguqz3IH6U79m8+QWZZgn6nEMk
         WHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iSM4KiWX5xiHYNImgQ6cDdJf0LCKtuaDlzcLfop++Jc=;
        b=Sd7vsgsla/Oxf1ITcbxJIEG/PkG5eUsnuzfQ9lvLMQXJHVG4G1rj9PZhsFLjsAJAbz
         ZN2jQhZQfG/e+NdamSMgKJpTZPvVbox1l6bhJZNWxtUpFC1I9QoLHse2ZSFUYgUO2f6q
         8U7Kwy87kk2NlR4XZ//voxg7OvyrnboxiaWku6l2V27fMxoer2Qljlgq86zh2sRKEIcd
         Nxy8TdP2YwzG+Mt2dhPLnEHl1dwMa9KZxoLkpHqYiyMZc3UmUod824Woc5uBwrmM3sNQ
         6lGooKY0JUp4lFyWcZqek5fzLlVLPo/3Kzm6ph+y8IoBuIhlWVp3+LWtt1X5dJWpZ39B
         3dUg==
X-Gm-Message-State: AOAM531L5aR1l8WFNXrueqKBTi+xzHLhH6RwTYOoJY3baZny0ysX80v7
        HCChvG1VFc0WslaRYtdmDaVONQ==
X-Google-Smtp-Source: ABdhPJwAJshh0pyoM8iVsERACEz5gij6am1vxgOpfUotlGosF/fppxLJBLF71r5SRAXCzg2PJZXhpA==
X-Received: by 2002:a05:6402:f13:b0:428:a849:d0c1 with SMTP id i19-20020a0564020f1300b00428a849d0c1mr11917128eda.346.1652260367481;
        Wed, 11 May 2022 02:12:47 -0700 (PDT)
Received: from [192.168.0.152] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cb13-20020a0564020b6d00b0042617ba639asm893261edb.36.2022.05.11.02.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 02:12:46 -0700 (PDT)
Message-ID: <66796853-efe7-f661-9637-ac6cfefc68e5@linaro.org>
Date:   Wed, 11 May 2022 11:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/2] dt-bindings: remoteproc: mediatek: Make l1tcm reg
 exclusive to mt819x
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20220506213226.257859-1-nfraprado@collabora.com>
 <20220506213226.257859-2-nfraprado@collabora.com>
 <d3e027ca-9ccf-cf91-2414-85d2b9b680f0@linaro.org>
 <20220510165016.r7nyck2abt5m4djp@notapiano>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220510165016.r7nyck2abt5m4djp@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 18:50, Nícolas F. R. A. Prado wrote:
>>> Also I had to add a description to the global reg-names, since it
>>> couldn't be neither missing nor empty.
>>
>> It is possible:
>> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/example-schema.yaml#L91
>>
>> Keep constraints and list of names in properties. Then in allOf:if:then
>> raise minItems or lower maxItems, depending on the variant.
> 
> Hi Krzysztof,
> 
> that example only shows setting minItems to override the default value, but the
> issue here is that it's not possible to override minItems/maxItems (after
> they're already set, even if implicitly) with a different value in the if.

No, this example shows exactly what you need in first step - make one
item on the list optional.

There are several other examples for the entire picture or different
aproach:
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/example-schema.yaml#L91

https://elixir.bootlin.com/linux/v5.18-rc2/source/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml#L53

> 
> That is:
> 
> 	properties:
> 	  reg-names:
> 	    items:
> 	      - const: sram
> 	      - const: cfg
> 	      - const: l1tcm

You did not use the example I gave you. Where is the minItems?

> 
> 	if:
> 	  properties:
> 	    compatible:
> 	      enum:
> 		- mediatek,mt8183-scp
> 		- mediatek,mt8186-scp
> 	then:
> 	  properties:
> 	    reg-names:
> 	      minItems: 2
> 	      maxItems: 2
> 
> Generates the error on dtbs_check:
> 
> /home/nfraprado/ext/git/linux/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtb: scp@10500000: reg-names: ['sram', 'cfg'] is too short

Missing minItems in first properties.

> 
> I believe the tooling is implicitly adding
> 
> 	      minItems: 3
> 	      maxItems: 3
> 
> to the common reg-names, and since it's not possible to override them, the
> override to 2 doesn't work so they are kept at 3, causing the error.
> 
> Moving the minItems/maxItems to the common reg-names as a test gives:

You cannot just. You need it in both places.

> 
> /home/nfraprado/ext/git/linux/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml: properties:reg-names: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 'sram'}, {'const': 'cfg'}, {'const': 'l1tcm'}]} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 
> That error, plus looking in the items meta-schema, suggests me that maxItems
> isn't supposed to be set lower then the length of items. So even if the
> minItems/maxItems override is fixed, there's still this issue. It seems like
> defining the reg-names list separetely in each if branch is indeed the right way
> to go.



Best regards,
Krzysztof
