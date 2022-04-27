Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DCE5111D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358505AbiD0HDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242563AbiD0HDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:03:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB953220FB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:00:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j6so1452141ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=knB5re2yE+knNYDwWLwV5oj9zfgG60eQTuuGICfcavo=;
        b=c3w0b4MoE63PeggJZgNSDCaIH6w9y7ctbyjC63+q6frBaZhU1HZvhDLJnumNuLC5u4
         Nom3enBsHvBvXVYwcflIWz5ouuAp0idEknyYRARXXG4rjRntZCpRwOtsqBnDB4TAfLEf
         r2Lnae9ns34uBM2GarNe07PaIw6KiCNkM4+I9D/Fv4rmkCXUEVfZxKuoeBmjGXV6gReW
         c49FxJSSDom/8zrKN9OB0FNklDPH9QDZZ19SAc61MAjWGZADreyaxIsn4AWtkWGuC3ue
         gzsMFhQanpPLoglKdHGfJptXIr+Jx61vIfGynY7IYeqvqrdM70GtgZ4Ywc9roPGKEQfs
         Ld1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=knB5re2yE+knNYDwWLwV5oj9zfgG60eQTuuGICfcavo=;
        b=qkcuU/KYfV3imNHe5blEH56yAxW7sLy/pEiko5R+TgLfD5+P95qVkBi9UIsL+d+Ra9
         AMzvEdI2ExX4wkg3l427FrAMjX7/B0HglMQqxDz/9laQt7/mbzR0I/FU05jd0bYrSzmT
         6VGyhghKXr904e0r+uR0nRgYDcxvUTqGxbFM++foafsFDFXSegdai7Yl4YNVuNnaO0S4
         rFKqVVDR2pKhkxPnQ+o8lIicD2F+6eRzI6NxbS++7Uszxxl2OPv/topA8DdOK2eRKStg
         wAfbAfKclr517zmxyTRQfSyGDu17VlH07ebn6KhnotqjKY81O3HIRTG8p7Ax25wS1B+k
         uIBQ==
X-Gm-Message-State: AOAM530TKMSBQ8vsGUgssPWB9PlT69Gaw7NxqlujsRcy6ZmUTJSKw1jf
        9qESyn68PF5zWAZ2OI33n3qwDg==
X-Google-Smtp-Source: ABdhPJy42PnL5k6WxDMHs9qpbs1kW+ltaQb338xJc6J452058yJtzF813cfMVtTrgpuVYaW3axL7/g==
X-Received: by 2002:a17:906:8982:b0:6f3:95f4:4adf with SMTP id gg2-20020a170906898200b006f395f44adfmr13223466ejc.524.1651042838202;
        Wed, 27 Apr 2022 00:00:38 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x14-20020a1709064bce00b006f006948581sm6267366ejv.170.2022.04.27.00.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 00:00:37 -0700 (PDT)
Message-ID: <a3d9f68d-9101-2749-a7cd-5a4b3595a07a@linaro.org>
Date:   Wed, 27 Apr 2022 09:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/7] dt-bindings: hwmon: Add nuvoton,nct6775
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220427010154.29749-1-zev@bewilderbeest.net>
 <20220427010154.29749-2-zev@bewilderbeest.net>
 <178b9310-a854-dfa6-a4f3-f971b608abe3@linaro.org>
 <YmjmWNUpCAFYesyk@hatter.bewilderbeest.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YmjmWNUpCAFYesyk@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 08:44, Zev Weiss wrote:
> 
>>> +    maximum: 0xff
>>> +    default: 0
>>
>> Since by default it is disabled, doesn't it make a required property?
>> IOW, if you add a node without this mask, will the device operate
>> properly and usefully?
>>
> 
> Yeah, zero active TSI channels is a totally legitimate way for these 
> devices to operate.  TSI is just an optional source of additional 
> temperature readings that's used on some (AMD) systems; all the basic 
> Super I/O functionality works fine without it.


OK, thanks.


Best regards,
Krzysztof
