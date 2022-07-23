Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B857F0BE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiGWRnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 13:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiGWRnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 13:43:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B911D192B8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 10:43:09 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t1so12215047lft.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HlHphoZuLPE3CLbqX5TxLcWzRpVyhW7sASqwVEBH1/M=;
        b=CNGVPQBLY5Tr6aU6+prX28HGV6JBxo6xYQGD3TwyVH/5Jsc9WiP/seiZr0xjNFagpw
         qzRG0jG3xVioEbFWKJcoXdddNRpYNkqxufPKSXUXcxfQh5HBTBrVLWl9Zue1PngXLl93
         uOfX2gN9Ifd9Rs03FlUm6xePYlb0vSvW85v03WSNSPDKz4VkznKkD7g+FTd25k2mi1+c
         9xBO0TTvqnc+3vjghW3VUpFB+0+aKwuVx55F8cuDBno+IlJfOGRgpo+A2d9cfeGeKYod
         UV9JgxC+dlqX2VoZsCWJtl8XiB7DWtqfZIauLLwW5B4tjTjXx9cDGg5kOEOHFgtzzvh9
         fmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HlHphoZuLPE3CLbqX5TxLcWzRpVyhW7sASqwVEBH1/M=;
        b=EKkZaoVrZNahS4qWP1gYjfRiTsL9GsKUr2qt9laqrXiXv4aVcYnYcgR9P95r+UV6lH
         zZ/yt8a9IgFML9D+nYo/jNHvpWpuqer4kqD8B1Chmne//RI0d2rnCDAwHzC6jXHNxjY0
         wmm3hz/mmVW0U15ZGFsQ7Xtnb1Z1+6Lou6cIf5lb6U5XhLd/ADTtsUM3WyTUDtWv3TK/
         KU+RYKrFleoDJywYd+HQs+aUp5C4A6o2qB/J1n50zq3lvM+1NtZCSiNMD6I0/PJU1UJm
         aytHdFdshezsQjV3R84XYRuIjZHHP8gYWLGGtjZP4EHxeEL+t1nuiVJ17rYDxahFrE2L
         MD8g==
X-Gm-Message-State: AJIora/xXzXxvc0YuAvmM7rEmZjmbdZpdV/05NZqbhUO6pRqORQ3cBkJ
        Ica40DljWMlZTyiIAFzyi+lz2g==
X-Google-Smtp-Source: AGRyM1uQNl3x42KCq0cGc9OqDnR54QTGrXDVh1wXSEUelvPCIfB7qPr5bBayswnv+Tpu0ay0JGCmIw==
X-Received: by 2002:a05:6512:3e0a:b0:489:e50b:1dc9 with SMTP id i10-20020a0565123e0a00b00489e50b1dc9mr2119685lfv.321.1658598187752;
        Sat, 23 Jul 2022 10:43:07 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00482bdd14fdfsm1770938lfr.32.2022.07.23.10.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 10:43:07 -0700 (PDT)
Message-ID: <d1a0dd15-3621-14e9-b931-417cefaab017@linaro.org>
Date:   Sat, 23 Jul 2022 19:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] dt-bindings: SPI: Add Ingenic SFC bindings.
Content-Language: en-US
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
 <487a93c4-3301-aefd-abba-aabf4cb8ec90@linaro.org>
 <37062a5d-9da3-fbaf-89bd-776f32be36d9@wanyeetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <37062a5d-9da3-fbaf-89bd-776f32be36d9@wanyeetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2022 18:50, Zhou Yanjie wrote:
> Hi Krzysztof,
> 
> On 2022/7/23 上午1:46, Krzysztof Kozlowski wrote:
>> On 22/07/2022 18:48, 周琰杰 (Zhou Yanjie) wrote:
>>> Add the SFC bindings for the X1000 SoC, the X1600 SoC, the X1830 SoC,
>>> and the X2000 SoC from Ingenic.
>>>
>>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>>> ---
>>>   .../devicetree/bindings/spi/ingenic,sfc.yaml       | 64 ++++++++++++++++++++++
>>>   1 file changed, 64 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>>> new file mode 100644
>>> index 00000000..b7c4cf4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>>> @@ -0,0 +1,64 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/spi/ingenic,sfc.yaml#
>> File name should be rather based on first compatible, so
>> ingenic,x1000-sfc.yaml
> 
> 
> No offense, does it really need to be named that way?
> I can't seem to find documentation with instructions on this :(
> 
> The use of "ingenic,sfc.yaml" indicates that this is the documentation
> for the SFC module for all Ingenic SoCs, without misleading people into
> thinking it's only for a specific model of SoC. And there seem to be many
> other yaml documents that use similar names (eg. fsl,spi-fsl-qspi.yaml,
> spi-rockchip.yaml, spi-nxp-fspi.yaml, ingenic,spi.yaml, spi-sifive.yaml,
> omap-spi.yaml), maybe these yaml files that are not named with first
> compatible are also for the same consideration. :)

We have many bad examples, many poor patterns and they are never an
argument to add one more bad pattern.

It might never grow to new devices (because they might be different), so
that is not really an argument.

All bindings are to follow this rule, so I don't understand why you
think it is an exception for you?


Best regards,
Krzysztof
