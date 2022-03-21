Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30D4E2204
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbiCUIUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiCUIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:20:04 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE631534;
        Mon, 21 Mar 2022 01:18:35 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id k10so3131794edj.2;
        Mon, 21 Mar 2022 01:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=/0sdOunF8bYlrb59zdSPU0+mivkFgjRHIGJYYpq5fKs=;
        b=A7Xarse1qyDgCB6AnoR+Iq0XdwJAIQnrArw1XGNeXpIQZGOcBdb7fE0L8atpP3zmh+
         pDCSHmWrgb/b+n8crGNwYVSRp/BfmZMVGqmnup4ryYnC9ssdfuWt9kbz78mAC9va/PzO
         WcfOYjE3bvt1JVq0t4XiBZh0P3l70bODzqXjhqvI3KyURGkTZ1ogfw8MNHB8sWXDNtft
         /hUFJ1xlbIgyY6PiApZYQm3x6RFceI9MJbPJ3VCm2/xbqQLik98FQgdJieaZ1x2SmmtK
         sb/31WoN3nJaXn/ulA0uKlhpGXouQm2nLnntzMAmUZ5OpIJMsTSuRg7Dn2QtctYjvf4D
         2GWQ==
X-Gm-Message-State: AOAM532x769VDZcrAtK2dt5wCkiTFZ/GqcvC2k2Ohzmb+smBjTYr/D+P
        DNKylIHyrTD6cNyqvghxN78=
X-Google-Smtp-Source: ABdhPJz4kBfZLTY8RiApGUmRgLXMzFmv4NiZFaApbEAGxSwJLab0xzA2fQqetXj46UTJbSF5xLXsKg==
X-Received: by 2002:a05:6402:3452:b0:418:f963:42a3 with SMTP id l18-20020a056402345200b00418f96342a3mr20019987edc.12.1647850714196;
        Mon, 21 Mar 2022 01:18:34 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id e5-20020a170906374500b006d5825520a7sm6649612ejc.71.2022.03.21.01.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 01:18:33 -0700 (PDT)
Message-ID: <1cf2b374-5083-ea02-94af-cf6e3ce7b0e8@kernel.org>
Date:   Mon, 21 Mar 2022 09:18:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] dt-bindings: mmc: xenon: Convert to JSON schema
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "huziji@marvell.com" <huziji@marvell.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220318033521.1432767-1-chris.packham@alliedtelesis.co.nz>
 <91b6660d-c22b-0679-4cb9-6ebba9066545@kernel.org>
 <fd8cb680-5ae0-6b47-3f35-a497c51a47b9@alliedtelesis.co.nz>
In-Reply-To: <fd8cb680-5ae0-6b47-3f35-a497c51a47b9@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 01:12, Chris Packham wrote:
> (adding some ARM people, resending hopefully without the html)
> 
> On 19/03/22 03:20, Krzysztof Kozlowski wrote:
>>> +          - const: marvell,sdhci-xenon
>> This did not exist before. Separate patches please for additions (with
>> explanation why). Maybe some DTS lists this, but then it should be
>> individually judged whether the DTS is correct.
>>
> On this specifically. I was all ready to add an additional patch to 
> document this but then I noticed nothing actually uses the 
> "marvell,sdhci-xenon" compatible and it appears nothing ever did. I then 
> figured I'd delete the unused compatible string from armada-37xx.dtsi 
> but then I remembered that sometimes we add compatible strings to have 
> them "just in case" we need them for some SoC specific workaround.
> 
> So there's a few things I can do
> 
> 0. Nothing (easy) although the binding I just submitted will complain 
> about the unexpected value
> 1. Document "marvell,sdhci-xenon" as a valid compatible
> 1.a. Add "marvell,sdhci-xenon" to the sdhci-xenon.c driver
> 2. Remove "marvell,sdhci-xenon" from armada-37xx.dtsi

Option 1 in a new patch, explaining why you are adding it.

Best regards,
Krzysztof
