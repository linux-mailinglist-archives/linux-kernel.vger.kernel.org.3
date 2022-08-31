Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47F35A8109
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiHaPRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiHaPRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:17:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59C4D86E2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:17:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p16so2403258lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=j+x8gtYgEvQXXsIme6paq057ppPsPgwtY+2WyVm4MYI=;
        b=mV16RjMDad5ybtkc4gAVnDW4AkoI60FHMSfLzmXwiijCy12PL8gSixmdRz/4ad5FGi
         FfJHaqcyAlWHY6+urDlVtlsVKkoRYxsSBa3zSMfadvSBxQIAXZ5kgQB+cytZJ+J/LP51
         T28JwY0hzoTUpulhg/AIkjyCmzbqfgGQ6GL4xkBKSbw04SMHaEm7mzK8yz01VkiDannY
         DTClbD2qNMH+egdDQs4zWohWxIlY/Xu+H77XJGIfaXzPrs9bi0YlOcg0lncJKwQf+BWX
         vokk6wlfT2mEMxTzOLaCws7Ys4x6AZoj6mNK0cftlTzQw1OgLoHnd2j7oqgX05UjW62b
         nkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=j+x8gtYgEvQXXsIme6paq057ppPsPgwtY+2WyVm4MYI=;
        b=zVF5m3B7Ts3WjFLYlra0v6lFT6V+mSseirKIOGskJBWffNUHceyk4E7atHXWKMM+Ws
         7PHLlSiiwCMJBb/ATtRqMsge8/ElodT58OUcgXdwo9FrIC2XmQlsiYzRuBJ4b0/7jbAj
         BbrS++Cg4vgZfCbk1NtmHEwUnYOMNwbBO2kJPiQT0q6yS1qclriqOlmjCq0A4uozUnzy
         AoTm0a7F0uq6uhd11HGwCz2mJnjImDw7tMAMglxsWWfYQAg+zINp8LSU6hpFRfBKm2nu
         JrlMtqDnybFMtNhc994b9QRism8j1L0ffvxWrCX06Cc1Eyr+SLr2dIMGsKzdfg5YNr+4
         LZeg==
X-Gm-Message-State: ACgBeo3IGQepkZvUNFoYz8pS5lSluDKhGxyPcmHQWvg7QgzuBVAOHmzt
        kJs1AsXNZUxTybZVaSEyaW3oYQ==
X-Google-Smtp-Source: AA6agR6Uffcrex9KBElxnc5zAZUe8Qy1Hc8g4alJjqXQ4Y2R1772q5doZMjf2xTZf0RIaGr2rAOmgw==
X-Received: by 2002:a05:6512:32c5:b0:48b:fa9f:a98f with SMTP id f5-20020a05651232c500b0048bfa9fa98fmr8899311lfg.335.1661959046205;
        Wed, 31 Aug 2022 08:17:26 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id q16-20020a0565123a9000b00492a0f02758sm2024739lfu.28.2022.08.31.08.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 08:17:25 -0700 (PDT)
Message-ID: <f04e7baa-ad75-57c3-bdd9-0a9aff7935c3@linaro.org>
Date:   Wed, 31 Aug 2022 18:17:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 2/2] nvmem: lan9662-otp: add support.
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, UNGLinuxDriver@microchip.com
References: <20220831064238.102267-1-horatiu.vultur@microchip.com>
 <20220831064238.102267-3-horatiu.vultur@microchip.com>
 <1ddf261e-55fb-e30c-93b0-efb9bc0987b3@linaro.org>
 <20220831105237.ot5aaawnrwjqmjgj@soft-dev3-1.localhost>
 <9e37285e-9408-7adb-1242-77f580573283@linaro.org>
 <20220831145216.cw6gignx3b2fo4u6@soft-dev3-1.localhost>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831145216.cw6gignx3b2fo4u6@soft-dev3-1.localhost>
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

On 31/08/2022 17:52, Horatiu Vultur wrote:
>>> If I put only one entry:
>>> ---
>>> static const struct of_device_id lan9662_otp_match[] = {
>>>      { .compatible = "microchip,lan9662-otp", },
>>> ---
>>>
>>> Wouldn't be a problem that the binding mentions also lan9668?
>>
>> No. What could be the problem exactly, which you are afraid? Why
>> implementation should be a problem for a binding (which we try to be
>> mostly implementation independent)?
> 
> The implementation wouldn't be a problem for the binding.
> The only thing was if the binding has more compatible strings than what
> the driver supports. As an example, in the binding we mention about
> lan9668 but nothing in the driver.

What is that "only thing"? What is the problem? It does not matter
really if the driver mentions or does not mention lan9668, because it's
not related...

Best regards,
Krzysztof
