Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620724EAC89
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiC2LpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiC2LpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:45:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C079765AB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:43:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so24347523wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B/lDSRmBt45ew7slN8pGHqNMcMQbF9rbjhPBwDXjCYQ=;
        b=pNjNmuRreTl0CTr39zOVQwrheRMDsU81PfQLCqwPmqVnaGzMEDTBUK0mQlmQ6+0Jaw
         ZHZ9nngJ95xQ09Ws3DREeamVFTVS1JTXo9EiQce4XCdlfNwDNxb72RjcY+CPculwyezx
         QbY9+2blqFt2yejbMciRwZt3ZRedCh9rnnHh5xWmkuVy+TjYLmlEna3WRCfQNeaAXHqT
         VsaZcvzSojKsvcYUpcRU8CLlQEY9SvmYRa90xshcjaT35XnOWpiY8mRQQFswiSSUFNdM
         YR4CIrWNBxoQoWqU3y2UTuw39M70Bzgx5xytJzwQYL/Xr6NLUqzjKEV9wdnoDvg1imAa
         Zq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B/lDSRmBt45ew7slN8pGHqNMcMQbF9rbjhPBwDXjCYQ=;
        b=JJqpCemQmHeZZ+4RFMKsdwAi+8k5zPslZF69PdWCu1cYK+WB3b9zMJzPLOtWxynO+/
         intBZs8SGsCqNT0VXxaYp/0HuGEQhjzPmDSZj6zcQ03IZb/B0enXSjxBH9uBV34D8mZK
         +6IkpH+oPz2RZaXV6+xUeDA1dg5NvTtQ743c5b6CAfm6S21iYToPYJorEhDBB/oFY3ZH
         ltM+Emk/zvz34NIXPmc8TY3RhJToFoulSYA9WHuiP38t9DzG1BJTxR1dEk8Wlnjnicz6
         /79B/bMVg8ppmdOAQ5KYDwrHknVa3Z0hNlUOVKswJ3ofXKEjJtaNJ146kKOz+ZyLDlpF
         Rn+w==
X-Gm-Message-State: AOAM530kOnQk+qUJl7GAd6NXcv8bd/PTiMA+iIDnsdtW3WWII3I1kYQH
        jnySvDRwdAgRxzM1xeBtWX5Ijw==
X-Google-Smtp-Source: ABdhPJypjAXnuentZlRpL2zBiRpa923vpXbWo7NUVcxVtz+EmSJ4zia7oIlJmVSKa0y8npilo+lpCQ==
X-Received: by 2002:adf:fbc6:0:b0:203:8dff:f49e with SMTP id d6-20020adffbc6000000b002038dfff49emr30167362wrs.72.1648554201399;
        Tue, 29 Mar 2022 04:43:21 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b002058631cfacsm15436766wrf.61.2022.03.29.04.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 04:43:20 -0700 (PDT)
Message-ID: <5ea0386f-5322-4efd-c0d0-0ba0ff526bae@linaro.org>
Date:   Tue, 29 Mar 2022 13:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: convert rockchip,
 rk3188-cru.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329111323.3569-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329111323.3569-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2022 13:13, Johan Jonker wrote:
> Current dts files with RK3188/RK3066 'cru' nodes are manually verified.
> In order to automate this process rockchip,rk3188-cru.txt has to be
> converted to YAML.
> 
> Changed:
>   Add properties to fix notifications by clocks.yaml for example:
>     clocks
>     clock-names
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 

It's the second patchset without my review. What's happening here?

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
