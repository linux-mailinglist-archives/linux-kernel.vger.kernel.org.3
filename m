Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55FA4770F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhLPLps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:45:48 -0500
Received: from mail.wizzup.org ([95.217.97.174]:44530 "EHLO wizzup.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231623AbhLPLpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
        s=mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=c0bx/p+6QRyhZntkIlFfi8MtGT/DE6geLRBYvsOnYgA=; b=F9dimIzE4ZmSZ4XsLth4Jd3Hc3
        cNQSXLdNVvUSCDeHYY4fRwEV4Vn/IGDhYqEGTE4f41fT9f8hSaREVQyq+Ace9fMyJ+3jyd1Zkd+og
        TQNIoWRg9bG/qsrwBidATIeEma+ajVjWwOrwX3ewzAgrfAnKHhApTfvklAhnHyWuhzgctdCUyimm3
        jLtbeBWuS46Zwt8YNKHlJznh/blg/PJFopBDqJJgJO47YyYTp1x/w9CJYTD8V5PmVs286uv1K75bS
        lD3nmcZqagXqTLIkXNiTGlBo3RW0MX9qoGNvpU5J0fKvW+lQ3p12RqD+z2jobnk8OalJ01odk2OXM
        vQmm8gsg==;
Received: from [45.83.235.159] (helo=[0.0.0.0])
        by wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <merlijn@wizzup.org>)
        id 1mxpCf-0004Nj-MZ; Thu, 16 Dec 2021 11:45:41 +0000
Subject: Re: [PATCH 0/2] Fix RGB status LED and keyboard backlight LEDs on
 Nokia N900
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-omap@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        devicetree@vger.kernel.org, Doug Zobel <dougdev334@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>
References: <20211212224007.10293-1-merlijn@wizzup.org>
 <20211215203259.GF28336@duo.ucw.cz>
From:   Merlijn Wajer <merlijn@wizzup.org>
Message-ID: <fb433210-e0e7-908c-eb0d-e4e58691368a@wizzup.org>
Date:   Thu, 16 Dec 2021 12:51:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211215203259.GF28336@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 15/12/2021 21:32, Pavel Machek wrote:
> Hi!
> 
>> The RGB status LED and keyboard backlight LEDs were broken on the Nokia N900
>> since the conversion to gpiod descriptors and additionally later on with the
>> addition of multi color support. There was at least one attempt merged to fix
>> the lp5523 driver since the gpiod conversion, but it doesn't honour the device
>> tree, which in the case of the Nokia N900 means that the fix doesn't work.
>>
>> In this series are two patches fix the problems:
>>
>> * One addresses the gpiod change in the device tree as well as the multi
>>   color support in the device tree;
>> * The other patch fixes the previous attempt at fixing the driver to honour
>>   the device tree;
>>
>> Please let me know if anything seems off, and I'll be glad to make any
>> recommended changes, thanks!
> 
> Thank you, I took the series. But if it changes the names in
> /sys/class/leds, we want to do something else.

Thanks -- just for the record (I already replied to the other email) -
the names do not change based on my testing.

Regards,
Merlijn
