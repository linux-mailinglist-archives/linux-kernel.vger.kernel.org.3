Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC932596938
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbiHQGMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiHQGMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:12:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7708575CFC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:12:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f20so17753166lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=PZ4LK8GGphGofsuluwN0mGslSZaTL+IEGFrATPvBPVI=;
        b=VHrTPPR76OtrWG3SrbjnGOx8gTtTZ7/M9JJD6NyyR85/G9baHBTsxzPHkmX/STyR//
         JEYu3kxeUnNdfzmSI1h5yzNsryVQKLXmySnxoCylUUtMreXwiSxqVKRHztrl8btq+Z+v
         A4EwjTAKUDWozs65TteOSM2+iupPmPOIsVrNfOLBbYT0xUZij+Ey4EL1NpUDCHV1cnxc
         ieGJGEAPmWm+PwoqHgRBSsH7b0LjTVijh3U++p4IZ1OFvfm/nMpIKWpS/GJ6GzEdYCdc
         o8lZbMT6Tw1Hrz7mxRXQIsi42fbue0vqJSVk5SxqPkinjCTwVVNWXlr/cPTqtym5Ge82
         Gi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PZ4LK8GGphGofsuluwN0mGslSZaTL+IEGFrATPvBPVI=;
        b=4qN1gaOfew2aa+4PMTXQjFdX6OspekBoQASMIcPOPcvHQaoV7bF8dq4sJ96/zSWnEQ
         Vzux5JVuFKdsiCRkQZnVL4SoJnD/EEA5lYUdOE3orHGwX7w4GNjpQw/Yzw5EWbXt4I+K
         IS4v8EEmkQPjQPFplWQiodJJJCqvKDAMMDrIQEMIk1i3heGyWD55CFtI2SW+YNvKWbay
         jAMbLRnugRUy45OcKP6CVBWGqJiIvABuKjeJWNlZCegCQxwJvY1qvYlTQ10HOfQjahXI
         EyNPCmD5btnfSKnSYVFtmTl+tKeBHVY8phiNluf4Y+P9BwaZT8EZGdFCUM22/vXQw3+n
         qfSw==
X-Gm-Message-State: ACgBeo399yfpbD63t8tO9/ueaeZ+HrBKhfDNT7uNqGZQGc5YVlcwuV0u
        6NRu/yo3gImOamOB5lHl18Nxhw==
X-Google-Smtp-Source: AA6agR4FX69ljy5R0pSejaqH04NrUc8B0QHFFVg2pHgqObkjP9l0n2ifZQDW8lJ0q/oyN25J9zg/yA==
X-Received: by 2002:a05:6512:2824:b0:48a:e80e:e654 with SMTP id cf36-20020a056512282400b0048ae80ee654mr8969163lfb.274.1660716754887;
        Tue, 16 Aug 2022 23:12:34 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1b1c:14b7:109b:ed76? (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id e3-20020a05651236c300b0048cf43c3a85sm1575558lfs.238.2022.08.16.23.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 23:12:34 -0700 (PDT)
Message-ID: <35973b74-f8f2-f953-f937-365acb67db43@linaro.org>
Date:   Wed, 17 Aug 2022 09:12:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 0/9] Improve MCP3911 driver
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
 <99d7784e-e59f-b4f7-e275-935836e5d406@linaro.org>
 <YvuwTVlgTeDvCTi+@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YvuwTVlgTeDvCTi+@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2022 17:57, Marcus Folkesson wrote:
> On Tue, Aug 16, 2022 at 01:22:31PM +0300, Krzysztof Kozlowski wrote:
>> On 15/08/2022 09:16, Marcus Folkesson wrote:
>>> v5:
>>> - Drop remove function
>>> - Split tx&rx transfers in mcp3911_trigger_handler()
>>> - Moved Kconfig changes to right patch
>>>
>>> v6:
>>> - Go for devm_clk_get_enabled()
>>> - Cosmetic cleanups
>>> - Clarify the description of microchip,data-ready-hiz
>>>
>>
>> Please include the diffstat (format-patch does it for you, but if you
>> prefer to use other tools - it's your job).
> 
> I'm sorry, I do not get you.
> The diffstat is included in the patches, should it be included here as
> well?

Yes, in the cover letter, so when someone partially interested (e.g. me)
opens the cover letter, it's easy to notice what files are affected.

Again, this is exactly what Git is doing, so you have to on purpose use
less-standard process to achieve cover letter without diffstat.

Best regards,
Krzysztof
