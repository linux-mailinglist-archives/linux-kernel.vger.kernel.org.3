Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB515B21C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiIHPOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiIHPOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:14:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24282F3404
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:14:17 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v6so6893410ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=hKRphsjsiF6LDtEqFgockhfe9lt7B5JqPVBYTTGnPnE=;
        b=ALkOSH9hcXOmQ1cb9SGg2JurKquWfIlWLvq0yh6sdGp9oUEF/i+BufiMVI8+1koec5
         TBB3vZsV3Lm9qk5i7Esr0dZ7CP8o1GYCJwX/1TTzOBemZkYTcKpCm4JMu1qL8b8FrWk4
         YdQhgKJcqS+L0Xe5Bwtda5VBGDed7nx9jXeD0ZnGp3tx1oIoZpOKpucwmZvJS0NwPqQB
         tJJKOnT+TQqnHPe2I8RQ3Z7tGnAI91x/TuIw2qO1ypgOJDlLKNNX9LA627UBGKOeMebH
         EmLE5/WUMn35PV1+6NabRLq1a9SmRFD+wkHw6ALPYPuuyfzI6aZkEBJZxKhWHTkUBR2R
         Uapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hKRphsjsiF6LDtEqFgockhfe9lt7B5JqPVBYTTGnPnE=;
        b=aKGTyFAEkwmW8df9DIYAmXy7IT5HGZFb2y1IylMg680WE+BIP7WlQ78bxnMYE/5e7y
         nBqxed/YMJuoA3SGJUb2K09fgF2OQz5e9Kurs0TPGiarYKtlNDOMzUbPTTyiSlwLNsqR
         FEA3bp/5WISMeLiS5sbx7xv8/0AfFCShxB2heSSVIBfkpKhR2ePJMK4Nl2NEl4RtIQhO
         Qh2XQk3R4i09M1s6Hb0iI/lAeG8XPHO9aC3kOJTJOLUuQ00Axs66BFtC7CzEDRNZQgKV
         EpFBKHsBS12xceuTRhVdx/JlfWuhW/y+hWAYE1LLRek+Cc72bCGm0jKQZkcENnkIVJYl
         xI1A==
X-Gm-Message-State: ACgBeo35bpWcIfP9PKfUC0UccmIOHyKECKprX1sCVIJ/V/TWI/5GTHd0
        UplnR9tTqKFjLJlywi6sKcu4pA==
X-Google-Smtp-Source: AA6agR6ly+Z7Ik8QtEkVhTYr2lWnChO2RHNj0Pr+lbGV0jqJ82hDKX5qPBmvMCN5NXRBGH8VwR24Cw==
X-Received: by 2002:a05:651c:1a2b:b0:269:1aae:3f0f with SMTP id by43-20020a05651c1a2b00b002691aae3f0fmr2875032ljb.457.1662650055521;
        Thu, 08 Sep 2022 08:14:15 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a18-20020a2eb552000000b0026ab2a04055sm1283693ljn.130.2022.09.08.08.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:14:15 -0700 (PDT)
Message-ID: <b25cc1d4-a2a4-efc1-eee8-70459d28311b@linaro.org>
Date:   Thu, 8 Sep 2022 17:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v9 2/3] dt-bindings: mfd: atmel,sama5d2-flexcom:
 Add new compatible string for lan966x
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        lee@kernel.org
Cc:     nicolas.ferre@microchip.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, UNGLinuxDriver@microchip.com,
        krzysztof.kozlowski+dt@linaro.org, claudiu.beznea@microchip.com
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com>
 <20220908150658.1839520-3-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908150658.1839520-3-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 17:06, Kavyasree Kotagiri wrote:
> LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1
> in flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
> can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
> functions being configured.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Best regards,
Krzysztof
