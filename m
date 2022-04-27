Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDBA511B62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiD0NXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiD0NXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:23:17 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE44D15A15;
        Wed, 27 Apr 2022 06:20:04 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-d39f741ba0so1855548fac.13;
        Wed, 27 Apr 2022 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=FviNAM9pNKCXOMOtlMI5MJmey3VrbsYUgeRslmWNkj0=;
        b=fOCehiICEf+o4/F4jrA9zIWuUdcDEHNQDhydvp2UHE/CzInyZcCEneVbUjVUcc3CPh
         LpmXgOXM49W+CtIuKJvjlPMWuTKVvFcOXHN3YhPKGym+rcpE7fY+fy9vp1ADCO/2kPMb
         Nf0E16ju0IPbAyoWeaxPMtRcaukVzcOdonl0ot/+ZkMHaZnLunfsQBBY9BLcLbG/r33p
         ktWTrKsQ8vNocemBjSz9FzEBX0Q/8+4H2YISeKlC1EBlQadMKk71ThqmZ/Uxronp6NJA
         jMGH57gYMDQvgPF6Km1ucKq0YTbOUU8r9G729mDf6zt1NZJHw+z1M2bg17EfIxatRbDE
         u6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=FviNAM9pNKCXOMOtlMI5MJmey3VrbsYUgeRslmWNkj0=;
        b=N1xJA7BYnKgyuzEKpR1zkxWwcCOPpJHCEvg0O8pGh/MEDcA1w26ARpI7CPSm+xfE3S
         QCWjDjC5+A5VO0Ezdj9ifUiO/PHVqA8gIMgd4fdDRCF6ZRY5kYs5P5dvC8dqh+kQ391n
         5h0DRoyLxd8rzXk9gOXb/gMLZANIf1wzrwgO8OYyUbTVZdWU86cizv8nlLPZl3FF9N0I
         3T1UJp+ny4vMHqzT0hDqCJWGlet4Lg+1/YB6RgKOo07F4gMehpuU8l/OacxRlOoLgFUB
         XChmUF8tmG9S2snWL+H610FGOeyK1WlbdniNLtNJdlPm7/lshpOHrTllmzJrcLGNnyZY
         uTIg==
X-Gm-Message-State: AOAM5327KfVhqevm45LQF/DtugXaQUybuXjendpxG7tVCp8cqCaQd/7W
        PYGekeX4qKMwhrDfodlPrk8=
X-Google-Smtp-Source: ABdhPJydKctThk2kvGPchZJ/awWW3mx7S0Rcn5JwvplM45mthZDKegORkHTcGUQ1/2nhg94HNzFVow==
X-Received: by 2002:a05:6870:d795:b0:e2:8398:d42 with SMTP id bd21-20020a056870d79500b000e283980d42mr15295486oab.93.1651065604126;
        Wed, 27 Apr 2022 06:20:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14-20020a0568080ece00b003258cebf59bsm225279oiv.16.2022.04.27.06.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 06:20:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8a8579df-1fd6-32bb-3e27-297efefe28c4@roeck-us.net>
Date:   Wed, 27 Apr 2022 06:20:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220426092340.495704-1-eugene.shalygin@gmail.com>
 <20220426092340.495704-2-eugene.shalygin@gmail.com>
 <20220426151656.GA3119637@roeck-us.net>
 <CAB95QASxuS=RDN6MRJ89O0pSpqQSaWFQVeyedGyda01FGtR7GQ@mail.gmail.com>
 <6d69fb63-a84f-31e5-0a88-4a154e290573@roeck-us.net>
 <CAB95QARDq1Tr64dvPVemXHRNyu=T5P7LJ_DUn7sdHauUB6daaw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
In-Reply-To: <CAB95QARDq1Tr64dvPVemXHRNyu=T5P7LJ_DUn7sdHauUB6daaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 05:16, Eugene Shalygin wrote:
>> Sorry, I don't follow that part. One can add "__init" or "__initdata",
>> as in
>>
>> static struct platform_driver asus_ec_sensors_platform_driver __initdata = {
>>
>> to mark a function or data structure as __init. I don't think adding
>> "_probe" to the struct platform_driver variable name does that.
>>
> 
> __initdata leads to modpost warning:
> WARNING: modpost: drivers/hwmon/asus-ec-sensors.o(.exit.text+0x3):
> Section mismatch in reference from the function cleanup_module() to
> the variable .init.data:asus_ec_sensors_platform_driver
> The function __exit cleanup_module() references
> a variable __initdata asus_ec_sensors_platform_driver.
> This is often seen when error handling in the exit function
> uses functionality in the init path.
> The fix is often to remove the __initdata annotation of
> asus_ec_sensors_platform_driver so it may be used outside an init section.
> 
> Compiling without attributes resulted in another message:
> WARNING: modpost: drivers/hwmon/asus-ec-sensors.o(.data+0x0): Section
> mismatch in reference from the variable
> asus_ec_sensors_platform_driver to the function
> .init.text:asus_ec_probe()
> The variable asus_ec_sensors_platform_driver references
> the function __init asus_ec_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> Here is why I added the "_probe" suffix.
> 
> Eugene

Ah yes, I forgot about the exit function. It needs a pointer to
the structure, which would be gone if marked __initdata.
Please add a comment to the structure name explaining why
it is named _probe.

Thanks,
Guenter
