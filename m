Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5234BF2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiBVHwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiBVHwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:52:05 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D76317A80;
        Mon, 21 Feb 2022 23:51:39 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id p9so40210140ejd.6;
        Mon, 21 Feb 2022 23:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F3WbKk5vimbhrQDgdHAazTZndoEQzHfmgGw6RSG9wZM=;
        b=3d7ryvmcu+zSWqUnELZnP057QpLnw8OEpwpZE4GFsEsnFJB53d8OgUIUlQbHMk3GHt
         abEnxCitV3MBGPdZFfOV7n51noj4YAhWJrzB+3GUNwSvAkSHNH5NtO399ay7ZoZ1x9Cx
         ycDLOoV2Q7KIIiwiEYtgS0wFPBTZ56lPf+bI0gQdmh/AsVqRW79QWibs/r4Ws/cYdPGG
         kVCnMumtWsCW0xzNgr9Brv0Bt0nQ4asM+cMRMutYhDyznODXvxFvMDbpmTob2He1Nqpi
         RbXopgyd6miDdp2TtD5YwGXPGVmWENvOMQ3YRNllRylbZ0fHxR6Zy1qJXFIqN+GmBBL8
         H5UA==
X-Gm-Message-State: AOAM530YkE9TIxJ8nO7zf+O4pNDAne4hl057XFhJnrElqTcwE2TudyZP
        v8YhgxlP+mM/vkx4twMedos=
X-Google-Smtp-Source: ABdhPJxpu/V0BvmnL6Gj9apR6o1rnAVPW2zXbVxfOJJpHy66Yspt3UgACkgnHKoxUsWvYzJMLlAP2g==
X-Received: by 2002:a17:906:d047:b0:6c8:185c:aad with SMTP id bo7-20020a170906d04700b006c8185c0aadmr18708547ejb.341.1645516297709;
        Mon, 21 Feb 2022 23:51:37 -0800 (PST)
Received: from [192.168.0.122] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id fx2sm5892678ejb.59.2022.02.21.23.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 23:51:35 -0800 (PST)
Message-ID: <8ce8a3db-0f42-0b30-6688-01c1ea905425@kernel.org>
Date:   Tue, 22 Feb 2022 08:51:33 +0100
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <fd66d0c1f8d5410ca676dd523bcde61b@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 07:15, qinjian[覃健] wrote:
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    const: '/'
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - const: sunplus,sp7021-achip
>>> +
>>
>> You did not publish DTS so bigger picture and context are missing here.
>> Is it a SoC compatible? A board compatible? Why only one? Against what
>> does it validate?
>>
>> This binding looks incomplete.
> 
> Sunplus SP7021 is an ARM Cortex A7 based SoC.
> The patch is for SP7021 SoC and SP7021 based boards.
> Sorry, I don't understand your questions.
> Could you explain more?

You have there only one compatible but if I would expect at least two.
One for SoC and one for board. Something like this:
Documentation/devicetree/bindings/arm/rda.yaml
but in your case enum would have only one entry.


Best regards,
Krzysztof
