Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBCD542CAA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiFHKJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiFHKIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:08:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA51B0780;
        Wed,  8 Jun 2022 02:51:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j7so18116515pjn.4;
        Wed, 08 Jun 2022 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fauG2+ouC/pE9fJBFguldPR02kf/OkXrX9OF5a1epKw=;
        b=HMDNWEhCcLSUhdf09KbZLJllzy0AHoA5hc7cY+4DfDKpW3uhdJJGQTM+yjNkBMqLC0
         rel0nka4lEpbb+UZaUt2hdT2PndkqBx9zUxAjumk+h47hcHBM/kwuB01UJ2vi57TYn1S
         bQYn+pk+nuP3R1TtODW7OP1xUqdV8AsjP9m2AQQU4wWsRjO8MqdDt49f8k7fRbhjrEGK
         BR8Ad9MoyjpPqYQf/1w6npeHENegaiZkU1umUoVJlpoj/YNRrQ4d2io8IAjflbzm+L4R
         1sJN0vFwes29VAAdtCA3+nhPFeSHeqwhgIU1IYGqBiwoBG1qB6AG5kzC/m4B/DwShDUt
         UHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fauG2+ouC/pE9fJBFguldPR02kf/OkXrX9OF5a1epKw=;
        b=JVdBqo2+E22LHn0+jbrBhtHLC4D9x/nr1ATfVZkTshNFcksdet+30xZEa7NthhUoLV
         GGf7k6uYWt8Ehvws9lpadtEkg8JcZJ1uAhJ+cHPSPCerPicL6AClCRknbmjVsnRmpMND
         IHZeKRHfUUfd1tqFegcU5ETPPCK2x1f6g4JataOC8HUSuBkJowNDApfsdP4QCFXdl/WY
         Noq6+8Kfrdhm8jo+BSDUdFAruzehufdkIobuqQO4K9uNQggVWOG72vTRQCYuNI656lA+
         uXlRPS8TSnoSyA/Cz5HQAwGGFzZkmT71Q6svoWvVJihMiVxezhLPHJXKqWq2VJJZaqug
         lkZg==
X-Gm-Message-State: AOAM530Z8sJk7EXq1TKqNQwu2/9sN0mIPVSd8HMvxijy9GhGFVQ7WU3l
        WnzbyzS4Ahw3llQ1hyEfSVU=
X-Google-Smtp-Source: ABdhPJxEWS/rHoQGxKsD3tIotODBmp2FZwHZA31x813cDASnCP9ZP49/qjqKKz0GqJChqK0YicDI1A==
X-Received: by 2002:a17:90b:3b8a:b0:1e2:ee1e:6340 with SMTP id pc10-20020a17090b3b8a00b001e2ee1e6340mr36776831pjb.38.1654681895328;
        Wed, 08 Jun 2022 02:51:35 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-80.three.co.id. [180.214.233.80])
        by smtp.gmail.com with ESMTPSA id e13-20020aa798cd000000b0050dc76281b8sm15275765pfm.146.2022.06.08.02.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 02:51:33 -0700 (PDT)
Message-ID: <28ec9f61-3086-a12e-3e8d-33f855f916fc@gmail.com>
Date:   Wed, 8 Jun 2022 16:51:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: virt_to_phys outside array bounds warning (GCC 12.1.0)
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <YqBgWoXQmzVczRDo@debian.me>
 <e8f8f42b-9df3-d9a1-893e-0f972e27ef80@linaro.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <e8f8f42b-9df3-d9a1-893e-0f972e27ef80@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 16:28, Krzysztof Kozlowski wrote:
> On 08/06/2022 10:39, Bagas Sanjaya wrote:
>> Hi everyone,
>>
>> When cross-compiling arm 5.19-rc1 kernel using GCC 12.1.0 (armv7 with neon
>> fpu, multi_v7_defconfig), I got outside array bounds warning pointing to
>> virt_to_phys() macro:
>>
> 
> Thanks for the report!
> 
> I think this was already reported:
> https://lore.kernel.org/all/CAK8P3a3X0UwQiVNZqvGmSKi8BX6zg=k07+9Q3rDGqHVkc8Hdsg@mail.gmail.com/
> 

The report above is for arm64, but similar to this report (arm report).

> Anyway, for the future:
> I don't think the CC list matches the problem. Please bisect this issue
> (since it is reproducible build time, it should be straightforward) to
> find offending commit and then Cc responsible people and maintainers
> (scripts/get_maintainer.pl). Ccing half-random people might not get
> necessary attention.
> 

I think the most likely culprit is commit 37efe6427dd50e ("[ARM] use asm/sections.h")
and 14c4a533e0996f ("ARM: 8583/1: mm: fix location of _etext").


Thanks.

-- 
An old man doll... just what I always wanted! - Clara
