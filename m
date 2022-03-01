Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA374C974A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiCAUtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbiCAUth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:49:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F946255B9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:48:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t11so1391899wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s0zN3hhnk6tK41DrdKyQraYoi1ZXQJ31C4XFuJfqtwU=;
        b=SLI31r+U7zdy/ueD7JyJPQIQhgVuJf7fzZYMp8w9hf8DgquIXp0VFH9xHFYh7xcAea
         wAMtG6V5CE4HDzbbvX+HTcW87yyVMHc03f7U504cTq5cHQKX5MI23JSD5QFuhArqGomP
         DI7rybe6+YasIBhtjvhHlaGzdaU6zEIZQip971svtaYg3sP24liyM9uHjYGAKDfc8n30
         4QTWlJRlBFrxlLBg5xkTIhNjzrI9OmY0Roc3XWomDVTx3hpmoEmWG+47Q2Z7in3JoHid
         Ft8Fxg11RMPt9K0PwSP3qBWo8jBbmoxKneQmJ7UgsDsMqFk9qeucQxEkQwZ47a7xVy5I
         tZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s0zN3hhnk6tK41DrdKyQraYoi1ZXQJ31C4XFuJfqtwU=;
        b=VoUiMEt9YvJa2PQME3Mf9dRraxIeci2RUjFWrU8h8DSkZi5fsGH/JEvNyTpxMfOd5g
         k5jlRFnNW9u+guK2cVz9WWs6gfpHrjg+U2NhirxPwVQA658PdDilVPYdeqQJKJ8Mo2hO
         +LrmFh3AOagqPGr+XBTEdaBSSejKam+lVHYdLg6gwZBZqJZ6989ZPyOJLJA0Cjk4NLsB
         k7pdxDjeLyAT0Q1tTl8g3yF0/baMIkvuAdtMzpjXbQ3H1Ffwcevl+I/gqHBBedR9Ht/9
         eRD21mVjQ7Hs0CLFMKIlKFfaHL4YBZN5lUPzAPxY36LsLX0ICqedH5Y4dLi4xfzFovVe
         ZT2w==
X-Gm-Message-State: AOAM533u41uA5gWC3e40AObEvvrlQPjMLD/tAGW/x1TmK9BI9Ll8JEJg
        Dl3/qHKaV4lBNkFv3T3ge2xPO3B4X8tnyg==
X-Google-Smtp-Source: ABdhPJwH+Y7CqgO8YIBl9tabA06yVVYyTTOyCWvJUHbCEQmwylJok7ggJXBKlJSTKp2t/fg8TnB42g==
X-Received: by 2002:a05:6000:184c:b0:1ef:f8a2:3283 with SMTP id c12-20020a056000184c00b001eff8a23283mr6410098wri.467.1646167733795;
        Tue, 01 Mar 2022 12:48:53 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:49e8:f41b:b2a3:3a55? ([2a01:e34:ed2f:f020:49e8:f41b:b2a3:3a55])
        by smtp.googlemail.com with ESMTPSA id f16-20020adff590000000b001f0122f63e1sm3021536wro.85.2022.03.01.12.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 12:48:53 -0800 (PST)
Message-ID: <96639c1c-b135-376f-4fb7-92e04110a12e@linaro.org>
Date:   Tue, 1 Mar 2022 21:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] thermal: genetlink: Fix TZ_GET_TRIP NULL pointer
 dereference
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220228110351.20518-1-nicolas.cavallari@green-communications.fr>
 <20220228110351.20518-2-nicolas.cavallari@green-communications.fr>
 <CAJZ5v0iW0KvBsJZbjBoMU6RukH0AmppxpFO9RrfD+K3OcaxOUQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iW0KvBsJZbjBoMU6RukH0AmppxpFO9RrfD+K3OcaxOUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2022 16:14, Rafael J. Wysocki wrote:
> On Mon, Feb 28, 2022 at 12:04 PM Nicolas Cavallari
> <nicolas.cavallari@green-communications.fr> wrote:
>>
>> Do not call get_trip_hyst() if the thermal zone does not define one.
>>
>> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
>> ---
>>   drivers/thermal/thermal_netlink.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
>> index a16dd4d5d710..73e68cce292e 100644
>> --- a/drivers/thermal/thermal_netlink.c
>> +++ b/drivers/thermal/thermal_netlink.c
>> @@ -419,11 +419,12 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
>>          for (i = 0; i < tz->trips; i++) {
>>
>>                  enum thermal_trip_type type;
>> -               int temp, hyst;
>> +               int temp, hyst = 0;
>>
>>                  tz->ops->get_trip_type(tz, i, &type);
>>                  tz->ops->get_trip_temp(tz, i, &temp);
>> -               tz->ops->get_trip_hyst(tz, i, &hyst);
>> +               if (tz->ops->get_trip_hyst)
>> +                       tz->ops->get_trip_hyst(tz, i, &hyst);
>>
>>                  if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, i) ||
>>                      nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, type) ||
>> --
> 
> Applied, but I think this needs to go into 5.17-rc, doesn't it?

Yes, correct


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
