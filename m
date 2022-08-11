Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363AE58F784
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiHKGVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHKGVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:21:40 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777727FE68
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:21:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s9so18332355ljs.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=lyTs0msMVRVl1NUIwPFvCz6xKYL3ajDC0cSoOz8c7XI=;
        b=FDV+lVhjw2kjDqTw4xfkooXjCluNrUuws4Xo5sbG5kfTLntDeDFgHP+PGT4OmaGMAQ
         cP20yptfuT0hLFAlcJ8UlBjqxXhvcaxEOCK6dIBAdQjqwXKvi57z4JtK+Xo/Q996qfiA
         VpD8Q8hFnyu06jHrhOGHMvzP0ygb6w1Hmw4KcVTFjQwb6vSh/oOGo5yQcKEM9kuegtx6
         lvUUouNQ4njGlvJTQOo/NPafJ99G/faXb6FwndWk0ZNA+CBIYhZlbjaNgw5tgr/qs4qb
         nfYlFAK179k+PGlmniTnKrWiFc2nCPq1J/BHXMuHly89aeNYK3h+s4Rafx+mjVn6F6Fv
         Noig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lyTs0msMVRVl1NUIwPFvCz6xKYL3ajDC0cSoOz8c7XI=;
        b=MdYAIYsl1/mh8xPLZEH1wFS2dMHU3FYJWiHlOc+UtJEMLrMzfCz4jrQqztV/85fpQz
         vt8QRo4EzMXCGQSOBWnuyNwbRhx+0qhFW73xSFKrJ3AQgZb3Ito667gvvaIh5YH1trYo
         mVH7XEqyKciDzIdt1DD90UzqX2rMO/ZCX6Bfrq9KHnlHh8sA0jRH7uhFtKwavDyRgRpL
         NURwjkKnTPx1Dsj2gtv4oNaz7epC1YnOgpuMAdUPsjf+ZdVnsS7lrjaCOhvysYNLApu3
         2tiKu2au5kgEBfhVQZuylLYdPbLX6UdXmoY1pH7Wd1suIFPLGFOxIh8DHLE3XGg7GT91
         Vfrg==
X-Gm-Message-State: ACgBeo3rCb2EcJepYv/LQtsldNrjWYPH2UsfwcdnqbXASCuJTdRDsdYd
        Z4IJcEMqSLsWO8nZej60Kuxt3g==
X-Google-Smtp-Source: AA6agR5PfCABBMzNdydhDAoRM7n+bYDqAckQIGcBfUqUJzialeclBQo6ABctsz1WRiMUt4Tcp3sWiw==
X-Received: by 2002:a2e:a411:0:b0:25e:5798:9fd with SMTP id p17-20020a2ea411000000b0025e579809fdmr9591658ljn.502.1660198897767;
        Wed, 10 Aug 2022 23:21:37 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id a5-20020a056512390500b0048aeafde9b8sm589362lfu.108.2022.08.10.23.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 23:21:36 -0700 (PDT)
Message-ID: <219a875c-f46c-fde9-4370-4168d440e614@linaro.org>
Date:   Thu, 11 Aug 2022 09:21:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: input: ariel-pwrbutton: use
 spi-peripheral-props.yaml
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org
References: <20220727164230.385614-1-krzysztof.kozlowski@linaro.org>
 <20220728151942.GA903363-robh@kernel.org> <YvQ3viBmbzuai+LC@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YvQ3viBmbzuai+LC@google.com>
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

On 11/08/2022 01:57, Dmitry Torokhov wrote:
> On Thu, Jul 28, 2022 at 09:19:42AM -0600, Rob Herring wrote:
>> On Wed, 27 Jul 2022 18:42:30 +0200, Krzysztof Kozlowski wrote:
>>> Instead of listing directly properties typical for SPI peripherals,
>>> reference the spi-peripheral-props.yaml schema.  This allows using all
>>> properties typical for SPI-connected devices, even these which device
>>> bindings author did not tried yet.
>>>
>>> Remove the spi-* properties which now come via spi-peripheral-props.yaml
>>> schema, except for the cases when device schema adds some constraints
>>> like maximum frequency.
>>>
>>> While changing additionalProperties->unevaluatedProperties, put it in
>>> typical place, just before example DTS.a
>>>
>>> The binding references also input.yaml and lists explicitly allowed
>>> properties, thus here reference only spi-peripheral-props.yaml for
>>> purpose of documenting the SPI slave device and bringing
>>> spi-max-frequency type validation.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Technically, this depends on [1] merged to SPI tree, if we want to
>>> preserve existing behavior of not allowing SPI CPHA and CPOL in each of
>>> schemas in this patch.
> 
> Could we merge this through SPI tree as well?
> 
>>>
>>> If this patch comes independently via different tree, the SPI CPHA and
>>> CPOL will be allowed for brief period of time, before [1] is merged.
>>> This will not have negative impact, just DT schema checks will be
>>> loosened for that period.
>>>
>>> [1] https://lore.kernel.org/all/20220722191539.90641-2-krzysztof.kozlowski@linaro.org/
>>> ---
>>>  Documentation/devicetree/bindings/input/ariel-pwrbutton.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>
>> Acked-by: Rob Herring <robh@kernel.org>
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 

There is no dependency anymore (and actually that time it was not really
dependency), so you can take it freely for next cycle.

Best regards,
Krzysztof
