Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69455552B94
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346656AbiFUHQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345218AbiFUHQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:16:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168EA167F5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:16:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id pk21so2389526ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/5gwkSl/og89k1zbn3bGxQzVMXDxSRfDx3JEZvQSNL0=;
        b=s0q9EHSJfWNT30T82nv9UOc+9lynICqUpHr3RHu563kFNqnRFE60UQSt+RYmVqm9qq
         YgufxSLZtsEjESJjMunfsYTqY2pA1C7nh4wpSK4u81/0hyJqM8w6A1XLeP/xQVMivlyn
         h/NTipUKFmIFtxtmvglYq0QnnEd0dqPZFSk+TaAowTvqRAEwO/48Iltfpr3er8sBslU+
         JkqahJOrIojXg1465sPdxBRvp9Up6YdpSmIaU+C4dibtN3LVEdAC7+O7t1XtrkT2wvoG
         kQDmqMsEReGH1I6Z3YKo939iqNZB9VYzK0oXGEFypfxVzEguGuSgGLA9W9fx+M8U3rWO
         V5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/5gwkSl/og89k1zbn3bGxQzVMXDxSRfDx3JEZvQSNL0=;
        b=MwLqZKRYTG39wqGMC1mr0mb6aiNeQDeKdxX6TyxStrzLIq/hxx3+GGC9aaJO6e4lPd
         0RAK/p0Lid8Dx36//AVIjUGKhyAnnlhO+BnGwFsxlxH7bBzSd6WJULfNRu1yadpiF9Md
         /cgnfJhHukc5RDDvqLqIxGKNv+Fb6X+C0xLQqRZiMFS58wJWw2VUBUfH6VslJoCArhd5
         AA0ei+Y2L53lv47n+RyjZUlFtfyWHImEopdFLQGqC1OCJs3ePBdXUf7FyRieVwc4Cfdv
         si7C/g1tqn+EzywDivKO26i9bqNFbljbp11w312GbgWfT6+a+Ze+6XyUR4n+M08+9rVs
         vl/Q==
X-Gm-Message-State: AJIora8v6Vmr8dUwjMmwbee33LXv84Pso+GKCHa8Y05P+D9fG1SVmkk8
        hY+OC1XoztPFZpNgjCYdXkOrIQ==
X-Google-Smtp-Source: AGRyM1uK1iLvnca6ZP7OFo1HPAJp3rkun2ZWvcPtcEpdFkuqBLzrZg5PJvqT2HBrL0NWklm8KHKPWQ==
X-Received: by 2002:a17:907:6282:b0:6e0:c64a:60a7 with SMTP id nd2-20020a170907628200b006e0c64a60a7mr24519933ejc.349.1655795793707;
        Tue, 21 Jun 2022 00:16:33 -0700 (PDT)
Received: from [192.168.0.216] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g5-20020a50d5c5000000b004356c0d7436sm8260676edj.42.2022.06.21.00.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:16:33 -0700 (PDT)
Message-ID: <2cad0c11-9bde-9926-f190-aa1ee5faa43f@linaro.org>
Date:   Tue, 21 Jun 2022 09:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        robh+dt@kernel.org, Nicolas.Ferre@microchip.com,
        Claudiu.Beznea@microchip.com, krzysztof.kozlowski+dt@linaro.org
Cc:     UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220620144634.25464-1-kavyasree.kotagiri@microchip.com>
 <20220620144634.25464-2-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220620144634.25464-2-kavyasree.kotagiri@microchip.com>
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

On 20/06/2022 16:46, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v4 -> v5:
>  - Fixed indentations.
> 
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
