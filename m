Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A846C2DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbhLGSb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhLGSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:31:55 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A8C061574;
        Tue,  7 Dec 2021 10:28:25 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so122953pjq.4;
        Tue, 07 Dec 2021 10:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3K6TOKmuXzbOyoxK5qeZN6UfLrjbFqLBLFd2or1FY3U=;
        b=bMn4HZzovqnSsKBYjx7SaX/7/1YnQpwZP0+VKOP4iiLq7LSFfCBZV9AU+pFkzJI1Fd
         4Nw+zBXs8m4ta8JPlqj4SuV8/lpOYJgqD3XTRBRBtwgX4BBCorP93aKWdbbOvahP9Ieu
         4fclBZDgT1sK/yI1MCQv9+gKiO4Q/+AVDNEtSgu3P9KKH42p1qdgD0C+JoS/spi52ZUo
         ayTkva3dvK5bn99tb883HDN9TNA9iomarw6Fl3mB9XdQscrwPuSQfQ5YPdDXW/bEzdm7
         gfdZZzrQtDoMjwOnx3I48NQchGUqZnOwQMwdOskA8X+RCIW6dMoxHO34UGD6PcdG2kp5
         8Zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3K6TOKmuXzbOyoxK5qeZN6UfLrjbFqLBLFd2or1FY3U=;
        b=FYIYkCnXeyXZ/dOoJ9TEKSeYcsrw8dsikGa+17VCFd3cf06ruBeq4E73eEOcq76mFb
         l8LziJw/HpAqm9Taf5fWXvlhH7g6bvyQ0RDOEcelCaei4r3fqjvAK7xrljl8vyQaS4RB
         SG5iR791V+iLKMaH2RV3SvKjxGCgcN+rxYyHMW23E1m+buMCEjzSEoaaKe8QdOL191um
         IMPqQ1bZOg2Lrxsz8Tw7TJSbu8fyJw5XR5LsbUwEBh1ujq8FVqh7LEec+DVd6wzQrqdI
         RHOS5B0YJ5tH7yfc3OSW9LEaf/zHTKG2Kkw7jdS6sgP2uBAQaYJhXPon6xQ2GJg8gaLq
         kpAA==
X-Gm-Message-State: AOAM5315rzCPKgmcaoSrdFJtdSuay66GpN40qq+1apgp0S4efQ1C2uDn
        JhhuFovFaWPVRpKMc36B2XM=
X-Google-Smtp-Source: ABdhPJzn0pfJRBt8YChyiQar1VcDrvcPxcRCu77UgUdlxwGOW7ggxIp8oNfTZO1IIk1I65ugPQuz/A==
X-Received: by 2002:a17:903:2443:b0:142:1e92:1d19 with SMTP id l3-20020a170903244300b001421e921d19mr53256611pls.24.1638901704865;
        Tue, 07 Dec 2021 10:28:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l21sm3446135pjt.24.2021.12.07.10.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 10:28:24 -0800 (PST)
Subject: Re: [PATCH v2 12/14] dt-bindings: ata: Convert Broadcom SATA to YAML
To:     Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-rtc@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>, Doug Berger <opendmb@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>, linux-pm@vger.kernel.org,
        Markus Mayer <mmayer@broadcom.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Zhang Rui <rui.zhang@intel.com>, linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-crypto@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Scott Branden <sbranden@broadcom.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com>
 <20211206182616.2089677-13-f.fainelli@gmail.com>
 <1638889090.722845.5803.nullmailer@robh.at.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f463f454-943c-e081-9005-c7b4df7304af@gmail.com>
Date:   Tue, 7 Dec 2021 10:28:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638889090.722845.5803.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 6:58 AM, Rob Herring wrote:
> On Mon, 06 Dec 2021 10:26:14 -0800, Florian Fainelli wrote:
>> Convert the Broadcom SATA3 AHCI controller Device Tree binding to YAML
>> to help with validation.
>>
>> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../bindings/ata/brcm,sata-brcm.txt           | 45 ---------
>>  .../bindings/ata/brcm,sata-brcm.yaml          | 91 +++++++++++++++++++
>>  2 files changed, 91 insertions(+), 45 deletions(-)
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
> Full log is available here: https://patchwork.ozlabs.org/patch/1564108
> 
> 
> ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
> 	arch/arm/boot/dts/bcm958522er.dt.yaml
> 	arch/arm/boot/dts/bcm958525er.dt.yaml
> 	arch/arm/boot/dts/bcm958525xmc.dt.yaml
> 	arch/arm/boot/dts/bcm958622hr.dt.yaml
> 	arch/arm/boot/dts/bcm958623hr.dt.yaml
> 	arch/arm/boot/dts/bcm958625hr.dt.yaml
> 	arch/arm/boot/dts/bcm958625k.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml
> 	arch/arm/boot/dts/bcm988312hr.dt.yaml
> 
> ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'dma-coherent', 'sata-port@0', 'sata-port@1' were unexpected)
> 	arch/arm/boot/dts/bcm958522er.dt.yaml
> 	arch/arm/boot/dts/bcm958525er.dt.yaml
> 	arch/arm/boot/dts/bcm958525xmc.dt.yaml
> 	arch/arm/boot/dts/bcm958622hr.dt.yaml
> 	arch/arm/boot/dts/bcm958623hr.dt.yaml
> 	arch/arm/boot/dts/bcm958625hr.dt.yaml
> 	arch/arm/boot/dts/bcm958625k.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml
> 	arch/arm/boot/dts/bcm988312hr.dt.yaml
> 
> ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
> 	arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml
> 	arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml
> 
> sata@a000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/bcm963138dvt.dt.yaml

All of those fixed in v3.
-- 
Florian
