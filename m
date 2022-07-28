Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660A258455F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiG1Rzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiG1Rzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:55:39 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014C927B28
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:55:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s14so2741341ljh.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n+Kpt1SrfIHhgdOH6tBSVGEfnfJMA34tVlG2Tbb5sFQ=;
        b=I4qPi8f+3XxKtWd7+MAY0XhUt0Gh5petC0kOU1jusTfg05yFCCorTM1HKl7AzCl4LB
         pWWEX9IYTPitqYdh2uJ1alCZ8L2Xso9vH1lgeTpoKLaK0ajEwiDkWcyqdU3D9LwzszW+
         k+i3EYifzKI8HqFpv1Z+93Od3Mfv3vR5jo1cIuTIxPL+zD/5eUMBPclEn86VbJnsrFDD
         CBMq/ChQC8iLiv6wzsw/hC6Uxfmxm/YA72cWIjY7cflzWJrLWespgfi5h+Ym9pwmUntz
         vr/cfU09+9EBKNNnXWNidkgGs7KswSjN9tl66jA1Hj/8GlBuHpu43RSJ0dPinVUMCZDH
         S4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n+Kpt1SrfIHhgdOH6tBSVGEfnfJMA34tVlG2Tbb5sFQ=;
        b=WaIxxcLBKZ3q8YnUOO8cU3k7V0/E5cCVCgbDhZRvKzLyGaUN9Rwm6mVZyRWeC5vl3x
         LwFGyZVvamA7E4VK+gQOtYqhc6nDr+m7ZggFPqriPsDl7OZlqDjmbJ5Dv8EFOnvjZFcW
         dN9aIgYGKkKVdCOsCnPqmg3csfBLFglR3Ez6KmC+CwEN0nLZmMWDGpPUHbOdeW2xwMCE
         2c3JxBxp5vqbqTHr4QpNqeJND627C/81JU/iQLR3sm1sGdEHb40NCIK9+F5G5hFkbg9u
         NEm9Rn2mcQbp/5If12zi1Livprzl5MyoGlifhsIPKrIIpWdwwQsg8kld14lmrlA11qZa
         /xFg==
X-Gm-Message-State: AJIora+uCLx/Ov1kHQw2CSaOivHwItJ1gE/jBTtxmULD8RQvWcgf1SKP
        TLrfktWrMW3zncCKjljHr/jDZw==
X-Google-Smtp-Source: AGRyM1v7R/9C/AmvCfr3po6yc03PXFrUR1UYDYImrkIqM9TWG/XyVQz+Ox5Yrs5dgjKdUOS8tAl5Mw==
X-Received: by 2002:a2e:938c:0:b0:25d:f714:52e8 with SMTP id g12-20020a2e938c000000b0025df71452e8mr8633ljh.454.1659030936008;
        Thu, 28 Jul 2022 10:55:36 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id u13-20020ac258cd000000b00489f0c8bddesm294371lfo.207.2022.07.28.10.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 10:55:35 -0700 (PDT)
Message-ID: <98cc7989-fafd-c252-2b05-46a788622f7c@linaro.org>
Date:   Thu, 28 Jul 2022 19:55:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] dt-binding: iio: time: add
 ti,am62-ecap-capture.yaml
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com
References: <20220728175124.468461-1-jpanis@baylibre.com>
 <20220728175124.468461-2-jpanis@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220728175124.468461-2-jpanis@baylibre.com>
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

On 28/07/2022 19:51, Julien Panis wrote:
> This commit adds a YAML binding for TI ECAP used in capture operating mode.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
