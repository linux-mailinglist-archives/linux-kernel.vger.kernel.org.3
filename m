Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3324D7763
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 18:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiCMR4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 13:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiCMR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 13:56:09 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695744D9D8;
        Sun, 13 Mar 2022 10:55:01 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id qx21so29306886ejb.13;
        Sun, 13 Mar 2022 10:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=AtJFAG1rS0UdoKCIw6TlSYmKm66HsiJJug31sCRSQaE=;
        b=q8b0jFFju004961j2pK36Jp+LiMJf+O598HUNkdFHkPgIJhQuS70MfXWE2/EPlsnMS
         z8swqTG1aRAhdYfA4C6lW7kXXfLfOjQ1PdVRt9CpPv5cv0J9jfaWGfGjViBh597VDbG+
         KOPz9T72bULO5tIOj9zCIbpqeUAxsnssVOzG97dvQ2xKXhZizOLWqOM1I6LHLL+PeOry
         DaQ2jGoA1pGavYbDSv8v19QIycZppH5Ise/w1tc8E3j6kosEdrlSxvbYT9tpOYH3KozA
         Xsg4MUMekTWZp4X7V3gQA3OUPpb607HX0T1qCvzWTQIUu6jUXwDIkICPU4tGF+hU5X0d
         W05w==
X-Gm-Message-State: AOAM530Hocgvn0OieV5z+suyOia34n4Fp6XOpYKe0Lh04Jt7eSxK2Wwl
        4AL8NSDFtJY9Icmc9FXYAnI=
X-Google-Smtp-Source: ABdhPJw5qqGwo6Z0GdV1LsOQtY8gC/tR92mv7iE/9TAZx/FptY0VqTQw25xP/lQs3sr5swfcVq/B4A==
X-Received: by 2002:a17:906:39da:b0:6cf:7f09:a7bc with SMTP id i26-20020a17090639da00b006cf7f09a7bcmr16701242eje.457.1647194099781;
        Sun, 13 Mar 2022 10:54:59 -0700 (PDT)
Received: from [192.168.0.152] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id f1-20020a056402194100b00416b174987asm5324319edz.35.2022.03.13.10.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 10:54:59 -0700 (PDT)
Message-ID: <62178934-9b16-c79c-387d-91526f7fe732@kernel.org>
Date:   Sun, 13 Mar 2022 18:54:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v1 8/8] dt-bindings: pinctrl: convert ocelot-pinctrl to
 YAML format
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
References: <20220313152924.61931-1-michael@walle.cc>
 <20220313152924.61931-9-michael@walle.cc>
 <869d4fda-e943-1817-17cd-df7b323a1fef@kernel.org>
 <b5a33a3441f829638740204e0c4dc938@walle.cc>
In-Reply-To: <b5a33a3441f829638740204e0c4dc938@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2022 17:36, Michael Walle wrote:
> Hi,
> 
> wow, you're fast!
> 
> Am 2022-03-13 16:55, schrieb Krzysztof Kozlowski:
> 
>>> +  reg: true
>>
>> maxItems
> 
> There are up to two address ranges. The second one is only needed for
> particular controllers (the sparx5 and the lan966x).
> 
> Is the following snippet the correct form?
> 
>    reg:
>      items:
>        - description: Base address
>        - description: Extended pin configuration registers
>      minItems: 1

Yes, it's correct. Please also add proper "if:then" under "allOf:" (and
move such allOf under "required:") which changes minItems to two for
such controllers, based on compatible.

Best regards,
Krzysztof
