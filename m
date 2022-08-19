Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB576599886
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347593AbiHSJJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347339AbiHSJJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:09:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49896C7FAC
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:09:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s1so2536570lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QZ60a7njs7IG948rZhCyRtft/iD3ZUBC7eYaZRnpLFA=;
        b=cfh92PDUUzDErD7ZwgSsE0YtwFh3ZrinlQcS1hojt2pG3zo2s6UVJkCSaB6ATTDaOQ
         hKITedK53sbmXsZlkhLkRXypNlI0O1EsJquweKp8Yndl6Aw1pbOlNy6KnlN+VJ/PLOXa
         QM0LEHj1uEH1K5Quegx/GYhWAgvTEVBpSrKS6KjQcObiu3YZ96I0nFx5g1SY/jJ6rPJ/
         dZAP+2sFfSd+zLFPCEvw1koFJaac7MDzrmLvgUehtE+fIw+RIKHagW2+IqTboLaexASJ
         i9iyInOAvdb8SJLR6XcdUOSjt1kjwziI7Y+NEqr20Dquew2n+XAZHQjUKhrQmgv/pDfU
         BZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QZ60a7njs7IG948rZhCyRtft/iD3ZUBC7eYaZRnpLFA=;
        b=WEMoD9mZwnUvskqRUhSD5edfjsWOoLclZdBmSHMYFDzxVur1NXAdyNnNVQVycHfEJ+
         vVLGd2bAM+a+G/9lsJ2sDmnPeL9guIXCDDrMFcP/C21NKLbsT+mpgPLeds24Nd1AZLZa
         3MmpmPp8cmVlSP/D0VBkEb7I2dlyIvMSJsBUus7M0mdLroK3+ejZGxEJ0au/NrhE/GDJ
         BO+CISqywFp2GcH0kfRwz+xspT7r4ycpPFfgw4dBoHcDxEq+V6TLX1OJoyKzbZXYmSv/
         fS+MZRVRfoIr1S0FsDgiLH6yuFjn/rpCiI36DcYlV5UqR9md9Yz5TupaGwH2gOBd4RfG
         sDGA==
X-Gm-Message-State: ACgBeo2T+OHVqDDoVmkNBhuS1wi9n6+iDoXtR3y0qvntf9EHSHZaDonB
        sa0r+FUrsYS067Q/M1VlH05guR7kOkZBzius
X-Google-Smtp-Source: AA6agR5ER+81K7w1ZtEXKG6dSNHxMZH8A9tQWAmUjpRddEe+flGhry+JKR6M3TDID4l3BuKm6j1kmA==
X-Received: by 2002:a05:6512:2389:b0:492:ba6a:ef43 with SMTP id c9-20020a056512238900b00492ba6aef43mr2318997lfv.394.1660900141694;
        Fri, 19 Aug 2022 02:09:01 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id a27-20020ac25e7b000000b00489e38c4fc4sm559192lfr.276.2022.08.19.02.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 02:09:01 -0700 (PDT)
Message-ID: <a12b6791-4441-e249-863e-ade5162c780e@linaro.org>
Date:   Fri, 19 Aug 2022 12:08:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: leds: register-bit-led: Add active-low
 property
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220818172528.23062-1-pali@kernel.org>
 <f635d5a7-6817-cd62-e395-63e346775716@linaro.org>
 <20220819065620.wvmy3kigvvbwo4bo@pali> <20220819080814.GA6653@duo.ucw.cz>
 <ae1c301a-60e4-5112-6681-8896a7479207@linaro.org>
 <20220819084222.ru4olyfntunlm3f3@pali>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220819084222.ru4olyfntunlm3f3@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2022 11:42, Pali Rohár wrote:
> On Friday 19 August 2022 11:38:29 Krzysztof Kozlowski wrote:
>> On 19/08/2022 11:08, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> Although the question is - where is the user of it?
>>>>
>>>> I was planning to send updated powerpc DTS files with these
>>>> register-bit-led definitions after accepting dt bindings.
>>>
>>> We need device tree people to ack them, first. But a note saying "this
>>> is for Turris Omnia router" would be welcome.
>>
>> In general the process is one of:
>> 1. Send DT bindings with driver and DTS changes,
>> 2. Send DT bindings with driver in one patchset, DTS in second but you
>> mention the dependency.
>>
>> You should not wait with DTS till bindings got accepted. Why? Because
>> for example we do not want bindings for stuff which never is going to be
>> upstreamed (with several exceptions, e.g. for other systems). Also
>> because we want to be able to compare bindings with your DTS
>> implementing them, so we are sure you described everything (especially
>> that you said running one command to install dtchema and second command
>> to make the check is not possible in your system).
>>
>> Without DTS here how can anyone be sure your DTS actually follows the
>> bindings?
>>
>> Best regards,
>> Krzysztof
> 
> Well, last time I was told that first needs to be accepted bindings
> documentation and then device tree files. So I did it like this. And now
> it is again feasible and different steps and ordering is needed...
> Sorry I cannot known all requirements which are moreover changing every
> day.

The rule is the same from years and no one was changing it. All driver
submitters, all DTS developers follow this. You are literally the one of
very few which is surprised by that generic rule and call it "a change".
The patches should be accepted by maintainers in such order (so without
bindings acceptance, the driver and DTS should not go), but not the
sending order.

It's the same with sysfs ABI. Exactly the same.

Best regards,
Krzysztof
