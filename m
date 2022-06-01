Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05420539E9C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347136AbiFAHlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344436AbiFAHlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:41:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E6A941A8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:41:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o10so1008195edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XCHjkR162OGclvyE8q2D5N6gNu/Lh1uzx3p/QFm8BQk=;
        b=AtF6guPyJWyd6SG6xS9QKeOyXDffCxhwicCbaelkeBvm/S3GCnGSmM05xNPoFrRu3L
         ReTi6NH0VZeNEMZ4ada9XXjai6EoPPLHiE2MJAbroWrVdNeTd89qTTqk0Pqh6GSNv0yz
         Q6yDQVqKYhB0JZ3ndw0FcOLnQkMAAecOMVbCS+F+Zek0U/F63h0nz4zb+QuffYSILmVN
         jW2ve/asRVDpAJS2YdtJiMEfw/kcwkTk9FJsc+LgW+XQA0jiKFee0KGXLtp95CCxkK4e
         B5+lissO4wnFESPgZwDmxe4sXrt/ev3lcs26fZks5TV2u6HYIMKaEdI8p8IbOaZe2vtx
         xbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XCHjkR162OGclvyE8q2D5N6gNu/Lh1uzx3p/QFm8BQk=;
        b=4JXtsyJpWRenatixODdHT18WucRCAsITPTsZn2akD/BqIP8VCxvDbt53bRsdV50JeB
         Ha9+RZGzSgF/Fmsc8rQFVBXYFonCeeS7i/LkQTqQi9YkhoL48cHUP0ArgalZS53XngdY
         Ljv5kWksxXbFUSSswE7Wu77c8uTLQ9tSWtqnXoRgpu8+bu/bvWnqm2GpPHBRD/YPM2eE
         uTgI3d5XpldpkPON+xSceRqrimj5juvC8quDVjrRK8jk8K/Kg/Uc7Up/C/IZP4i2go1W
         EzlmuLPia8m6JjmNgRCZtccOWhTjMIZGdtbctn9kPlFmieOk5ce2+bpUlFKpk6QUqrdg
         gATQ==
X-Gm-Message-State: AOAM533EPGpnBfLoKhXqnkHLHJizbLFMd8e00c6ktXv55aYY1rL56Rlx
        hUCEYLvRyFB3Xjj4kY2X2hAwfgO8+/tB9N45
X-Google-Smtp-Source: ABdhPJw8lmBFSnKs4AJ8uLJicEzY0+9ftI56dBz+ES5444j2D8o4bn2ufx6ey9/KjgIrBpxndW4IAA==
X-Received: by 2002:a05:6402:17d0:b0:42d:ccc1:f4e4 with SMTP id s16-20020a05640217d000b0042dccc1f4e4mr17759792edy.150.1654069275357;
        Wed, 01 Jun 2022 00:41:15 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bv15-20020a170906b1cf00b006f4c4330c49sm377636ejb.57.2022.06.01.00.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:41:14 -0700 (PDT)
Message-ID: <ecd2031d-faef-8a3e-e99c-8ee4fdd524e8@linaro.org>
Date:   Wed, 1 Jun 2022 09:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/3] dt-bindings: arm64: add BCM6858 soc
Content-Language: en-US
To:     Anand Gore <anand.gore@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, florian.fainelli@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220531184615.2836433-1-anand.gore@broadcom.com>
 <20220531114551.v2.2.I2bc1418dd24a902e941c7073bbadab00568b4f5d@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531114551.v2.2.I2bc1418dd24a902e941c7073bbadab00568b4f5d@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 20:46, Anand Gore wrote:
> Add BCM6858 SOC device tree description to bcmbca binding document.
> 
> Signed-off-by: Anand Gore <anand.gore@broadcom.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
