Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7332475D60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244785AbhLOQ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244775AbhLOQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:27:56 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBC7C061574;
        Wed, 15 Dec 2021 08:27:56 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so25474015oto.13;
        Wed, 15 Dec 2021 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y/1jB2ZwfsJXg2YK0DhwOCi5cq2cI54SE4JyfzcH21I=;
        b=IE9FLv5LeQlVnJ9mGpj2YWJh3KnfkuTOjileU40I6m74ORoBhgzyAbWSAFfLc6nG6l
         Pwkz3aKiu6aATD79HYGBBe+ADsO+5fnWS2aK3HkDJONgC0LbznxWHRNk06Bn8OXrGDAg
         FzdrxFuEF8GfcGxvIepGgHVTqatE477qtmOZt/E4MBJp9fQ9B6U2ej0nfNTAlEBq72A0
         dtzAxMREiHymYKV+cKCVpBImb4Pc31AQKQPYi5ZMKOEoNhyL85gWtDNZmeHxfxEenF8a
         8dmXTCag0IeW5AGYOZJND7i7hESpVzsPjIMnQglHeehojsxfnQNZhLxx70Zt7/WFq0oJ
         CUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=y/1jB2ZwfsJXg2YK0DhwOCi5cq2cI54SE4JyfzcH21I=;
        b=O7LdUbchaz+llob4D6PZxa3rwQAYfFtRYICqrTKpnJffOk6tEV0YS9A9AlURpeC0zK
         Z7P9InehEBXMPaXUWlHPO6E+9zagVqwjXXLwXN0lnSTlp1+jjIEPAdsSGSjavZU0HLHV
         nyvJyF43fvxs8WXkcL6Q3O5IYT2DaVUARdPKna3Xhdk5TYgt7lac0zMM0LOncniGqR4/
         RAnUo+AT7C8jrlfqlo6OKmQFEHhnGUvlTc8Tgyx/4xlfMJK1EwtWhHN8oduViMvwmNZB
         LK/QGsQyPhsKdhv04tB7kTCeFibpVwOF3wBWcyk2H3x1HTSpejLmna82pDIdCBzWCgY7
         nnOA==
X-Gm-Message-State: AOAM531ignmSFNj4yKf/4ye3n94AOseGK7SVJg/eFq+3RYLc5LwuRLYq
        7+urnW3YhV+ZKhg+s78d1uqDS+y8+v8=
X-Google-Smtp-Source: ABdhPJw5PnqOumF+5yaYCS4LYA8VkaPRJi8NrNYdj8JL2DKiB7nNKYCWTe47iidRot/DcJ8cUs/+sA==
X-Received: by 2002:a9d:64d4:: with SMTP id n20mr9228401otl.328.1639585675659;
        Wed, 15 Dec 2021 08:27:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4sm523429oof.40.2021.12.15.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:27:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Dec 2021 08:27:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arseny Demidov <a.demidov@yadro.com>
Cc:     Arseny Demidov <arsdemal@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon : (mr75203) fix macro typo
Message-ID: <20211215162753.GB2906031@roeck-us.net>
References: <20211215113023.2945-1-a.demidov@yadro.com>
 <0baa6133-5903-ffd8-69a0-99fb9f69665d@roeck-us.net>
 <06d7c6ee-2db5-f250-50f7-9a47e33a35b5@roeck-us.net>
 <c1d036c0cfa14fbb9c289f792780f003@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1d036c0cfa14fbb9c289f792780f003@yadro.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 12:36:32PM +0000, Arseny Demidov wrote:
> Yes, I have access to the datasheet and caught an error on simulation IP-block.

> The datasheet says that register "Expressed in units of IP clk cycles."
> Typical power-up delays for Temperature Sensor are 256 cycles i. e. 0x100

Please add that information to the commit description. Also,
please copy Rahul Tanwar <rahul.tanwar@linux.intel.com> and
Andy Shevchenko <andriy.shevchenko@intel.com> on your patch.

Thanks,
Guenter

> 
> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Wednesday, December 15, 2021 3:31 PM
> To: Arseny Demidov <arsdemal@gmail.com>
> Cc: Arseny Demidov <a.demidov@yadro.com>; Jean Delvare <jdelvare@suse.com>; linux-hwmon@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] hwmon : (mr75203) fix macro typo
> 
> On 12/15/21 3:59 AM, Guenter Roeck wrote:
> > On 12/15/21 3:30 AM, Arseny Demidov wrote:
> >> In the file mr75203.c we have a macro named POWER_DELAY_CYCLE_256, 
> >> the correct value should be 0x100
> >>
> > 
> > How do you know that ? Do you have access to the datasheet, or is it 
> > just an assumption based on the name of the define ?
> > 
> 
> Also, how do you know that the value is wrong, not the name of the define ?
> 
> Guenter
> 
> > Guenter
> > 
> >> Signed-off-by: Arseny Demidov <a.demidov@yadro.com>
> >> ---
> >>   drivers/hwmon/mr75203.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c index 
> >> 868243dba1ee..1ba1e3145969 100644
> >> --- a/drivers/hwmon/mr75203.c
> >> +++ b/drivers/hwmon/mr75203.c
> >> @@ -93,7 +93,7 @@
> >>   #define VM_CH_REQ    BIT(21)
> >>   #define IP_TMR            0x05
> >> -#define POWER_DELAY_CYCLE_256    0x80
> >> +#define POWER_DELAY_CYCLE_256    0x100
> >>   #define POWER_DELAY_CYCLE_64    0x40
> >>   #define PVT_POLL_DELAY_US    20
> >>
> > 
> 
