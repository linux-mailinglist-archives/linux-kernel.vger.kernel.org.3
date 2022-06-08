Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1AA542BA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiFHJga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiFHJgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:36:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C934B4DF60;
        Wed,  8 Jun 2022 01:59:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so23220980pju.1;
        Wed, 08 Jun 2022 01:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aeY+E2s+xqcp9S+3WYYKKbSRPSZdfKf0yIr1/ChlM6Y=;
        b=G3EJjCDGk7gLbL/ubJK60fZmOOwfehvNH8HAuHtIs1iNLAgYpEdN7Tw5Xu3a8tXN+F
         IgkNvAwT1rIW3tGcivbUqaQz8ECQFs/OEcoH5SWFtoRBM87bWPcx6G6JP6qFGKNt3PHM
         4EzjNVJK3XdIv7QrJVTodkFaDADVrQjYoI3bYXXeQR7U/YpZA834tzyrRWgriqwBIX0p
         mZ9b8wToYPe8mlTUlqqfOd9thkUPRa+19vsX9AS7xfnUknTNTP8zAFSEGafs6UzENkD5
         AqpILKRJdMaAYDeN5A+hm3demJEZHfCrP8sgiRPkC5FvIv/Tg4Ss7hP8oqNvsIHQn7Lu
         BrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aeY+E2s+xqcp9S+3WYYKKbSRPSZdfKf0yIr1/ChlM6Y=;
        b=Nu/ouvmu6jobEvcSUs+XleOJtQGw5apeXM22+ONPX+W8ZT+KfQMeONdHcQQt8zTP5/
         wbEhUBq7dsT5WOc7vlFjVBN3yac7sLlQHeT+Du4fgzj/+TfDguOcSXigZCl6WQaXqvQo
         S3F9F3vZpez/C2qZKXyKI4q/iV/etxH82h1OLFeHJxVYs1t5oqvVcnbPHEt/nKcohlAh
         w+tuu9CAFeRK7NXEMu7FfavsJ6cFdg+yP1XyfbXMIamKBYz/LeWfNdHM/92BbP9XSCOi
         CVMRRlsXnOUlZuECSugc1GbfavbMqEEfXxcYSAH40MoNyThkGCM4Yw12J+Rpral4IsBG
         ZrNA==
X-Gm-Message-State: AOAM533Ss00SNFYHWCnayyor1amzG0jDEk5CZE9b6rXAq/x2cnxXGwuk
        n8GbqqR9Kfa0L7o4ODF4tjs=
X-Google-Smtp-Source: ABdhPJzj3e3D998OD8t66vRWWcs3+/ze7qNVmF+RikiNyrTtdIp4YMnu6VD/heXrhybNFh+AS+kmhQ==
X-Received: by 2002:a17:902:ccd0:b0:156:7ac2:5600 with SMTP id z16-20020a170902ccd000b001567ac25600mr32674595ple.156.1654678776902;
        Wed, 08 Jun 2022 01:59:36 -0700 (PDT)
Received: from [192.168.0.24] ([88.126.57.132])
        by smtp.gmail.com with ESMTPSA id e22-20020a17090a4a1600b001e345c579d5sm13331733pjh.26.2022.06.08.01.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:59:36 -0700 (PDT)
Message-ID: <b89a2406-282c-7de1-2452-17f1a1c98d38@gmail.com>
Date:   Wed, 8 Jun 2022 10:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/3] arm64: bcmbca: add bcm6858 soc support
Content-Language: en-US
To:     Anand Gore <anand.gore@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        joel.peshkin@broadcom.com, samyon.furman@broadcom.com,
        dan.beygelman@broadcom.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601201958.3072173-1-anand.gore@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220601201958.3072173-1-anand.gore@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/2022 10:19 PM, Anand Gore wrote:
> 
> The initial support includes a bare-bone dts
> for quad core ARM v8  with a brcm6345 uart.
> 
> Changes in v3:
> - bus addressing changed from 64 bit to 32 bit
> 
> Changes in v2:
> - Fix psci and GIC entries in dts
> - Remove extra empty lines
> - Simplify subject line
> 
> Anand Gore (3):
>    ARM64: dts: add dts files for bcmbca SoC bcm6858
>    dt-bindings: arm64: add BCM6858 soc
>    MAINTAINERS: add bcm6858 to bcmbca arch entry

Series applied, thanks Anand.
-- 
Florian
