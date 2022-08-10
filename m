Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB2558EA20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiHJJ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiHJJ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:56:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25DF6AA2E;
        Wed, 10 Aug 2022 02:56:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 73so13891096pgb.9;
        Wed, 10 Aug 2022 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=gYnpsrzUcSkvTedJeFolSDVZv7wH8NdfJvuS82L6Zr8=;
        b=pz5dJlqmAGBo+uMSzGbOw4tvRJoiIpBKArpa50w5xy7lXuO2n7A1fLy4jx/CELb1OS
         uga3lLNxHhqzzGk6iUIZRMIIzmBrIbXb94kPOGe1+yPgUF1REyvN7vxexI9uaHYBr3Pm
         jm0+J+YFcZAD6w2QmwPF0ZW4YGoX79wylvWahNhEeEwCQY7a/bn2JzhsnrGwHYAcCHel
         goC+69JAgqIz7b2P3rTN8MbVbaJh9DOFovrnwiqSaSJ83kpfGm9AaZl4L6I+HsPDpZyc
         va5PXborI8Jg7ESqZGUgFIWVCo8fyeblg6CHUsnPzkU0221ARCgJSdZK+GetG5whJ2zB
         k30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=gYnpsrzUcSkvTedJeFolSDVZv7wH8NdfJvuS82L6Zr8=;
        b=AOrYw3G6XxCbvvlKPVgw0/VnG6/ZpoGuN/mzNsq2IZ4DlWJ8oFXn8bENjzfaYPppSZ
         wqr828f8AdRLPe/tJfUVQf7urJX0DHvG5wYIaeeMLhl2/kHXDVluA7hJ4HqA/XmP2lGN
         WvqfCrLTlg4xW855lSNg6OyHBIotXGxa0L3+U2j9/1flBk7qlE2ylGGMT0HimelHkC8p
         +/sb8BGUXz+5ak+gSxcgIuNod8UruawfXDYmMEzDf4tLSNzwt31+a6wVSQpnRYjzpNKi
         UGl+oTPgbwFPQbQ1Nvovq1SrQQiWGMUaBpJSf3EtwOXBpyUxDXBU4uMK3313L8BJ8pvW
         58Lg==
X-Gm-Message-State: ACgBeo3Bjl5oHs1KwjoQ6ZOGsQcuAXcwrM1WIMEPK9pMniz3JWxSNS/y
        CsY36H8JGH+uyTO7d0N/QOk=
X-Google-Smtp-Source: AA6agR7KnM8w/qAkv2TZPlH11kVGs5XIZHHauaRjNJU4m/s0Hx+2oUJ9Y03TwSOUwRVFozMcyZDsUg==
X-Received: by 2002:a63:8b44:0:b0:41c:df4c:7275 with SMTP id j65-20020a638b44000000b0041cdf4c7275mr22848772pge.434.1660125373153;
        Wed, 10 Aug 2022 02:56:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b0016f15140e66sm12594786plr.202.2022.08.10.02.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 02:56:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fa4f12bd-4eb0-0249-d6f2-0230b904a8ad@roeck-us.net>
Date:   Wed, 10 Aug 2022 02:56:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/33] New thermal OF code
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Walle <michael@walle.cc>
Cc:     daniel.lezcano@linexp.org, abailon@baylibre.com,
        anarsoul@gmail.com, baolin.wang7@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, digetx@gmail.com,
        f.fainelli@gmail.com, glaroque@baylibre.com,
        hayashi.kunihiko@socionext.com, heiko@sntech.de, j-keerthy@ti.com,
        jonathanh@nvidia.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, mhiramat@kernel.org,
        miquel.raynal@bootlin.com, niklas.soderlund@ragnatech.se,
        rafael@kernel.org, rui.zhang@intel.com, shawnguo@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, tiny.windzz@gmail.com
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220808094216.928018-1-michael@walle.cc>
 <20220808102610.GA1969424@roeck-us.net>
 <c7b3c6b3-1384-079c-fe76-dc1eca4f3ab2@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <c7b3c6b3-1384-079c-fe76-dc1eca4f3ab2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 01:34, Daniel Lezcano wrote:
> 
> Hi Guenter,
> 
> On 08/08/2022 12:26, Guenter Roeck wrote:
>> On Mon, Aug 08, 2022 at 11:42:16AM +0200, Michael Walle wrote:
> 
> [ ... ]
> 
>> It would also mean that all hwmon drivers registering a thermal zone sensor
>> would fail to register unless such a thermal zone actually exists. This
>> would make the whole concept of having the hwmon core register thermal
>> zone sensors impossible. I have no idea how this is expected to work now,
>> but there is an apparent flaw in the logic. That means I withdraw my
>> Acked-by: for the hwmon patches in this series until it is guaranteed
>> that hwmon registration does not fail as above if there is no thermal
>> zone associated with a sensor.
> 
> I tried to figure out where we are not in sync and I suspect there is a misunderstanding from my side of your initial statement.
> 
> I understood you meant the thermal zone can not be created with the hwmon if there is no thermal zone description and that was the case before.
> 
> But actually, I suspect I misunderstood and you meant if the thermal OF registration fails, the hwmon creation fails for the hwmon subsystem, and before the changes it was created anyway.
> 
> Is that correct ?
> 

Yes, that is what I meant.

> If yes, the change -EINVAL --> -ENODEV fixes the issue, shall I consider in this case your Acked-by ?
> 
Yes.

Thanks,
Guenter

> Thanks
>    -- Daniel
> 

