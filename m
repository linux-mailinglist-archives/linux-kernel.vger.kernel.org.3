Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEBB48B251
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350041AbiAKQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbiAKQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:36:48 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C2EC06173F;
        Tue, 11 Jan 2022 08:36:48 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso19216492otf.0;
        Tue, 11 Jan 2022 08:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aMa1K6iPjPAPg08ZLNGEeXUTDyEHDQxHzcN0Cbel3LA=;
        b=N7mA7/ot7qu3Hv4IX53R47Xaa//rwaA+r9eNJAAoRUqhB2mWljL2dra45sIlpeiOWI
         3tAIzbjT27fAZFAePiy7HYw0eU6Vt0pRnVxUKZJD/UcagreU/dWk5pBj5UQhIx4eUrb0
         K/JEluujfChIFeBKCHpHOBvMkg6dxjKNsapf3L+u33BcIvs1tTbuUHwSskPgfbBERcDa
         pUPGfHLxAuONfIMAwXvsgx9XRbRSQo7uC2EV+8eZ5Jqcp50Sn0cAD/qkhCuLoN1c992s
         iJkfVgHUO0S2RK6LLeWeeOaV9VIkhZZf7LWPcCJV0jRn9w+/5QmJ+LxAxRSsQTKlMbfF
         k6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMa1K6iPjPAPg08ZLNGEeXUTDyEHDQxHzcN0Cbel3LA=;
        b=Wzb462q0VVoiE4rvCXwspr6WgDy20cQgWuyV99ERlBChV385nK7iMFIv78wpc8pqpO
         rvGaUf9SKsfLuluQJnOoX1mcCpAEyHNiA0K4BZOgtQzINUONHB15AUoLZ9gsk04Z+sQK
         m0QuF1N5graSwd/ZwyVizcRwXbjveBBZqpWVP/ZoGO6rUmAo4xUtvPgcSKioz4h0MMKE
         B/XcebPPp5JUsrvMBDVwP0g5R6eBUSq+4M6V3g1iDojznsBmyK3dW8rfMMEwVmaN0LOW
         dtxF/wDAK7mvc9e8FLxUPAFUI5Akp6oCKgm6NPIZOVmVgPP5sxOM7hzeNEBVZedGhr0v
         Ol0Q==
X-Gm-Message-State: AOAM5317te/5Ors+/ihTS+R8oQfocuozqLbdPoD1plipkWQ3Q6icZEvX
        Ezlj7MCiYCCVDsx9bRwdVtoi3RKiIM4=
X-Google-Smtp-Source: ABdhPJy1pN5AnEEJ4Qw68vtybJ5C8F9mRbhQNR18RQVZqxMCscmOx+Njpeuu+3pVfGAp0kkTzakYzQ==
X-Received: by 2002:a9d:6e0a:: with SMTP id e10mr3890350otr.323.1641919007232;
        Tue, 11 Jan 2022 08:36:47 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id be30sm1721139oib.50.2022.01.11.08.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 08:36:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (asus_wmi_ec_sensors) remove the driver
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     andy.shevchenko@gmail.com, pauk.denis@gmail.com,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20220111160900.1150050-1-eugene.shalygin@gmail.com>
 <20220111160900.1150050-4-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f291e622-2812-1842-64ec-0e185aef6a15@roeck-us.net>
Date:   Tue, 11 Jan 2022 08:36:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111160900.1150050-4-eugene.shalygin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/22 8:08 AM, Eugene Shalygin wrote:
> The driver is superceeded by asus-ec-sensors
> 
superseded

I want to have this handled differently: In Kconfig, mark the
SENSORS_ASUS_WMI_EC driver as depending on !SENSORS_ASUS_EC,
and add a note to Kconfig stating that the driver is replaced
by SENSORS_ASUS_EC, which should be used instead. Then, in a couple
of releases, we can remove the obsolete driver. This will give
us some test coverage of the new driver but still provide an alternative.

Thanks,
Guenter
