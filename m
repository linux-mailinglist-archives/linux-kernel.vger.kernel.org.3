Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A84511720
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiD0MHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiD0MH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:07:29 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8EE41FBC;
        Wed, 27 Apr 2022 05:04:17 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e9027efe6aso1659556fac.10;
        Wed, 27 Apr 2022 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=iO3iPqQTxiKsc9sKOi2OBzzXfrLXQyoF5Zqanj5SxtY=;
        b=TO6Xopu575eCaZSZbaxgpzRwlvuFPWb3Zwlw0TSKXJtFv9z6ldleZkizSTOqLinUm9
         ptxWKfykjZA4nhIKBcNfoqmF5wgznC9phQOtGhhIi26BaMBKS3nD3Xifoi1eMJOHwcaJ
         B1qqoIlOyxv27VLQqxJl4/ra8zIuZUodeBncc6PbVzYo4rEXW59QScBX1Y6VM7u3pxQN
         /UaAe7Erf19OrfKFMdJarG7IhqwkMYjxYV+YALivIoaZPtrBz5XPIq6KpKXixoCIcXmK
         pcwPqCA4OYbhnHQf/WAZUObIYYN7yWLdDRGlfx4X3Q+iuCvvOMgKuO7pEVkX3Bq6xuTC
         uXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=iO3iPqQTxiKsc9sKOi2OBzzXfrLXQyoF5Zqanj5SxtY=;
        b=TUZX4k796KeXV/BQq7Ce4+cO9h8CZIhSwjqCQZG1ROXGEa8jmmt6/kUnGru/sJbJgw
         6+wDoM1OFiu+OqcvBhNtSs5nrnmHWtixtt7fXZmhzXiqfxe5oGo05MBd6sjNrloEqNvg
         iuC2Qvd24EELqbMBLZeDbjaiy0fo11DT0/WRV6KBenPwRTuZ+hjd0dgxYTmB7bXt6Xut
         xwinLk7nDLpJBML7qB0qJxUcWbv7L1tjbcJma928bqfx9lr31kpbH5f6W342c16DM5NE
         lWilkecJPt8E9lpRcJCW3XRcGoIjxrEtwNFFYIx3qhel7h2/vS5jGrpUBfIUVTrQc4S2
         Rw0A==
X-Gm-Message-State: AOAM532lMDGX69oK+quka5TUnYL95quVwgNVlSjtFVp+GxJYmtA1PZjd
        XVRdJOyy00/C0FYN7ZikrDE=
X-Google-Smtp-Source: ABdhPJxkqSCrCIPyp50+OwSN4J6casg7Ael84jWBU7s2gxupHcTK0FXAGtSbZKCB8ssBIhXO68IgYw==
X-Received: by 2002:a05:6870:9a17:b0:e9:3d1:f91a with SMTP id fo23-20020a0568709a1700b000e903d1f91amr10111968oab.44.1651061057212;
        Wed, 27 Apr 2022 05:04:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h22-20020a056870539600b000e686d13877sm540202oan.17.2022.04.27.05.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 05:04:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6d69fb63-a84f-31e5-0a88-4a154e290573@roeck-us.net>
Date:   Wed, 27 Apr 2022 05:04:14 -0700
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
In-Reply-To: <CAB95QASxuS=RDN6MRJ89O0pSpqQSaWFQVeyedGyda01FGtR7GQ@mail.gmail.com>
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

On 4/27/22 02:32, Eugene Shalygin wrote:
>> Since this is now tied to MODULE_DEVICE_TABLE(acpi, ...), I think the
>> probe function should be referenced in asus_ec_sensors_platform_driver,
>> and it should be module_platform_driver() instead of
>> module_platform_driver_probe().
> 
> As follows?
> 
> static struct platform_driver asus_ec_sensors_platform_driver_probe = {
>      .probe = asus_ec_probe,
>          .driver = {
>          .name = "asus-ec-sensors",
>      .acpi_match_table = acpi_ec_ids,
>      },
> };
> 
> MODULE_DEVICE_TABLE(acpi, acpi_ec_ids);
> module_platform_driver(asus_ec_sensors_platform_driver_probe);
> 
> The "_probe" suffix added to keep the asus_ec_probe() code and its
> deps as __init.
> 

Sorry, I don't follow that part. One can add "__init" or "__initdata",
as in

static struct platform_driver asus_ec_sensors_platform_driver __initdata = {

to mark a function or data structure as __init. I don't think adding
"_probe" to the struct platform_driver variable name does that.

Guenter
