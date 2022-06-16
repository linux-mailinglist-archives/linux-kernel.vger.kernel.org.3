Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5B454E25E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377255AbiFPNrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377243AbiFPNrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:47:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693EA165A0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:47:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id o6so1330505plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EdDkRKKho92MrNIWNxsUiDkrk0oeSOr07WjZUBmDl0E=;
        b=Ej1lcIf2+oWupNOuU41TZHeE8OVVyKOdu8eW31o30OeCSGUx/sgBffvdj9xLw9bmFW
         vO9mlgfdpKRM6CWVcacgXPdVH4wOWEw3Ca3wBkToQsplv/N8z1naa6uU+XsPd+bMNbcW
         YuBhF8MDwOGr49zU+7zafiR3+AxMLjHyLMjBzBRD62pQFHUD0wD9KlY+7lG61+NZ6OL/
         JrHKwmGFqABYPlFzBptrspn7StsrfwAQ4qfJFJzn/Ak3WE96CMoGDh8mnkhvo0dpD0vo
         Qdp6+YL51cT07iA5VlphrevzEgyhHZlBZ/z2UoPc9gprtoI9Goc1M9SSZ12AWwgRoEXo
         S8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EdDkRKKho92MrNIWNxsUiDkrk0oeSOr07WjZUBmDl0E=;
        b=6bMdO2n4OYv7qba0wqvLb9qAwd6uPjFH6Acvn/Zs88hHHzWZQ+f1OJJauYz+HpQmsU
         QilYyzbAxUiP6Si2XGrYgTQJ+jRXYxbjilg5wxy7VXghwqRvoKlQLuQY2SzQzLba6kAH
         Bv+SyBD3xX9P4MvHM6puhjShJOhmzaZnoTYgKq8jFgFRGXt5Mv5ko3BCpb/ZUlQ1b3Gb
         v3STyMOGwfGj7s71uSXf3p4mbbZHTEUM13bLtdgnPnSN4rglhZEKV1JgL4SEDAMqsBUX
         DmPlBsPmY6cyeiHp+N0hFFVeMb/GyVN118N8h7Wa3gpb5hYQ0zGF3vjVZGwauSIOQ51B
         MYCg==
X-Gm-Message-State: AJIora/P/X/zl8gQpKK1SyVb7dGhtxNLA4NGGql/L4bbds1WYFDaHBM8
        pDGtWFu4GDNGdoBDbIHLDVnmcQ==
X-Google-Smtp-Source: AGRyM1t0Rr/VQcaapCXMr3kff4RkmVv6r41Lq3jurOo5i5Ni90ka0/whLxrdmOfhOmK+QybdIIM6qA==
X-Received: by 2002:a17:90b:1192:b0:1e2:da25:4095 with SMTP id gk18-20020a17090b119200b001e2da254095mr15893626pjb.240.1655387257894;
        Thu, 16 Jun 2022 06:47:37 -0700 (PDT)
Received: from [172.20.0.255] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id f5-20020aa79685000000b0050dc7628196sm1763759pfk.112.2022.06.16.06.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:47:37 -0700 (PDT)
Message-ID: <5abc998e-fea1-791b-3068-334d927af63d@linaro.org>
Date:   Thu, 16 Jun 2022 06:47:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Content-Language: en-US
To:     Kavyasree.Kotagiri@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-2-kavyasree.kotagiri@microchip.com>
 <1345050e-b6a4-64be-1359-8d31d88769ab@linaro.org>
 <CO1PR11MB4865738B0AFB2F74CD184C5592A49@CO1PR11MB4865.namprd11.prod.outlook.com>
 <18c84400-2fb1-e802-d43a-766c7dcb80aa@linaro.org>
 <CO1PR11MB4865A1D77AAD30410D8A815792AC9@CO1PR11MB4865.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CO1PR11MB4865A1D77AAD30410D8A815792AC9@CO1PR11MB4865.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2022 02:20, Kavyasree.Kotagiri@microchip.com wrote:
>>
>> Yes. This is how you did it in previous patchsets.
>>
> I did so in v3 series, but below errors are reported on 1/3 patch:
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml: properties:compatible:enum: 'atmel,sama5d2-flexcom' is not of type 'array'

I don't remember it but it's a simple fix of syntax.
Documentation/devicetree/bindings/arm/arm,cci-400.yaml


Best regards,
Krzysztof
