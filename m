Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D20A463643
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbhK3ORg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbhK3ORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:17:31 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC707C061756;
        Tue, 30 Nov 2021 06:14:11 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u22so41389402lju.7;
        Tue, 30 Nov 2021 06:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z1J0y0gaW7B4raqw4H8GsUg3EspZTt7FQXFgNkdNkJY=;
        b=Ff2fxIADLa/9ugLAMvqLJCEpC/y7w2XdTa/S7whA5sOBkHPVAcqjt/30ZzVUJK2hd9
         JuQOvk+rJqpVi4JgrzwPi1RKAlqhKrJKoWCxLTOvLfjBskRhoO/dxtA+RBjaJHWmq+kk
         ux8q59d+Ol5rnHyhvcyGkQ/6F1s8JJx7vFepneMxCi0C3m6Ux5mga7HnGlG/stfw/fBe
         AjTjZfzNaJFWHD4bmQuChotGxqHXU0HOznglKQrNJOE9ToPjZ5LBi22A0jL7E0NnxUS/
         vtamjUvIbdKA+8OGpLA2cWOXKQ66qZwKLbDTR1jIyMfbivwXnjs5sxp6ACSgiikWdvz1
         A4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z1J0y0gaW7B4raqw4H8GsUg3EspZTt7FQXFgNkdNkJY=;
        b=F8DaU5JB2e/XM03OpMko8FVxNEmkAsn3flWATHbXXXW5cw58nHfYnZ/GZfDCVNHHBp
         +NoIUNy4Sh5gta+I3Gew+QFgLUKOLGqIStTtueGineIVQB+mJx4FCiig/VecdIMEj15H
         Pqg6F8TXRWDsylySYegVj9PjRxNYeYEpD2N5FXWV/UIHOvVw4Aw1KdU92owvw/cJG4/c
         lfvEXxSaFs8hWwo4aL5gH1bf/mvITxGXEt2hst6pjgnR9hbfVUUeIr0B0DRi7VeNexu7
         iEJoyYQeJ/lmiwINGmeBCWNWuszQV+BJh4GJEGK0Fw+0zkxV/gcKert7nw5X/3aL1zxh
         WlDA==
X-Gm-Message-State: AOAM530gfteVTKy6P2F8toY/q0/J2JtQtOwDhoFLtUdQ5NCw11+HFcPp
        TRA98PWN0W9NbXs1QAI3Gwl+vW+pAdg=
X-Google-Smtp-Source: ABdhPJyUftsIiqwPANf1ITW9QfnN9N/4vJE1raFGnE5Ll3TUpshyMKP/mcjkXOFsa81tv3P4bDg9CQ==
X-Received: by 2002:a2e:b6d4:: with SMTP id m20mr57091983ljo.471.1638281649773;
        Tue, 30 Nov 2021 06:14:09 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id u8sm1581914lje.91.2021.11.30.06.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 06:14:09 -0800 (PST)
Subject: Re: [PATCH 2/2] spi: tegra210-quad: add acpi support
To:     Mark Brown <broonie@kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
 <1637834152-32093-2-git-send-email-kyarlagadda@nvidia.com>
 <YZ+ImY1LrvB5a5iF@sirena.org.uk>
 <BN6PR12MB124973BF5CBB4AB35CC59B8AC3669@BN6PR12MB1249.namprd12.prod.outlook.com>
 <YaTHKuohUNt/hVLq@sirena.org.uk>
 <BN6PR12MB124927C4F4FAF53B59C2A23CC3679@BN6PR12MB1249.namprd12.prod.outlook.com>
 <YaYhtFnHlZob9s0J@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f6c68e0a-eaa9-12a8-cc44-84b13592c1d9@gmail.com>
Date:   Tue, 30 Nov 2021 17:14:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaYhtFnHlZob9s0J@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.11.2021 16:05, Mark Brown пишет:
> On Tue, Nov 30, 2021 at 01:50:07AM +0000, Krishna Yarlagadda wrote:
> 
>>> That said frankly I'd expect this handling of ACPI reset to be pushed into the
>>> reset code, it's obviously not good to be open coding this in drivers when this
>>> looks like it's completely generic to any ACPI object so shouldn't be being
>>> open coded in individual driers especially with the ifdefery.  Shouldn't the
>>> reset API be able to figure out that an object with _RST has a reset control
>>> and provide access to it through the reset API?
> 
>> Common reset apis are not handling _RST. Each driver is implementing
>> _RST method in ACPI and calling from drivers.

I see only two or three other drivers in kernel which do that.

> I can see that.  What I'm saying is that this seems bad and we should
> instead be implementing this in common code.
> 

The ifdefery, that this patch has, shouldn't be needed. We have a
similar ACPI patch for Tegra I2C [1] and it doesn't have that.

[1]
https://patchwork.ozlabs.org/project/linux-tegra/patch/1637859224-5179-1-git-send-email-akhilrajeev@nvidia.com/

I assume this patch could be reworked similarly to the I2C patch.

Agree that should be better to have a common reset driver for ACPI
instead of polluting each driver with a boilerplate code.
