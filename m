Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900E856176F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiF3KPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiF3KPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:15:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683F344A2F;
        Thu, 30 Jun 2022 03:15:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o4so22601641wrh.3;
        Thu, 30 Jun 2022 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D2l/alwWXf1CVyTuw+hZLZhlyCPLz/ur8fv0lCK+uZM=;
        b=JrpUkbde4kSciP3oT6RZ3DkFhdZIM22/vkIpi0CJagW2lHvhdlfpjE/M7m/Rz3kZUn
         DYmRbz7bURq8OXPsP54TzJabZUrnEjj8Sik5aPWRzVLGgJ0avDRWZ1hsAs1fW/V37vD7
         5uxZghbYXtU9uQDL4WoWUISzWmJcNj5LlyOImamTYAYzY0iRgJFxmU49luxmUVKpAqZJ
         AKHuxmxsOx84Hww+AldOVQFl4x9UmfF0RKJgoqr83CQlmvVUc71rdSV8uAfonhoK/xQ2
         qgfl9ny0a664ezRO9olVbCeCQxh89WvLoqlWqbCDR8Zpi+wxbx9lN01p0WaZkYWLjCJP
         2/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D2l/alwWXf1CVyTuw+hZLZhlyCPLz/ur8fv0lCK+uZM=;
        b=O6AxMOtQ+cRQqXsIlQF9WiIsrtNYevtJAD+rK6BHZ1n4RnCuOD6t276B5vXyrragD/
         fuzzEg4GV6buh5U/raUcOuKN5q3MRMs5ym9s8Oi4sx2kQCq/2PhdA3TIFhX+3Y1+CMkn
         pIM67rGacXiq6ufH0pU2A6vWC/agR41rCrd+naDUrymw9y2A1nzRsMsRImTnAKDtovfC
         6XFWII9y1sQ6lUxgvBLOm94CUHKWhrIqnhIi29Zo7bjb2rDFb2yRJROfeJ2RAKEHpw1Z
         ZBfqolSjCaNdLIrKFhbh78yx5VNgljbivOpXxpsGjGjl8O2pFL7z2/f1Xjr0zmsILpBT
         suDw==
X-Gm-Message-State: AJIora/U6GGyoUbekjBi4I0cr2t0eqonnJoZmZTmmhH//FVqERa3KoY+
        HLU13jkBW1qgf46qSVR0SKI=
X-Google-Smtp-Source: AGRyM1sdyNLVwVNZUej/hEK50d7NOlexoITli2k4NgW4Okli3tnuEL4cNslKo6oD0dztVBghbpg3xg==
X-Received: by 2002:adf:e350:0:b0:21a:3bc:7d85 with SMTP id n16-20020adfe350000000b0021a03bc7d85mr7391515wrj.400.1656584142036;
        Thu, 30 Jun 2022 03:15:42 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b003a17ab4e7c8sm2489395wmq.39.2022.06.30.03.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:15:41 -0700 (PDT)
Message-ID: <3fcbbea3-6c1e-723b-cc20-9a2454d2ad50@gmail.com>
Date:   Thu, 30 Jun 2022 11:15:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 5/6] media: dt-bindings: ov5693: document YAML binding
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
 <20220630074525.481790-6-tommaso.merciai@amarulasolutions.com>
 <167f09c1-795d-1471-20f7-9f4df29355ed@linaro.org>
 <20220630090232.GC482517@tom-ThinkPad-T14s-Gen-2i>
 <Yr1pD2U2ilXXXX+Q@valkosipuli.retiisi.eu>
 <20220630091613.GD482517@tom-ThinkPad-T14s-Gen-2i>
 <Yr1xzeqW2p4jVDzS@valkosipuli.retiisi.eu>
 <20220630100957.GE482517@tom-ThinkPad-T14s-Gen-2i>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <20220630100957.GE482517@tom-ThinkPad-T14s-Gen-2i>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 30/06/2022 11:09, Tommaso Merciai wrote:
> Hi Sakari,
>
> On Thu, Jun 30, 2022 at 12:50:05PM +0300, Sakari Ailus wrote:
>> Hi Tommaso,
>>
>> On Thu, Jun 30, 2022 at 11:16:13AM +0200, Tommaso Merciai wrote:
>>> Hi Sakari,
>>>
>>> On Thu, Jun 30, 2022 at 12:12:47PM +0300, Sakari Ailus wrote:
>>>> On Thu, Jun 30, 2022 at 11:02:32AM +0200, Tommaso Merciai wrote:
>>>>> On Thu, Jun 30, 2022 at 10:07:19AM +0200, Krzysztof Kozlowski wrote:
>>>>>> On 30/06/2022 09:45, Tommaso Merciai wrote:
>>>>>>> Add documentation of device tree in YAML schema for the OV5693
>>>>>>> CMOS image sensor from Omnivision
>>>>>>>
>>>>>>> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
>>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>>> Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>
>>>>>> How Sakari's tag appeared here? There was no email from him.
>>>>> Sakari made me some review on v2, but I think he forgot to add the mailing
>>>>> list in cc. ( I suppose :) )
>>>>>
>>>>> Let me know if I need to remove this.
>>>> You're only supposed to put these tags into patches if you get them in
>>>> written form as part of the review, signalling acceptance of the patch in
>>>> various forms. Just commenting a patch does not imply this.
>>>>
>>>> Please also see Documentation/process/submitting-patches.rst for more
>>>> information on how to use the tags.
>>> Thanks for sharing this. My bad.
>>> I remove your tags.
>> The patches themselves seem fine. I'd just drop the 4th patch or at least
>> come up with a better name for ov5693_hwcfg() --- you're acquiring
>> resources there, and that generally fits well for probe. The code is fine
>> already.
> Then we don't need v5 with your reviewed tags removed?
>
> I think the patch4 is needed to add dts support properly.
> Also this contains devm_clk_get_optional fix suggested by Jacopo and
> support for ACPI-based platforms that specify the clock frequency by
> using the "clock-frequency" property instead of specifying a clock
> provider reference.


I agree patch 4 in some form is needed - I didn't do the clock handling
particularly well in this driver, and though it's ostensibly an ACPI
driver it wouldn't actually work with a "normal" ACPI, but just with the
cio2-bridge-repaired style. So the changes to the clock handling logic
are welcome and needed I think. whether it needs to go into a separate
function I don't particularly mind either way.

>
> Some suggestion on the function name?
>
> Thanks,
> Tommaso
>
>> -- 
>> Sakari Ailus
