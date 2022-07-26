Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47815581002
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiGZJfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiGZJfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:35:00 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC66B2F66D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:34:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id z13so15478145ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UbC9r+lVYb5azPSkNOhFyuGn+Y0LpjW+CB5M3j+9eZ8=;
        b=FBUEaYcWAzUe37l+rjhvVBRMCaiPTGWKKmthl3kddv4upz5hyqB4+AqD8b/6sEZWu8
         l+X/6BqpjVxyMR4ho/blG2lM6XWWSI2qd9oL7gBxGpo08sGRDDfT2hOCWu0bkaNACGvd
         OaynO09MAVQEaaxpOh3QOh6yU6Nd7jFrWjUdix7v836eW1T3vwdrcdrxtKT7FTl7lYC5
         +qC13pmQPnOAK0S1FPiPsT6xiJZnCm9MzRPPnOLPOGXp8qk1XOVjMM9DWfKKdGmKwLVh
         EFx2NhostrTagiAkavLVMhXSftfegXQc3swwKIyuCuTp3oPPRkYmbyPcPl2bpvDxUQIk
         4/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UbC9r+lVYb5azPSkNOhFyuGn+Y0LpjW+CB5M3j+9eZ8=;
        b=CQ9dzXLwHWM/zm3U301D0DYnvrGyEDZpPIg0B/TjlKHuIcBrKLJLxq0yKPKZT5Thxh
         u50yw2OkdX4Exkjvhk8NT7eYLw+S5l8MeHgGDn8KLlOAOAx+Ao2OWow94Th/k+xlyMPR
         lMzrMD2tB5Zj5+5+VvEVYTOdZ/AF1hj2Y1w05DA0rH/dkBdKA0qdhf2Ad/yb1tgMq/CL
         4YoleJf4Qz9Sb1ybbIGwct59LrQXqHOoGXt0Ns6AhAqWjZw9t7SrUiPlade4LMyGn1wC
         l9SIuvz5ByljOvY1Di2d8nmeWF29M1b4X7eVUvynBtPot0UMrF6B4G4gKxS4jiF/mWJI
         nltQ==
X-Gm-Message-State: AJIora/Px/r2KRCprIVfpdBsXsKpOR3ZC/UshMstwjsJNKWOaK98Giv3
        GBFC38GC25uhmJyEMG1HNCS81w==
X-Google-Smtp-Source: AGRyM1tigmESYBHdCULUbFVd2COUlgERvPSXR/0SNXcbQTe2QhRXSxOA9weeGqnXDiYTXNBG2XhOyg==
X-Received: by 2002:a2e:6e0d:0:b0:25d:da36:10ad with SMTP id j13-20020a2e6e0d000000b0025dda3610admr5839921ljc.152.1658828097133;
        Tue, 26 Jul 2022 02:34:57 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id o12-20020ac25e2c000000b0048a77a2c4b2sm2384328lfg.158.2022.07.26.02.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 02:34:56 -0700 (PDT)
Message-ID: <2dffc393-b86c-17e2-8c11-bdd9504366c5@linaro.org>
Date:   Tue, 26 Jul 2022 11:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/3] Documentation: sysfs: Document Broadcom STB memc
 sysfs knobs
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220722201043.2731570-1-f.fainelli@gmail.com>
 <20220722201043.2731570-3-f.fainelli@gmail.com>
 <135be705-24f9-13b8-6939-0eaa569434d7@linaro.org>
 <3d29b8fc-f183-5883-edc0-cde55b76e4fd@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3d29b8fc-f183-5883-edc0-cde55b76e4fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 18:07, Florian Fainelli wrote:
> On 7/23/22 10:59, Krzysztof Kozlowski wrote:
>> On 22/07/2022 22:10, Florian Fainelli wrote:
>>> Document the "srpd" and "frequency" sysfs attributes exposed by
>>> the brcmstb_memc driver.
>>>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>>  .../ABI/testing/sysfs-platform-brcmstb-memc       | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-memc
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-platform-brcmstb-memc b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
>>> new file mode 100644
>>> index 000000000000..2bf0f58e412c
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
>>> @@ -0,0 +1,15 @@
>>> +What:		/sys/devices/platform/*/*/*/*/srpd
>>
>> That's a lot of */. Are you sure it is correct path? Didn't you include
>> here some driver-related path components? Can you paste in email full
>> path as an example?
> 
> Yes this is the correct path:
> 
> /sys/devices/platform/rdb/rdb:memory_controllers/rdb:memory_controllers:memc@0/9902000.memc-ddr/
> 
> the 'rdb' node is our top level bus node, the 'rdb:memory_controllers' is an encapsulating node that groups all of the possible memory controllers in a system (there can be between 1 and 3), the rdb:memory_controllers@0 is the first of those memory controller and finally the 9902000.memc-ddr is the sub-node that contains the register controls of interest, since the memory controller aggregates different functions (arbitration, configuration, statistics, DDR PHY SHIM layer, etc.). Maybe I should provide a more complete binding while I am it.

The path should be much more specific so include at least:
rdb/rdb:memory_controllers/rdb:memory_controllers:memc@*/
(or some variations of it if pieces of name change)

However looking at the driver, this is regular platform driver, thus  it
will appear as:
/sys/bus/platform/9902000.memc-ddr


Best regards,
Krzysztof
