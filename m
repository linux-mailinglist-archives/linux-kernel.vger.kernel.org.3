Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF5F58E7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiHJHp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiHJHpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:45:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2572180A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:45:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l10so10661750lje.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4Y8I/o2ZbiCR2XoMPvfK2Mfm06LP8ATnJlBaZaL2WHs=;
        b=ZPY3vZrZ8hfIfAKR0pHDDnplr3AJ0h5vaoF072rkhn/U+6pqhT/wRJ9o9tyGJsPz7R
         qkSLwvL2Hnj97oxpl/z2GYLfUUXIdoCs5zPPo9ELk7jm2lsNmmYMg+RcAmuyTSIPjPeZ
         uoyeWXFLbXar6ODfT6wr25kab3akxPDlGMqO3RKne6tRgNlSsK+ncKwjoqgQkfKnW/iL
         xnUiepF+ox5Igd7zPp1NRbCxR2i2xCQUISY7YZ033V4C7DMCsrQ4Ml5WyHatKEcZY73C
         lQez4RsUV98ozXfwhVIZ0GhG9LE/Zp0cKSA9GS2Bg1W3JnUxDiOjLDFSUCNQE3DTLtH8
         No3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4Y8I/o2ZbiCR2XoMPvfK2Mfm06LP8ATnJlBaZaL2WHs=;
        b=7adbuhuJ8ieVcV9eA4ZEgmzjAuCnjV4E8vP5wauqlHpFGSOoVw0K7eqg6R8yOL8nkV
         tZU/M1R0x98HZUbzSGSn8vCVNm1QXXmh7y/JrIA3LtkqD6hhOR7J6TCx0XQ5/H61XOGV
         5E0RV8lKAYB92lzv1JRtmkpFa0NxUGD9kyPD05lu5RCmODrmMR90E0pizdIsAEO1UsWn
         K2SzpLVDjNXlPHE8iVyNe7kB3basXjos1lFHYmDVXn+61R2t0nvFPG0CxnLC0AuQl+MZ
         cmpvt5EnGugNh/S+Jw1jr9waFBRkr2heUK7VsiAe46zH0e3vg47HNp4Y1gd/c1xS4j1M
         k5Pg==
X-Gm-Message-State: ACgBeo1BC1Z3aIGr5KXGBDuHvgOi3KZcxQ5ZAsKJNnGiwIQDfxLVCxjG
        wLx2+rMTwy2AWyK6eSz+KKchmA==
X-Google-Smtp-Source: AA6agR7B5+SnMSke7I7OLX8tC2RJaujbBSE5MWsv2wnEiHh8r7AIqvCB6ZCQ66mKP71PVcQhW/VGLg==
X-Received: by 2002:a2e:9cc2:0:b0:25e:4ec0:19cc with SMTP id g2-20020a2e9cc2000000b0025e4ec019ccmr8160991ljj.401.1660117520209;
        Wed, 10 Aug 2022 00:45:20 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u17-20020ac243d1000000b0048b0975ac7asm240813lfl.151.2022.08.10.00.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 00:45:19 -0700 (PDT)
Message-ID: <6771dc13-36ab-dc86-e231-4f9caaa06bcd@linaro.org>
Date:   Wed, 10 Aug 2022 10:45:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: Document the AXP228
 variant
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220810013430.27061-1-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220810013430.27061-1-samuel@sholland.org>
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

On 10/08/2022 04:34, Samuel Holland wrote:
> AXP228 is a PMIC used on boards such as the Clockwork ClockworkPi and
> DevTerm. Its register map appears to be identical to the AXP221 variant.
> The only known difference is in the default values for regulator on/off
> states and voltages.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
