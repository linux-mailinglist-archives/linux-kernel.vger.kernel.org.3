Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458B9524ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352844AbiELKyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352864AbiELKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:54:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BA16B0AD
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:54:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y21so5774498edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jGdKfFqAtrS1gqNbHfbXY/tQwLbLfSQD8UHbxsN3ezg=;
        b=srA6iFtAgIpOUr2eG3F2XMl9mLYgLpPosDFcbhEUA0rTh2XVoUwwg3LRKMF+5T8qYg
         fDbTkTqcO8ydPJ3HOsfEke/zTViOj8+gxPxFO0Zn7zmtrq9efdBY7dPXBw4hoMab7MZC
         +MoG0uc5fusMkOaY1oSGyITx5seVrvJXc1yzPDDg6bPsQhHE9lABBA6/L5Ejpc+wTtXK
         eG6PRK5UGn4Fjy2aH+Tdu0IixeCwSFc+Krton0MNL03wNabI23gX7tvE14ah6DLBAzNU
         YwmXE8Yr+Sy+oWnxOk4aQfXLaWAFjhNEexzbf1LBDED2JKtLat087WSjMNQSfeslrEz2
         1Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jGdKfFqAtrS1gqNbHfbXY/tQwLbLfSQD8UHbxsN3ezg=;
        b=C9BsqUhRN8tRPomdCec9m6ZNDnzdedJfSB7OAfHKECOqbGU8wwz6ANmnquMJBCtntb
         +kHxXNqByKa7FqoN3uuFHQtX0ukP3IECX8rDthaQ5/r29Ewfz1WdNZdYRDgbaRNHu9bn
         k2fVMGhqLnvJ7/O5pWQbVJZN4IeLP/gshxtqBteUP18nqfOJIXqWoR5A7jVpdOCeexDh
         ySnNvERumIs2kE/WQvLRneM9qyGHP3x1XiIl7FV8nnmXzXOtfvFLN2qHD+Un71Bqt3S4
         7w+lax5s0JXixDXk5Ryp7DRwVW5bamVctvZAGPOuEQs/hde9mdJsMELxFtm1UzheIqcr
         NVbw==
X-Gm-Message-State: AOAM532kz6UKwHRMgfxKLdZWJb/uwh9ICUkeRBh0d7aZvs/XrRmYXtvj
        vDvOUX7KG658gEkU/9fUtyOh8g==
X-Google-Smtp-Source: ABdhPJy858LVoVMPz+mUZhXi0JydYasRlBRoI/V9Jpro8MUTujKDDlY60ugIiM/WrNy7bI8JAT5xcQ==
X-Received: by 2002:a05:6402:1113:b0:428:679e:f73f with SMTP id u19-20020a056402111300b00428679ef73fmr32538713edv.378.1652352845735;
        Thu, 12 May 2022 03:54:05 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906474f00b006f3ef214dbcsm2000898ejs.34.2022.05.12.03.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 03:54:05 -0700 (PDT)
Message-ID: <c385961d-7290-bad6-a1d7-be9738a1d842@linaro.org>
Date:   Thu, 12 May 2022 12:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v15 04/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Content-Language: en-US
To:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
References: <cover.1652329411.git.qinjian@cqplus1.com>
 <b5ca5d417be079a2a40a6e79ac1b246b6359a49e.1652329411.git.qinjian@cqplus1.com>
 <e9a39eb6-d8e2-bac6-27e2-f63ef8519917@linaro.org>
 <8a9fa13f66ce4ef9a8f8c9200e1fac5f@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8a9fa13f66ce4ef9a8f8c9200e1fac5f@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 12:45, qinjian[覃健] wrote:
>>> +
>>> +examples:
>>> +  - |
>>> +
>>
>> Same as in v14. Please go through the comments thoroughly so reviewers
>> will not waste time repeating the same twice.
>>
> 
> Sorry, I don’t understand your meaning.
> Could you explain more, thanks.

I commented in your v14. Please apply the comment or keep discussion
running. Don't ignore my comment.

Best regards,
Krzysztof
