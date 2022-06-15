Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF354CF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346020AbiFORQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244057AbiFORQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:16:38 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F9F35DCD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:16:37 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 184so11925427pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YwPLgDxyuMvpvopE1a1vSveFD87H5x3EsFEOC1y1D1Y=;
        b=yhUOBJCl0gMsKi78C0bvK1VKV92CvJzw9G1Aa8dLPXkAhzE7+Dip8lE9H+jS+DgG/O
         UkRMk/BkAWgSy6FNWN8RZDjcb6D6HMEYz22HlRsNzZbZAB6602FBLHRW+TBY/W4wWFOz
         2qMthuvAP4OUT6XiZiffWmSZ/CBxPeNR0Fj9LKkC658TyVJoC5QoBG+QsXR5YMeF8Ere
         Shxh/v+IUUWVyipyknblyOeeqpt+DFubv9/D4Nn16feGBg0lvtBCwjLZ7QF3XIzx7Xy/
         1SJbsDgI9SHAeDeQLY/kiTbGWNSUX4NPAFIkRCqRbqgPX8FlUuFt+MSo27DveDTHTUFH
         yujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YwPLgDxyuMvpvopE1a1vSveFD87H5x3EsFEOC1y1D1Y=;
        b=QKmHFG8Mj0N+K1tB4rmCQe6eQVyMyFAFJcoH+CnOM/ovSXMaQwdzib+JmJsa/Edr75
         suSNvQwI/dyHAhRD8vg19uPAC6+BAFP4ozxb6Vuz+QN1GyeHTZ8s6JRU+boragE7EUZQ
         crmS2XU5p4aRATUNXocbxzWv7mkxplCs8fStVIcWpCaSDImBphQNdqZ54LYSttZLtf/G
         pcE9r6Cek5I4Lx1qAz4QgtneDHhD5F3OL0s2cg2Iy/m+oxwHK5laFpyUjzf5edWYPxG8
         HUlNieXegv+9uBuTDY0CTFdmoXBQkyOsOWIOMcMbuuwN6tKpUtCuc66jRqjeDwRimUQ9
         Bpug==
X-Gm-Message-State: AJIora9VkaUHX8q6oRj6lkgBaTJ5MXZRewnJaIl/LLFBjMl/RzGQZxBr
        t9sLTOspd1Ud0ICKoyGHy497DA==
X-Google-Smtp-Source: AGRyM1vea1pCIzgALGoWtdku0ZEN02bZLY/l1PjIFJWbemwEUCX2a88E6hLPWZFoab+LFbh2HUUvSA==
X-Received: by 2002:a05:6a00:b8c:b0:51c:2d3d:4595 with SMTP id g12-20020a056a000b8c00b0051c2d3d4595mr611855pfj.80.1655313397004;
        Wed, 15 Jun 2022 10:16:37 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id q138-20020a632a90000000b003c6a71b2ab7sm10319655pgq.46.2022.06.15.10.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:16:36 -0700 (PDT)
Message-ID: <8857a3dc-1a11-6364-ed32-552a3a459de1@linaro.org>
Date:   Wed, 15 Jun 2022 10:16:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/5] dt-bindings: power: Add bindings for a power
 domain controlled by a regulator
Content-Language: en-US
To:     Max Krummenacher <max.oss.09@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org,
        Max Krummenacher <max.krummenacher@toradex.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
 <20220609150851.23084-2-max.oss.09@gmail.com>
 <1654829855.220248.560616.nullmailer@robh.at.kernel.org>
 <CAEHkU3W0wRDWvEVwgjoeAQaTSr-V=0J2L-FtwJA78EHkaED4YA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAEHkU3W0wRDWvEVwgjoeAQaTSr-V=0J2L-FtwJA78EHkaED4YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 08:19, Max Krummenacher wrote:
> Hi
> 
> On Fri, Jun 10, 2022 at 4:57 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Thu, 09 Jun 2022 17:08:47 +0200, Max Krummenacher wrote:
>>> From: Max Krummenacher <max.krummenacher@toradex.com>
>>>
>>> Adds binding for a power domain provider which uses a regulator to control
>>> the power domain.
>>>
>>> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
>>> ---
>>>
>>>  .../power/regulator-power-domain.yaml         | 58 +++++++++++++++++++
>>>  1 file changed, 58 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/power/regulator-power-domain.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/regulator-power-domain.example.dtb: power-sleep-moci: $nodename:0: 'power-sleep-moci' does not match '^(power-controller|power-domain)([@-].*)?$'
>>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/regulator-power-domain.yaml
> 
> Will change to 'power-domain-sleep-moci' in V2.
> 

Instead: power-domain
(names should be generic)


Best regards,
Krzysztof
