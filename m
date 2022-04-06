Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6643C4F5C1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiDFLY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiDFLYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:24:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D25540E8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:06:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q19so1948722wrc.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L78jN7S0NWr7Tauf3Ih4qh+7uPsQd7xS6nlswionrbw=;
        b=tFrclb85P+yDQkunEBt4+9y41xI11mXcCn8t3IYd57D9qw29K7Y8ivEVlaEWBhpsWv
         /vdMWzVJc+k4YrD5fQIgH9S+UmPtpz8WN0p2c2lcrIXQ6wHAWMb1nHLFimETRNSD4BlX
         upF57yEBGGkvOryz1tTc4481e04lFY+aKz/3wrchw5xwvGPQdNFTNkVtyZTxH5E/5P36
         Cq0pGUsrzfFje8D7WAI8lF+mfiEIHqBhYPKl0QJ31f9qAP64yRQxXpViYL6bY0rP2uiN
         wf84cBx4wyyfPkfbKzmAKIIYuXcZCIjVs8e8tGoWS4fodxp7uOH6C/rLjaTfmwjZgskS
         eYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L78jN7S0NWr7Tauf3Ih4qh+7uPsQd7xS6nlswionrbw=;
        b=bzf+HlX7qbJKCA/zKNheEsp3/ZUXFmoYHku96jhh2xhcxK0TIp+rWf8kVyGy/DfHc9
         wIrhpTKzloElKHjaK8ltpoI41ngAu2Gqxe0lUsBYr9mfduObBEqB8l4XVEF4hEao1LWn
         C/C8UBNbNze+vOaVZSJ5ptz8er3HcD1mTEu+dXGIrN1Yw/zRK2qYrsciH2vPrqR8n/df
         RrFmdYi/cA60FAhNz3P1RVx6AI3DxvjZ9DwQO9xytXOzU/0h9Yj+ThZJjDGmWlfvO8PH
         aQhc04OtyNqqA1zX8pFnVyakHSbyRU22owg3+dw3f5YLu2jHhTHSNyz+nv1V311kpzwX
         v2Gg==
X-Gm-Message-State: AOAM531Z0ypVyEW2czvtQiuXmZdlhuOjMom1aweN/PmBfaxCKxo2I57A
        eKWqHmU4C7BhTQgF24BiWQrE8w==
X-Google-Smtp-Source: ABdhPJyCCo7+pi/Naf0wendiSYRd/uC8NueeO1SUa9RWQLul9eAhpzG6vDq90XQ2LgrW9D2NpK4vhg==
X-Received: by 2002:a05:6000:15c5:b0:204:901:af44 with SMTP id y5-20020a05600015c500b002040901af44mr5658822wry.714.1649232362033;
        Wed, 06 Apr 2022 01:06:02 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:261f:c14c:d23b:d177? ([2a01:e34:ed2f:f020:261f:c14c:d23b:d177])
        by smtp.googlemail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm13666184wrv.79.2022.04.06.01.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:06:01 -0700 (PDT)
Message-ID: <3d74d7e2-1f52-11d8-e458-b7074bc4c070@linaro.org>
Date:   Wed, 6 Apr 2022 10:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v10 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, shruthi.sanil@intel.com,
        tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
References: <20220322130005.16045-1-shruthi.sanil@intel.com>
 <20220322130005.16045-2-shruthi.sanil@intel.com>
 <7e711327-bcb8-4c7f-5537-425ba1a79e62@linaro.org>
 <71e82477-16fb-2e7a-e5a9-e22327f31e77@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <71e82477-16fb-2e7a-e5a9-e22327f31e77@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

On 30/03/2022 13:55, Krzysztof Kozlowski wrote:
> On 30/03/2022 13:44, Daniel Lezcano wrote:
>> On 22/03/2022 14:00, shruthi.sanil@intel.com wrote:
>>> From: Shruthi Sanil <shruthi.sanil@intel.com>
>>>
>>> Add Device Tree bindings for the Timer IP, which can be used as
>>> clocksource and clockevent device in the Intel Keem Bay SoC.
>>>
>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>>> Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
>>
>>
>> In order to pick this binding I need an ack from Rob or Krzysztof (added
>> to the recipients)
> 
> Rob was looking into this and there were some comments around v8, so I
> will leave it to him.

whenever possible could you review this patch, so I can merge the series 
which has been a long on the mailing list ?

Thanks

   -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
