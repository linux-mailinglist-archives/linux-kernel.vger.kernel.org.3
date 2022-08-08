Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EF358C7BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbiHHLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiHHLm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:42:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F1513D47
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:42:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x19so3984086lfq.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=pL87Fqs9PTMJ304pFnGS1YWG0FPpYwtTQJEDWykJS1Y=;
        b=hsC2y+8dl47fq/cyB5jqNdU+9t5zOkxnPhby5pK5ozIpOHz+vbhw8qEGoCKQ+ukChK
         AdcXQFjnSZWDHmf5JqFjmd/wWvx9zeSY0qWc7LwvYhHO8B5f7dM1sXMDz56q3m2EMnj/
         YPqxuihQZMbpJZbqAh+xJ077M/zyM67hcjjzvVJM1sqi1nSrnBf1CKAukDInEM1/ywDy
         qMkEjz4aUbWQiKJ3plo73b0100VDwKvCNh2Mwl0/HX7vpg0v0vcoottO+FK4Hygdyxkr
         cnytxlUKjEalMUKguRxakNA/XhmQirbAZXC+aa9gQforfnp7QLLElbPWuuc5egnpA/HT
         Ir0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pL87Fqs9PTMJ304pFnGS1YWG0FPpYwtTQJEDWykJS1Y=;
        b=IUMEktTzks6ryeft5KBKijt9uohqSndfC9jgJSe4B7QdipSXYdY9x+/cwDpDw2M/6J
         TuK+QgyeHH5bT+sJwrHRkpECNRcYYsGoftIQkhk4hZL0Az7fu98kUCbpYWUyAURimhwm
         wnzRAUwV88ZbcBTX6pN8g5ggu53WHLQDWytLg0vl9N+SfQsAy5W6TPDPFJEABU2a/9Oq
         V36mE84QWcv09v0ImlNpLHbktedJJtlQNatop95lU2V3U3rZf1yhF5I48hyu9SlpaGhN
         O3BGkyvbm9kyY5FOL25IAvDRN2u/Bu+Hz2x+Z72m2Rkgm5znyxfuQgScB0Ob82wGX/Hu
         9trg==
X-Gm-Message-State: ACgBeo0YKo3ZWBQ9Usx55xDWTcXp4lVG9S8CTymmU/XaFiPe8SLIK2Hk
        D58raKccwxYIp8Qr5b9ywu1lTg==
X-Google-Smtp-Source: AA6agR7uQY9shl0hp2+z5QHs2BFUW0aA/OjGjkksM04+e/jE05tULLxoVs/bZclB54fR84ZQE3wJ/Q==
X-Received: by 2002:a05:6512:2622:b0:481:5b17:58e7 with SMTP id bt34-20020a056512262200b004815b1758e7mr6154823lfb.600.1659958944435;
        Mon, 08 Aug 2022 04:42:24 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id h28-20020ac24d3c000000b0048b18700dddsm1401868lfk.106.2022.08.08.04.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 04:42:23 -0700 (PDT)
Message-ID: <727e15b9-cc6a-5117-2c8f-3e78e9992565@linaro.org>
Date:   Mon, 8 Aug 2022 14:42:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Content-Language: en-US
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        martijn@brixit.nl, ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
 <6461a695-171a-b160-5406-b8ac31c5ba0e@linaro.org>
 <20220808111225.pslgct22eltiakiv@core>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808111225.pslgct22eltiakiv@core>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 14:12, Ondřej Jirman wrote:
> Hello,
> 
> On Mon, Aug 08, 2022 at 09:35:55AM +0300, Krzysztof Kozlowski wrote:
>> On 06/08/2022 01:44, Tom Fitzhenry wrote:
>>
>> [...]
>>
>>> +
>>> +	/* Power tree */
>>> +	/* Root power source */
>>> +	vcc_sysin: vcc-sysin {
>>
>> regulator-vcc-sysin
> 
> Interestingly, most DTS files in rockchip/ use a -regulator
> suffix and none use regulator- prefix. And this is inconsistent
> across the larger DTS tree, because outside of rockchip/ most
> DTS use a prefix.
> 
> Checked by grep -R 'regulator.*{' | grep -v state-me

Can be a suffix. Just pick one pattern.

Best regards,
Krzysztof
