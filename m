Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70D14BA7E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbiBQSOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:14:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiBQSOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:14:36 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BB320A897;
        Thu, 17 Feb 2022 10:14:21 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id c14so9874257qvl.12;
        Thu, 17 Feb 2022 10:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K49iyUfP87GUSWjSsQDrw9184z8W1wX9twPD7fJ5DdI=;
        b=bjgBJHKoVTIzjZh3TmK6la8r3vIUyGMNAK24MTaOPb6docls8lRqvD/AFi3e5NyXKK
         TCmevyglQ7g2F+IgIKqpwf2V03nQF7ZYx/2bbI5ANGBUOvEj6r7kkCOaxKMSaJ54VmV4
         zSf1LBF4o4KnEon7TGh3bpCsrjUVq4L8zOoQKnArLV+7gihJNitVkreWa62ch2IcbGsW
         dl4tYq3tA8CN5ZNC9W7eTZy01p0d8u0VSek5TbY+n7krrC5zO2DZNUA7qlTfLzocbpYY
         CIgRnEv1xGZNwHcQ1Ux8m5OCFxxdcd5WoGljDECICzITVLL1o9rX9HB1O2J2XynHQiFg
         Kdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K49iyUfP87GUSWjSsQDrw9184z8W1wX9twPD7fJ5DdI=;
        b=tbkW6j3BKOK2TdX5pz16K4zuLMHADRgbr1iSTbV+fHFpdm+JWb79i2PdWijxAMTOgs
         H9IA1Cz8PPhLH/SUxm3307mK+jLB0NjI2qJUxDVyRiDurrNHHqatoU8ge/CeVuZrMe/n
         NfaYuv0bIMqeIcnBlmbyHQ/X2axAGe87IxDHYVWD/wLdHTxMqVs2yWdh4ZQeumkAK1f8
         XCoUDZPPfkV3RqZ8xZcjOI2su56lvJi6JMI23VJmndq6GHq3pmaWBT6jKJXu1aQRpgxW
         oQt75bNL82DTTZ31GNr4pjKEkNF9eB05TimHq2h3W/2a1g3p6Dghi7HYGaaIOhJIDCeI
         b20g==
X-Gm-Message-State: AOAM533+pqIm+HbPmVwheJiAgVvVB81IJXDTNLPual3m7tlhu2ADQQaM
        +vlcV+0hza6H4aG2Vy0ZnDM=
X-Google-Smtp-Source: ABdhPJx9Kr9K7CaT4uf99J5p6k4IB7qjpuwkNpxc9I74+w8uJKlDLM85H41UC8A+sKnvawNpUmdEKQ==
X-Received: by 2002:a05:622a:1007:b0:2d6:5ac4:6b78 with SMTP id d7-20020a05622a100700b002d65ac46b78mr3534147qte.668.1645121661036;
        Thu, 17 Feb 2022 10:14:21 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y5sm20490979qkp.37.2022.02.17.10.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 10:14:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5b0b69cf-5688-3679-dd77-49179e0b17bb@roeck-us.net>
Date:   Thu, 17 Feb 2022 10:14:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] misc: Add power-efuse driver
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     openbmc@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20220217104444.7695-1-zev@bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220217104444.7695-1-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 02:44, Zev Weiss wrote:
> Hello,
> 
> This patch series is another incarnation of some previous efforts [0]
> at enabling userspace access to the OPERATION state (and now status
> flags) of PMBus devices, specifically with respect to efuses
> protecting general-purpose power outputs.  This functionality is an
> important component enabling a port of OpenBMC to the Delta AHE-50DC
> Open19 power shelf [1].
> 
> The first patch extends the pmbus core's regulator support with an
> implementation of the .get_error_flags() operation, mapping PMBus
> status flags to REGULATOR_ERROR_* flags where possible, and the second
> patch adds regulator support for the lm25066 driver.  These two
> patches are essentially independent of the power-efuse driver (and
> each other) and could potentially be applicable individually, but are
> necessary for the power-efuse driver to be useful on the AHE-50DC.
> 

Nevertheless, the first two patches are orthogonal to the remaining
two patches and should be separate.

Guenter

> The third and fourth patches add dt-bindings and the implementation of
> the power-efuse driver, respectively.  The driver is fairly simple; it
> merely provides a sysfs interface to enable, disable, and retrieve
> error flags from an underlying regulator.
> 
> There is one aspect of its usage of the regulator API I'm a bit
> uncertain about, however: this driver seems like a case where an
> exclusive 'get' of the regulator (i.e. devm_regulator_get_exclusive()
> instead of devm_regulator_get() in efuse_probe()) would be
> appropriate, since in the intended usage no other device should be
> using an efuse's regulator.  With an exclusive get though, the
> regulator's use_count and the consumer's enable_count don't balance
> out properly to allow the enable/disable operations to work properly
> (the former ending up one more than the latter, leading to
> enable_count underflows on attempts to disable the regulator).  So at
> least for now it's using a non-exclusive get -- I'd be happy to hear
> any pointers on a way to allow an exclusive get to work here, though.
> 
> 
> Thanks,
> Zev
> 
> [0] https://lore.kernel.org/openbmc/YGLepYLvtlO6Ikzs@hatter.bewilderbeest.net/
> [1] https://www.open19.org/marketplace/delta-16kw-power-shelf/
> 
> Zev Weiss (4):
>    hwmon: (pmbus) Add get_error_flags support to regulator ops
>    hwmon: (pmbus) lm25066: Add regulator support
>    dt-bindings: Add power-efuse binding
>    misc: Add power-efuse driver
> 
>   .../devicetree/bindings/misc/power-efuse.yaml |  37 +++
>   MAINTAINERS                                   |   5 +
>   drivers/hwmon/pmbus/Kconfig                   |   7 +
>   drivers/hwmon/pmbus/lm25066.c                 |  14 ++
>   drivers/hwmon/pmbus/pmbus_core.c              |  97 ++++++++
>   drivers/misc/Kconfig                          |  15 ++
>   drivers/misc/Makefile                         |   1 +
>   drivers/misc/power-efuse.c                    | 221 ++++++++++++++++++
>   8 files changed, 397 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/misc/power-efuse.yaml
>   create mode 100644 drivers/misc/power-efuse.c
> 

