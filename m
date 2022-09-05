Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6355AD5EB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbiIEPKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbiIEPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:09:43 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E0957E3E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:09:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b19so9528850ljf.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wotiwuuGN+3vY+Pb6kB9JIBGYqeqbtL4gAUMEsBlbA0=;
        b=RLUqNbXDdHfpxjI53Dt/5u3a7EkRvMWO8dYrO/I6SCaHjNvdvSHXEZsuHO1yG4+OMb
         kPQmOY9J6xRa3vtrOUYIVfyuKq8kJBgEQ2aKG0Kim7XRphAmUcYnohEU11mwGDTKBABl
         jxZpvojDzfRPVEj6ihArNQ76BnC3iF8fnDQ9xGAYJiTpHbhhOwDRMzpGIreqHZ8UNmo4
         u2DbH9MR1xQWj4YmZqD62Nt4/rXtpJ0gy5BPbor1XssZBfDHF+XbAUd2uVkjMJoy+1qT
         oV7ixM+ih8SnST3+SqL5aN1vHjVZmbKOpxEBIFmJTsnUTWkZlJ9ricgPgYoOOf9955YN
         J08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wotiwuuGN+3vY+Pb6kB9JIBGYqeqbtL4gAUMEsBlbA0=;
        b=WkdqE80YqupVMx4xK///6/3V9ZweUEefqEBRRU9vFDZf1sUsSgxX/0w9P6W+hGwy1K
         rMJ6ah4Bw9N5ZhCl+Oys4AW0SnwLCLUTe2PkequFzYm/j1Ivvqh0Ma4RYrca2RtN/4Yv
         pbAqAV0cqDpbmglmTbJK/eE6u68lWWzE4Qcz6668F7cWPQKt8I7mPfIXPWsJ03P5S7Ni
         F+zoJN2KMBmDwU6lPCWQQGU7SqKIuumuS3Nl8dJI2tK1pF9Sxws6WIW98gB6RwW+Bcd6
         MgNqDT2eIyaBy4eVZdP+w0TgyTv0dWMd8pDV/a39ZeQUfkacE1rqQnGjyak97qcwrfIC
         R4Sg==
X-Gm-Message-State: ACgBeo0PIJr6k8PYHINPLKGijYfqxoYvIIAyxWE4RfthmrLjGlCBQi2S
        eHRRP+54oc/4MxpKRsMQO7oK8Q==
X-Google-Smtp-Source: AA6agR7XVc15tL3SpbTFubNujEeZKUUlMqoX392XJaa/nI9h+BUnr8/JYEt5aZXhLLP3Csu4GAD5iw==
X-Received: by 2002:a2e:a604:0:b0:25e:87b1:fda5 with SMTP id v4-20020a2ea604000000b0025e87b1fda5mr13979288ljp.428.1662390549253;
        Mon, 05 Sep 2022 08:09:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r7-20020a2e94c7000000b0026548b59479sm1386201ljh.64.2022.09.05.08.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 08:09:08 -0700 (PDT)
Message-ID: <734070e4-f77d-11bd-51f4-18bfeac0fe11@linaro.org>
Date:   Mon, 5 Sep 2022 17:09:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] dt-binding: gpio: publish binding IDs under dual
 license
Content-Language: en-US
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Stephen Warren <swarren@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220905145555.674800-1-etienne.carriere@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220905145555.674800-1-etienne.carriere@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2022 16:55, Etienne Carriere wrote:
> Changes gpio.h DT binding header file to be published under GPLv2 or
> BSD-2-Clause license terms. This change allows this GPIO generic
> bindings header file to be used in software components as bootloaders
> and OSes that are not published under GPLv2 terms.
> 
> All contributors to gpio.h file in copy.
> 
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Nuno Sá <nuno.sa@analog.com>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>

Please keep my Ack once received (for insignificant changes):

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
