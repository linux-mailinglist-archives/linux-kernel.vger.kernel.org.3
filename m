Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C8E57C499
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiGUGo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiGUGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:44:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A55C599E0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:44:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a13so526781ljr.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9EZ/ZfJ5Dqv/Z3vw3hGwnwu2K6278KtSj/3KJUUKvB4=;
        b=C+NIwK6JmyQSy6TZnTxWc8AE+VxdpZU00M/uR3FaIduX2i1aGcHp8PW81i+6ey+5ue
         rkjoDwpZ0e//SR/C9AhcyQ/KdHZ2X4cHoOVPYnEdcLbOqej9PdZwsrFS/N8R8zMG0q3m
         bmoiY+XaYattEv5qCdDDghTcCwpWhc/bU+a9Tt/9e+82i8zLPDy4/dOJGuE5n9kqtK6D
         r8RmDV+Pq4fAHW3E19Kg3XaHr8imi4zRGwZZ+W6J4hQnVsXodmTLK4kIkB/OrHA/veTL
         ZHMPb2JpXU2+DH6f5KRPxpc0R+fpte1fUma6KjuRz0dnu2BYE33TTXXKAdjgIvosvEyn
         r6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9EZ/ZfJ5Dqv/Z3vw3hGwnwu2K6278KtSj/3KJUUKvB4=;
        b=l96n6qjtUz4FrApHt0peacM3j94FRXJ2vDfP9MvNkpPQXJRyZomAyCyWnYaB1aTNrB
         /UEC4sTgpYxbjpaAfoRy+9fjK52bSPR5mtAUH2Qmz9hAV7JYXYjQhzpQ3YVDluy4H6WW
         kdvVdhV9q+0AFHeeHyaq2Czslz16eyzY7KLoz+5XfLZ/hN22/sbGNn+suUXgp0EsOsFT
         JZmYzyPpKmf+j9er5ZPOJoEr/NDTY7P/8vtGGRnQLb+rg6cG3zFKvB5bkwi/1AoeItEI
         b+Cva+Jte+pjHS4MJXxgC4fR3UPKNw2a098GkgEbQAQVJGb6d63PoBiW7PojZgBdm0Wy
         Qykw==
X-Gm-Message-State: AJIora9hzuoZvAwDqkH0BHJBS0+UuI+Rcw4EYR/pi7jM2wl7eBhs92iN
        zAtsoqSudFShWRKqO0FtmOniIw==
X-Google-Smtp-Source: AGRyM1sAMFvj0gKcnXVhV+I8VCvP4qPZbRcyE6t04/7Xi0WloWvBTC4tmIjUdUAAD0J3xuGPkDDjeQ==
X-Received: by 2002:a05:651c:54a:b0:25d:6c19:448 with SMTP id q10-20020a05651c054a00b0025d6c190448mr19349273ljp.239.1658385860890;
        Wed, 20 Jul 2022 23:44:20 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id m1-20020a056512114100b0047f7464f1bbsm242803lfg.116.2022.07.20.23.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 23:44:20 -0700 (PDT)
Message-ID: <a635754e-bf41-4058-5fbb-57ead36b7128@linaro.org>
Date:   Thu, 21 Jul 2022 08:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH 2/9] dt-bindings: arm64: bcmbca: Update BCM4908
 description
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220721000658.29537-1-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721000658.29537-1-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 02:06, William Zhang wrote:
> Append "brcm,bcmbca" to BCM4908 chip family compatible strings. Add
> generic 4908 board entry.

This does not explain at all why you are doing it. Improve your commit
messages.

The explanation you gave here:
https://lore.kernel.org/all/b8eda882-6838-ab7d-6e2e-131e3125b16f@broadcom.com/
is also not really sufficient (and is not in commit msg). Moving things
around in Linux Kconfig does not justify adding some new compatibles.

To be - clear - this is not a review, so you cannot add Rb tag. If you
insist on a tag, then it as counted as NAK.

Best regards,
Krzysztof
