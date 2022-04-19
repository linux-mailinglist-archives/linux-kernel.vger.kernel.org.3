Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528695076BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356043AbiDSRsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352507AbiDSRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:47:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC462E9;
        Tue, 19 Apr 2022 10:45:13 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y11so3912361ljh.5;
        Tue, 19 Apr 2022 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SjD5CFslJQQYURAmfXvw+WxJZ7JPzN1dOfI/dFsBNzg=;
        b=dUdFe12pHTI33mJnYfkh/TazjFWSWVb+om+MTj/GzhLgegWL9KGtC6MyUS1i4zTKxA
         0CNH077RDCRwL15pPGcRpmIE8js/9QFKpPz0L4mG5KM3zbvFb7oONTpxAJO2+kKdGMsd
         owWHsM+kj0A8W8DfI+x5A5+Bp6LL7HF36f/iZSNbFmoCskj3Dv07UrEDlUoBVcpthWFW
         T6ybwCUHutfaZh3+oFxP1JweHzQ1wpF6CjFwHA8jH6GgadsPc3YtzUyuEARBfhTht95U
         zWjc8MdnxpncRGG6FK1yGnbLaJDe5hihomQ3b78OVdDKLGx25xRAsLZa2COCAaiQTzaf
         SH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SjD5CFslJQQYURAmfXvw+WxJZ7JPzN1dOfI/dFsBNzg=;
        b=AqxklEtcNNCeyTSph+PfM3A1uSbkiqvY6PgS8dtt8Jz+I0cQ9umaRYerRGI+Mfp6AU
         Th7QqZ4eJ1WmqzGjYx2yFO1u6MpWVZuz0GC7Mt6hfWTyjKpP5hu/fTZTfYXgUnF+bqQ8
         v+qWgsE4GgNHLD0lRsJWiHgIfUBepRJ15qHnvPFCC79c1jHd/zCt1U5uleN4uUKr9DxL
         JScxk7cbnPQ76pPsxRK6BJuKCjYxq8B0FxM6JXfaJYL9T32PIw7vVNlaCPP5f4xiccRq
         oJWNyvMT6h3lPyz/F57x9p1ZVJfJMkiTxAHZTZ3rRjYZgU6L7xBaNGspkOQG8RpkXEA/
         I1Ug==
X-Gm-Message-State: AOAM533bt5XT0hdEFYjleJVpbY/eJoiNjAz+YNwVtDIUvfGQPlKlRMWr
        pxt5sZS2hlLr8ttZtK7kjmg=
X-Google-Smtp-Source: ABdhPJx2o4TRNqJTcBSZ5qW8z5gPbd0SOEt8FZJeRrvnYgmsTK5aLgP3VQ+f02YC6tAp/Ax9YpzTyQ==
X-Received: by 2002:a2e:7012:0:b0:24a:f9bf:ce70 with SMTP id l18-20020a2e7012000000b0024af9bfce70mr10512154ljc.329.1650390311309;
        Tue, 19 Apr 2022 10:45:11 -0700 (PDT)
Received: from [192.168.86.247] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id r4-20020a2e5744000000b0024d9e106768sm1490874ljd.89.2022.04.19.10.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 10:45:10 -0700 (PDT)
Message-ID: <0599e7ac-bd06-8d56-b510-0f27f4cc6790@gmail.com>
Date:   Tue, 19 Apr 2022 20:45:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/4] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
References: <20220419160058.9998-1-markuss.broks@gmail.com>
 <20220419160058.9998-2-markuss.broks@gmail.com>
 <Yl7pqgjza/ZfajyM@sirena.org.uk>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <Yl7pqgjza/ZfajyM@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 4/19/22 19:56, Mark Brown wrote:
> On Tue, Apr 19, 2022 at 07:00:54PM +0300, Markuss Broks wrote:
>
>> +description: |
>> +  SM5703 regulators node should be a sub node of the SM5703 MFD node. See SM5703 MFD
>> +  bindings at Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> Why is this a separate binding with a compatible rather than just being
> part of the main MFD binding?  Alternatively, why aren't the regulators
> described individually in the DT (ie, one node/compatible per regulator)?

I took an example from the rohm,bd71847-pmic.yaml MFD binding, they have 
regulators at a separate regulators { } node, with a separate dt-binding 
for it. I'm not sure what should I do, I'd be more than happy to follow 
a better example if you can show me it.

- Markuss

