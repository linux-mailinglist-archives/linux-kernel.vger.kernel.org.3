Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA6051F499
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiEIGtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiEIGnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:43:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD1118FF2A
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:39:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dk23so24822461ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 23:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UV9zjmHYlW+6A7MQ6c6pItDR5gnRmcinDnUlAmO8o4s=;
        b=hzjmM6oUphOTv/1VPY1VsofK8BtDOdAvdqw4l2wRm3nyyk3knoYA+470tzaBgBWByW
         oEx9yq4xf8wLj8MarLGMhbvPhJitxVqIkJndkI0RUgIahTHHllfHLmQ2Cr3DEPh8mprK
         T3jeoqxaCup6Y39F7tDd3zWaxPGAX0dtt4CaEzuZogh/QsUqL5yB1rdpHej9KjW1zq2I
         4dL4ePYA2i/GnSoUFPfAHtketeRvOuxR+KBqGYwlAIN1Nv1AuSBG+gczDO8xiEQDEwCZ
         hjMEsjHmmft2ZOAncTFIIHmOZE9IOLHUXfBC+/3qUVuevlU0m7kZ1HcWMDpVEMfE5Hfs
         GzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UV9zjmHYlW+6A7MQ6c6pItDR5gnRmcinDnUlAmO8o4s=;
        b=XWLuAGZ2+IdOUY2yggJlBaSjeaCnCJxeld/Cyutk0jkzxcVf0L+kB+8z69HdjdiySJ
         0LcCKHUYUEtGq0gI7igw6G7ZjCDBlKWmQ6QEgt8OC8pWUSzP8yGf+l3qQhkYWubxW8X/
         MbxyDrt6P7BLbLK0o6+Gp6+RXgHttA2Qi1eVckHNrRrbpx1o8/o7uzmzOYUbPaM0DhWg
         b8iueK4IzksFgRiCoHFJaHlMOY41NCIG3lAnacZUAbpUgFZzn9z5BraAzp5U56wWwA94
         5RHGyK7JE96cXhyaO37m56LJ/+5ENIERvdfPqXcqz/xRjVl2/ZJmtceS2dEqX5IUES00
         kdrg==
X-Gm-Message-State: AOAM530k+QsvMIHYAv6PGHVOxEESk41RU4zEOEyB+102wv9KB0ogxupP
        ifmpXkR0l8J7PgQJNGk5deQt7A==
X-Google-Smtp-Source: ABdhPJwods/7Sd25/CejtLdRC3yOQ4HyzjC7vaMwqSaAKsR5nOmQu3wz5BjBUvUcVGvObNORipndng==
X-Received: by 2002:a17:907:8693:b0:6f8:635a:1d32 with SMTP id qa19-20020a170907869300b006f8635a1d32mr7747735ejc.663.1652078333319;
        Sun, 08 May 2022 23:38:53 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id mj9-20020a170906af8900b006f4c82c2b12sm4693247ejb.19.2022.05.08.23.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 23:38:52 -0700 (PDT)
Message-ID: <0fdfcc16-7b80-47e9-709c-648d3a0cd6fc@linaro.org>
Date:   Mon, 9 May 2022 08:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] dt-bindings: display: Add bindings for EBBG FT8719
Content-Language: en-US
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     airlied@linux.ie, clabbe@baylibre.com, daniel@ffwll.ch,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        fanghao11@huawei.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        phone-devel@vger.kernel.org, robh+dt@kernel.org, sam@ravnborg.org,
        shawnguo@kernel.org, stano.jakubek@gmail.com,
        thierry.reding@gmail.com, ~postmarketos/upstreaming@lists.sr.ht
References: <2ab35af2-b067-4243-35ed-a592a7046374@linaro.org>
 <BY5PR02MB7009A604AC912DC78FAF42A5D9C69@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BY5PR02MB7009A604AC912DC78FAF42A5D9C69@BY5PR02MB7009.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 07:08, Joel Selvaraj wrote:
> Hi Krzysztof Kozlowski,
> 
> A quick question.
> 
> On 07/05/22 21:02, Krzysztof Kozlowski wrote:
>  >> +  backlight: true
>  >> +  port: true
>  >
>  > Both should not be needed - they come from panel-common.yaml. They might
>  > stay in list
> 
> I see that almost 54 panels mention "port: true" and 46 panels mention
> "backlight: true". Almost all panels refer the panel-common.yaml too.

They need them only if they use "additionalProperties:false".
> 
> So I think specifying them as true is just for extra clarity that
> these properties are usually used by this panel? But I am not very sure.

If they don't use additionalProperties:false, then the explanation could be:
1. Just for clarity as you say, because they might want to require
property/node which is listed in the properties, otherwise it is a bit
confusing.
2. They were copying first example without actually checking...

> Should I leave them be? or it's still recommended to remove them?

It's not a big deal and I do not have strong opinion, but I would
propose to remove them from list of properties and still keep port in
"required"


Best regards,
Krzysztof
