Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1C358EDC6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiHJOBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiHJOBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:01:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C043A6CD33
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:01:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b6so7836310wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=dZA7yOywUXukdcu5pO+Io3zvJr55DJZjswrAfBadLys=;
        b=Yn8uEP++9IJloQ1BDCmMiI3k7Ee8qgEzlCEAYmHEDqta1P+Vib47gUxe6vH3H4XdOV
         OQkpMmnZbDPz5ZX+zt2N196uqkG5xcL5/Kx/Wb43oX4ErRJWdjMi0ew0lu/wjmc8Yjuy
         sFyHWISDMv2E9DqiHP1/J0w2EuhM24mGHNrb4Ifk62k07OzhsHShfSKkxVKjBCkYkmOC
         SfBZ5uckbvCi0a0mbgdNeZ2wy8YvQU/QtZtPC/PFahOvXfByRXvwnLyTDuPoMx64qAnG
         4mFLpCptRa301NI9CDIrmS097PGpKW57ag53WZk2Gx6MJ05SzA6QUFllmNpPRl9jQWFN
         gfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=dZA7yOywUXukdcu5pO+Io3zvJr55DJZjswrAfBadLys=;
        b=1t5OElyVjw0rStUgBcYCmft9FCc8r+KYz+mQPb7L1vOnciaAkxbojMf5rZL3JBoJSR
         gUAYM8+D2djTl4k9nAmLxavPeS+c4ygg9Eqd15l/fVmOC/Os8HNYdRpa5whaGoiu3HCO
         4s4HBvlO0Njr+9NFTpmh6///FMANafvQaJEgs0ROQtJ/2DDJW306DMDCv5QlYMgoEpEH
         fLlImpmvnOYJd+SQaxfiRUEBVUZsI0l7qL7EXJlTW4kL20aPMoYQtueTdkpqn8DdgaqD
         O+CZJ13jWb1/y0MDe7mPA7KLYCb9c0U6PqAsVjCq9aglP0u7VNDZk/7dQreZfc8kKiOp
         u3+w==
X-Gm-Message-State: ACgBeo3ibJbRP1nFllKmyyIpXevkpfJF6YJegfeYEyLUzQiNwroI7Sk5
        0bkx28EoLWMYAwybrgI600S+fw==
X-Google-Smtp-Source: AA6agR7DzgEgT3CgQhryxKIY8bUl9vYO/MdJ9kGHKEoVxRh7PUHU+GxrH0F86bCtL7LF92AxXsWGgg==
X-Received: by 2002:a05:600c:1d1e:b0:3a5:4f8d:743f with SMTP id l30-20020a05600c1d1e00b003a54f8d743fmr2558911wms.121.1660140096061;
        Wed, 10 Aug 2022 07:01:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:bbf0:b69d:fecb:8006? ([2a01:e0a:982:cbb0:bbf0:b69d:fecb:8006])
        by smtp.gmail.com with ESMTPSA id az21-20020a05600c601500b003a31ca9dfb6sm3347611wmb.32.2022.08.10.07.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 07:01:35 -0700 (PDT)
Message-ID: <518f22f4-1582-924c-9eaa-28ebbe53a632@baylibre.com>
Date:   Wed, 10 Aug 2022 16:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spi: meson-spicc: save pow2 datarate between messages
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
References: <20220809152019.461741-1-narmstrong@baylibre.com>
 <YvJ84qkuXdvVgXRm@sirena.org.uk>
 <39c2f53b-8f53-ceb1-ae0c-81e5e53d01aa@baylibre.com>
 <YvOmnDJA+ov49chC@sirena.org.uk>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <YvOmnDJA+ov49chC@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 14:37, Mark Brown wrote:
> On Wed, Aug 10, 2022 at 11:17:14AM +0200, Neil Armstrong wrote:
>> On 09/08/2022 17:27, Mark Brown wrote:
>>> On Tue, Aug 09, 2022 at 05:20:19PM +0200, Neil Armstrong wrote:
> 
>>> When you say the value set by the clock framework does that mean that
>>> the clock driver is adjusting hardware inside the SPI controller IP
>>> block which is then getting reset by the SPI driver without the SPI
>>> driver knowing about it?  That seems like a bad idea as you're finding
>>> here.
> 
>> The SPI driver is explicitely triggering a reset at the end of each message
>> to get back to a clean HW state, but it does reset the content of the "legacy"
>> registers containing the power of 2 divider value, the new registers configuring
>> the new clock divider path (only on newer SoCs) doesn't get cleared.
> 
> Sure, but that doesn't really address the concern - is this something
> that the clk driver programmed or is this the driver forgetting to
> restore a register that it programmed itself?  The commit message sounds
> like the former which is a much bigger problem.

It's what is programmed by the Clock Framework yes, it was designed as-is
so the Clock Framework takes the most accurate clock path but the reset case
wasn't taken in account.

Neil
