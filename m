Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720CB53E386
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiFFHaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiFFHaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:30:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6002BFD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:30:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gl15so13338967ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=C20vxMWdqTwD6Z42rEEVzIJpyd097nkNjpEAy8hCZfk=;
        b=FT0hiO/wt9Ln26hReszWV7kve6WAQ7SHRAXHuM3oRcyMcf62QkOMqSeKO7K5Q78tV5
         jqZbs/pnJHNkKXfFb5szKb/IknvxYaw6NxhOfSQMJu39Orgpud1c0nHJEYhlJwBSG3g4
         MmGf34twiFLhdqro9wTstyDge0JufEnO8kpC6eFUvoJMSFadTBbyjOMQe0j2P8JJ0S/D
         iWAc3DOU0+HSvwVqGySRPfQDMJMQ+d9ne1njR2H81Dx76MXiTUbI3BF2QydGU6s0Z4OR
         2sLoyhzZDAB6++fqC4WXdwKsoNeRFox4yH28AxiIaBKfcq7eroLmoOeZx8H74tM6VFRp
         BpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=C20vxMWdqTwD6Z42rEEVzIJpyd097nkNjpEAy8hCZfk=;
        b=T5k3fV8iSbeLe3++0bf/lp5QjN/yjZBOB1pVpK0bSz7pdWVe4ciG+Zu7XfsSzUVjSD
         4SXnFrW8F0Ui45AU7I+sZ6/bv0Rf41d8mO+MYFmsBqSoQ+Yov2vRsNmkmcC+X8QMMOTh
         usHWKWUImbP5nrVLgYkb4TL8biI1BxOMHEdMZyB6y/Mn45uPh/QoEI5UFE/s6kdeU9yj
         4p+kSvoHSpBO0iWU0lFGmYqXOubxpJBcBaX16Cy2zsC1mvn7ASNGGjEgn4bgnv2Ztq/E
         zCvkvarKA3P8l81Q6br/xHEq39je7PFfL6s5HCXW6rj/xGVciYGVEExQaWFo5ueVspP5
         wUjQ==
X-Gm-Message-State: AOAM532M0Vur5cbRr4FtempXKRf6xvYimQzI3OW8TMIuggK/3Dfu6kmD
        O/g+OhpvXDtE00FmFbvJpb5PHQ==
X-Google-Smtp-Source: ABdhPJwDrG9m7vAQS+VF/GQXXz1IT+Mgco25TxBuVlJNzEy+22mr0JP9+ZK6aVbHXdWQQHWMrTExsA==
X-Received: by 2002:a17:907:3daa:b0:6fe:88ab:fe8c with SMTP id he42-20020a1709073daa00b006fe88abfe8cmr20075363ejc.575.1654500601591;
        Mon, 06 Jun 2022 00:30:01 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t11-20020a17090605cb00b00706c1327f4bsm5994755ejt.23.2022.06.06.00.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 00:30:01 -0700 (PDT)
Message-ID: <8e81de5f-dfb7-e34f-ff5f-44b52421fa24@linaro.org>
Date:   Mon, 6 Jun 2022 09:29:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC v2 1/2] clk: hisilicon: add CRG driver Hi3521a SoC
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "Marty E. Plummer" <hanetzer@startmail.com>
Cc:     arnd@arndb.de, cai.huoqing@linux.dev, christian.koenig@amd.com,
        devicetree@vger.kernel.org, gengdongjiu@huawei.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux@armlinux.org.uk, michael@walle.cc, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, novikov@ispras.ru, olof@lixom.net,
        p.yadav@ti.com, rdunlap@infradead.org, richard@nod.at,
        robh+dt@kernel.org, sboyd@kernel.org, soc@kernel.org,
        sumit.semwal@linaro.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, xuwei5@hisilicon.com
References: <20220501054440.2434247-1-hanetzer@startmail.com>
 <20220501173423.2473093-1-hanetzer@startmail.com>
 <20220501173423.2473093-2-hanetzer@startmail.com>
 <f42cb4d0-7133-eea5-b456-b5169bebfad1@linaro.org>
 <20220601105846.7hriawg3stxb657f@proprietary-killer>
 <630b0d13-6778-2508-6a34-9daa0358047d@linaro.org>
 <20220601110616.xmxih663kxgupszv@proprietary-killer>
 <a2a98c6d-2ff7-89f6-0711-c8f8b99e85c2@linaro.org>
 <20220601182418.okoofgannw6vbcxo@proprietary-killer>
 <b1b87be5-a048-b713-c9f2-84b948aa6718@linaro.org>
 <20220603112227.hmzwy7xxl6ddezqh@proprietary-killer>
 <34e6715e-795c-3d64-1341-31da9bd27563@linaro.org>
In-Reply-To: <34e6715e-795c-3d64-1341-31da9bd27563@linaro.org>
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

On 05/06/2022 16:54, Krzysztof Kozlowski wrote:
> On 03/06/2022 13:22, Marty E. Plummer wrote:
>> On Thu, Jun 02, 2022 at 08:37:43AM +0200, Krzysztof Kozlowski wrote:
>>> On 01/06/2022 20:24, Marty E. Plummer wrote:
>>>
>>>>>> Either or. Whatever makes the workload easier is what I'm looking for.
>>>>>
>>>>> Sorry, you need to be more specific. Apply is not a job for you, for the
>>>>> patch submitter.
>>>>>
>>>>> Then you miss here important piece - which is the first patch. DTS goes
>>>>> always via separate branch (or even tree) from driver changes. That's
>>>>> why bindings are always separate first patches.
>>>>>
>>>> So, add a 4: arch/arm/boot/dts/soc.dtsi and 5: arch/arm/boot/dts/board.dts
>>>> to the above list, or should those be the same patch as well?
>>>
>>> For me does not matter, sub architecture maintainer might have preference.
>>>
>> Fair enough. That being said, for the dt-bindings patch, is it
>> permissible to include #define CLOCK_FOO 1337 and so on for clocks which
>> haven't been wired up in the driver yet? As in, you know they're there,
>> and are important enough to model, but you haven't gotten to that point
>> yet?
> 
> What would be the benefit to include them now? I imagine that if you
> plan to add such clocks to the driver in next week or something, and you
> need to use them in DTS, then it's fine. If that's not the case,
> probably there is little sense in defining them upfront...

Actually I see one more benefit - since IDs should be incremented by
one, you can define all of them upfront thus having some
logical/alphabetical order/grouping. If you extend the bindings header
with new IDs later, they must go to the end of the list, thus maybe
ordering will not be that nice.

If you want, go ahead with all IDs. Just remeber that these must be IDs,
not register values or some programming offsets.

Best regards,
Krzysztof
