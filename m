Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5448D4C64F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiB1IlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiB1IlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:41:12 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B9E6621B;
        Mon, 28 Feb 2022 00:40:33 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id i11so16440483eda.9;
        Mon, 28 Feb 2022 00:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lU9U3y2H7TqVnOKr76UbIM5qDbprhU53RuO6iQcXBMM=;
        b=KuRA/HCILOh35h1WjtNlZr12Xn1VpoPNsKsuCte7HiHc55pOeypTmQWcHmx1XRLKgB
         i6WUEudncISh3tzzoy0iOdrjxyJ4UYr5igWy6FtFr9k2PYlKB3T34DYK4JtfHIZ05MLJ
         F585x5WhLQs+t/bcnk8moVVPN9CSz/p55VVzKK/stB0LR1hXrtHUxy/jB+ninO6kDl52
         RYmsEt5KGGG/B6159fjp3nKusVU4HV3yYq2XvJo8w3NOhk+ecj0Dx17sQa8N2TuGTwW9
         nfdoIR42kPm6K4HdFf6b6UcMBC2peFE0OreB8nK9lEfw5+9PAOWMOn8eqr8Qv+upOMdA
         0OrQ==
X-Gm-Message-State: AOAM53255x1/hOdRr5+9EDsQbwRWikfCYv70W3DLu8yznupTv82X4FOi
        0qUo3eOrOQSc1djk74l+iyg=
X-Google-Smtp-Source: ABdhPJyts5/gqTTGMWCFC+e0qih7SB7RX2Oirk3XrA6slJNhiE6x/o/r+k1+mv+NqSeB5e5HpidKlw==
X-Received: by 2002:a05:6402:524e:b0:410:dedd:ea37 with SMTP id t14-20020a056402524e00b00410deddea37mr806629edd.260.1646037632061;
        Mon, 28 Feb 2022 00:40:32 -0800 (PST)
Received: from [192.168.0.133] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id j7-20020a1709062a0700b006bc28a6b8f1sm4119215eje.222.2022.02.28.00.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 00:40:30 -0800 (PST)
Message-ID: <d6031c8e-5a70-9561-f44e-0573594da34d@kernel.org>
Date:   Mon, 28 Feb 2022 09:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 02/10] dt-bindings: arm: sunplus: Add bindings for
 Sunplus SP7021 SoC boards
Content-Language: en-US
To:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Rob Herring <robh@kernel.org>
References: <cover.1645413746.git.qinjian@cqplus1.com>
 <87cc20bb3ef747c4da89f9e60c0847532bb0a679.1645413746.git.qinjian@cqplus1.com>
 <141c1b3e-b116-a0eb-78ad-dd9263880e9d@kernel.org>
 <fd66d0c1f8d5410ca676dd523bcde61b@cqplus1.com>
 <8ce8a3db-0f42-0b30-6688-01c1ea905425@kernel.org>
 <66b2710bc7c048a284fa3b6270ba7bc8@cqplus1.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <66b2710bc7c048a284fa3b6270ba7bc8@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 08:05, qinjian[覃健] wrote:
> 
>>>> This binding looks incomplete.
>>>
>>> Sunplus SP7021 is an ARM Cortex A7 based SoC.
>>> The patch is for SP7021 SoC and SP7021 based boards.
>>> Sorry, I don't understand your questions.
>>> Could you explain more?
>>
>> You have there only one compatible but if I would expect at least two.
>> One for SoC and one for board. Something like this:
>> Documentation/devicetree/bindings/arm/rda.yaml
>> but in your case enum would have only one entry.
> 
> Currently, we only support one board. Maybe will support more boards in future.

This is not the answer for my questions. I said I expect two compatibles:
1. One for SoC,
2. One for board.

And you respond "we have only one board".

Where is the SoC compatible?

Best regards,
Krzysztof
