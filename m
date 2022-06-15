Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A50F54D32E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbiFOU6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349765AbiFOU6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:58:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111211117C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:58:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s37so9819258pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3DBLU8nISIrYTBK8k6DcAIb8oRhQQh+dzHePuisDgWw=;
        b=K24g/lp0GAYbpVQo8ffvCiVoK+NofOFqwuVsXiGGu5CBJ4sNRZ8/bce7zFuzF54uu/
         0i2IjAF0NYQK4gdnJmXxrZi38QR9r8Y86zP27hydPWeIOKd3NFUvqJXA6RpF0O08RRv5
         nea7yOhOu8VrTW6W+jFQWsMJ9IdLTsIFZFvQ+Y1cnH0KFnarEq4IwnzxG98KdoIkOmp+
         2xL4pc1WfSSw5NflXAB7KxcGUn+0F/d3P9HS7ttjRi4wr/UERRi1Tb7kFPyGOEYDgLkD
         yRf8y8q7QGnDz5qxromfsCTalsHFoia4QiMizrBPmLxfyBJubSVyoeXOcC3+dVK7n1p5
         kIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3DBLU8nISIrYTBK8k6DcAIb8oRhQQh+dzHePuisDgWw=;
        b=WBbWOKF+zuOglS/up2bdkhfchG3DYjlaXyGm8KEDaVvQML9HDzP+aXvabQktz27wvZ
         KohHqR/uxDrboIEDg2BBUO0tkUgmicskPDkbzvMVHVFJdEognvDDIzWqQjoQsomAxSFE
         UcqXRCh8bOJGZHXLXMolsPsb+Zb1I6qY5jlBOX22i7vTJFIH1eJnE2t++vlcXJfWFbGr
         GtySz3GaGZdILgKPrPVjMToKYSA9uJeKd56mesGiwt6m2E0GIKpLHqSOjzDEE9iX3Uo0
         KknWcxyTkaUozsJPZSNdtWkBHKOFcJTo3vlOU1HZ1ME7IFbjeM+DOcHF5XbN+tWijSzo
         biuw==
X-Gm-Message-State: AJIora+SkiDJPS6xkKBwmgECW8SfMXYdG8cdKklNzDRe5S54mmZhJgF7
        ZMLj7dXOs5yPWKhTuZGX+vsmHw==
X-Google-Smtp-Source: AGRyM1sURT8l4Y+xwDaCXscmfLCsHvqJ63+ufGKTkBJlmbmd+0N7utxS/KDWcHHPQYICiTqtfN5cgg==
X-Received: by 2002:aa7:82ca:0:b0:51b:cf43:d00a with SMTP id f10-20020aa782ca000000b0051bcf43d00amr1348872pfn.58.1655326688844;
        Wed, 15 Jun 2022 13:58:08 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b0015e8d4eb209sm74146pla.83.2022.06.15.13.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 13:58:08 -0700 (PDT)
Message-ID: <add7aa29-d49d-8d3b-06d1-2275660fc7e7@linaro.org>
Date:   Wed, 15 Jun 2022 13:58:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [v2,2/4] Input: mt-matrix-keypad: Add Bosch mt matrix keypad
 driver
Content-Language: en-US
To:     Gireesh.Hiremath@in.bosch.com, krzysztof.kozlowski+dt@linaro.org
Cc:     m.felsch@pengutronix.de, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        swboyd@chromium.org, fengping.yu@mediatek.com,
        y.oudjana@protonmail.com, rdunlap@infradead.org,
        colin.king@intel.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
References: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
 <20220613080638.1339-1-Gireesh.Hiremath@in.bosch.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613080638.1339-1-Gireesh.Hiremath@in.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2022 01:06, Gireesh.Hiremath@in.bosch.com wrote:
> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> Hi Krzysztof,
> 
>> You wrote pretty long message explaining how the device works, but I
>> still do not see the answer to questions - why it cannot be part of
>> matrix keypad?
> 
> Following are the difference between matrix keypad and Bosch keypad
> make us to add another keypad driver.
> 
> matrix keypad:
> 	- By hardware schematic, a column GPIO line will intersect only
> 	  with row GPIO lines, not with the other column GPIO lines
> 	- so, row and column GPIO property are fixed, because of this
> 	- key scanning work based on interrupt mode
> 	- and key press is determined based on setting column as output,
> 	  row GPIO as input and set interrupt to monitor the changes in state,
> 	  serve the key pressed in ISR
> 
> Bosch keypad:
>     - By hardware schematic column GPIO line can intersect with row GPIO line
> 	  as well as other column GPIO lines
> 	- so, all GPIO act as row as well as column, because of this
> 	- key scanning based on polling mode
> 	- a key pressed is determined by setting one of GPIO line as output and
> 	  other as input and poll for change in the state of input GPIO lines.
> 	  Setting one of a GPIO line as output and remaining GPIO lines as input is on
> 	  round robin bases.

Which is still not the answer "why it cannot be part of matrix keypad?".
To me looks similar enough, although maybe not exactly superset of the
other.

>>
>> "It looks like this driver has smaller number of features than
>> matrix-keypad, so it should be integrated into the matrix-keypad.
>> matrix-keypad features are superset to this one."
>>
>> "But anyway this should be just merged into matrix-keypad. It's a
>> simpler set of that binding."
> 
> This keypad driver specific to Bosch measuring tool or similar devices.
> Please let me know to send latest patch which resolves build warning
> and gpiod API support.

That's a poor reason not to merge into existing driver... I am sorry,
but our entire Linux kernel concept is to integrate, not duplicate. If
each of vendors wanted their own feature, we would have unmanageable
monstrosity with millions of drivers doing almost the same...


Best regards,
Krzysztof
