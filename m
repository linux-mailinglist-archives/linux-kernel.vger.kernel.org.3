Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD75A777B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiHaH3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiHaH3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:29:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B2EBC804
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:29:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w8so9660797lft.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2TsGK34bA5KqKqr5+etpP4SBSBDx4W1Iyg9gkSGp89Y=;
        b=MB1Wz1/I+H8pAA/lyOwnr/Pwb9fss6od/9GDLkGMHr7ullFlxVlxDjWwvLXij+/U+h
         /zbMQVWHxlT7YoVLgSPKXCCMCfHv23FIDQpnVk/eacv+GKfYEDky78dxqsRFCVowxAYQ
         YFmg0W/zBxbE7JnGoO8714ypYOH1VdsUs3tu5um02iCLee5HBXBhDHb/vxilQX0Dnsxc
         pPxoV/jFUKlbMm+Pf4ODUnJ7eHs0YBwBrFdkeIxp6gONCZRgwOfkCx3WO6tsxiN99wqe
         NJqBq53gL395lrAHVuP4qw4LdOzwBS1W+IvAAqmGVn7Q7Ek347nixtbP1BdrhV2m1crO
         ptmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2TsGK34bA5KqKqr5+etpP4SBSBDx4W1Iyg9gkSGp89Y=;
        b=mx6UZ5Y12KNVJ1ycCnZMoBgpHUs9fqeMb+4PjqPTwE+xa7p3kRkOelJde8j7SBQYKE
         wF00VJO96r+9c6mW4vQQdr4XvLdy7Nd00l/061SAeEZvRb6q6Mgvz9eOxVgcxL0nCOl3
         N4OpKKCK7kn16ykWFYDaWmsw8DQsTwRfjBO0RzOh9gfcvEzHIoiOFzP6Ww1iOVLGiE4s
         2Hp+TFI7lYM92XajlXB/voV7RghdWOlRTZEzminLdG7ef1Yhc1397GbiRsSDq2wlWhsi
         V8ELADo76VqCY1hT1RG49kRBqvaw6DOVJQP2xTNFAqajkHocMe13DADvhkOQo0GPJq3K
         GpiA==
X-Gm-Message-State: ACgBeo39PgSQHw7P57ERnVbO2uIokCG9xpSTYf/RZHKhEq7zgKVtLIAl
        PVpBd19fLjzRKdO7/1A+EuMgWA==
X-Google-Smtp-Source: AA6agR7H1+Rn7DKaC75RdA+ThF5pC+j1tHFgTLf6uGiYVF/nQ+yoG98+ucJbyfMMUxCX+IHoWcsjYg==
X-Received: by 2002:a05:6512:230c:b0:494:8ddb:606 with SMTP id o12-20020a056512230c00b004948ddb0606mr480203lfu.44.1661930950905;
        Wed, 31 Aug 2022 00:29:10 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id f16-20020a05651c161000b00261b175f9c4sm133548ljq.37.2022.08.31.00.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 00:29:10 -0700 (PDT)
Message-ID: <1ddf261e-55fb-e30c-93b0-efb9bc0987b3@linaro.org>
Date:   Wed, 31 Aug 2022 10:29:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 2/2] nvmem: lan9662-otp: add support.
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, UNGLinuxDriver@microchip.com
References: <20220831064238.102267-1-horatiu.vultur@microchip.com>
 <20220831064238.102267-3-horatiu.vultur@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831064238.102267-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 09:42, Horatiu Vultur wrote:

> +static const struct of_device_id lan9662_otp_match[] = {
> +	{ .compatible = "microchip,lan9662-otp", },
> +	{ .compatible = "microchip,lan9668-otp", },

This is still wrong, does not match your bindings at all and still
duplicates entries without driver data. One entry - 9662.

Best regards,
Krzysztof
