Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CE857286B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiGLVUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiGLVUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:20:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E68BD38A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:20:20 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q7so11343780lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1mFxtDA9LSxUsU12njCqMZhvHHF7HJIJqn+iKNjF+Io=;
        b=sZmYBSMyhXlRcTmJDw7l4ckT+sUzRBhSVeZNyarvb5fOLbVBcCia4fICSqvoAZzIuO
         iDPbR++PVnLgjMJNL7fNtVKg72Uwde4p04nAV6qBLu3uYxLQHLB8is7o1MHx9qgIolmU
         /NJa6Sp6KALuiZ/OHHTHKr41eCoPB3LQf0bhWLNtmOl/FgEzOvEbERV5DfYNFscxPMah
         j7ipgsCO/ZxbZmS51OK1E/RQu2wAkSFDR2mtrKKisZkVl1EgaZWuc/I2Ks/1wEFQh3XK
         xJ7DV7MLfYPjnLfotUeXd/7BICIHy2tWY/r2uYoKFQ4bXRIIR0zVPZLJTgdyxaTz6+mp
         IjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1mFxtDA9LSxUsU12njCqMZhvHHF7HJIJqn+iKNjF+Io=;
        b=urVHRpcGqpQgDE/Bxo971Mjc4Cyf4aps0wZEcTgLgIfum+Ap9vLHhcptPQM9TsegDD
         K9BVbMuLJJiGbGa59qY+3ZHJ5b/D+R1Wdk5ngRrvXYnsxZllGWfCcDB0niYY8oiLLKny
         9wnmAD7PKQqTs+QwBQBDWKkv34QVkm/4tHgBrBfjRzRwYnml+qHiDxUYKUe9cgAWmp2R
         7+CdUN/FT7VidfDJQ++/wheK34+z/dMJn45BP061Jhot6h9jVxeFJ8AvI0OJi4bk6+c3
         md4CMVaTjRW6RgGLa35o4bTyGCLY1wt31F29z41RCxMy1ZA502pjM+3xA+lkUCmtb2ne
         WlKg==
X-Gm-Message-State: AJIora/AwsHlUzvFzEWsmQivzb8dROJZafY3UwrFp34DM9EcSD73GZWH
        gxsonpOt/aq0faYar2TlxmKgXdxproWsVQ==
X-Google-Smtp-Source: AGRyM1tYwKqNBj4xqQgq80zrrG/ToMGgLkH8wj5OKXw8TC37pLSSQVnojnIDcTfjeXcOI2+pWG4pEg==
X-Received: by 2002:a05:651c:1586:b0:25c:258:5837 with SMTP id h6-20020a05651c158600b0025c02585837mr1452ljq.260.1657660818354;
        Tue, 12 Jul 2022 14:20:18 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id o19-20020a05651205d300b0048910301774sm2375708lfo.307.2022.07.12.14.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 14:20:17 -0700 (PDT)
Message-ID: <0014fc7b-e6cd-a56b-0e3f-43660087bc2a@linaro.org>
Date:   Tue, 12 Jul 2022 23:20:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add Sony Tama TD4353 JDI
 display panel
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712200244.960018-1-konrad.dybcio@somainline.org>
 <68b8da6a-03e2-9da7-795d-f028bc0ed05b@linaro.org>
 <9b535332-838d-6662-d0eb-feab075b2915@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9b535332-838d-6662-d0eb-feab075b2915@somainline.org>
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

On 12/07/2022 22:50, Konrad Dybcio wrote:
> 
> 
> On 12.07.2022 22:47, Krzysztof Kozlowski wrote:
>> On 12/07/2022 22:02, Konrad Dybcio wrote:
>>> Add bindings for the display panel used on some Sony Xperia XZ2 and XZ2
>>> Compact smartphones.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>>  .../display/panel/sony,td4353-jdi.yaml        | 84 +++++++++++++++++++
>>>  1 file changed, 84 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
>>> new file mode 100644
>>> index 000000000000..d75abc72ad1b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
>>> @@ -0,0 +1,84 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/display/panel/sony,td4353-jdi.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Sony TD4353 JDI 5 / 5.7" 2160x1080 MIPI-DSI Panel
>>> +
>>> +maintainers:
>>> +  - Konrad Dybcio <konrad.dybcio@somainline.org>
>>> +
>>> +description: |
>>> +  The Sony TD4353 JDI is a 5 (XZ2c) / 5.7 (XZ2) inch 2160x1080
>>> +  MIPI-DSI panel, used in Xperia XZ2 and XZ2 Compact smartphones.
>>> +
>>> +allOf:
>>> +  - $ref: panel-common.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - sony,td4353-jdi-akari
>>> +      - sony,td4353-jdi-apollo
>>
>> Shouldn't the properties of panel like width and height be specified by
>> dedicated properties, instead of customizing compatible? The device is
>> "td4353-jdi", the same in both cases, isn't it?
> Not sure if it should, but in this case it probably could, the panels are
> software-compatible, yes.

There is width/height-mm property in panel-common, so if this is the
only difference - use them with only one compatible.



Best regards,
Krzysztof
