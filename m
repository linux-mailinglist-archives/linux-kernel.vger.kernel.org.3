Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445215119F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbiD0Omy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbiD0Omt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:42:49 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A8D33357;
        Wed, 27 Apr 2022 07:39:38 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id f8-20020a4ae608000000b0035ea1486af9so173888oot.5;
        Wed, 27 Apr 2022 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vTxpUA215DFAgCWRsxj8jTjennVn40DBH7zdM0caEec=;
        b=oOigsJ/PRaAumCPze8pLjvvkNpXC2GAhd43ctlCMFPmG7wUiXeKjn5HDLLTMuC1tOg
         qitGuYrFpJ6GHWdFN/svAoBVTaJK1/poD2lSt53iNfG4jOtqtHZMME9DitmGdOnrcPZd
         MqlPG49jJnSm1VRaZgNGlsHIjE3MCP70I+UNMPj/VXFi2iW0Qbg0eUEWW/ylAT/npEpa
         lc2+pBEps5vtAMS5AmEo6uJzupAINduBWE2OVaCO2M6BdElX/GeWB0yTzwDbprDxtWd2
         /+TB30JgNnhwVBgtdlBfGNUEGmp5Zwnj05BV3iPGYQRt92uMmMno+/cpOARHBOkGZope
         0AOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vTxpUA215DFAgCWRsxj8jTjennVn40DBH7zdM0caEec=;
        b=qq2z+Ih4SqcmevhzFjYDODtDdQaaiBafTmvQc0a5WLd4t2YasA8gUyaMSxiNuEJhEj
         8z0964/MPXPGXPzpJGf//lma5nFwSk/77HaHV9wvKdit/10IL9rrsQCt0pVYADL3gQPy
         l7WFrJeMHE4vhgEmIRZeUb51Tgr3FeKff6eZVjv/kzEhGr1ZYG6HQb7TSyBZgUBlb8ed
         6YPGNIARKPKEmg6qfb8fQX4lDog0v9MKVn7+HhurvNL6BUTSR60F+v+n2N5jIHCIoejF
         xsLWUVKseW+3uQomY1MYIZTj12OZUK2KE2NtO4UBMWwEYrHs72Dz2YUhN5jfMRUluXO4
         O44w==
X-Gm-Message-State: AOAM532ezmVhqkjhBA3RTmVZk6dRQLNGedOuHmiElJbp8HX3na3GygXq
        YhBx2bpObgdGPkCrwjx6l90=
X-Google-Smtp-Source: ABdhPJyF9fR1IsbcBcNpXpmhtnaNfu9wpueJhGN8nIOXozOcMcA7NMyZcV66Hn8rmnMEAiszi6kmPg==
X-Received: by 2002:a4a:d450:0:b0:324:c398:7305 with SMTP id p16-20020a4ad450000000b00324c3987305mr10225534oos.45.1651070377873;
        Wed, 27 Apr 2022 07:39:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y18-20020a056870381200b000d6c86ea98dsm708837oal.1.2022.04.27.07.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 07:39:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8698b0d9-e0c0-65b1-c44c-3cc765e1dfc8@roeck-us.net>
Date:   Wed, 27 Apr 2022 07:39:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/4] asus-ec-sensors: add support for board families
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427143001.1443605-1-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220427143001.1443605-1-eugene.shalygin@gmail.com>
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

On 4/27/22 07:29, Eugene Shalygin wrote:
> Users provided information for boards from AMD-400 and sTRX40 families
> and demonstrated that sensor addresses differ from those for the AMD-500
> family. Also the AMD-400 family board uses the global ACPI lock instead
> of a dedicated mutex to guard access to the hardware.
> 
> This patchset implements required changes to support other board
> families:
>   - per-family sensor definitions
>   - options to choose hardware/state guard mutex: an AML mutex or the
>     global ACPI lock.
> 
> These changes are used to add support for the PRIME X470-PRO board.
> 
Series applied to hwmon-next.

Thanks,
Guenter

> 
> Changes in
> v3:
>   - Added family_unknown member to the board_family enum to ensure the
> 	 default value of 0 is not a valid family value.
>   - Added a note explaining why module_platform_driver_probe() is chosen
> 	 over module_platform_driver().
> 
> v2:
>   - Removed the case without ACPI mutex where the state was guarded using
>           the normal mutex. After receiving an update from user that case
>           turned out to be non-existent.
>   - Removed the __initconst attribute from the board data array.
>   - Updated documentation to include the special string for the mutex
>           path module parameters which make the driver use the global ACPI
>           lock.
> 
> Eugene Shalygin (4):
>    hwmon: (asus-ec-sensors) introduce ec_board_info struct for board data
>    hwmon: (asus-ec-sensors) implement locking via the ACPI global lock
>    hwmon: (asus-ec-sensors) add support for board families
>    hwmon: (asus-ec-sensors) add PRIME X470-PRO board
> 
>   Documentation/hwmon/asus_ec_sensors.rst |   2 +
>   drivers/hwmon/asus-ec-sensors.c         | 420 +++++++++++++++++-------
>   2 files changed, 302 insertions(+), 120 deletions(-)
> 

