Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27354542BC9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiFHJoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiFHJoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:44:14 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42A51C0C97;
        Wed,  8 Jun 2022 02:10:57 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id b81so8730886vkf.1;
        Wed, 08 Jun 2022 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dOhE7tBwUTzDHWJUqlLa6u3BtIc9nsfJZSTQNm4ba5s=;
        b=iJ8scK9JvwTKON3zTMv69x4wn3FhcGd2sCC/5gGerOZqlGfFz1safQNPxQF1mBLT5u
         Z1QauknMoPojSUEPi8EPes4qWFIsuq1204M2K1GKuC5cNSkBKxcSQStdt9VeFN/pmXlI
         JPVikob4kmQtEh3VQxF3XNpPGs6bHwl22MgMw//vX+PxVh2Gh3sytSxB2CTiohYvndoD
         4y2vHk4cE+gmH3xkXPkMsdpODnkLjVNzEkVjrTqKjjs6UN9jUIRwxyioEMmfFlwjOg7P
         JkuD4gAbI86R5Jvkx2igqOsQh/f1nrDBebofmfCZEJ3a0Y3TJhWHnbrqrssiwOv7RcZN
         qbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dOhE7tBwUTzDHWJUqlLa6u3BtIc9nsfJZSTQNm4ba5s=;
        b=60ev7hp6g7dzYioDKhbEYeyf2BmO7lVwtbVmewYHmG6QRpieyTxpkoM7VVPrt4Uxr1
         Nwjzvo7QYu46HDHB5DtyLMKRXzi/1Jx/rs24FFsosCE9Cx0LX7thWoaf68DPggRvvPVq
         a5otcLi+1Q+nuyFm69V/0008zre2oKbW8YoMgp8y5Z/sEtGJwL6gUKx2vXi4Is1jw1ot
         EC6H9vGMZs6rHPpkfiXeNbc6yzcn26bJgrir4VPNcEILXCcZ3EOi/i3NNkppyZ7LE7Ja
         E8Fiej4h7y0FCYXY9xojro4Hdkuf7ta49kroQC4P+Q9/cTkDBgkdVlYz4dO80xTZXk3A
         zczA==
X-Gm-Message-State: AOAM533onannuTldnjPx66Aj/KpjTNduZEN7H7u6509Rw/pZLeuam8PF
        +dGzHdyT1LZEUhiz4U8ViWE=
X-Google-Smtp-Source: ABdhPJzCXKta5zQGCjhIQCXPTCuWYd960sfiUBlkfcNP+PixBw4B5zF8JX2RhzfRKzdGn2YxPO8/Jg==
X-Received: by 2002:a1f:adc6:0:b0:35e:588:2ece with SMTP id w189-20020a1fadc6000000b0035e05882ecemr6492212vke.27.1654679456306;
        Wed, 08 Jun 2022 02:10:56 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q130-20020a1f5c88000000b00351bcf78967sm3461307vkb.9.2022.06.08.02.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:10:55 -0700 (PDT)
Message-ID: <98f4a12e-bcce-6cad-f976-a4313f9a8000@gmail.com>
Date:   Wed, 8 Jun 2022 11:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/3] arm: bcmbca: add bcm6878 soc support
Content-Language: en-US
To:     Anand Gore <anand.gore@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        samyon.furman@broadcom.com, dan.beygelman@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        joel.peshkin@broadcom.com, Arnd Bergmann <arnd@arndb.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
References: <20220602221646.3127512-1-anand.gore@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220602221646.3127512-1-anand.gore@broadcom.com>
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



On 6/3/2022 12:16 AM, Anand Gore wrote:
> 
> The initial support includes a bare-bone dts
> for dual core ARM v7  with a pl011 uart.
> 
> Changes in v4:
> - Fixed subject line
> 
> Changes in v3:
> - Simplify subject line
> 
> Changes in v2:
> - Fix psci, GIC dts entries
> - Remove extra empty lines
> 
> Anand Gore (3):
>    ARM: dts: add dts files for bcmbca soc 6878
>    dt-bindings: arm: add BCM6878 soc
>    MAINTAINERS: add bcm6878 to bcmbca arch entry

Series applied, thanks Anand!
-- 
Florian
