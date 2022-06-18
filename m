Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178A05501F3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383848AbiFRCRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiFRCRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:17:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBCD6BFFA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:17:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso8439709pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 19:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JMI1LEXkNW8y4Ij7/pAVnRWBfFIajhln9mWym9qtdBk=;
        b=aQztmLrHt2dZI0m3S9ZIj7LgfrGA9fkQjP6RpIpNbYdZONF/8bunfvMULxgX7lz1Jz
         bGPOPLYBo3cQtv/Y//b6bNRAZEyHf6fejsuSIWtd0G+r6U0As7DAOTMx+QUw/714q9io
         N1Yh/d8+TIC9sd6MCkdttGxne5uafq8HOTeC6bjLHMbfPkJt3R4A5TM8nPv4lW4F5cBK
         lqeACve+y6w/y2FZpV8n/21VwIjdNOyJTMazCWBdQLW6s6ZGbjMgdumRdPjHHguSAj69
         OUZJdZF6hAm3/gbGVmtW5Thi6nlFbXsdzj892Hf0gu9AYDe5aNJMWIDCvb0BUQF6eaQV
         HjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JMI1LEXkNW8y4Ij7/pAVnRWBfFIajhln9mWym9qtdBk=;
        b=JGChyvqsb0MgOrBW/3bMAWmSubskILaJly9bgFT0FZlz2ETdd2p/gL8/IXC4NCQ2Y7
         hYP8SGTMNB/BV2DbhpMqHRpBJJcUz/MUIj8r771Kn0SI2EBqytbWlGo8oLDQ4hLAMteN
         B8TnojpOTeBLuRjtUAi4PKpUS1Q9Jb/kOv3uEzfKScYDxZGfUZHgdNnnMQ9+ZRID/AYa
         oZdcnquLcePwozZnMBZQLGzbxXa799JJ0gBvqMR0fBUFYx4dwXVpVilxnB3lEI18GRcG
         JDMIdw0bD6eHtw4+YDfNxFjgzIpTWVfAe+0ikgMg+gZHaMqBwXccb0B2xqqnxV4E9vt7
         CLCw==
X-Gm-Message-State: AJIora8JOzdCpkyU37h+zpnu1hbPZ9cNTu7KEea5VGnsYFg3e05WxMrf
        Y4bmUSzNqULUaJ2XIdjtptjgyw==
X-Google-Smtp-Source: AGRyM1s2R4p5Z+wXjDKBZyJZTtR9es+sqUpsVnnguraPXL+sRdJ03xv4un21pN3MjdQXcECp0OS3Tw==
X-Received: by 2002:a17:90a:384f:b0:1ea:fa0b:3132 with SMTP id l15-20020a17090a384f00b001eafa0b3132mr10143859pjf.5.1655518624043;
        Fri, 17 Jun 2022 19:17:04 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id z63-20020a633342000000b0040c5c174b6esm1741857pgz.29.2022.06.17.19.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 19:17:03 -0700 (PDT)
Message-ID: <4afdd1a2-6670-35aa-da70-7246ed96ef60@linaro.org>
Date:   Fri, 17 Jun 2022 19:17:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, Jian-Jia Su <jjsu@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2022 19:28, Julius Werner wrote:
> Sorry, wrong email for Krzysztof.

You need to base your upstream work on upstream tree. My email was
changed like three months ago...

> 
> On Tue, Jun 14, 2022 at 7:25 PM Julius Werner <jwerner@chromium.org> wrote:
>>
>> We (Chromium OS) have been trying to find a way to pass LPDDR memory
>> chip information that is available to the firmware through the FDT
>> (mostly for userspace informational purposes, for now). We have been
>> using and expanding the existing "jedec,lpddr2" and "jedec,lpddr3"
>> bindings for this (e.g. [1]). The goal is to be able to identify the
>> memory layout of the system (how the parts look like, how they're tied
>> together, how much capacity there is in total) as accurately as
>> possible from software-probed values.
>>
>> The existing bindings contain the fields "io-width" and "density",
>> which is terminology directly matching what an LPDDR chip can report
>> to firmware through the "Mode Register" interface, specifically MR8.
>> (The LPDDR specs describing this are not public, but you can see the
>> register definitions in most LPDDR chip datasheets that can be
>> randomly found online, e.g. [2] page 37.) The code in
>> drivers/memory/of_memory.c also suggests that these are supposed to
>> directly correspond to the MR8 values read from the chip, since when
>> of_lpddr2_get_info() copies the device tree values into struct
>> lpddr2_info, it encodes them in a format that directly matches the
>> mode register bit field patterns.
>>
>> The problem with this is that each individual LPDDR chip has its own
>> set of mode registers (per rank) that only describe the density of
>> that particular chip (rank). The host memory controller may have
>> multiple channels (each of which is basically an entirely separate set
>> of physical LPDDR pins on the board), a single channel may be
>> connected to multiple LPDDR chips (e.g. if the memory controller has
>> an outgoing 32-bit channel, that channel could be tied to two 16-bit
>> LPDDR chips by tying the low 16 bits to one and the high 16 bits to
>> the other), and then each of those chips may offer multiple
>> independent ranks (which rank is being accessed at a given time is
>> controlled by a separate chip select pin).
>>
>> So if we just have one "io-width" and one "density" field in the FDT,
>> there's no way to figure out how much memory there's actually
>> connected in total, because that only describes a single LPDDR chip.


Isn't the memory node used for that purpose - to identify how much
memory you have in total?

>> Worse, there may be chips where different ranks have different
>> densities (e.g. a 6GB dual-rank chip with one 4GB and one 2GB rank),
>> and different channels could theoretically be connected to chips of
>> completely different manufacturers.

>>
>> We need to be able to report the information that's currently encoded
>> in the "jedec,lpddr2" binding separately for each channel+rank
>> combination, and we need to be able to tell how many LPDDR chips are
>> combined under a single memory channel. For the former, I'd suggest
>> creating a separate FDT node for each channel, and then creating
>> subnodes under those for each rank that implement the binding. For the
>> latter, I would suggest adding a new property "channel-io-width" which

No, because io-width is a standard property, so it should be used
instead. It could be defined in channel node.

I'll think later, although it would be easier if you just bounce the
message to me, not forward. Much easier to read...


Best regards,
Krzysztof
