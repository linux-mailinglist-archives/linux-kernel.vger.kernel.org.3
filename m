Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0556507D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358365AbiDSXth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358101AbiDSXt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:49:26 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BD62018A;
        Tue, 19 Apr 2022 16:46:41 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id a10so289287oif.9;
        Tue, 19 Apr 2022 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Dehn88Ll7BtUdvgyx2lkGmMqT0Tj9xWydgg6NgtluA=;
        b=VosXpeoVLhzsyAl1blbG4cVIlMyFZ2LqrcBckgME/840WGuIxThIKFbJSA2UGPnTyS
         ZIgIZlucYr6lRmwCnPuTmTk1SSMkJ0v3T4AYhFFs22yiLuLk3BY4U6y70dwSiMkGvKxA
         vNdAS8eE+hfs/KHkKvMFrJxHBwtb6w+y9jtgsLJBg/Y7Qq1dGR0LB1yVqtLfe7G7d1V8
         dBFxbDWwCxIS7cxAIrpQ0Z1j2ljP8PFql2yn6lg35Lr7hTXEX4kO7+Bt+m5EhAJip8Dc
         2Q66P7CVNl0lnefhQSTHYjaLdFHWaTD4lYZ+RrVQIdmVuJ9VU4EGJ2Nx2xZTzbBmbk6M
         7htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Dehn88Ll7BtUdvgyx2lkGmMqT0Tj9xWydgg6NgtluA=;
        b=BxLSMYUL3oZczXRyCXZf4dg0q0CyAMRnGbWKHZLcyrIIbEunR7lYqeRGxGMYqlVJ+t
         e70wH2sj7ln0AW79lo4Kui37/s+PJlm+1hWGz6SF3hntgdP06KG6qdCGYtmEJqTA4zta
         9rM/uaTe033NtsxH4u7lfc0Ux8xCi2KcXU+qsy1S2PF0tNlE0APnX2BTUw17/ZG97UsH
         QqD/uhVDEkaLeKTxxO0wFAakbV++ycDjQzzzypUY/wo69Jl0cfMi4lzyeQSfz3riwndI
         UuSoUHPoa9RjPJntgvBDUAhWf5aYddkHK/YzFDV5BtGxGxmTGnXW3jWzAbVGSbEyYt1H
         iujw==
X-Gm-Message-State: AOAM531NnI/Ga0U0CzkofY0UnTYdHlZwloG447UZWphV44TBUS7Sj+ta
        MS7wwEBZNI5uMomSg+hnuOPZG6sZ2kU=
X-Google-Smtp-Source: ABdhPJzd0miG+YXnmgDdjRJUJBGUjE5wptjYEpBrlw3JwY72bVLuWtY0gbKIQ8L+GmUwn/JqyN5enQ==
X-Received: by 2002:a05:6808:16a7:b0:2f9:39c4:c597 with SMTP id bb39-20020a05680816a700b002f939c4c597mr504924oib.101.1650412001256;
        Tue, 19 Apr 2022 16:46:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q12-20020a4ad54c000000b003245ac0a745sm6044454oos.22.2022.04.19.16.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 16:46:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8a8124e0-0789-fcc2-826c-69ef870a42d3@roeck-us.net>
Date:   Tue, 19 Apr 2022 16:46:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hwmod: (pmbus) disable PEC if not enabled
Content-Language: en-US
To:     wujek dev <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220419205228.303952-1-dev_public@wujek.eu>
 <734e748b-941c-5ae1-5140-22cc845bdfc1@roeck-us.net>
 <zNXN2w4xqB6a_14RhNubTjTdcUmzypjeVY-5FXeXlPHsYDuSdQ0qlDjO0CNFnYOrUUAnIlBBIdvMjKURyH4nuthmNQ29ifpaNywsWiU99oQ=@wujek.eu>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <zNXN2w4xqB6a_14RhNubTjTdcUmzypjeVY-5FXeXlPHsYDuSdQ0qlDjO0CNFnYOrUUAnIlBBIdvMjKURyH4nuthmNQ29ifpaNywsWiU99oQ=@wujek.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 15:10, wujek dev wrote:
> ------- Original Message -------
> On Wednesday, April 20th, 2022 at 00:00, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>>
>> On 4/19/22 13:53, Adam Wujek wrote:
>>
>>> Explicitly disable PEC when the client does not support it.
>>> Without the explicit disable, when the device with the PEC support is removed
>>> later when a device without PEC support is inserted into the same address,
>>> the driver uses the old value of client->flags which contains the I2C_CLIENT_PEC
>>> flag. As a consequence the PEC is used when it should not.
>>
>>
>> How can that happen ? I would assume the I2C device gets deleted and re-created
>> in that case, which should clear the PEC flag.
>>
>> Guenter
> In my case it was when I unloaded the driver for the I2C slave, changed the advertised PEC value in PMBUS_CAPABILITY register on slave. Then loaded the driver. When the switch was from disable->enable it worked as expected (this case was already covered), but when the PEC was set in the slave from enabled->disabled it was still using PEC to communicate.

So it is really the same device, only you unload the driver, change the
device configuration (presumably with i2cset commands), and load it
again. Please explain that in more detail in the commit description.

Thanks,
Guenter
