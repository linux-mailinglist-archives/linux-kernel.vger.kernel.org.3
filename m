Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4DB51379A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348707AbiD1PEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348730AbiD1PD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:03:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E01B3C4C;
        Thu, 28 Apr 2022 08:00:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h12so4571782plf.12;
        Thu, 28 Apr 2022 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Xzh71VOPVUr+FTLGg1rFRJRlpUUfpPpuTtbbxsOPXfI=;
        b=O5bMQXXZowjnASkvRhCWoT+QMe8mgP+/12AIDAsuiTgxY4Nj4M71kFjRRl4/HvuX7n
         iKd+G/OfoI31xR44jdpgxb+UxGmOPvjBbjJbg6IQh+CfSC1ahh/7SRr4jYt+kooa1S/k
         ntgHw7A88EWdbHp0rib6grcjCLLI2lWNvbXSIvRo3eWXiTtQOvkU98+mKCqTmarQ5a6j
         89tilDCVOHA10IV7O+ZQNiLHy6uev/Wl6S6ArorU06Ka6erpU5y+4grLqvOy2CimHT3s
         m8ZnO+VLvQeQPdpsVUixFFcV70NnnAV2O0jWWDLxQLRMfVG97HWK/oTaX6dhBIpy7UoF
         3RlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xzh71VOPVUr+FTLGg1rFRJRlpUUfpPpuTtbbxsOPXfI=;
        b=C2Vt0t9t+ZxPG45rGdFB9+coGXrGsYnEuthb3ygBiWHULQX5ZwjCYv1RznqE+Vvsy5
         YzysSQyULS5iS4CAnNKin8e30KDNMi+QlLypdgR0nbMkLDD7e2rFNys1Xs4a6ZEsPVkr
         +sjNuULNcYaorjstGNhQ0wkC1OyipmI9oakUuzwUyRuVfYu4//lQcyXzSYNxYOqoLudt
         QwtH3pCF0hex0y5ckP1/7cBero9NFtNHLupBU9BpEIknTdfeRhInEbLyLxHalL5EfXVL
         1hmT2HlDHOSMRiyH0/GhnU5YYMtj45a84E8gsTE6nfZhIavSsf2GxVGDj5p7ltrH0VLN
         51tw==
X-Gm-Message-State: AOAM5323kMcZW9k/CyicxVwWCHn01vez8ugOsa2/eGdeZVm+upjOYbM7
        gXnsvNBa+eHJ3QoAp5URpaMam2z3PNU=
X-Google-Smtp-Source: ABdhPJz8BQrt5G2ELPiXuQARmcj6SXgWvxmGYSF4ceGToAt3z56e7gcOGZXW/o5OYHsXQeAzQ/LZew==
X-Received: by 2002:a17:902:f612:b0:14c:e978:f99e with SMTP id n18-20020a170902f61200b0014ce978f99emr34096174plg.23.1651158043945;
        Thu, 28 Apr 2022 08:00:43 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:e9ac:ce6:5da2:8724? ([2600:8802:b00:4a48:e9ac:ce6:5da2:8724])
        by smtp.gmail.com with ESMTPSA id t63-20020a625f42000000b0050a7eaff8c9sm127923pfb.189.2022.04.28.08.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 08:00:43 -0700 (PDT)
Message-ID: <0650ab91-4102-77a4-c27a-f48e74c6bd8d@gmail.com>
Date:   Thu, 28 Apr 2022 08:00:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] dt-bindings: mmc: brcm,sdhci-brcmstb: cleanup example
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org>
 <20220428081817.35382-2-krzysztof.kozlowski@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220428081817.35382-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/2022 1:18 AM, Krzysztof Kozlowski wrote:
> Cleanup indentation and order of entries in example DTS.  The most
> important when reading the DTS are compatible and reg.  By convention
> they are usually to first entries.  No functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
