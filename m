Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5439059270B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 02:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiHOAQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 20:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHOAQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 20:16:06 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871F111A2A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 17:16:05 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x10so6232926ljq.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=l3+yF3qhdS96OdDhc9XMFg04673o05VuwvwuRib16k4=;
        b=iP6IhE5UUNDdzXpkiESuc7r4lK/Sz4ILj1L2l2FcZ2Bcb6TD0Nswu5gkGWnehzZ+Yd
         yHTkTCXhaU9Zg5cl2LOImc7oGIaZLLN+uzL9qdFQKz6OJTwXhMW5vLO0nHTr1L6WGQHx
         QIKbH2hWClQhoBiiL/V8keNYs4jVUYpEEKz5NbOq4vlkcITA0uzXpZ7g0+NLiXs3hK3Q
         9QSsSrjhLznzEHNRvkr+7mI7HoCQ5J7MOOqw/mQe3Kwuo1s2Jvg8AyC2YvZtyPJJa9vj
         Qlhc0AsGeeu8F8ZeIBYp/7uHAmyZEoC5k98y9gOel2XWwBeMMxFCqRAebz7PSg+xgzde
         jbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=l3+yF3qhdS96OdDhc9XMFg04673o05VuwvwuRib16k4=;
        b=GQy3H1Yjum0XweuAHHG51ucDDlwZMVSFAe/V4ko0UWMu7V2iLMmwZN2amlO0tRCq1U
         OCzvaiw3T9H4Bo72qLy0pBCpsj7Y4X8IdKrd3B+EW6twjyElcMgDAxpoSu3OisqBdn2O
         MuvCnWe2+iFDCs+w8iK3NW6n3LZV5TiyrF4JVcmp/OuWAV8pmV/aCSUAlRsc0lGFBu20
         1mEeT3h/9LjH5yznztGYOSV7QBrvpfcIQNVDtWSe66qLuYibozY4tSR9WO1AuGnKws55
         9Axz8JEDGzPtV9ccEnFTi38ceuK1qZuzXCqUVaaMiz/mEuabV0WdxFARCCN9/HmbPqoO
         Chag==
X-Gm-Message-State: ACgBeo19wfM1B5qTYetuZn0olOOJsSyZ7r1tA/d7rFQC62KFUUSn/f0E
        HFOeFALBj1XVlVbzBsBxjSU=
X-Google-Smtp-Source: AA6agR5vwbw5fkg1bibtipX+1uR4elcGwZEDSv1oZrn8eLenUGXy2mB3I2/nLNDx60tnXzBOPiKKEA==
X-Received: by 2002:a2e:9417:0:b0:261:7f6a:7ed3 with SMTP id i23-20020a2e9417000000b002617f6a7ed3mr2052350ljh.184.1660522563301;
        Sun, 14 Aug 2022 17:16:03 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-13.nat.spd-mgts.ru. [109.252.119.13])
        by smtp.googlemail.com with ESMTPSA id s2-20020a056512202200b0048ae8e4cebdsm936237lfs.139.2022.08.14.17.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 17:16:02 -0700 (PDT)
Message-ID: <5a1df5ce-a497-760b-8e2c-130a0e659c0b@gmail.com>
Date:   Mon, 15 Aug 2022 03:15:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] drm/bridge: sii902x: add support for
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     jernej.skrabec@gmail.com, jonas@kwiboo.se,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent.pinchart@ideasonboard.com
References: <20220113144305.1074389-1-narmstrong@baylibre.com>
 <25976b46-21b4-6e3f-0182-85dd4ca2b654@gmail.com>
 <a4a36360-3f77-17a0-9239-08cb8c08de74@baylibre.com>
 <13bd6440-9a61-d444-518c-f4e8cba0b825@baylibre.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <13bd6440-9a61-d444-518c-f4e8cba0b825@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.08.2022 12:51, Neil Armstrong пишет:
> On 08/08/2022 11:15, Neil Armstrong wrote:
>> Hi Dmitry,
>>
>> On 31/07/2022 22:07, Dmitry Osipenko wrote:
>>> 13.01.2022 17:43, Neil Armstrong пишет:
>>>> This adds support for DRM_BRIDGE_ATTACH_NO_CONNECTOR by adding the
>>>> bridge get_edid() and detect() callbacks after refactoring the
>>>> connector
>>>> get_modes() and connector_detect() callbacks.
>>>>
>>>> In order to keep the bridge working, extra code in get_modes() has been
>>>> moved to more logical places.
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> ---
>>>>   drivers/gpu/drm/bridge/sii902x.c | 129
>>>> ++++++++++++++++++++++++-------
>>
>> 1 file changed, 99 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/sii902x.c
>>>> b/drivers/gpu/drm/bridge/sii902x.c
>>>> index 89558e581530..65549fbfdc87 100644
>>>> --- a/drivers/gpu/drm/bridge/sii902x.c
>>>> +++ b/drivers/gpu/drm/bridge/sii902x.c
> 
> [...]
> 
>>>>       }
>>>> +    endpoint = of_graph_get_endpoint_by_regs(dev->of_node, 1, -1);
>>>> +    if (endpoint) {
>>>> +        struct device_node *remote =
>>>> of_graph_get_remote_port_parent(endpoint);
>>>> +
>>>> +        of_node_put(endpoint);
>>>> +        if (!remote) {
>>>> +            dev_err(dev, "Endpoint in port@1 unconnected\n");
>>>> +            return -ENODEV;
>>>> +        }
>>>> +
>>>> +        if (!of_device_is_available(remote)) {
>>>> +            dev_err(dev, "port@1 remote device is disabled\n");
>>>> +            of_node_put(remote);
>>>> +            return -ENODEV;
>>>> +        }
>>>> +
>>>> +        sii902x->next_bridge = of_drm_find_bridge(remote);
>>>> +        of_node_put(remote);
>>>> +        if (!sii902x->next_bridge)
>>>> +            return -EPROBE_DEFER;
>>>
>>> Hi,
>>>
>>> This patch broke ARM/QEMU vexpress display because of_drm_find_bridge()
>>> always fail with -EPROBE_DEFER. Reverting this patch returns display
>>> back. Please fix or revert, thanks in advance.
>>
>> Can you share a QEMU cmdline to reproduce ?
> 
> Actually the vexpress DT has multiple input ports instead of a single
> input port at @0
> and an output port at @1 like documented in the bindings:
> 
> vexpress-v2m.dtsi#L303-L307:
> ports {
>     #address-cells = <1>;
>     #size-cells = <0>;
> 
>     /*
>      * Both the core tile and the motherboard routes their output
>      * pads to this transmitter. The motherboard system controller
>      * can select one of them as input using a mux register in
>      * "arm,vexpress-muxfpga". The Vexpress with the CA9 core tile is
>      * the only platform with this specific set-up.
>      */
>     port@0 {
>         reg = <0>;
>         dvi_bridge_in_ct: endpoint {
>             remote-endpoint = <&clcd_pads_ct>;
>         };
>     };
>     port@1 {
>         reg = <1>;
>         dvi_bridge_in_mb: endpoint {
>             remote-endpoint = <&clcd_pads_mb>;
>         };
>     };
> };
> 
> bindings:
>   ports:
>     $ref: /schemas/graph.yaml#/properties/ports
> 
>     properties:
>       port@0:
>         $ref: /schemas/graph.yaml#/properties/port
>         description: Parallel RGB input port
> 
>       port@1:
>         $ref: /schemas/graph.yaml#/properties/port
>         description: HDMI output port
> 
>       port@3:
>         $ref: /schemas/graph.yaml#/properties/port
>         description: Sound input port
> 
> The patch is conform to the bindings, the DT was working but is actually
> not valid.

I haven't looked closely at how to fix this properly, but if we can fix
it using of_machine_is_compatible("arm,vexpress") workaround in the
driver, then it will be good enough at least as a temporal fix, IMO.
