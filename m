Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78EB4FA81B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbiDINSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241916AbiDINSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:18:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7330939FA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:16:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u15so3632630ejf.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ss9MX+8gL4N4vyRNsaMrOS75b4x1ebnPrfSl9fp2oY0=;
        b=JMllX10YFuNjqx27/rOo2M1HLwoeovBOn3cPsw4U/W/19GVIzS1JC7irYjfLQSZ4+J
         wI0Lg5htFNguIB4VvI5IDAexpAAItOPwGj2f8Uq5IOYeHQQhMe8Ke5wl7y9nWyN/XWEb
         yBBtD7Iz5w+n8PQRxvEuV3E/+flRv3BnOo61XQ+KLRy/VCYAMUm1A4qQerFq6GRzUtSo
         ce5Xg1k0l/QPSlZVVAx+SZSf90c5oW7LFu7JufmggKEUzwkpHM33CQzkd0PHeR9SuFfe
         2dGTPqSNnoAWZFWSeWPOlRw21Kld3LKaneMwslDnE0GA08Y/BZlT4atMovoKobQ8aiTG
         LuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ss9MX+8gL4N4vyRNsaMrOS75b4x1ebnPrfSl9fp2oY0=;
        b=ijBDtlLjmAtEWB6CVASMwQfVd9Hk+hleVmKRdgwzIRXhmKdTwR988qerS8paA9BxE5
         AyIVxSuxheMJBgTMKz3JGl+WK5jbmstpOmojW39WT22S7RzGUYSdQNWdlF8kXE5/70sE
         8wp8Adl45b8t7b0XsGc8e/bX+IpLpq5E1QEED0HVssKwZjAvMZnBJK3+1s3UdSbxzys2
         rf4TY8Umgcz5gk1TE7NhHpKKUeHDtHv9AgzUMQceBAxNFhCTXJeIe7xO3aBkkdGh4x/M
         YF0qJpTkwF+5mZVwLNCtbwsHJdrYqbeUMjUcXvdhtNJhJmlIkPa++//F8LuXSV2AdyEF
         Pu2w==
X-Gm-Message-State: AOAM532ei7U3K4qQOWhQNA2Q2zj7YAFlhaWzh1KP1zePKIgbBxshvLFI
        YyvvXET5NQFxbrSXfsz6CWpIfA==
X-Google-Smtp-Source: ABdhPJxTJa/ThVbDtrAocRQOPXNgcyksMHjHri7oimqybW2dJSBE3w/ve01GXGppk6F0yQd+Yg/3Pw==
X-Received: by 2002:a17:907:6297:b0:6da:6388:dc58 with SMTP id nd23-20020a170907629700b006da6388dc58mr23207144ejc.472.1649510183329;
        Sat, 09 Apr 2022 06:16:23 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s11-20020a1709066c8b00b006e7ca6f0401sm7273511ejr.136.2022.04.09.06.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:16:22 -0700 (PDT)
Message-ID: <79dd8425-947d-603c-ebab-0625921551d8@linaro.org>
Date:   Sat, 9 Apr 2022 15:16:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 10/18] MIPS: DTS: jz4780: fix uart dmas as reported by
 dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <00ec9d965cac78b252e14444deed8c93f5116bca.1649443080.git.hns@goldelico.com>
 <a7a46736-e917-7274-1593-147ed36a2a68@linaro.org>
 <86044652-7B23-4F4D-B60F-C413F3C7BEF1@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <86044652-7B23-4F4D-B60F-C413F3C7BEF1@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 15:07, H. Nikolaus Schaller wrote:
> 
> 
>> Am 09.04.2022 um 13:18 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>
>> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10030000: 'dmas' is a required property
>>> 	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10030000: 'dma-names' is a required property
>>> 	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10031000: 'dmas' is a required property
>>> 	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10031000: 'dma-names' is a required property
>>> 	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10032000: 'dmas' is a required property
>>> 	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10032000: 'dma-names' is a required property
>>> 	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10033000: 'dmas' is a required property
>>> 	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10033000: 'dma-names' is a required property
>>> 	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10034000: 'dmas' is a required property
>>> 	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>> arch/mips/boot/dts/ingenic/ci20.dtb: serial@10034000: 'dma-names' is a required property
>>> 	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
>>> arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10050000: 'dmas' is a required property
>>
>> All these warnings are the same two warnings...
> 
> See my earlier explanation that without them you can't verify by just reading commit message
> and diff that all existing warnings have been addressed.

Which does not make sense and there is no need... Automation does it
(see Rob's tools). Don't make human life more difficult...

Best regards,
Krzysztof
