Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9184A46C2C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbhLGSbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhLGSbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:31:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DE5C061574;
        Tue,  7 Dec 2021 10:28:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so2535238pjc.4;
        Tue, 07 Dec 2021 10:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GRqhPtcSnMULJhJ20QnKRoUeef/qK4ZW5QrfZaF8seo=;
        b=jYjw8CfmBCCSRCDPe4Zc5R5UI7OgkNEkfApAKZiU6b1apiST5G/kA243PWM1NYo+3A
         4ROmfj/8aBKMPy2eoSR++YBpRPRmlU5hoOMXIYM2EuR1NYy8iqzOYAs5NsxHBQn40XL7
         tzcQVHn+MSVpvyHeC5mUh0W2sz7wDvhqpZqTIaOc4EIZx+dL1wCstT+K1uGgn4SzZ1js
         9x2EejEK8pQfu0gEV0gTFIS1lNC1HdrTJzk1mLJHUvCNJWWcddFBGe3W2SZGJws2DxhI
         L4uaO8IgSidMVTv1jTn9ybdrJgi1H7ZVF9IDr5u514wC9fOZaFo22EnYDZafwNmbhCRq
         6Dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GRqhPtcSnMULJhJ20QnKRoUeef/qK4ZW5QrfZaF8seo=;
        b=E6D0dfjeE03Dl4im8D7kvbutmqyt7VMK97Y79WIqMP7htKYqAj4hPFZcKY/kZMTGF0
         LUjsqyxU0jnhjahmW1dbIKkg/1JKJgCSXjRlgBiRejx5dSLr4t8A6L62WTiE7HaizWZs
         X5W4o+kEWfUNWs/UMBUE8y4JAN6M8x83ZHUXCmPojfwzLRBfPPyeGwh0lNpvl2eBIVfR
         XwZ+6ofo7kAfejLW4RiIzJK6ayqx5RiM+QectGjmzxeAQJuulbsqJ3Q4pVrbNNwapH+v
         L67f8LOuoq0MumKlOIh49mQGKb2m5XDz888zJBOu2KKMJjSCv7TIGl1kD2Yeh+seRmj6
         xoAA==
X-Gm-Message-State: AOAM532uOZS40Lba6PQR+9d9C8H7O8FQ75lkS9O+vQtXOxVyhbUfLrjD
        TADZPXoNWSOjMQXjeoLYE6JznjOOytk=
X-Google-Smtp-Source: ABdhPJyzfgAcrd35S76+cciJc3dwo9MwdGfqtwtvppjuOolxT/kCBhAGE+khdttM6yLFTtJp8d9E3g==
X-Received: by 2002:a17:90a:9bc1:: with SMTP id b1mr962060pjw.49.1638901690582;
        Tue, 07 Dec 2021 10:28:10 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p43sm412532pfw.4.2021.12.07.10.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 10:28:10 -0800 (PST)
Subject: Re: [PATCH v2 09/14] dt-bindings: interrupt-controller: Convert
 Broadcom STB L2 to YAML
To:     Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Doug Berger <opendmb@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ray Jui <rjui@broadcom.com>, linux-usb@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Scott Branden <sbranden@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Al Cooper <alcooperx@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pwm@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-crypto@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Markus Mayer <mmayer@broadcom.com>, linux-mmc@vger.kernel.org
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
 <20211206182616.2089677-10-f.fainelli@gmail.com>
 <1638889090.711166.5801.nullmailer@robh.at.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d6c8a959-f9bc-aae3-5f8f-876ea34484bf@gmail.com>
Date:   Tue, 7 Dec 2021 10:28:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638889090.711166.5801.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 6:58 AM, Rob Herring wrote:
> On Mon, 06 Dec 2021 10:26:11 -0800, Florian Fainelli wrote:
>> Convert the Broadcom STB L2 generic Level 2 interrupt controller Device
>> Tree binding to YAML to help with validation.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../interrupt-controller/brcm,l2-intc.txt     | 31 ---------
>>  .../interrupt-controller/brcm,l2-intc.yaml    | 64 +++++++++++++++++++
>>  2 files changed, 64 insertions(+), 31 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1564135
> 
> 
> interrupt-controller@3e1000: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/bcm7445-bcm97445svmb.dt.yaml
> 
> interrupt-controller@7ef00100: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm64/boot/dts/broadcom/bcm2711-rpi-400.dt.yaml
> 	arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dt.yaml
> 	arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dt.yaml
> 	arch/arm/boot/dts/bcm2711-rpi-400.dt.yaml
> 	arch/arm/boot/dts/bcm2711-rpi-4-b.dt.yaml
> 	arch/arm/boot/dts/bcm2711-rpi-cm4-io.dt.yaml

Both fixed in v3.
-- 
Florian
