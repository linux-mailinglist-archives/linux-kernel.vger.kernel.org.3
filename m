Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED86A46B4F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhLGIBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:01:49 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:43882 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhLGIBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:01:48 -0500
Received: by mail-lj1-f169.google.com with SMTP id 207so25787814ljf.10;
        Mon, 06 Dec 2021 23:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PqqmL5JIKPAasL4UGzmoMf6bSek2Vm/kZLmu62cP2bU=;
        b=F4cNbdayU86W7Xt7WwdQ4PHppFHg80E3B1wMuNyH6sT1P7xIFuQAqvTvuHLUhaGSsF
         OS2GK/QfqhuZMh6nlM8QBlW8KIcL35WCeVSSMjZD1aMxSzQ4lPoLttMutn+YSGfgG4Rj
         OX3+e9Evoce6wMHVRlIGh/AlXv5OFm2gLnV8qve5xvpc7N69iR6miRpwECnAw/z2nUFc
         rHb3zK6sgbpL3eg8rklilDhW3puwd6pazdTsqpebcjVxxb2OnQhVIIAl7s6Ci3J6wVG0
         CXVq9L3B4pBR4eIeyopKXjBeMlXUoSYInU9L+uiPogeOQrgBYELQWClggBwjIIfsg/vS
         lcIA==
X-Gm-Message-State: AOAM531cbZ2nkD7q7wiFJTb1T1+VWvNxaZt63zm2Wu4Y92jUbjcW7wlG
        9bFCvjiUWX5OTaiyQ82Lt+Y=
X-Google-Smtp-Source: ABdhPJwHA8X1ZsMu+rN78A9VZ7MQ1tTslA/UTtTNWlLfjgFKD0FM6W6Jb6S/TJEcgFM+4f38L6tBxQ==
X-Received: by 2002:a2e:84c4:: with SMTP id q4mr40356345ljh.266.1638863896657;
        Mon, 06 Dec 2021 23:58:16 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.googlemail.com with ESMTPSA id f19sm1595702lfm.119.2021.12.06.23.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 23:58:15 -0800 (PST)
Message-ID: <498caafa-fdc5-eb5a-312f-13968a088448@kernel.org>
Date:   Tue, 7 Dec 2021 08:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 2/2] dt-bindings: add Delta AHE-50DC fan control module
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>, linux-hwmon@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, openbmc@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211207071521.543-1-zev@bewilderbeest.net>
 <20211207071521.543-3-zev@bewilderbeest.net>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20211207071521.543-3-zev@bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 08:15, Zev Weiss wrote:
> This is the integrated fan control module of the Delta AHE-50DC Open19
> power shelf.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)

This is a third version sent within one night, without changelog and any
indication why sending the same three times. Please do not send multiple
versions the same day and give people some time to respond. When
creating a new version, add a changelog under ---.

> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 791079021f1b..1c43cc91f804 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -73,6 +73,8 @@ properties:
>            - dallas,ds4510
>              # Digital Thermometer and Thermostat
>            - dallas,ds75
> +            # Delta AHE-50DC Open19 power shelf fan control module
> +          - delta,ahe50dc-fan
>              # Delta Electronics DPS-650-AB power supply
>            - delta,dps650ab
>            # Delta Electronics DPS920AB 920W 54V Power Supply
> 


Best regards,
Krzysztof
