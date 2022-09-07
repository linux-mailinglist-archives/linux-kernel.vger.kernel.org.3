Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC095B0951
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiIGP5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIGP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:57:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBB79083E;
        Wed,  7 Sep 2022 08:57:43 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y127so15089369pfy.5;
        Wed, 07 Sep 2022 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=90Xvi+56Sm4mGXm2omfvc9YC5HDL8H5MTroWt/Dz1Q4=;
        b=kRaQxDAlVRQJLv4uZSVrt050gH5Yh6HqW6UFtuPzFeB1j6tKplnQn1hRKm759uHCgD
         tYvI+qxcD2DeI19BcJ+a9Cnp18AKCDUGScaa9daO1DhsunKxfVDD7d7AHwSC5m/9NSm+
         JKpRW3SHoD9RNVnWS0gHi7zjxoC0X7Qm29/sr1yPjVRTyHUIpRNoT1KPtmMOAdpCIhVw
         qJgFHu6KMsvh0WBRgvhGZWf5kNtMF/JStY0S0DxzjY1FHnK6R+KTSNvbiAseEwraEdtp
         60Jr0dlVaMGCm2ttc9DUQ7/XrLWh51NwyNqy+235P8+fo5LuwEzWo2tIviUXmRywXrTJ
         ak3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=90Xvi+56Sm4mGXm2omfvc9YC5HDL8H5MTroWt/Dz1Q4=;
        b=fkRT8XVMChYt8dafpn5No6q48nRXSxwRYTQMYv6qV+MhQo+COck2rcIVeAVfxVlIfr
         RLktBmb+4osp6oxfsVMtxrWsmKCa130NwzN6tnQhqz7k+eTqXCruKhSzvpDQ3Ti8cJHF
         dj81KNb3QlPHC3G4MTyFNrjRaAus4sgId4zIu7x4/lIM26LiIJuBvYX1JOJRc1ygR2LZ
         8cbIn5+4i7he/U5qITOffTzIAF3QHW7aRvV3cMb40yQ2dJtghaquKjpJ0lG1iQRWDZeS
         sDT6ZUtiiHaXqcCU+6SR5xA3zNrF1PKHK4xaWR9yWAWzdZERx6TTOMAhtqmph1vn/OsA
         6Q3Q==
X-Gm-Message-State: ACgBeo03K4K/PXMT9IOxxHsx0iQCXmfdmCKaORmy9RUHE/UA+Z3P5aDN
        UZUnwof3Nzg0d1AQjDdueIk=
X-Google-Smtp-Source: AA6agR7w5Teen2BpgoN8X7BqcmGW7FR4uGbE9nE8EOLp9A3YU4AedbqZE6P7U3fToeDRBrzR9gDF1g==
X-Received: by 2002:a63:b54:0:b0:430:87bb:d1c3 with SMTP id a20-20020a630b54000000b0043087bbd1c3mr4106069pgl.294.1662566262988;
        Wed, 07 Sep 2022 08:57:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f7-20020a635547000000b0042b117e8bf8sm10799737pgm.23.2022.09.07.08.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 08:57:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e2750a0-3ad5-f3d9-1d23-82d89f592476@roeck-us.net>
Date:   Wed, 7 Sep 2022 08:57:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 01/21] hwmon: (mr75203) fix coding style space errors
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, p.zabel@pengutronix.de,
        rtanwar@maxlinear.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hhhawa@amazon.com, jonnyc@amazon.com
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-2-farbere@amazon.com>
 <20220906165229.GA594012@roeck-us.net>
 <9323b609-cb9d-8b3d-2894-65296487cdb1@amazon.com>
 <Yxit2fq1kwzIN9x0@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Yxit2fq1kwzIN9x0@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/22 07:42, Andy Shevchenko wrote:
> On Wed, Sep 07, 2022 at 09:50:00AM +0300, Farber, Eliav wrote:
>> On 9/6/2022 7:52 PM, Guenter Roeck wrote:
>>> On Tue, Sep 06, 2022 at 08:33:36AM +0000, Eliav Farber wrote:
>>>> Fix: "ERROR: space required before the open parenthesis '('"
>>>>
>>>> Fixes: 9d823351a337 ("hwmon: Add hardware monitoring driver for
>>>> Moortec MR75203 PVT controller")
>>>
>>> Coding style "fixes" do not fix the code. I consider using the Fixes: tag
>>> for those to close to an abuse of that tag (and it would be great if that
>>> was spelled out somewhere). As it is, I can not with good conscience
>>> apply
>>> this patch to the mainline kernel (especially not for -rc5), meaning the
>>> entire series will have to wait for the next release window unless there
>>> are no conflicts.
>> Because as you mentioned  it is not a functional fix in the code I’ll
>> remove the Fixes tag in v5.
>> I checked older kernel versions and patch applies without conflicts.
>> That’s also why I moved it to be first in the series, so it will be
>> before any of my other changes that night cause merge problems for
>> other branches.
> 
> If it's not a fix, it should go _after_ real fixes.
> And by nature this kind of patch is usually at the end of the series.
> 

I don't care where it is, really, as long as it is after the real fixes.
And obviously I would not want to see a patch fixing something introduced
in a previous patch of the same series.

Thanks,
Guenter
