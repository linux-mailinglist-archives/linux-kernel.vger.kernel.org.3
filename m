Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EED580062
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiGYOHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiGYOHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:07:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B79613CC4;
        Mon, 25 Jul 2022 07:07:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c3so10505812pfb.13;
        Mon, 25 Jul 2022 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mbvIXTn30Rl2aubdxi4kIY7ompkhv+r5bFVC1iAjIf8=;
        b=qfqOX9NCZ35c6s1+SGcylAwHK9tj10QEKszs64RSy5mqoYX/WRpd+eSVS8E16g37wR
         2Ik1lf1EARtX6qnb5Du79G54GHaTQiVsLhBIYdICMLPCXT3vKAEI17qNPW54qIgMNKwD
         B4i9wM53v5bmi0sHa/k9ZGjBh/asZykwpPNcdknzBvwyKG1qDkWGHL0wu06Ey0P/9c/a
         dK7R+Mk5b8sHYmKnGr0gNEop5GMnI4BGyuCWR2EGy1rfIrJauoPTYI0mT5Izrpfe2GP5
         3QGLtf9JVjsaW1tvkzt0gwaH4MCWAPiR73EHVaT3K+NHw3Y1tzvfI8apJnndTUq+Y5jv
         JDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mbvIXTn30Rl2aubdxi4kIY7ompkhv+r5bFVC1iAjIf8=;
        b=DwWrTBMBZhSPTyu0mQA+qAasJsgbu6cjZT5wc4uTvWVoHBZFVKYCW1beSHgobtEI8T
         m6Y8cVrvrG7uicLcuFF0gu6tpfcFcfs3BTQyMhnTwiM9+JnO1INrMOl7YvlE2iPcMPaY
         GYOR0szM9auAQPL5T+16mqwy63Njh098rVkac/Zn0zSNP193yQCuYTtYFUuN1ZI4RAPM
         42ynA0OBhaiuKuwEleM3D56DnOURdSge0jvoSZHa6jePUjRUFfioLKHKsjuEGV6Oc9mh
         9D+fRPZw1I0Z3e4kolyoZ2orueV9qXhs8q1CV1CRxfY7YaRm5yWVk+i/ZZUl+URGsVhC
         DF4g==
X-Gm-Message-State: AJIora/s151xD+zNhW7aau2h5DQUnjcMgMrB1/SdZxE5+anrXpk/EXmO
        pqtLLniQY8jIsWyBMtzaBy8=
X-Google-Smtp-Source: AGRyM1vPz9QbsQ1zbDmGU7eRndtpV8jTRXKy3TA7peGKa34gFLVQ0RXC4DWhWA3a6XrwCuvsIDlAFw==
X-Received: by 2002:a05:6a00:140a:b0:4e0:54d5:d01 with SMTP id l10-20020a056a00140a00b004e054d50d01mr12917947pfu.20.1658758039791;
        Mon, 25 Jul 2022 07:07:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b0016b81679c1fsm9381356plf.216.2022.07.25.07.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 07:07:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d9e12738-8de4-bce9-a181-b3d231b18e42@roeck-us.net>
Date:   Mon, 25 Jul 2022 07:07:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog
 device
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, atishp@rivosinc.com,
        atishp@atishpatra.org, yury.norov@gmail.com, aklimov@redhat.com,
        atomlin@redhat.com
References: <20220725030605.1808710-1-klimov.linux@gmail.com>
 <Yt5Zn9cXDe9/F9RJ@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Yt5Zn9cXDe9/F9RJ@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/22 01:51, Greg KH wrote:
> On Mon, Jul 25, 2022 at 04:06:05AM +0100, Alexey Klimov wrote:
>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +module_param(nowayout, bool, 0);
>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>> +			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +
> 
> Meta-comment about watchdog drivers, this is per-driver, not per-device,
> which does not make sense for when these devices are on removable busses
> where you can have multiple ones.
> 

It is really intended to be a system configuration parameter
(CONFIG_WATCHDOG_NOWAYOUT) which can be overridden. Also, I think it still
makes sense to have it, even for removable devices. The ability to bypass
the flag by pulling the device would defeat its purpose.

Guenter

> I don't suggest changing this (as it follows the current style of other
> watchdog drivers), but perhaps a sysfs attribute for watchdog devices
> can do the same thing in the future so you can do this on a per-device
> basis.
> 
> Anyway, driver looks good to me, nice work!
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

