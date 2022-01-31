Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7628D4A4A78
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379434AbiAaPW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:22:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241253AbiAaPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643642543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1yKKyQNpn9GQvDG3vl3rth1pSqIt5HzIp/zlMMSE9sc=;
        b=gkDuW+PDl98uqK3247Xom9PCsBzQsDpCNwF4QDpxW8a6/UNWt2P8kejstDYspP+YGu9ful
        /XBFPaiIxQbIieQYIdFbEPPHbodWNpa2FYQ/ajpWgSCWJWvXgNc1QewVwTL1bH/OxDuYze
        qCYhneT1alD0lY4NfhM9hsw2k1P6Bt0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-_k65Dsg0OAetm7iSAIvPBQ-1; Mon, 31 Jan 2022 10:22:22 -0500
X-MC-Unique: _k65Dsg0OAetm7iSAIvPBQ-1
Received: by mail-ed1-f71.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so7124836edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1yKKyQNpn9GQvDG3vl3rth1pSqIt5HzIp/zlMMSE9sc=;
        b=ndL8jLqap2qAERJFV4tO2eQ1mkODmpIE11qMp4wIDIlSKX3/A6K1NgJ/tZToylJp24
         00U7yZr7Mc6rYXc+WDfchsTfOgjN9fMHAVPG+hP/z1cB0INro5RdkNZXT3mNkwVg2hKb
         ezhzas1mXNk0dxDT69UZZvA8276c9tpzMH/VCgX7n5JrQJLI//DCynJXZialSyKuuryr
         Q9c81RnJA5VdV1/6u+vNu3hklr6AGheJoDqwWXq8AAR2sDZYzsmuWy3+Ur1sjFGF2J/e
         jdYyNeWg9SiZJPAphqSEx58NVg7jA53L1WbvQlI3QjZd3e7BEo/vgsu9WMGmXFVCmMwU
         LFYA==
X-Gm-Message-State: AOAM532sL3Ltxn28cuhcDa5B9/MYKSLekhOuAbwEsN49qX3+vEkBF7pN
        akKkOGOMd11Zw2cSFj3+V8mz+yfQxIe+m82IHLL6/DQGAk8l5MBqe0GpdwyhIA2j9tCyZoJX6BO
        7wq9LCKi7p/16PBBryU1wTbYA
X-Received: by 2002:a05:6402:2c7:: with SMTP id b7mr21496665edx.217.1643642541109;
        Mon, 31 Jan 2022 07:22:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZCKT74UkCDZBDQNDUdwOtrJDPJ19WVDRL2LkVmN7hZB3+nxQLwq0VfY4rGEwkR0/CEPHnog==
X-Received: by 2002:a05:6402:2c7:: with SMTP id b7mr21496648edx.217.1643642540992;
        Mon, 31 Jan 2022 07:22:20 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id t13sm13466973ejs.187.2022.01.31.07.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 07:22:20 -0800 (PST)
Message-ID: <7aefe6a7-eff9-bd86-10d0-f2c51517aeba@redhat.com>
Date:   Mon, 31 Jan 2022 16:22:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 18/20] extcon: intel-cht-wc: Refactor
 cht_wc_extcon_get_charger()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
References: <20220130204557.15662-1-hdegoede@redhat.com>
 <20220130204557.15662-19-hdegoede@redhat.com>
 <Yffqd4c7WrxTrHHL@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yffqd4c7WrxTrHHL@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/31/22 14:56, Andy Shevchenko wrote:
> On Sun, Jan 30, 2022 at 09:45:55PM +0100, Hans de Goede wrote:
>> This is a preparation patch for adding support for registering
>> a power_supply class device.
>>
>> Setting usbsrc to "CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT"
>> will make the following switch-case return EXTCON_CHG_USB_SDP
>> just as before, so there is no functional change.
> 
> ...
> 
>> -		return EXTCON_CHG_USB_SDP; /* Save fallback */
> 
>> +		/* Save fallback */
> 
> I see it's in the previous code, but what does it mean?
> I would read it as "Safe fallback", bit I have no clue.

Ah yes that should be safe not save, sorry will fix for v5.

Regards,

Hans

