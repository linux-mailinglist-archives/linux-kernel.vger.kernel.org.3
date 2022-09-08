Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DD75B1FC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiIHN4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiIHN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:56:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F46F8255
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:56:28 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x14so12492025lfu.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pOPqsiftrlDPRDm64xElWxeUxNUaZvmJVwA/KSgraGc=;
        b=xsZxYFNroPjJpFcKvxCYptH7XwhHKQE0D9VdIu6Ntn3a7MfQuKyf2xpbPMT0ND0zcp
         Xr9wJjQ5y8kS+Fh1EQiQYFMEvdaDB674uLU0RiaK85ZL+Qwf0u68q0RD6OTMch9V/DOu
         85iu3/mFBtUB79lWG8E215dgYn8MT2Rdsdqw0gSZHvy6JT5CLE9Rbsc9lCnYULy38Tsj
         ljXhfRiPmo1lQ/a6Y04pjKqviTAICx88LZLwyRJOzZ3OhcDQz/GSELP1Po+jb0nwtMOx
         yHeRX47ko7mZ6wMz2HSUpS6fyB2ArtZX9t6P8YQD7MfSLDOQ1ADqLGa3y2Amc3OOLzuE
         dcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pOPqsiftrlDPRDm64xElWxeUxNUaZvmJVwA/KSgraGc=;
        b=RV2YlxC/CeuMM1yeNwCWCFYoCluOOP9q3ZavLvS3UNGYWTItsvQGu3hYqlbIm2sD1m
         FIliSYTwC6rPabQ479dYcUWcO1uLVHDIchetJv3GNJew2pWMp44jAsTAW6vfiFuVEETa
         zyuQqBsqwxpt3j6m1IoatUZujLXHuRny+zllTOtV3yJ0P5SxJcVBdTyN/qwu6eCq76dJ
         KnGQJIDU2XJWL3ue++xnDdZHFuMVqidXIg5z8e7ZRwGagqbCAnaDgtcbo+ZBlbIDZrLF
         kfqD0+rq3Z8nutgx02qdMVQx1d2xriysqX0+hTTOxv07Bi2o9FUIAAi41Wzi8K+/8bNM
         IKUw==
X-Gm-Message-State: ACgBeo33ALO26/u7kzpV4Nfrn+74B5DPD/tK+axwG8Bdi/ayzhTlmqyX
        3zN83dH4uArLneP3fk/1sY/PdQ==
X-Google-Smtp-Source: AA6agR4HhU5QeL7rvfGq7cejavEYRwj3rTuRTIMQlj5eAWppuLO4pSyAHj3t6PTH25LHqxK/r0IzhQ==
X-Received: by 2002:a05:6512:2c03:b0:497:a808:7d90 with SMTP id dx3-20020a0565122c0300b00497a8087d90mr2487117lfb.544.1662645387189;
        Thu, 08 Sep 2022 06:56:27 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z15-20020a05651c11cf00b00267db636cddsm3101755ljo.109.2022.09.08.06.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:56:26 -0700 (PDT)
Message-ID: <4abfb333-fd68-d752-a140-d15828be2148@linaro.org>
Date:   Thu, 8 Sep 2022 15:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/4] dt-bindings: memory: Add jedec,lpddrX-channel binding
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20220831013359.1807905-1-jwerner@chromium.org>
 <20220831013359.1807905-5-jwerner@chromium.org>
 <63c350a0-2393-208b-4fab-94db050407c2@linaro.org>
 <CAODwPW-9njhmjf1jEYsm68-StqciovgXo8VFBYksrdmqDJGC7g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAODwPW-9njhmjf1jEYsm68-StqciovgXo8VFBYksrdmqDJGC7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 03:11, Julius Werner wrote:
>>> +description:
>>> +  An LPDDR channel is a completely independent set of LPDDR pins (DQ, CA, CS,
>>> +  CK, etc.) that connect one or more LPDDR chips to a host system. The main
>>> +  purpose of this node is to overall LPDDR topology of the system, including the
>>> +  amount of individual LPDDR chips and the ranks per chip.
>>
>> "channel" in this context confuses me a bit, because usually everyone is
>> talking about DDR controller channels, not memory channels. I think this
>> actually maps to a DDR controller channel?
> 
> I'm not really sure what you mean by "memory channel" here (that would
> be different from the DDR controller channel)? According to my
> understanding there's only one kind of "channel" in the context of
> main memory, that's the DDR controller channel (i.e. each separate
> complete set of DDR pins coming out of the controller, as I tried to
> explain in the description).
> 
>>> +    lpddr-channel1 {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +      compatible = "jedec,lpddr4-channel";
>>> +      io-width = <32>;
>>
>> I wonder now, how does it exactly work - channel is 32 bits, two ranks
>> each with 32 bit IO bus. Your description said that:
>>
>> total_ram = (rank0 + rank1) * (channel_width / chip_width)
>> so for this case: (4+2)*(32/32) = 6 Mbit
>>
>> If channel io-width = <64>, then memories are stacked in parallel and
>> according to your description total RAM would be: (4+2)*(64/32) = 12 Mbit
>> I wonder why stacking memories in parallel increases their size?
> 
> Well, stacking in parallel just means you have more of them? In the
> original example, you have a single LPDDR chip with two ranks, one
> 4Gbit rank and one 2Gbit rank. That chip is directly hooked up to the
> LPDDR controller and that's the only chip you have, so you have 4+2 =
> 6Gbit total memory in the system.
> 
> In your next example, the LPDDR controller has a 64 bit wide channel,
> but you're still using that same 6Gbit LPDDR chip that only has 32 DQ
> pins. The only way to fill out that 64 bit channel with this kind of
> chip is to have two of them in parallel (one connected to DQ[0:31] and
> one connected to DQ[32:63]). So we infer from the mismatch in io-width
> that we have two chips. Each chip still has 6Gbit of memory, so the
> total system would have 12Gbit.

Two chips so more device nodes? Since there are no DTSes with it, please
provide an additional example in the bindings.

Best regards,
Krzysztof
