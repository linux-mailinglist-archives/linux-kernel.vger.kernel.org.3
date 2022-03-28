Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFCC4E9D49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbiC1RTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239644AbiC1RTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:19:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFE063BE7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:17:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b24so17708145edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PfGu1Gh5gOnyIlm1iZqOR1KzskMRiaHDBmIl7z2QE6I=;
        b=SS9lD2FartjqbmLvIybnxYK7DZu2mOa4V8OjcueWGmfHX7+9gyvVzz2YR231SARBlh
         tT/ACANSvNw+nR+IArymugrc8NoiWptCklXZ6AkM6tRyOphTeapK5odP+9gFQxn3t22w
         gAhBqmMnVOXhdFhDQUCdui2mBW14iFjrpkxvrNeHgfbovOK8gOXjiyO1/AWWkaTIliTK
         8hKLoAcIz//0MU+sOaNl9OcMObocqWkl2gPQ4FsyanmuyZ66sVR/Vwt0NHE44kAgNzZh
         InZ9rwqlN1jlO9QjKlNSOJqxAtwdSAdd8q4xXpJxalSzV5tY1vCYhkUJpMImvs4AO/ey
         lS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PfGu1Gh5gOnyIlm1iZqOR1KzskMRiaHDBmIl7z2QE6I=;
        b=MkKaYmHeQ+87RmjwROQgxVA00B8x691o2qYbNtrDzzhEMiGG62/siG9L1zCb13FZJR
         TkQcpiZW14m3zUAp/LzhdXowZLO26dtXOfkargSsNSgB0r9V8zUToKnIUq+hq2Omrs7I
         dqqY4ZQrDuwgN3b9+b2j4porNx9co2SFlgYFSLekC2xMK3gRWt4eGQa0B4CKy8hwZB8g
         9G1lbjECMv3VOw+67U7On6YKCfTdNwteOfE26DYh2cC7VS1VaAC77ywdBeejZ5VcQ5+l
         I4vZSwwRPC/bMQVIOL7orhREirCy8TYvTziFzhqWoh3QqOI4+qvzPCEoxOuNggRvC9fg
         dxNQ==
X-Gm-Message-State: AOAM530r3ZQlz7yGyjXR+1Qd24Ndz1pOL5dcOlHeu9C+VjDTe5n+7baX
        xXSbUW8i6xj8GFBlnDJ8cIlogg==
X-Google-Smtp-Source: ABdhPJyigBX1uqqXExWRAhFYFbuaenjSC8MKFfgbyUoYMWd4PQLdsdqvigzxFhceIqW/RQzj5hlXtw==
X-Received: by 2002:a05:6402:60e:b0:419:d2e:bcea with SMTP id n14-20020a056402060e00b004190d2ebceamr17695197edv.326.1648487877473;
        Mon, 28 Mar 2022 10:17:57 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402004300b004162aa024c0sm7190332edu.76.2022.03.28.10.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 10:17:57 -0700 (PDT)
Message-ID: <12b0056b-8032-452b-f325-6f36037b5a80@linaro.org>
Date:   Mon, 28 Mar 2022 19:17:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: display: msm: dsi: remove address/size cells
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220328152923.90623-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJprWoxWwk5EWEfWdLquPR+2=u6V0-v1-+wHMHOk8HiEyNw@mail.gmail.com>
 <YkHtY9absUjmqmW7@matsya>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YkHtY9absUjmqmW7@matsya>
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

On 28/03/2022 19:16, Vinod Koul wrote:
> On 28-03-22, 19:43, Dmitry Baryshkov wrote:
>> On Mon, 28 Mar 2022 at 18:30, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> The DSI node is not a bus and the children do not have unit addresses.
>>>
>>> Reported-by: Vinod Koul <vkoul@kernel.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> NAK.
>> DSI panels are children of the DSI device tree node with the reg = <0>; address.
>> This is the convention used by other platforms too (see e.g.
>> arch/arm64/boot/dts/freescale/imx8mq-evk.dts).
> 
> So we should add reg = 0, i will update my dtsi fix
> 

To "ports" node? No. The reg=0 is for children of the bus, so the
panels. How to combine both without warnings - ports and panel@0 - I
don't know yet...

Best regards,
Krzysztof
