Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A1A4C8523
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiCAH3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiCAH3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:29:16 -0500
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E26433B0;
        Mon, 28 Feb 2022 23:28:35 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id s1so20731608edd.13;
        Mon, 28 Feb 2022 23:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wKJAfUuvmexmmq3PlD9f46VsJrO53MebKTGUYq+/qrQ=;
        b=vjjEUsy3R6rR8QL5rOuAGtRclvkUJJLskyRbWf/a7lyyY2IcSr2UG3h1cf8NxrbDZW
         4Ej6JHvE4oyb0UxkW/Hu+YE1yLXs5iE7oioc6iit7cWXUe/0AxNP2107h0+K6bF18n+T
         WEcZ6PxcSazmaJx7g1z3e/LbCdzhbOXPxXWJU+uitp3bvpgCeaj+eXGgXliL/0AnNSGp
         FEAJDRNieP9sPOqaLB+7QlaogCuwKl42o8M7P2nb3xtPKeHf5xtlOg8fuVID3hz8bOYc
         +PdXXVEePWMqGJ+owuvjgsu4sGrjTETjeiqNSREg8+FhQoT5/IGapGdTwUCcerFHjozg
         dnew==
X-Gm-Message-State: AOAM531AARg/lKTn18a68F2aD8BhMe+yCOcucueYyDDXPqfPRI7MsWHf
        NAy7lqLgEKzBFbc+2J/k++M=
X-Google-Smtp-Source: ABdhPJwNczAdO1z86KiTqLoOamzpjwnTcoZbKMAdw4eGkzqoIH+WEsHJKDD2jE1OIyExt85h8nXfLA==
X-Received: by 2002:aa7:c948:0:b0:413:2bed:e82e with SMTP id h8-20020aa7c948000000b004132bede82emr23373534edt.394.1646119713356;
        Mon, 28 Feb 2022 23:28:33 -0800 (PST)
Received: from [192.168.0.135] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id d6-20020a056402144600b00412a7d10c20sm6720982edx.60.2022.02.28.23.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 23:28:32 -0800 (PST)
Message-ID: <496ebfcc-424f-d56a-5b88-9ae1c35d47db@kernel.org>
Date:   Tue, 1 Mar 2022 08:28:30 +0100
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
 <d6031c8e-5a70-9561-f44e-0573594da34d@kernel.org>
 <3d7decc2cf9c4df4ae7f22d0ca671f34@cqplus1.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <3d7decc2cf9c4df4ae7f22d0ca671f34@cqplus1.com>
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

On 01/03/2022 03:08, qinjian[覃健] wrote:
>>>>>> This binding looks incomplete.
>>>>>
>>>>> Sunplus SP7021 is an ARM Cortex A7 based SoC.
>>>>> The patch is for SP7021 SoC and SP7021 based boards.
>>>>> Sorry, I don't understand your questions.
>>>>> Could you explain more?
>>>>
>>>> You have there only one compatible but if I would expect at least two.
>>>> One for SoC and one for board. Something like this:
>>>> Documentation/devicetree/bindings/arm/rda.yaml
>>>> but in your case enum would have only one entry.
>>>
>>> Currently, we only support one board. Maybe will support more boards in future.
>>
>> This is not the answer for my questions. I said I expect two compatibles:
>> 1. One for SoC,
>> 2. One for board.
>>
>> And you respond "we have only one board".
>>
>> Where is the SoC compatible?
>>
> 
> Got it, thanks for your explanation.
> 
> I'll add the SoC compatible(sunplus,sp7021) in next patch.
> 
>   compatible:
>     items:
>       - enum:
>           - sunplus,sp7021-achip
>       - const: sunplus,sp7021

Yes, this looks correct (assuming "sp7021-achip" is the name for this board.

Best regards,
Krzysztof
