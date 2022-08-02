Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE147587B28
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiHBK7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiHBK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:59:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDF1102F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:59:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w15so21346237lft.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=3UZBnzqWpB98WZ5WXdV7+6O+9aoJ0uIzaDcZHuy05io=;
        b=rHvDCifZbqvkjHdJC7gWvrBFKRjbHjANCxJBbmphZQZ4ovDLyc74utiVqv6CAB6OJa
         EZuduabY3WEPjYsx0CFTFAXf5fMkUchtIXwhF4HW98CjM/5Pv4iO1lf+jMYWrMa56pCf
         LOCrOVSsO/12QiZnwMmnpxSuTe9QryMRwgxSEyw2BdF+Q8N2PA9V80Rr6ZiZOWBwW6Kt
         bLfeEsXRCcMlbsUwS6plLdU6RFw4SbkrhCVZy0HtpqXeXOxweLOrrLjBYKRte8O5D+Dy
         U2ES6uqPt4yD9d1u75N+URMBLUzVMVL6Qg/2F+SqxNBbGCLMGI3i1rLACSUS0XL1N/jy
         gatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=3UZBnzqWpB98WZ5WXdV7+6O+9aoJ0uIzaDcZHuy05io=;
        b=ZsM9A4AINmd5lOxQoxZukaC7qVrkw4dyX4MGTCtEhJLWFZjsPl5QNt6LIOzLHuVFmw
         UB4OcJZXS8Ni8GN2ZpwARGNy962mcapuuVPvHEVh6jZXWAyqv/MczGkVXhyI1gbkroq1
         L0xNQyVfOvqQYXjmaF2pyr45vblkYd7IFpKYq1hOBvYNnBMk785yGy4NUNrom0HziFB0
         kn77nRBon310ANyYo/pRnmlQElRz83HVfZ8nnrcGpG5GsrB5Nx8ZOZzjPqG2Sr/yElPn
         7UnFpalbBlPmubzV7QxcptS52DuRwGS3fltqUIijUf289/zMAa6zx5Oh8Ap3d+t0A8Y+
         mJgA==
X-Gm-Message-State: ACgBeo14RFkVZXT7MvDV823GkhPbs7jJXNhCDvrptoeApCWshNF+mBAV
        nqHoNSuICCdtokLujyJIotoLg50XgK91OlGB
X-Google-Smtp-Source: AA6agR7gwPFKnFVV8CRFCZ2R0r6tN+gc89kLYSvCJc5B83Cs5RgtG5p7hMbKyu6+28x/GoblETbw7g==
X-Received: by 2002:a05:6512:3a82:b0:48a:f7fd:57de with SMTP id q2-20020a0565123a8200b0048af7fd57demr3620712lfu.453.1659437972910;
        Tue, 02 Aug 2022 03:59:32 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id p13-20020a2eb98d000000b0025e4ca99066sm797015ljp.139.2022.08.02.03.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 03:59:32 -0700 (PDT)
Message-ID: <4697e12b-e9e3-100e-190c-7eece43b3a05@linaro.org>
Date:   Tue, 2 Aug 2022 12:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] drivers: bus: simple-pm-bus: Use clocks
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liu Ying <victor.liu@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be
References: <20220802071310.2650864-1-victor.liu@nxp.com>
 <20220802071310.2650864-3-victor.liu@nxp.com>
 <7b0d5f68-491e-ace4-5970-92ef795ec5a7@linaro.org>
In-Reply-To: <7b0d5f68-491e-ace4-5970-92ef795ec5a7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 12:56, Krzysztof Kozlowski wrote:
> On 02/08/2022 09:13, Liu Ying wrote:
>> Simple Power-Managed bus controller may need functional clock(s)
>> to be enabled before child devices connected to the bus can be
>> accessed.  Get the clock(s) as a bulk and enable/disable the
>> clock(s) when the bus is being power managed.
>>
>> One example is that Freescale i.MX8qxp pixel link MSI bus controller
>> needs MSI clock and AHB clock to be enabled before accessing child
>> devices.
> 
> No, because it is not simple bus anymore.

Hm, actually I take back my no, as this pm-bus was done for such
purpose. Since we allow power domains, we should also allow clocks.

Best regards,
Krzysztof
