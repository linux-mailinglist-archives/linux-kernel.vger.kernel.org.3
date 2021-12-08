Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DFC46D9D4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhLHRhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbhLHRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:37:14 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AEDC0617A2;
        Wed,  8 Dec 2021 09:33:42 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id np3so2409224pjb.4;
        Wed, 08 Dec 2021 09:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j51/wboThEFJzNlTL2/MvStE5Zhc5RgdP9nJ3GHQLi4=;
        b=SbSD6mZJ015HeEhL/uBJxeceiYhXjXXX8O35V590Ke94L+Ypdy2WwxDQgcz/dz+vI1
         9iApRbSY2daO38A2/c4VBdCm5/hoAefgOIeLm7P1O52CMdhCW27CIQQo7jkS6qbbrUPO
         3WKj6PRExiHs43Nuk8VacP7HVUjibVx1bhNJbIiCWvhO4QqWIEn592JcsURU3789agcG
         ncOxe6HUt2my0cYlDUL8RcSTK9JgX7BPA1pZ7AH8yULqG5uz/ZBHDwvocVsgM8St6ejv
         1/1FST6raHCiQCFH3cNSEMmx22jHFteyEfVTMXXiJo2nr++5nPj6rqfaXIrTBjcOd4vi
         jvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j51/wboThEFJzNlTL2/MvStE5Zhc5RgdP9nJ3GHQLi4=;
        b=2r2ZvMPjWwNnf4Uog3b8BzKL7PsJVAYqvAKUuh6M7dFIo79wT3R+a2XzPFsf4/YBX3
         gcgsUxl5CIg5fZsESW6futNxVGEN5BrqPZZaN0tHg2VJqAUYuFQuG6+geP/drKtvOwEG
         wD0FNIdYS2/4NxkO52kyD/QkSMHPkJv3AyGZW9YGLIJ6u0iw5K3OV0fD5F426SuGiXXN
         80FJQFpxe2VTplfG42OVMyuFvxPnQFTYHWScymghZucYE7ACEN4aQuRH1oqVtxzAleVW
         urQj5LyEiExxVdiyzNvvQavF3jI6VPlYoTLYiZQ+vVmNdDlXLV1OtRdQ2nu76Fv4kkRP
         z9qQ==
X-Gm-Message-State: AOAM530AfHmYwKR5Y/NbxYHgSnWiLWJV8pog4ejg+wA+452uS5wpDKDX
        AFOLdm10Rps3an3MNx6fkGlpHLhRF9U=
X-Google-Smtp-Source: ABdhPJyY3AKgLSvRqD8BVr8X+ATPHvvEnFQBIBZfXeEJiyOz1hIwOAXlFSUT2pXiD/r3MLJpe5zcrA==
X-Received: by 2002:a17:90a:e012:: with SMTP id u18mr8961529pjy.103.1638984821458;
        Wed, 08 Dec 2021 09:33:41 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n31sm3801031pfv.176.2021.12.08.09.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 09:33:40 -0800 (PST)
Subject: Re: [PATCH v3 13/15] dt-bindings: ata: Convert Broadcom SATA to YAML
To:     Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, Markus Mayer <mmayer@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>, Amit Kucheria <amitk@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-usb@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-rtc@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-14-f.fainelli@gmail.com>
 <1638971068.770579.3857735.nullmailer@robh.at.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <dd170216-fedd-45a1-a3a5-efc99b9f6197@gmail.com>
Date:   Wed, 8 Dec 2021 09:33:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638971068.770579.3857735.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 5:44 AM, Rob Herring wrote:
> On Tue, 07 Dec 2021 16:37:24 -0800, Florian Fainelli wrote:
>> Convert the Broadcom SATA3 AHCI controller Device Tree binding to YAML
>> to help with validation.
>>
>> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../bindings/ata/brcm,sata-brcm.txt           | 45 ---------
>>  .../bindings/ata/brcm,sata-brcm.yaml          | 98 +++++++++++++++++++
>>  2 files changed, 98 insertions(+), 45 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
>>  create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1565011

Likewise, those indicate that the preceding patch which renames the sata
controller unit name has not been applied.
-- 
Florian
