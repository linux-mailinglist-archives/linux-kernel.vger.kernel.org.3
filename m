Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FA057D1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiGUQpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiGUQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:45:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7399123E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:45:05 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m9so2478835ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uLpnLpELmGe+yW4fk7cGq1x4Clkl1m4lKrfogbkISGs=;
        b=y/N//J9OncWfwmp594eRgx7W8jbGgyhSim7LGCZTPur/VLGskrYmihhXMi6hjynqzf
         PrjkxNwWHMeXlYB7s4578SVe5tddiUAIcHmgColnaYF3X0srb99o9rQ5f2FVYwSIm1TG
         mCvEhwtMoq26Qi9P2i8MPzm/cr2Dyaio28inHKV1dLEStl83ufY5GB/fRwwSTG+d0dbE
         6BdU0fTczo8pXN4eFsbnYvhknNVkKON10U+wZrDHqBo8wfNEHYadZkYQpDFdcy/SIG0S
         pHfO573+ChPSbgHqFglo8qCTXeIvYEM9ge6ZOk6SjP4Us7SAGwmncGKLXQCh8elimy+u
         Mzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uLpnLpELmGe+yW4fk7cGq1x4Clkl1m4lKrfogbkISGs=;
        b=UV12yjJdMzcMq5ZglQ4tTnEXN7CCRLEh71S+rWcHtL/xjHEAYPphY4GpWtf6OqAlzN
         C5LfwAmk0CRCtEpl6R03VSIDeuO/lrBlwC0vEQ2F+TB/udtDjmnUbzrrFF+aUQHZMAbU
         EmfTinKdtTrHW4kbnD4q2UBMEZjW1oJLRWK0hX1vq4cQ9JnJ//wncCSy5QG7o8i+zn/a
         /2ZzqnI+a8OZranvhUFgb2CudkJItBCfDnuLk/R7IU1MZ6UhrxMGntkKhU7Wl+X2vjwV
         3pAMkzaAMLYOpbveq0ltneSvPTGB6uTN4s9zVHDr8YGeAMWApPHHokxMr7A8LAyoX1kv
         P/pA==
X-Gm-Message-State: AJIora/13OKJDW2GD8uZaP8yB5lumKrUv1aASBHCopLTPR5Mr154FlsE
        +xpGeCddY6SmMLLpvqZfGkurwbn7tIMbqLK1
X-Google-Smtp-Source: AGRyM1ufnNopFhtdPylk7dscYQmUDCYnzxosLQ4ObPtS3j36bW3vf1kRStON1rNbR09cdEcuszHqwg==
X-Received: by 2002:a2e:bc17:0:b0:25d:50b7:74fa with SMTP id b23-20020a2ebc17000000b0025d50b774famr19322030ljf.444.1658421903829;
        Thu, 21 Jul 2022 09:45:03 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id u3-20020a197903000000b004833caeb8bdsm538861lfc.101.2022.07.21.09.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:45:03 -0700 (PDT)
Message-ID: <0fbc4db2-76bf-f25f-e7a0-13838762a439@linaro.org>
Date:   Thu, 21 Jul 2022 18:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] dt-bindings: Fix typo in comment
Content-Language: en-US
To:     Slark Xiao <slark_xiao@163.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, david@lechnology.com,
        mturquette@baylibre.com, sboyd@kernel.org, mdf@kernel.org,
        yilun.xu@intel.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        agross@kernel.org, bjorn.andersson@linaro.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        narmstrong@baylibre.com, khilman@baylibre.com,
        mathieu.poirier@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220721011746.19663-1-slark_xiao@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721011746.19663-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 03:17, Slark Xiao wrote:
> Fix typo in the comment
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
> v2: Add all changes in one subsystem into 1 patch


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
