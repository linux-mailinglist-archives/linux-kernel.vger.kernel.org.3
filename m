Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5204B542B3B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiFHJRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiFHJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:30 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5921D82FD;
        Wed,  8 Jun 2022 01:36:09 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id w10so19047259vsa.4;
        Wed, 08 Jun 2022 01:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iAF2is9hd7aZ+2U7boYc8MSkpYt/dDVKNcmXOFwYDgM=;
        b=iJA6n2BUTLITEWw6g2QnkfRrBN0OZw++hKUDliuxNW6DmMcDvZzO8bGponQZiNTAOq
         yItCdGloer5n9XBdpBF2XlTldgZatl70KVCYRimgfcIlN6t1xBt//hkvjh0WZSHZtPla
         u5HFkZU42c8XPpqTTxgIGTh47F0AiMqwJ8iDaUVMIvKAABIHSWcCdU5DADHxFkDuA2qD
         NKMz0g5w0aMnDAIrGkKFyOWvh1D9nU3kCNxGEySWcqo1CG8cEcCDuG397rUgNOSo5VKB
         0nNub5zrOqwP3womu0v1hoeuAJ3XprwCZooQV1oeZywY24Dv6AJ28XzgUH+7JIf8djA5
         Cqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iAF2is9hd7aZ+2U7boYc8MSkpYt/dDVKNcmXOFwYDgM=;
        b=vguEUfFOXy6tW2k+3WxXZUE3JYq3VQxdGscQid6RbC1OdBj7oP2RHpt3DJRNisxiF6
         389Rc85oRU0f8fN7GsZsQ146DGtjaFwXAZlUAuvn9PZvBy9pGGRUOuyLAONY+iV2OmUP
         v+w+rFYNDOfhw/f/lRBZk6coXqRLXGcKhf4eTIb2B67ePc6+iy2WeilY9Px97RUxxD/G
         yQM6hGU4TnGcFvKrW3NLvWpPn6xNwwtVXn+5fAFiPq0Npei5/bDyNo1CTrK+pYImZQ1V
         sd2phibtR8iqpjdGvd/QOaGrsZFqLAhEkAEjIykH5Fl4d0JhoXZieW1qt/PWLJS/WuCy
         jCOw==
X-Gm-Message-State: AOAM532iFAuHa3pDJI/CtL1HwO9jM5eTWJ1mNQ63A8SFdDkcZBW5Ik1Q
        sukcXVLcbjd3oSLZ0ZutesA=
X-Google-Smtp-Source: ABdhPJyIrOqxcMg5l1CWPDDl5AQMDCJpcjp0/ljZKqhoeM9i+ttir6FjaciN1KbQnCY3eC5KUonwXg==
X-Received: by 2002:a67:dd98:0:b0:349:f0c3:9137 with SMTP id i24-20020a67dd98000000b00349f0c39137mr14027467vsk.23.1654677368364;
        Wed, 08 Jun 2022 01:36:08 -0700 (PDT)
Received: from [192.168.0.24] ([88.126.57.132])
        by smtp.gmail.com with ESMTPSA id l19-20020ac5c353000000b0035c9c5f48a6sm2663118vkk.41.2022.06.08.01.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:36:07 -0700 (PDT)
Message-ID: <7737777b-a918-30f3-089a-b814ef11c9c6@gmail.com>
Date:   Wed, 8 Jun 2022 10:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/3] arm64: bcmbca: add bcm4912 SoC support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     dan.beygelman@broadcom.com, philippe.reynes@softathome.com,
        joel.peshkin@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, tomer.yacoby@broadcom.com,
        samyon.furman@broadcom.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601201737.15896-1-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220601201737.15896-1-william.zhang@broadcom.com>
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



On 6/1/2022 10:17 PM, William Zhang wrote:
> This change adds the basic support for Broadcom's ARMv8 based
> Broadband SoC BCM4912. The initial support includes a bare-bone dts
> for quad core Broadcom B53 with a Broadcom uart.

Series applied, thanks William!
-- 
Florian
